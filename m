Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19660C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DA3217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFZWjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:39:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:10653 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfFZWjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:39:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313575017"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:39:04 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 08/10] platform/x86: ISST: Add Intel Speed Select PUNIT MSR interface
Date:   Wed, 26 Jun 2019 15:38:49 -0700
Message-Id: <20190626223851.19138-9-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using new non arhitectural features using PUNIT Mailbox and MMIO
read/write interface, still there is need to operate using MSRs to
control PUNIT. User space could have used user user-space MSR interface for
this, but when user space MSR access is disabled, then it can't. Here only
limited number of MSRs are allowed using this new interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel_speed_select_if/isst_if_common.c    | 59 +++++++++++++++++++
 include/uapi/linux/isst_if.h                  | 32 ++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index 391fc3f12161..de2fb5292f1c 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -25,6 +25,11 @@
 
 static struct isst_if_cmd_cb punit_callbacks[ISST_IF_DEV_MAX];
 
+static int punit_msr_white_list[] = {
+	MSR_TURBO_RATIO_LIMIT,
+	MSR_CONFIG_TDP_CONTROL,
+};
+
 struct isst_valid_cmd_ranges {
 	u16 cmd;
 	u16 sub_cmd_beg;
@@ -229,6 +234,54 @@ static long isst_if_proc_phyid_req(u8 *cmd_ptr, int *write_only, int resume)
 	return 0;
 }
 
+static bool match_punit_msr_white_list(int msr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(punit_msr_white_list); ++i) {
+		if (punit_msr_white_list[i] == msr)
+			return true;
+	}
+
+	return false;
+}
+
+static long isst_if_msr_cmd_req(u8 *cmd_ptr, int *write_only, int resume)
+{
+	struct isst_if_msr_cmd *msr_cmd;
+	int ret;
+
+	msr_cmd = (struct isst_if_msr_cmd *)cmd_ptr;
+
+	if (!match_punit_msr_white_list(msr_cmd->msr))
+		return -EINVAL;
+
+	if (msr_cmd->logical_cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (msr_cmd->read_write) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		ret = wrmsrl_safe_on_cpu(msr_cmd->logical_cpu,
+					 msr_cmd->msr,
+					 msr_cmd->data);
+		*write_only = 1;
+	} else {
+		u64 data;
+
+		ret = rdmsrl_safe_on_cpu(msr_cmd->logical_cpu,
+					 msr_cmd->msr, &data);
+		if (!ret) {
+			msr_cmd->data = data;
+			*write_only = 0;
+		}
+	}
+
+
+	return ret;
+}
+
 static long isst_if_exec_multi_cmd(void __user *argp, struct isst_if_cmd_cb *cb)
 {
 	unsigned char __user *ptr;
@@ -309,6 +362,12 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 		if (cb->registered)
 			ret = isst_if_exec_multi_cmd(argp, cb);
 		break;
+	case ISST_IF_MSR_COMMAND:
+		cmd_cb.cmd_size = sizeof(struct isst_if_msr_cmd);
+		cmd_cb.offset = offsetof(struct isst_if_msr_cmds, msr_cmd);
+		cmd_cb.cmd_callback = isst_if_msr_cmd_req;
+		ret = isst_if_exec_multi_cmd(argp, &cmd_cb);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
index e4b1c2ec3279..d10b832c58c5 100644
--- a/include/uapi/linux/isst_if.h
+++ b/include/uapi/linux/isst_if.h
@@ -132,9 +132,41 @@ struct isst_if_mbox_cmds {
 	struct isst_if_mbox_cmd mbox_cmd[1];
 };
 
+/**
+ * struct isst_if_msr_cmd - Structure to define msr command
+ * @read_write:		Value 0: Read, 1: Write
+ * @logical_cpu:	Logical CPU number
+ * @msr:		MSR number
+ * @data:		For write operation, data to write, for read
+ *			place holder
+ *
+ * Structure to specify MSR command related to PUNIT.
+ */
+struct isst_if_msr_cmd {
+	__u32 read_write; /* Read:0, Write:1 */
+	__u32 logical_cpu;
+	__u64 msr;
+	__u64 data;
+};
+
+/**
+ * struct isst_if_msr_cmds - structure for msr commands
+ * @cmd_count:	Number of mailbox commands in msr_cmd[]
+ * @msr_cmd[]:	Holds one or more msr commands
+ *
+ * This structure used with ioctl ISST_IF_MSR_COMMAND to send
+ * one or more MSR commands. IOCTL return value indicates number of
+ * commands sent or error number if no commands have been sent.
+ */
+struct isst_if_msr_cmds {
+	__u32 cmd_count;
+	struct isst_if_msr_cmd msr_cmd[1];
+};
+
 #define ISST_IF_MAGIC			0xFE
 #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
 #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
 #define ISST_IF_IO_CMD		_IOW(ISST_IF_MAGIC, 2, struct isst_if_io_regs *)
 #define ISST_IF_MBOX_COMMAND	_IOWR(ISST_IF_MAGIC, 3, struct isst_if_mbox_cmds *)
+#define ISST_IF_MSR_COMMAND	_IOWR(ISST_IF_MAGIC, 4, struct isst_if_msr_cmds *)
 #endif
-- 
2.17.2

