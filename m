Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77D0C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34F8206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrIE+QUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKPKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:38:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37232 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:38:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so13670478wrv.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IK+AqHSdGqoBBJoPINHZQoI83RUAzsKVHTqvwrhiiO8=;
        b=hrIE+QUpRRlZbK0YQ5WW2gID0u7XJEcbT9pNiyfWkDmq96u/dxgDb70TZoCEJCGorl
         ZhOHZFD3dKxvuyLBQIU7TCTmrjwdC3C6cm5qGjw/xS8eqhMa2diPUw9EjgANFCFp3rax
         mT7QzpXS0X6vmq+Id/tOcb6K3rxIX9DeMp7YYB7Q5Qk2UVZLylk0Kt9MhWGXp4qA41Xi
         sVoup8JBBolRDWTKuW1CZu7KN4xL8kfPSdaAwjRNesPDa8cqeFkGzMoYCJ5Vy8EDcqZz
         RXpr4YFPWXoe9vFNgkqIW2zGJLNtNuv+t7oSArwd/HpzGsLhJhY7PBNwQVzAUe51WxOp
         g9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IK+AqHSdGqoBBJoPINHZQoI83RUAzsKVHTqvwrhiiO8=;
        b=ETzdX65dtPlNNixoHmWNK4ZJFgAjWBGaaCIvrVqpD3P5sTw4pn9bGBEmZJLw5igktV
         ubAnDq12bDf7b5tRJj7Ge9TZ5qwn3xYIgJhJOVQYKkECI697TGWUnr+D7NKNmn4YEIYB
         /Tnkt/m/4/ZTdkYJuGjLFYmmDw+s7UwqHT0G98FLz0GzOXrOclUTnqflFYmDKpeWptn7
         6XC2E3N9o6F9+TrSyOI+/zMtzwufSRqCCSg3+IaWREtChpBBbpRv8vyN0IGB4DUBb2lI
         z/LYAlnQCduXX0nrrHn9/dq2cpCbTXlqWjwgLs+Drv7cl2VSIup8F1ewb+GK58Ai79eK
         /W9g==
X-Gm-Message-State: APjAAAVipdokHewegxqhRy2Age3+UO7hP13WSb8uCHr2/q04Qs3dWBY9
        oiuMgNGZ9uYsor0Aa9pBjb9upjr9h80=
X-Google-Smtp-Source: APXvYqw0m2jbwsi4JLERwHHw5HPjC4G/JLDsjzkE4EoYgNFZv1ZiCFU4teLMRoWxDoprFDGTfbIEPQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr21601095wrm.264.1573900713812;
        Sat, 16 Nov 2019 02:38:33 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id q15sm15015602wrs.91.2019.11.16.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 02:38:33 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: expose reset counters via existing INFO IOCTL
Date:   Sat, 16 Nov 2019 12:38:29 +0200
Message-Id: <20191116103829.7144-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

Expose both soft and hard reset counts via INFO IOCTL.
This will allow system management applications to easily check
if the device has undergone reset.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 19 +++++++++++++++++++
 include/uapi/misc/habanalabs.h             |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 5d9c269d99db..6474b868ef27 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -242,6 +242,22 @@ static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(clk_rate))) ? -EFAULT : 0;
 }
 
+static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_reset_count reset_count = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	reset_count.hard_reset_cnt = hdev->hard_reset_cnt;
+	reset_count.soft_reset_cnt = hdev->soft_reset_cnt;
+
+	return copy_to_user(out, &reset_count,
+		min((size_t) max_size, sizeof(reset_count))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -260,6 +276,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DEVICE_STATUS:
 		return device_status_info(hdev, args);
 
+	case HL_INFO_RESET_COUNT:
+		return get_reset_count(hdev, args);
+
 	default:
 		break;
 	}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 716e70750f23..4faa2c9767e5 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -98,6 +98,9 @@ enum hl_device_status {
  * HL_INFO_CLK_RATE            - Retrieve the current and maximum clock rate
  *                               of the device in MHz. The maximum clock rate is
  *                               configurable via sysfs parameter
+ * HL_INFO_RESET_COUNT   - Retrieve the counts of the soft and hard reset
+ *                         operations performed on the device since the last
+ *                         time the driver was loaded.
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -107,6 +110,7 @@ enum hl_device_status {
 #define HL_INFO_DEVICE_UTILIZATION	6
 #define HL_INFO_HW_EVENTS_AGGREGATE	7
 #define HL_INFO_CLK_RATE		8
+#define HL_INFO_RESET_COUNT		9
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -160,6 +164,11 @@ struct hl_info_clk_rate {
 	__u32 max_clk_rate_mhz;
 };
 
+struct hl_info_reset_count {
+	__u32 hard_reset_cnt;
+	__u32 soft_reset_cnt;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
-- 
2.17.1

