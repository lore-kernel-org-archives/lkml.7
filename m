Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D1E2652D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkHtZhss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEaHj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:39:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38827 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfEaHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:39:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so4968941pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Nj60oBqIopyn1T0IlYYbYPmf6l7buHAsI+lHlXOg1k=;
        b=ZkHtZhssBlyDhxswlfEUAS1Y3CtbQ9bqfTQnvrQrGeCWHBeLSOjEUACwOZS7Ge+o1l
         MJW+IOlmm35blzrv1SFnVZW/Lf4qnTBs40u+tsXiPXtiX80q4rkRCzkMVhERs589KqZm
         DPq1c7M2+F/sP+CZadODVEfH8ZYseJ/92Okw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Nj60oBqIopyn1T0IlYYbYPmf6l7buHAsI+lHlXOg1k=;
        b=agmdf/NiTDJC2P0PSlN6TmI5hpkaLX/7X0ZTVZoo62Pp9ZET2uV6aNlXH9MRWwibKI
         vbK/vr8FcjkhWUGWkT78GQvXOBRlw/Pifhx4L03o+KUrN1VGS9p16YD2ED/fBR27yy5D
         U1vaioJwXljvw3kevAx0uuHyq97f+TfSgJCmGHB04Wu8VwGehfWRDVWMH74VBpYGcxjU
         4BFhdriTy3ZhRTv1ZZ0oAF1g7v8xA8AXQtzmFa4XjAsc5dMy8e2h89+9GdY9J1E8NMAX
         ru1NavhAEX9dBLVWBQaMfMT//NtKBKiYt12JndMQSqYiH7Bc1IWXQOCfR1LjVd55+wgn
         YURQ==
X-Gm-Message-State: APjAAAWQyIEWqpAd0umqr3Hqsu4RU92QfieKzbqn+YrKk9s/vKtpeRu3
        Y7Col1d7FIkaq7Fe/wERzWWxkA==
X-Google-Smtp-Source: APXvYqzBbChruBHRjjXj+6jQC2mdU1dW5CEXePkSM1WEL6tL8pEWny6Q/UNJJS4/7kCzYYFs/39n+g==
X-Received: by 2002:a62:6145:: with SMTP id v66mr8012840pfb.144.1559288364789;
        Fri, 31 May 2019 00:39:24 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r71sm17051741pjb.2.2019.05.31.00.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:39:24 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 6/7] mfd: cros_ec: differentiate SCP from EC by feature bit.
Date:   Fri, 31 May 2019 15:38:47 +0800
Message-Id: <20190531073848.155444-7-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190531073848.155444-1-pihsun@chromium.org>
References: <20190531073848.155444-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System Companion Processor (SCP) is Cortex M4 co-processor on some
MediaTek platform that can run EC-style firmware. Since a SCP and EC
would both exist on a system, and use the cros_ec_dev driver, we need to
differentiate between them for the userspace, or they would both be
registered at /dev/cros_ec, causing a conflict.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

---
Changes from v8:
 - No change.

Changes from v7:
 - Address comments in v7.
 - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196/.

Changes from v6, v5, v4, v3, v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
 include/linux/mfd/cros_ec.h          |  1 +
 include/linux/mfd/cros_ec_commands.h |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a5391f96eafd..66107de3dbce 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -440,6 +440,16 @@ static int ec_device_probe(struct platform_device *pdev)
 		ec_platform->ec_name = CROS_EC_DEV_TP_NAME;
 	}
 
+	/* Check whether this is actually a SCP rather than an EC. */
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "CrOS SCP MCU detected.\n");
+		/*
+		 * Help userspace differentiating ECs from SCP,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index cfa78bb4990f..751cb3756d49 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -27,6 +27,7 @@
 #define CROS_EC_DEV_PD_NAME "cros_pd"
 #define CROS_EC_DEV_TP_NAME "cros_tp"
 #define CROS_EC_DEV_ISH_NAME "cros_ish"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..8b578b4c1ec7 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -884,7 +884,7 @@ enum ec_feature_code {
 	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
 	/* EC supports audio codec. */
 	EC_FEATURE_AUDIO_CODEC = 38,
-	/* EC Supports SCP. */
+	/* The MCU is a System Companion Processor (SCP). */
 	EC_FEATURE_SCP = 39,
 	/* The MCU is an Integrated Sensor Hub */
 	EC_FEATURE_ISH = 40,
-- 
2.22.0.rc1.257.g3120a18244-goog

