Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87756C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE72068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DQeBIB0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK0Nfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfK0Nfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so26660154wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7V+xHNIyZ2oclfWUQxjk4vsWRTb0u39sFlOPPMozoc=;
        b=DQeBIB0MbsdD5azj83qLyq5xXygJ8x270ElD+3EiUQe2zs2MUdeeLUql8faCfqh2lK
         BeO3Kc4vdsWEorFyj3CEpadokZbQLp9jbVzasxJr1P3S4WF3iuwsf3JagZlD8GjHqqDA
         evotXPIzeD6khCPCkAfafJ0SkPZGg8ojgICVY1mtqCFGSYWHN/4kJwvlYLTqZeDHD7l5
         AXvgRd0xK40HFyyttyVDgNDQMbj0KF0VTukzhN2bZja856yfS5hG2oz8PVVovaYVCCtx
         5+b43hjwsVguZWafJVrQtqQMDqgADztTM95RP6fFhFxThF/kbxssVNiyAzwBmfcTdOlj
         AXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7V+xHNIyZ2oclfWUQxjk4vsWRTb0u39sFlOPPMozoc=;
        b=q3qbfFO0y90AhYVaTUp+gCi/aYXjyjYW+rXvwgHZAzJClOHWr1b42lDsNlMBAjMuF6
         4jLxuh7frxmk2Dw4xsO6iJv9WMQNbVohk0xw+uUId2wiJjnKB44xHLfrVgFBRIcqkt1C
         NYXcZYxJqJ+YMoKVRo73RbNgyctPTjvWhvbOkub4gOEZ9PzmILbvBdi3JTHUL5zrAgk3
         BjNn6YvUZASoaGaG9ijYtoltORjMYnPGMMArMUGhUwn6Jryaj2CzxjkZ1Nptan6l2WYw
         xfMCd6YHqxr7Hro6eaKT6nmfcnbEHsMUiTD+8F79ykbgj3uWjeiRPfzlg4A3J//5y8Yq
         JI+w==
X-Gm-Message-State: APjAAAWsGXuNi2Eb083NyCbV/L1Da0eKYQ+vij86v0LGMm55G7Lg9A0N
        th/D4d4ctIPx3OgevgH1Cs0oVw==
X-Google-Smtp-Source: APXvYqwaKYrlokMX+NiLacauZCYl0mXZel/xbNs/uoO322ginCua9tDEtUexwnlvD3GMv1QHlyzFuw==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr39661533wrl.377.1574861727081;
        Wed, 27 Nov 2019 05:35:27 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/8] gpiolib: actually protect the line event kfifo with mutex
Date:   Wed, 27 Nov 2019 14:35:08 +0100
Message-Id: <20191127133510.10614-7-brgl@bgdev.pl>
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

The read_lock mutex is supposed to prevent collisions between reading
and writing to the line event kfifo but it's actually only taken when
the events are being read from it. Also take the lock when adding the
events and checking if kfifo is empty.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 17796437d7be..d094b1be334d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -818,8 +818,10 @@ static __poll_t lineevent_poll(struct file *filep,
 
 	poll_wait(filep, &le->wait, wait);
 
+	mutex_lock(&le->read_lock);
 	if (!kfifo_is_empty(&le->events))
 		events = EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&le->read_lock);
 
 	return events;
 }
@@ -838,7 +840,9 @@ static ssize_t lineevent_read(struct file *filep,
 		return -EINVAL;
 
 	do {
+		mutex_lock(&le->read_lock);
 		if (kfifo_is_empty(&le->events)) {
+			mutex_unlock(&le->read_lock);
 			if (filep->f_flags & O_NONBLOCK)
 				return -EAGAIN;
 
@@ -846,6 +850,8 @@ static ssize_t lineevent_read(struct file *filep,
 					!kfifo_is_empty(&le->events));
 			if (ret)
 				return ret;
+		} else {
+			mutex_unlock(&le->read_lock);
 		}
 
 		if (mutex_lock_interruptible(&le->read_lock))
@@ -969,7 +975,9 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 		return IRQ_NONE;
 	}
 
+	mutex_lock(&le->read_lock);
 	ret = kfifo_put(&le->events, ge);
+	mutex_unlock(&le->read_lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
 
-- 
2.23.0

