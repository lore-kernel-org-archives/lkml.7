Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37A7C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD2B24683
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BnDEMX+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLSRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:15:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfLSRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:15:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so6230363wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Srugj812bEad7lTKigN1hZIzPJdNdOMlpYaAJOfYAF4=;
        b=BnDEMX+afx9fDJ+i/VCutbb8AFolX5d7d9pqZ41uk9qRHnoY91mJh4l4JDsNZVvsPC
         4wUTIz3Wcci1tRsQMdRzDp+3ZX5UvXXgUN3dhWN2F6UV2KXG4MLet6JX9UtunslNOfck
         xEFcIOBjfx1a5+xdwb/ZMftjszOTd06KorkIx4lzzIkkrICHB8XwgJOqz4K89bpXiqCL
         k3f7nKuetBXHNLEwLLvffqZUnBuuLWx/kYsxjw048Xv4FT67Q7psPUM/xnxUyVwz/NTn
         6sOkjcdBFk4bCbWO5I/MuG5LFcVGM4L64x8rvg/rOU96xlC2fq67mvYUHUKHpTp9+31s
         6fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Srugj812bEad7lTKigN1hZIzPJdNdOMlpYaAJOfYAF4=;
        b=Gkg94RBADx6LvGHW1oKSxskryMFpPmpSgz7wstehfxBQDo1xG7WEvA15BA0trh/35m
         N8z9FL3NZ9yjcEr95JF+RtIFTzhJYb2bQhBH/4MVUSZoksaxaLnEIaICy6qiATzQY+uh
         2Rejto/gP8R+swpXvw4iSRny6TaWIl5SUm26AEHrdoePp+F3PockPAD13FgyUfeYiYDN
         Q3/saiHU08HGtjdWNMBcYpcRg5cM2zTt8hkc5jm55vQSMgbLGXJtOvD03PNbBBVof/7L
         Sl+kiALBTkgjxez97nE1l+bmVfMENK75BkqzmMLs7Mr7xmcvrZXqcAY4UUW+kUzjDTrD
         L7LA==
X-Gm-Message-State: APjAAAUDqLfB9RiecoGO9fp/TS3Uav3YAbMpnFvW8pmIjW8TNbQpsmuP
        p9M+bSFdCpbHCV13lNRzICGcfQ==
X-Google-Smtp-Source: APXvYqw9BKPU3MwZXjSWVFbnLdLXiP4QsXclsAm4IhCn5elS0bX/IO0FaokjhPdH92FkGCV0lPANdw==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr11583568wma.5.1576775740982;
        Thu, 19 Dec 2019 09:15:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id q6sm7401428wrx.72.2019.12.19.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 09:15:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 05/13] gpiolib: use gpiochip_get_desc() in lineevent_create()
Date:   Thu, 19 Dec 2019 18:15:20 +0100
Message-Id: <20191219171528.6348-6-brgl@bgdev.pl>
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
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6ef55cc1188b..17796437d7be 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1009,8 +1009,9 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	lflags = eventreq.handleflags;
 	eflags = eventreq.eventflags;
 
-	if (offset >= gdev->ngpio)
-		return -EINVAL;
+	desc = gpiochip_get_desc(gdev->chip, offset);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
 
 	/* Return an error if a unknown flag is set */
 	if ((lflags & ~GPIOHANDLE_REQUEST_VALID_FLAGS) ||
@@ -1048,7 +1049,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		}
 	}
 
-	desc = &gdev->descs[offset];
 	ret = gpiod_request(desc, le->label);
 	if (ret)
 		goto out_free_label;
-- 
2.23.0

