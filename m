Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1FC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0AB2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTBMYcGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfHCVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 17:35:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36952 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfHCVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 17:35:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so37713956pfa.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTxWia5xX02WvPnp2uEjiefvHrcZPYIX5+0Wgmee+Pk=;
        b=LTBMYcGzprbtDGxIPHTf+oSjKUa835LMfKM954lEhmz+dBkkqUqtOJuQvbiblw4vd0
         GoP1eLNv7wZc5YD48YCn3EXEOYHkiMqHZXDm0HT74/Fnsln15p2M+FMDtfUEo9+cNASL
         eew7Yft64f19KCGbHBFjh7qomGhRTphDYYZZQqgdmkDKXQ4b5qEvTzhOtb0fRUCJj6ua
         72sIPDvS6+5nXSfs9PsqwzDjy1jTo6F2aONBUSPEifF6KTo9EPmKheMw5WOQ6BUSKdGB
         h53w2aSVsZWsGgS23iJRf5nJVWuMoanOok/W7SY8ovQQfrQ51Yu7podFtey2EllUiQcZ
         tAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTxWia5xX02WvPnp2uEjiefvHrcZPYIX5+0Wgmee+Pk=;
        b=gufC5FkQHBKrD+bsnLKJRTXUsb2cUXFQFdvVfz1+d15WVTPMrOTcqHH/M1xPUbmDLu
         24K+gEt6POubzZlCCzpw2z88Aft3jfFz2LyBB9nfajVBorvD049T4762OWs2CAsAzQs7
         irhHqwrNocxM5wzOh1PEyb0Sxk3qjji1hVcFEbN7drXP8TIgq+z4SYjJ8s8n0KCKRW4F
         y+1+y1hqipXGgXlvXB+mNPWoxSASLCZbFPlPxgSYrcZrSllAPVi1jLMMX6eZBCyhVi7f
         naSI3JVh15cy2UZepa8f1ON2lEhaxyWhXZLsvWfsl1/ZZrhGIn3KCGhN93WKIxrX112r
         97XA==
X-Gm-Message-State: APjAAAWPG4KXOWXWtbYkZlK4Cxbd/qWmzq3oXGWO5U0BaatxF9ThvxNc
        mv1bEsxILKNsWAwteqwsZCM=
X-Google-Smtp-Source: APXvYqyVNiG19eszv1DY0YcDZcQN1aciZqj6gfPTL8J5HnF4633On3P7FwvAUAIKGJZz+shhd/HxLw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr68806329pfc.110.1564868104374;
        Sat, 03 Aug 2019 14:35:04 -0700 (PDT)
Received: from localhost.localdomain ([117.243.24.232])
        by smtp.gmail.com with ESMTPSA id 201sm95844106pfz.24.2019.08.03.14.35.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 03 Aug 2019 14:35:03 -0700 (PDT)
From:   z3phyr <cristianoprasath@gmail.com>
Cc:     z3phyr <cristianoprasath@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix lines greater than 80 characters
Date:   Sun,  4 Aug 2019 08:34:53 +0530
Message-Id: <20190804030456.10567-1-cristianoprasath@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error for "line over 80 characters"

Signed-off-by: z3phyr <cristianoprasath@gmail.com>
---
 drivers/staging/pi433/pi433_if.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 9feb95c431cb..74b6e2513813 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -115,11 +115,14 @@ struct pi433_rx_cfg {
 	__u8			bw_exponent;	/* during AFC: 0x8b */
 	enum dagc		dagc;
 
-	/* packet format */
+    /* packet format */
 	enum option_on_off	enable_sync;
-	enum option_on_off	enable_length_byte;	  /* should be used in combination with sync, only */
-	enum address_filtering	enable_address_filtering; /* operational with sync, only */
-	enum option_on_off	enable_crc;		  /* only operational, if sync on and fixed length or length byte is used */
+    /* should be used in combination with sync, only */
+	enum option_on_off	enable_length_byte;
+	/* operational with sync, only */
+	enum address_filtering	enable_address_filtering;
+	/* only operational, if sync on and fixed length or length byte is used */
+	enum option_on_off	enable_crc;
 
 	__u8			sync_length;
 	__u8			fixed_message_length;
@@ -132,10 +135,14 @@ struct pi433_rx_cfg {
 
 #define PI433_IOC_MAGIC			'r'
 
-#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
-#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
 
-#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
-#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
 
 #endif /* PI433_H */
-- 
2.22.0

