Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DBF206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHln7p/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfCZSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:47:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbfCZSrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:47:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so12143433wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OVnmi5wOmW/zqZlcYVO518iIu1tVVP8uQRVyAqiy7oY=;
        b=VHln7p/7dzcclv7f8UmDVD3BppLy11ME8RGrCrVtRlgxIpI5Rp7hFLK2T8GUHiyWoO
         ykqnMuDH5j2Aw9UOM7u6NtAjpn3XblexzBYSqqJMvcDeEi9f4PrJTv9xFGNClOfc0zGK
         fxeoy0A8ToRBpH1bq5OHlrN+Lzc4kskWM/tX+pJGQR2FQ5Z1To/IlI3ZD0RbLH4vuTDp
         lGavKXCc2MuvdWObczA/FrSuO9jUkX+hQzdtO4BnZc19dDYvN6VelhIzLU9iVSinA+gG
         Xi6nrbg4mPBHf5VYtmhn6Q2WRPiL1+RCuzPsNfUBr4/LpG05Qy3Dz5xj1pH2wMj4Zrs+
         hs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVnmi5wOmW/zqZlcYVO518iIu1tVVP8uQRVyAqiy7oY=;
        b=dUQOHkRAHSsWoDU4mXaJ9dbmlUBWALMFlOG+zIA8PKJd3QVQiRdVbgCHKtE5LDIZ3N
         LKMAGtjT1guu2S6Xu4FFGPYM1bsXhZlYFrYZrOPcs2L9VLVLLebOAbGwZu8lsnfbZtDA
         hpoqc4efW87QPtyOEmF/K8YhPE4gIrHCJAouG0vbno3oVimIgngL3e1EXfiTRTEXFdxm
         EC8NYTUQzrA4yrOpmPChUQAz4ynvRTWL+B1WDmp2slwzJCPIlSU8rNZNpcStKaHRT0dG
         +p+oxAM9GqYdNFCE/BFoS/R+Xw742weSgqU89lRTAAIiLd6hN/avn5tV87s2jYMOcVOe
         RatA==
X-Gm-Message-State: APjAAAVmagbBsfOVCu4zMaaVfRRH3Feg49T6LqaXrjHLc2imAfrtSRIV
        FBvbo3emL9n/Y6aGQyw8J1RUmtwl
X-Google-Smtp-Source: APXvYqx/TWCl6XgjEQpg4Myqfm0feJf42g5AYK7v0n88Bbp40Y0b6mWukQ3uEdN4f4jiXud+HAXKvg==
X-Received: by 2002:a5d:6b0d:: with SMTP id v13mr22441291wrw.284.1553626039979;
        Tue, 26 Mar 2019 11:47:19 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm10417953wrs.52.2019.03.26.11.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 11:47:19 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH] habanalabs: add device status option to INFO IOCTL
Date:   Tue, 26 Mar 2019 20:47:15 +0200
Message-Id: <20190326184715.13456-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

This patch adds a new opcode to INFO IOCTL that returns the device status.

This will allow users to query the device status in order to avoid sending
command submissions while device is in reset.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c           | 15 +++++++++++++++
 drivers/misc/habanalabs/habanalabs.h       |  1 +
 drivers/misc/habanalabs/habanalabs_ioctl.c | 19 +++++++++++++++++++
 include/uapi/misc/habanalabs.h             | 12 ++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index c51d1062d0bc..e3797f582436 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -10,6 +10,7 @@
 #include <linux/pci.h>
 #include <linux/sched/signal.h>
 #include <linux/hwmon.h>
+#include <uapi/misc/habanalabs.h>
 
 #define HL_PLDM_PENDING_RESET_PER_SEC	(HL_PENDING_RESET_PER_SEC * 10)
 
@@ -21,6 +22,20 @@ bool hl_device_disabled_or_in_reset(struct hl_device *hdev)
 		return false;
 }
 
+enum hl_device_status hl_device_status(struct hl_device *hdev)
+{
+	enum hl_device_status status;
+
+	if (hdev->disabled)
+		status = HL_DEVICE_STATUS_MALFUNCTION;
+	else if (atomic_read(&hdev->in_reset))
+		status = HL_DEVICE_STATUS_IN_RESET;
+	else
+		status = HL_DEVICE_STATUS_OPERATIONAL;
+
+	return status;
+};
+
 static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index e9253d937bfc..fd7fcdf7050f 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1272,6 +1272,7 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 
 int hl_device_open(struct inode *inode, struct file *filp);
 bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
+enum hl_device_status hl_device_status(struct hl_device *hdev);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		enum hl_asic_type asic_type, int minor);
 void destroy_hdev(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 37f9de8e7404..9000ff615805 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -12,6 +12,21 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+static int device_status_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_device_status dev_stat = {0};
+	u32 size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!size) || (!out))
+		return -EINVAL;
+
+	dev_stat.status = hl_device_status(hdev);
+
+	return copy_to_user(out, &dev_stat,
+			min((size_t)size, sizeof(dev_stat))) ? -EFAULT : 0;
+}
+
 static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 {
 	struct hl_info_hw_ip_info hw_ip = {0};
@@ -105,6 +120,10 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_device *hdev = hpriv->hdev;
 	int rc;
 
+	/* We want to return device status even if it disabled or in reset */
+	if (args->op == HL_INFO_DEVICE_STATUS)
+		return device_status_info(hdev, args);
+
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_warn_ratelimited(hdev->dev,
 			"Device is disabled or in reset. Can't execute INFO IOCTL\n");
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ab1957e31077..993a79edad73 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -45,11 +45,18 @@ enum goya_queue_id {
 	GOYA_QUEUE_ID_SIZE
 };
 
+enum hl_device_status {
+	HL_DEVICE_STATUS_OPERATIONAL,
+	HL_DEVICE_STATUS_IN_RESET,
+	HL_DEVICE_STATUS_MALFUNCTION
+};
+
 /* Opcode for management ioctl */
 #define HL_INFO_HW_IP_INFO	0
 #define HL_INFO_HW_EVENTS	1
 #define HL_INFO_DRAM_USAGE	2
 #define HL_INFO_HW_IDLE		3
+#define HL_INFO_DEVICE_STATUS	4
 
 #define HL_INFO_VERSION_MAX_LEN	128
 
@@ -82,6 +89,11 @@ struct hl_info_hw_idle {
 	__u32 pad;
 };
 
+struct hl_info_device_status {
+	__u32 status;
+	__u32 pad;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
-- 
2.17.1

