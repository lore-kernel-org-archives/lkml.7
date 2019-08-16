Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD62C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB38206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHPCdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:24701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfHPCdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894541"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:19 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Victor Sun <victor.sun@intel.com>
Subject: [RFC PATCH 13/15] drivers/acrn: add service to obtain Power data transition
Date:   Fri, 16 Aug 2019 10:25:54 +0800
Message-Id: <1565922356-4488-14-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The px/cx data is critical to support the power transition. DM will get
these data to build DSDT for UOS. With this DSDT, UOS would have the
capability on power control if acpi-cpufreq/idle driver is enabled in
kernel.
Add the PM ioctl that is used to obtain the info of power state
so that the DM can construct the DSDT with Power frequence/C-state idle
for guest system.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Co-developed-by: Victor Sun <victor.sun@intel.com>
Signed-off-by: Victor Sun <victor.sun@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/staging/acrn/acrn_dev.c           | 75 +++++++++++++++++++++++++++++++
 include/uapi/linux/acrn/acrn_ioctl_defs.h | 36 +++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
index 93f45e3..ef0ec50 100644
--- a/drivers/staging/acrn/acrn_dev.c
+++ b/drivers/staging/acrn/acrn_dev.c
@@ -432,6 +432,81 @@ long acrn_dev_ioctl(struct file *filep,
 		break;
 	}
 
+	case IC_PM_GET_CPU_STATE: {
+		u64 cmd;
+
+		if (copy_from_user(&cmd, (void *)ioctl_param, sizeof(cmd)))
+			return -EFAULT;
+
+		switch (cmd & PMCMD_TYPE_MASK) {
+		case PMCMD_GET_PX_CNT:
+		case PMCMD_GET_CX_CNT: {
+			u64 *pm_info;
+
+			pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+			if (!pm_info)
+				return -ENOMEM;
+
+			ret = hcall_get_cpu_state(cmd, virt_to_phys(pm_info));
+			if (ret < 0) {
+				kfree(pm_info);
+				return -EFAULT;
+			}
+
+			if (copy_to_user((void *)ioctl_param,
+					 pm_info, sizeof(u64)))
+				ret = -EFAULT;
+
+			kfree(pm_info);
+			break;
+		}
+		case PMCMD_GET_PX_DATA: {
+			struct cpu_px_data *px_data;
+
+			px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+			if (!px_data)
+				return -ENOMEM;
+
+			ret = hcall_get_cpu_state(cmd, virt_to_phys(px_data));
+			if (ret < 0) {
+				kfree(px_data);
+				return -EFAULT;
+			}
+
+			if (copy_to_user((void *)ioctl_param,
+					 px_data, sizeof(*px_data)))
+				ret = -EFAULT;
+
+			kfree(px_data);
+			break;
+		}
+		case PMCMD_GET_CX_DATA: {
+			struct cpu_cx_data *cx_data;
+
+			cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+			if (!cx_data)
+				return -ENOMEM;
+
+			ret = hcall_get_cpu_state(cmd, virt_to_phys(cx_data));
+			if (ret < 0) {
+				kfree(cx_data);
+				return -EFAULT;
+			}
+
+			if (copy_to_user((void *)ioctl_param,
+					 cx_data, sizeof(*cx_data)))
+				ret = -EFAULT;
+			kfree(cx_data);
+			break;
+		}
+		default:
+			ret = -EFAULT;
+			break;
+		}
+
+		break;
+	}
+
 	default:
 		pr_warn("Unknown IOCTL 0x%x\n", ioctl_num);
 		ret = -EFAULT;
diff --git a/include/uapi/linux/acrn/acrn_ioctl_defs.h b/include/uapi/linux/acrn/acrn_ioctl_defs.h
index c3c4f98..c762bd2 100644
--- a/include/uapi/linux/acrn/acrn_ioctl_defs.h
+++ b/include/uapi/linux/acrn/acrn_ioctl_defs.h
@@ -234,6 +234,39 @@ struct ioreq_notify {
 	uint32_t vcpu;
 };
 
+struct acrn_generic_address {
+	uint8_t		space_id;
+	uint8_t		bit_width;
+	uint8_t		bit_offset;
+	uint8_t		access_size;
+	uint64_t	address;
+};
+
+struct cpu_cx_data {
+	struct acrn_generic_address cx_reg;
+	uint8_t		type;
+	uint32_t	latency;
+	uint64_t	power;
+};
+
+struct cpu_px_data {
+	uint64_t core_frequency;	/* megahertz */
+	uint64_t power;			/* milliWatts */
+	uint64_t transition_latency;	/* microseconds */
+	uint64_t bus_master_latency;	/* microseconds */
+	uint64_t control;		/* control value */
+	uint64_t status;		/* success indicator */
+};
+
+#define PMCMD_TYPE_MASK		0x000000ff
+
+enum pm_cmd_type {
+	PMCMD_GET_PX_CNT,
+	PMCMD_GET_PX_DATA,
+	PMCMD_GET_CX_CNT,
+	PMCMD_GET_CX_DATA,
+};
+
 /*
  * Common IOCTL ID definition for DM
  */
@@ -281,4 +314,7 @@ struct ioreq_notify {
 #define IC_SET_PTDEV_INTR_INFO         _IC_ID(IC_ID, IC_ID_PCI_BASE + 0x03)
 #define IC_RESET_PTDEV_INTR_INFO       _IC_ID(IC_ID, IC_ID_PCI_BASE + 0x04)
 
+/* Power management */
+#define IC_ID_PM_BASE                   0x60UL
+#define IC_PM_GET_CPU_STATE            _IC_ID(IC_ID, IC_ID_PM_BASE + 0x00)
 #endif /* __ACRN_IOCTL_DEFS_H__ */
-- 
2.7.4

