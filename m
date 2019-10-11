Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1418ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC4E20659
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCERHfbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJKHVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:21:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:21:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so10604527wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yed/Zw6p69EzfF3CTH8cJ/M82R5voY0Fjq65QCPL/JU=;
        b=CCERHfbW2XL9LVmzDIkCKAZhPNjqoiOFgHo+yin3U0e+c2jWBPDb+xYWL4q9aQSlOF
         hk3j1p+PntM4knQNdUvX9TMCkEP+FLsUDVttF9S7ReOa8j+HXDi/G05YjxEBXI81qpYX
         DIg43sJM429sSp/4nerZcsIhTTfdP/l18ccpx7a8zvQQeJcDgh7K8EgC5Fdqh6O+v3h6
         7031V0stboIqd6W1D2tpSdCrO9hMwLT/7o+kNraeVBYdQOBsMPpeOYki135C6509LTzm
         yCdESn77FaCZu3LKu2Hk7up6HWJ+OcSgumCLqEqd0MiCHBTtQ6x/52CwojCDXG4BG1Yx
         xBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yed/Zw6p69EzfF3CTH8cJ/M82R5voY0Fjq65QCPL/JU=;
        b=EJY3O2UIPlXRALWfibsW+CFO6F9r3IRbkVd+X7BXbwuIy1FHAlEZQzw7IdCUTezmAE
         jI+FBcBgY5IU9lSAGePDcYk43ZtU2lthfougZgolgFCPjNp7ev0UA+O4t0tfkc/IpRbf
         LDPeCnEf0VvAUpn/GcuiVAL3T4EYSiExxYpG4EeVGtY38PphfX/yUJSWZlwsb73FLwvV
         qFss1VFlHP83/sJaN04n7Scq7VCXqhTegi5AZk4pas3Beq4aDyT793RpOHwhWZWIAnHm
         uHL0rhH8MchpLMENGHHjxjpu29BTX6hQ5lyfGOtdr2vf3xbwtBmUshy3H3DlrroV8FlW
         p+0A==
X-Gm-Message-State: APjAAAXlqDOmu8yIwK4Eo6W1gmL9D9SU9J6rV6ssoolOREpV6b/BDc2Y
        RGNUfhmoo1wfpeTMu05DS0dQBlGx9f8=
X-Google-Smtp-Source: APXvYqzSyv+4v1S6FqAwMhwo9Q2C0xuT5x3tmgkShuHXnAzM7L4f5YOLDwsln6inSAIuibyW0f0nbQ==
X-Received: by 2002:a5d:4010:: with SMTP id n16mr11606743wrp.152.1570778475906;
        Fri, 11 Oct 2019 00:21:15 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 143sm10146031wmb.33.2019.10.11.00.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:21:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: add opcode to INFO IOCTL to return clock rate
Date:   Fri, 11 Oct 2019 10:21:13 +0300
Message-Id: <20191011072113.4992-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new opcode to the INFO IOCTL to allow the user application to
retrieve the ASIC's current and maximum clock rate. The rate is
returned in MHz.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        |  3 ++-
 drivers/misc/habanalabs/goya/goyaP.h       |  2 ++
 drivers/misc/habanalabs/goya/goya_hwmgr.c  | 31 ++++++++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h       |  2 ++
 drivers/misc/habanalabs/habanalabs_ioctl.c | 23 ++++++++++++++++
 include/uapi/misc/habanalabs.h             | 19 +++++++++----
 6 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d49f5ecd903b..ac574d18c139 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5148,7 +5148,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.init_iatu = goya_init_iatu,
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
-	.halt_coresight = goya_halt_coresight
+	.halt_coresight = goya_halt_coresight,
+	.get_clk_rate = goya_get_clk_rate
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 89b6574f8e4f..c3230cb6e25c 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -233,4 +233,6 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
+int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index a2a700c3d597..b2ebc01e27f4 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -32,6 +32,37 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 	}
 }
 
+int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
+{
+	long value;
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, MME_PLL, false);
+
+	if (value < 0) {
+		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
+			value);
+		return value;
+	}
+
+	*max_clk = (value / 1000 / 1000);
+
+	value = hl_get_frequency(hdev, MME_PLL, true);
+
+	if (value < 0) {
+		dev_err(hdev->dev,
+			"Failed to retrieve device current clock %ld\n",
+			value);
+		return value;
+	}
+
+	*cur_clk = (value / 1000 / 1000);
+
+	return 0;
+}
+
 static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 91445371b08b..4ff2da859653 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -508,6 +508,7 @@ enum hl_pll_frequency {
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
  * @halt_coresight: stop the ETF and ETR traces.
+ * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -590,6 +591,7 @@ struct hl_asic_funcs {
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 	void (*halt_coresight)(struct hl_device *hdev);
+	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 };
 
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 66d9c710073c..cd4b5a9ceac1 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -221,6 +221,25 @@ static int device_utilization(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(device_util))) ? -EFAULT : 0;
 }
 
+static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_clk_rate clk_rate = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hdev->asic_funcs->get_clk_rate(hdev, &clk_rate.cur_clk_rate_mhz,
+						&clk_rate.max_clk_rate_mhz);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &clk_rate,
+		min((size_t) max_size, sizeof(clk_rate))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -271,6 +290,10 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		rc = hw_events_info(hdev, true, args);
 		break;
 
+	case HL_INFO_CLK_RATE:
+		rc = get_clk_rate(hdev, args);
+		break;
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 53e4ff73578e..783793c8be1c 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -88,13 +88,16 @@ enum hl_device_status {
  *                         internal engine.
  * HL_INFO_DEVICE_STATUS - Retrieve the device's status. This opcode doesn't
  *                         require an open context.
- * HL_INFO_DEVICE_UTILIZATION - Retrieve the total utilization of the device
- *                              over the last period specified by the user.
- *                              The period can be between 100ms to 1s, in
- *                              resolution of 100ms. The return value is a
- *                              percentage of the utilization rate.
+ * HL_INFO_DEVICE_UTILIZATION  - Retrieve the total utilization of the device
+ *                               over the last period specified by the user.
+ *                               The period can be between 100ms to 1s, in
+ *                               resolution of 100ms. The return value is a
+ *                               percentage of the utilization rate.
  * HL_INFO_HW_EVENTS_AGGREGATE - Receive an array describing how many times each
  *                               event occurred since the driver was loaded.
+ * HL_INFO_CLK_RATE            - Retrieve the current and maximum clock rate
+ *                               of the device in MHz. The maximum clock rate is
+ *                               configurable via sysfs parameter
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -103,6 +106,7 @@ enum hl_device_status {
 #define HL_INFO_DEVICE_STATUS		4
 #define HL_INFO_DEVICE_UTILIZATION	6
 #define HL_INFO_HW_EVENTS_AGGREGATE	7
+#define HL_INFO_CLK_RATE		8
 
 #define HL_INFO_VERSION_MAX_LEN	128
 
@@ -149,6 +153,11 @@ struct hl_info_device_utilization {
 	__u32 pad;
 };
 
+struct hl_info_clk_rate {
+	__u32 cur_clk_rate_mhz;
+	__u32 max_clk_rate_mhz;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
-- 
2.17.1

