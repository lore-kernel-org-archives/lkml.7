Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB7C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A09214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZWjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:39:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfFZWjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:39:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313574981"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:39:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 04/10] platform/x86: ISST: Add IOCTL to Translate Linux logical CPU to PUNIT CPU number
Date:   Wed, 26 Jun 2019 15:38:45 -0700
Message-Id: <20190626223851.19138-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add processing for IOCTL command ISST_IF_GET_PHY_ID. This converts from the
Linux logical CPU to PUNIT CPU numbering scheme.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel_speed_select_if/isst_if_common.c    | 74 +++++++++++++++++++
 include/uapi/linux/isst_if.h                  | 28 +++++++
 2 files changed, 102 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 0e16cbf685d0..72e74d72724b 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -134,16 +134,90 @@ static void isst_if_cpu_info_exit(void)
 	kfree(isst_cpu_info);
 };
 
+static long isst_if_proc_phyid_req(u8 *cmd_ptr, int *write_only, int resume)
+{
+	struct isst_if_cpu_map *cpu_map;
+
+	cpu_map = (struct isst_if_cpu_map *)cmd_ptr;
+	if (cpu_map->logical_cpu >= nr_cpu_ids ||
+	    cpu_map->logical_cpu >= num_possible_cpus())
+		return -EINVAL;
+
+	*write_only = 0;
+	cpu_map->physical_cpu = isst_cpu_info[cpu_map->logical_cpu].punit_cpu_id;
+
+	return 0;
+}
+
+static long isst_if_exec_multi_cmd(void __user *argp, struct isst_if_cmd_cb *cb)
+{
+	unsigned char __user *ptr;
+	u32 cmd_count;
+	u8 *cmd_ptr;
+	long ret;
+	int i;
+
+	/* Each multi command has u32 command count as the first field */
+	if (copy_from_user(&cmd_count, argp, sizeof(cmd_count)))
+		return -EFAULT;
+
+	if (!cmd_count || cmd_count > ISST_IF_CMD_LIMIT)
+		return -EINVAL;
+
+	cmd_ptr = kmalloc(cb->cmd_size, GFP_KERNEL);
+	if (!cmd_ptr)
+		return -ENOMEM;
+
+	/* cb->offset points to start of the command after the command count */
+	ptr = argp + cb->offset;
+
+	for (i = 0; i < cmd_count; ++i) {
+		int wr_only;
+
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		if (copy_from_user(cmd_ptr, ptr, cb->cmd_size)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = cb->cmd_callback(cmd_ptr, &wr_only, 0);
+		if (ret)
+			break;
+
+		if (!wr_only && copy_to_user(ptr, cmd_ptr, cb->cmd_size)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ptr += cb->cmd_size;
+	}
+
+	kfree(cmd_ptr);
+
+	return i ? i : ret;
+}
+
 static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
+	struct isst_if_cmd_cb cmd_cb;
 	long ret = -ENOTTY;
 
 	switch (cmd) {
 	case ISST_IF_GET_PLATFORM_INFO:
 		ret = isst_if_get_platform_info(argp);
 		break;
+	case ISST_IF_GET_PHY_ID:
+		cmd_cb.cmd_size = sizeof(struct isst_if_cpu_map);
+		cmd_cb.offset = offsetof(struct isst_if_cpu_maps, cpu_map);
+		cmd_cb.cmd_callback = isst_if_proc_phyid_req;
+		ret = isst_if_exec_multi_cmd(argp, &cmd_cb);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index fa94480b5f74..15d1f286a830 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -36,6 +36,34 @@ struct isst_if_platform_info {
 	__u8 mmio_supported;
 };
 
+/**
+ * struct isst_if_cpu_map - CPU mapping between logical and physical CPU
+ * @logical_cpu:	Linux logical CPU number
+ * @physical_cpu:	PUNIT CPU number
+ *
+ * Used to convert from Linux logical CPU to PUNIT CPU numbering scheme.
+ * The PUNIT CPU number is different than APIC ID based CPU numbering.
+ */
+struct isst_if_cpu_map {
+	__u32 logical_cpu;
+	__u32 physical_cpu;
+};
+
+/**
+ * struct isst_if_cpu_maps - structure for CPU map IOCTL
+ * @cmd_count:	Number of CPU mapping command in cpu_map[]
+ * @cpu_map[]:	Holds one or more CPU map data structure
+ *
+ * This structure used with ioctl ISST_IF_GET_PHY_ID to send
+ * one or more CPU mapping commands. Here IOCTL return value indicates
+ * number of commands sent or error number if no commands have been sent.
+ */
+struct isst_if_cpu_maps {
+	__u32 cmd_count;
+	struct isst_if_cpu_map cpu_map[1];
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
+#define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
 #endif
-- 
2.17.2

