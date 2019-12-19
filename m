Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE92467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oOE+JHQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfLSRQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:16:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34603 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so7504849wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKnof9NnGnWaz5Wg5PNLvyOb/wEdh4vzWoDXW3CwsIs=;
        b=oOE+JHQMOaM2l1QZYogpzJH6M7Wn3Dp2n5HfS+vV9Nr7K85412tv8ZdYFI1dhaCtDD
         ++YFBXokMGS6KEFagBjki2uJesGJIgREumCwOdU9e2+v21zYxDYi2U8oPDVG9OcEm7/i
         xZbd3W+OlbjSLaOzwMM2rg3rETgaiRzWxf9onnmMPPKOYf+Fe3x2+WcKN39U/41wTmpN
         ZkTueFGigG84uc7joqvVY9tmyOgWWcddHiPhSXHcJ81j3fA/cY7nD4CWzX8cGrIWM/Y7
         XOxgbm7YkMD+lLRoLBtBdyIuSKEUDAOf64BBogI3nIhsGUCAWX4zLuZHfvutISOK+xBT
         fTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKnof9NnGnWaz5Wg5PNLvyOb/wEdh4vzWoDXW3CwsIs=;
        b=mHivEt5vegjEcUNbJp5VOTDIEdU51WIPRHYmSR7QgEs+2H8rUvO3oP2G5nn3thNCfB
         WeEFMjjxrzJ+W8li9pBiYuuKWbBz7UYRxmyvLZ1d47SH16tC7F3JIZCZIGqdJcs2G/x6
         lFq+Cd8O0hq4MEILWxAsH41BZVCa3aPksugtkMvcjnMaRvcUAx1glYh69fQwxZA2uV3z
         NfaQ6G4KgHQfSneOh/ksiBqQZvZW52/0MAOq12TGmn6uHNUqNcqkOm7jpnccb/3cmI/N
         LKqnkNp9tlJHbnIGhIofmO0YZ/O88C2GgL6bUYDGnNnc9Z2z/y9KP/zr/R+LduveMrLQ
         FmSg==
X-Gm-Message-State: APjAAAXS1eRLwba44dovWqfe5HyliYj65B7wMgCuFtBJkggQMEmWtx4S
        INmS87iJHGHn8KvB4Mg1H4IT+g==
X-Google-Smtp-Source: APXvYqxyed9XQDWxCA7f59327N+KYa5GAs0nDM+2pUGQ5XO2gXAyJSlmK01+XGMkzke8l8r38BZI+w==
X-Received: by 2002:a1c:6404:: with SMTP id y4mr11340453wmb.143.1576775739740;
        Thu, 19 Dec 2019 09:15:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 04/13] gpiolib: use gpiochip_get_desc() in linehandle_create()
Date:   Thu, 19 Dec 2019 18:15:19 +0100
Message-Id: <20191219171528.6348-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191219171528.6348-1-brgl@bgdev.pl>
References: <20191219171528.6348-1-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

