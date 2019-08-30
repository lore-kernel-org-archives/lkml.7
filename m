Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31FBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBC121726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWDUYlb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH3K5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:57:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfH3K5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:57:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so5180928wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zs6CLLBMUT4QHyCFCyblC6g2rYX67ALZuTK/huwV0BM=;
        b=VWDUYlb5ESSj+c73n1p452K6wxB4/ZqBlK49YYZ7gyQ0REpms/iH0AEnOXeseGtsVU
         TPh2F4G2dlhKPawp4WdKic0Un+lZAWOqadh7wWhd1bLDYX4HLzPvIeTTSeEXMXWwmzcF
         ICvovHJprKjFTVKgljAdfNZFrGXSmrt3CH43A/SGJdu1DLz8D6lUSrD7E/lIpHqF86vI
         LdW27LDPd7a0dWnECe7+FjQ+JlXNaRcb46qVcVEvJd3Ua/5OWvTzITkrYQFy565PO2bO
         hxEZOXuLStqJ/vnGjyXHhZwPsYoQIpzrTAkGwU11UY4Zt2pvdv22Mv/n7FtKfdRyFUOi
         L7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zs6CLLBMUT4QHyCFCyblC6g2rYX67ALZuTK/huwV0BM=;
        b=Rgcl75IGY4LJIoenVJqA/QZ+r/0zhiRHnp6CwrWi4rcQDtO1Js+H6tg9K4K0gE1Z7Z
         p36LiL7KAeBixddU1kwRXuBxsOslj1dvJed4TFbevb5ibj2ThTe34LiNmQUu/4c/5zrw
         F9FhB0+8aFo1F48E/A1ji7fSCgmi+I+N7SXv3/0vR0xXmlVG0SRnv35TnvMtmFAG05/7
         7IJLPpnP8KcEBkvzdkA8O4jRQw0yyaOXCPrJY2J5r1x2aBXJjwgzRFBD8wXFmsjwIWCL
         NcOawXTwooKn1XwvNZdqI3sGZ1XokjulRKMrQApxHKTfztjwPerTmhXdtH2NKQlmKB4a
         z9kg==
X-Gm-Message-State: APjAAAWMSNBwrPbb9e8/xK3wYnUB8tHkNst00jnBCp7QZFcA3TWDaJeU
        KOeOIqqaAVcUl+maZ/eV0WNWMilc
X-Google-Smtp-Source: APXvYqwQIhNVXGnShzdWSUDjad/PmkNRh2mTyVqXs2hGVKfeXhPSgtEoLlYCCkKD5QA4JPwfrAqnpQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr713500wrx.156.1567162624541;
        Fri, 30 Aug 2019 03:57:04 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 74sm7930892wma.15.2019.08.30.03.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 03:57:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: add uapi to retrieve aggregate H/W events
Date:   Fri, 30 Aug 2019 13:57:00 +0300
Message-Id: <20190830105700.8781-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830105700.8781-1-oded.gabbay@gmail.com>
References: <20190830105700.8781-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new opcode to INFO IOCTL to retrieve aggregate H/W events. i.e. the
events counters are NOT cleared upon device reset, but count from the
loading of the driver.

Add the code to support it in the device event handling function.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c        |  9 +++++++--
 drivers/misc/habanalabs/goya/goyaP.h       |  3 ++-
 drivers/misc/habanalabs/habanalabs.h       |  3 ++-
 drivers/misc/habanalabs/habanalabs_ioctl.c | 11 ++++++++---
 include/uapi/misc/habanalabs.h             |  3 +++
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0dd0b4429fee..1267ec75b19f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4469,6 +4469,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	struct goya_device *goya = hdev->asic_specific;
 
 	goya->events_stat[event_type]++;
+	goya->events_stat_aggregate[event_type]++;
 
 	switch (event_type) {
 	case GOYA_ASYNC_EVENT_ID_PCIE_IF:
@@ -4550,12 +4551,16 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	}
 }
 
-void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
+void *goya_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
-	*size = (u32) sizeof(goya->events_stat);
+	if (aggregate) {
+		*size = (u32) sizeof(goya->events_stat_aggregate);
+		return goya->events_stat_aggregate;
+	}
 
+	*size = (u32) sizeof(goya->events_stat);
 	return goya->events_stat;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index d7f48c9c41cd..f830cfd5c04d 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -162,6 +162,7 @@ struct goya_device {
 
 	u64		ddr_bar_cur_addr;
 	u32		events_stat[GOYA_ASYNC_EVENT_ID_SIZE];
+	u32		events_stat_aggregate[GOYA_ASYNC_EVENT_ID_SIZE];
 	u32		hw_cap_initialized;
 	u8		device_cpu_mmu_mappings_done;
 };
@@ -215,7 +216,7 @@ int goya_suspend(struct hl_device *hdev);
 int goya_resume(struct hl_device *hdev);
 
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
-void *goya_get_events_stat(struct hl_device *hdev, u32 *size);
+void *goya_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size);
 
 void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
 				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 23b86b7f9732..aa7aaa710f12 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -558,7 +558,8 @@ struct hl_asic_funcs {
 				struct hl_eq_entry *eq_entry);
 	void (*set_pll_profile)(struct hl_device *hdev,
 			enum hl_pll_frequency freq);
-	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
+	void* (*get_events_stat)(struct hl_device *hdev, bool aggregate,
+				u32 *size);
 	u64 (*read_pte)(struct hl_device *hdev, u64 addr);
 	void (*write_pte)(struct hl_device *hdev, u64 addr, u64 val);
 	void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 6325e98a5ae9..bb84b6dc2223 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -75,7 +75,8 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t)size, sizeof(hw_ip))) ? -EFAULT : 0;
 }
 
-static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
+static int hw_events_info(struct hl_device *hdev, bool aggregate,
+			struct hl_info_args *args)
 {
 	u32 size, max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
@@ -84,7 +85,7 @@ static int hw_events_info(struct hl_device *hdev, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	arr = hdev->asic_funcs->get_events_stat(hdev, &size);
+	arr = hdev->asic_funcs->get_events_stat(hdev, aggregate, &size);
 
 	return copy_to_user(out, arr, min(max_size, size)) ? -EFAULT : 0;
 }
@@ -251,7 +252,7 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 
 	switch (args->op) {
 	case HL_INFO_HW_EVENTS:
-		rc = hw_events_info(hdev, args);
+		rc = hw_events_info(hdev, false, args);
 		break;
 
 	case HL_INFO_DRAM_USAGE:
@@ -266,6 +267,10 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		rc = device_utilization(hdev, args);
 		break;
 
+	case HL_INFO_HW_EVENTS_AGGREGATE:
+		rc = hw_events_info(hdev, true, args);
+		break;
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 73ee212d7fa6..19f8039db2ea 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -93,6 +93,8 @@ enum hl_device_status {
  *                              The period can be between 100ms to 1s, in
  *                              resolution of 100ms. The return value is a
  *                              percentage of the utilization rate.
+ * HL_INFO_HW_EVENTS_AGGREGATE - Receive an array describing how many times each
+ *                               event occurred since the driver was loaded.
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -100,6 +102,7 @@ enum hl_device_status {
 #define HL_INFO_HW_IDLE			3
 #define HL_INFO_DEVICE_STATUS		4
 #define HL_INFO_DEVICE_UTILIZATION	6
+#define HL_INFO_HW_EVENTS_AGGREGATE	7
 
 #define HL_INFO_VERSION_MAX_LEN	128
 
-- 
2.17.1

