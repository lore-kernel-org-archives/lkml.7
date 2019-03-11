Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E461206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fhoMfBr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfCKGfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:35:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46962 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfCKGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:35:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id a22so3257694pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amWzEjgHdVBWDvoM3DRy4nnRCJepbtnQhM8Z904O2e0=;
        b=fhoMfBr6c9UHQxhKuHbKRYvWNGfQvtqBP0MRmlpHjT9c+PVqG6h7nWWgY7YNRYCJK2
         1vcV5LH7FLLmNGckxwav9xcmYmEdjJggQpdNxFICPnBbihP02QCof7omJhKWBZ+PEE5R
         qM8Il38EM8ajB3J1hYxN/VD5CkguiBnyVMxpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amWzEjgHdVBWDvoM3DRy4nnRCJepbtnQhM8Z904O2e0=;
        b=Zcu0G7jQxjSg8osBVWsnDXxbutF5et6V7XJ/RJs9a64+RWsHN7ix3Gg/aYqgHOuXjM
         sk5g1L91uvWe/F/2z7uVOVfHu9jitjL4me6IwAxx536Xs5/m01/uE+SLDh1VCpiF3JT2
         uUO3v/q9AHhYNCZQWGwLHjcwNxigxInRyWaktwA/z6h0rW1qHjam3KscB0bNoeZW/dtj
         ZrRqPQCcJthTVo3Q5mSD3/IbQn70xw7/u97CFQ5gUt5rGw/6++Ij4YBgFa3sA5XtOUq2
         /eQVu+n9mYPUpdxq75gSr+FIJokdDrfjuSvoCp0bBk8dNkVg0J5Z+243Gxxam2xColhL
         3mBQ==
X-Gm-Message-State: APjAAAXu7cQRnTa+V3qprnBkqEDeY37UbiJg66cDTb+wMT5vXsb5QnFG
        XENS83K5HnuzL6Q6ngLtfkxSOQ==
X-Google-Smtp-Source: APXvYqytdIldk4pAiuWeu0vh1CBnjTqbPit62ESx3USpEOSPnJEmN60nue6a8CvVv/zEoP13cEfgXQ==
X-Received: by 2002:a65:63cd:: with SMTP id n13mr17580659pgv.193.1552286144027;
        Sun, 10 Mar 2019 23:35:44 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id p5sm6573040pfn.154.2019.03.10.23.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:35:43 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 7/7] cros_ec: differentiate SCP from EC by feature bit.
Date:   Mon, 11 Mar 2019 14:34:58 +0800
Message-Id: <20190311063458.137473-8-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190311063458.137473-1-pihsun@chromium.org>
References: <20190311063458.137473-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a SCP and EC would both exist on a system, and use the cros_ec_dev
driver, we need to differentiate between them for the userspace, or they
would both be registered at /dev/cros_ec, causing a conflict.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
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
 drivers/mfd/cros_ec_dev.c            | 9 +++++++++
 include/linux/mfd/cros_ec.h          | 1 +
 include/linux/mfd/cros_ec_commands.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb12..7fb81b11791f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -418,6 +418,15 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
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
2.21.0.360.g471c308f928-goog

