Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B436C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0F2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="d2cdxQQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfK0Nfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44507 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfK0Nf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so26660045wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwQtKdAUQY+SBl5OsHs80mv2U9tLV35lkOjHDH8uz/U=;
        b=d2cdxQQ9QM6aWaCcpY6BPsgrz80U8Fwcf2w8R3J7+De+fTehFpP77InXdBpOshmtG+
         32etBPEhPm69z+HnzUbWIXJmqF88J66XAgQl8duvoOYffYObmQYfJqYiOgZsL+F8OGbM
         9J3aA3CJVF/GVScfiKoOkpwruakMZhbJgAta3PvgQtnlC2VTUGGDAqt0xceZ7b+jOZ/V
         B+2C9t+orE3i5/ixDEQByG2iCRCllJcKFVRZCBMIP6eMtvUShSkWMB8wRJ0VDuR1dh6r
         D2IrBbw4zC08FxiILk2FxWaw1TSMKAKJomt2K7GIEm/kbRTupkA8JCjd6W7ltZqQbB56
         Q0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwQtKdAUQY+SBl5OsHs80mv2U9tLV35lkOjHDH8uz/U=;
        b=qHHU+jtdtqXuMFYcwmcoA/qdT2GsljugoHEpn602MHUyLRjGC5A7S03kFaa+IkSHDs
         mbBjHwILhLobnaQz7kBCo2L8ZX+kb4MqUqpDUThM/tnmnF9S6D/OZME2QvVP35thi9ty
         cMVVZxiyX7E86d28vrHBTQSOueGYlZnwQj5kS6YD0UFeHEM/mAKXFBg2/Y36tYpq3gA4
         w/FWQvo8I/Z17VbdHKVdcBSCK8KEk1isc8d53RxqqXVIYgmVGwNwAcHCLohxphHt2Qor
         cGifLJFAFiX6wXkHfeGm9tz07aCGj1+ruy71oMwlhY+O+4+cik2dtHt2g5AKEXq93/q3
         MBQw==
X-Gm-Message-State: APjAAAUhqZT6pk4g0L+OA8oz9V1QpVibvW95bC/cWKsnSWrdL/SVOC84
        w24IKOlQ9Q1UbGmQAS2eg+h4Gw==
X-Google-Smtp-Source: APXvYqyY8p/I8uBCHcvNGF+XJfKMVeXXS67kHVI4ZRKWPfTZ/XQUA9ardXrExDJRQfWZ1TU2jqN73Q==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr20934477wrq.196.1574861725481;
        Wed, 27 Nov 2019 05:35:25 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/8] gpiolib: use gpiochip_get_desc() in lineevent_create()
Date:   Wed, 27 Nov 2019 14:35:07 +0100
Message-Id: <20191127133510.10614-6-brgl@bgdev.pl>
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

