Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A7521473
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMiKxb8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfC0FPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:15:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42439 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732489AbfC0FPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:15:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so9141606pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8zaTUk0BnVa2J8hDxdZEkl8OZGwBzmzq9A3ZT/PfYw=;
        b=bMiKxb8zfFn6v1B4IR+KfLysRcMJ1Lr6yAiSMzf+2TixaUxY332f+8eDB5A7r8Q7GU
         /fZsTA/epa+yZl31H6KQOGw3ipFkB/tkTQvBu9AL5rAAH5i2A9QdRlN1NMa3TwIY9eMZ
         OgyFEUDObjO+jZ2+BSr3wPrC0l1/Iiprqd/L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8zaTUk0BnVa2J8hDxdZEkl8OZGwBzmzq9A3ZT/PfYw=;
        b=OZllpqjHcHavb014huqhP/uo53npuUwYPe3PIjRIMiSTm3655UwARycRF8Wq5hg4dB
         yWU0pSIN1nuPMqaY+2jkX2VBQoNjOnbgxTE2MkQ0lBorjpXsoFD20ZZXabOqqTjRUP5d
         3ap3M6pWLCu1f7nVpGAUE/gooRwTInODYTcdak3IzWisthIQe/sp5LuV+tA4QT60kcc2
         zh9GN7WCb4y4XybvMc8HdlI59EnuUZv9t5xRVnGYQUPe4MhXJg9JQNt2ZO4Xbi8k915M
         FS2PaM71SynYMii/+NR+WA0mZafDtV2JThhe482K5GLS9Crpp/qPCURcmYnVV3/k35yy
         dRLg==
X-Gm-Message-State: APjAAAWdRTpFhFRNjsWP6pX/7RZmJeFJGLZMtsywN7e4fRp3ptRon4fm
        fBmhrpC6tqEDEOLLegAHJf0fy1t1dbk=
X-Google-Smtp-Source: APXvYqxFiGT4P6ppEdxfQJ0cFvSIz7aDffM/60gLja5V93ZoDDuYCixlvy1p3wTwuLlf5TJ1GZiLbA==
X-Received: by 2002:a63:530e:: with SMTP id h14mr8291121pgb.136.1553663733152;
        Tue, 26 Mar 2019 22:15:33 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k72sm58622609pfb.122.2019.03.26.22.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:15:32 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 7/7] cros_ec: differentiate SCP from EC by feature bit.
Date:   Wed, 27 Mar 2019 13:14:49 +0800
Message-Id: <20190327051450.16222-8-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190327051450.16222-1-pihsun@chromium.org>
References: <20190327051450.16222-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pi-Hsun Shih <pihsun@chromium.org>

Since a SCP and EC would both exist on a system, and use the cros_ec_dev
driver, we need to differentiate between them for the userspace, or they
would both be registered at /dev/cros_ec, causing a conflict.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v6:
 - No change.

Changes from v5:
 - No change.

Changes from v4:
 - No change.

Changes from v3:
 - No change.

Changes from v2:
 - No change.

Changes from v1:
 - New patch extracted from Patch 5.
---
 drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
 include/linux/mfd/cros_ec.h          |  1 +
 include/linux/mfd/cros_ec_commands.h |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb12..da2f2145d31d 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -418,6 +418,16 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	/* check whether this is actually a SCP rather than an EC */
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "SCP detected.\n");
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
index 8f2a8918bfa3..a971399bad82 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c35..3e5da6e93b2f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU exposes a SCP */
+	EC_FEATURE_SCP = 39,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
2.21.0.392.gf8f6787159e-goog

