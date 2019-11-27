Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F77C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB89F20722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lsmokxWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfK0Nfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34239 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfK0Nf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so4921047wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90rmEcHqIRhcxzdKSYRA7QCcxU0JzYE9Vo2kuWKmjpQ=;
        b=lsmokxWSgSGnB1sFt9+HqrLY9tkt/xgtaUuFxPHus6576V+rgiFPDhEQUqdVxzITlF
         XGqHrjUM0QnF2BglcFVigQwP8eOceKRFkUcpurb+GEsSRAU8BJgF2ftB0Q+NE831WV6R
         jhrqEZewUTYZ8VKbzhI+rT0Xmio5K3PCGOHM9UrudVUMqrTufh8kX1MdHZIRBclFu6x3
         F6lC1gnkF8R2u39aHSyiQUVmwxo9kLNxzEJsrbwucYlqYXmufLqGzoT4456NmNsrWM60
         SYNiOGiJzaQxLNnPh7/fAktljQUpDjQA7stkBwzK4+AxE2GGXHh9u1IOVVpXFowYooLO
         acCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90rmEcHqIRhcxzdKSYRA7QCcxU0JzYE9Vo2kuWKmjpQ=;
        b=hcPeXliNqlOZfpUDQbBl8ZlCjph1qB+M+mVZ4NIVvAojommYy1MEp5WxyMRtiaN/sx
         bxpunVVyig0AMjHzZAchO79wm1ZH88GgGf+WE75n8cOT1qu6S4nmH4bLBwnX+cL49snf
         LDbEVrJlP7QPvr3h+Qxxdq1j54/fG5MF762rr8vGG/JClRoMw4vpLbRk/SypgUF14Una
         BtQMnspXX/vTHDUNnOH4bqITv7wQ0xsLfuJb+3mZ3tJxEllTOSJAkgzOTXomXmGFZ159
         S3PepIlxvJeWXV7/VNcSikK16zYYJDVU8uIfEF5IzS5fd/B7IrPUqurRiWzhVL8QdBi9
         CXgg==
X-Gm-Message-State: APjAAAU9RP1IOz93HoYO7liUQFQo9iAaR5xG7I1A5MSgI5hhNSU8kS9f
        MnCP6vxLcqEgvt1xVtjJgNt14UOe/T0=
X-Google-Smtp-Source: APXvYqyEKbJhNA5wSqMWKJS3HG/CSd1V3ZLl33/JEaEa1okf7X2eLlplHQ9Cy5ys1gohyy+xvZNFpg==
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr998905wmk.60.1574861724196;
        Wed, 27 Nov 2019 05:35:24 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/8] gpiolib: use gpiochip_get_desc() in linehandle_create()
Date:   Wed, 27 Nov 2019 14:35:06 +0100
Message-Id: <20191127133510.10614-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
checking its return value.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b3ffb079e323..6ef55cc1188b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -678,14 +678,13 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	/* Request each GPIO */
 	for (i = 0; i < handlereq.lines; i++) {
 		u32 offset = handlereq.lineoffsets[i];
-		struct gpio_desc *desc;
+		struct gpio_desc *desc = gpiochip_get_desc(gdev->chip, offset);
 
-		if (offset >= gdev->ngpio) {
-			ret = -EINVAL;
+		if (IS_ERR(desc)) {
+			ret = PTR_ERR(desc);
 			goto out_free_descs;
 		}
 
-		desc = &gdev->descs[offset];
 		ret = gpiod_request(desc, lh->label);
 		if (ret)
 			goto out_free_descs;
-- 
2.23.0

