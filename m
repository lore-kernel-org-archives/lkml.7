Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB047C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F382208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 10:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDe/04/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfL2Kna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 05:43:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41588 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfL2Kn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 05:43:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so16975621pfw.8;
        Sun, 29 Dec 2019 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KfH/WTQPO3RAECd+zAOPLsSZgZBZzVlcd2UC7GE6hHI=;
        b=FDe/04/l9yK8IA/6QqwpbWhZUzluJkbsGQjywcYB2FDblu1uRPpIv4NCxRwV4Zy143
         dSbJ49VE1dz51O4kMA8aMGgZVhFjI1UU3wPppXOWgyF74JppWCQGJR+aKcdx9fh8ZMrN
         zWj5oS8YJ1K7E7cYWTLaUN450rUnMAQeOKfRUszQIDbB1Hl02+WWckG1Lx+UwRJ0a6sz
         evUsxsQXPN0CcnC4JQSeUenOVRFSLxR02hr13KRbvtpJbgjoFB1X9oBlzmQuJ82uWPKY
         36z7ZanEDTdBVF+rQe8I/bzw06QseB0BlZflyQCyxejJg/5KUq4HKR6F43Rfh8L2cbit
         z+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KfH/WTQPO3RAECd+zAOPLsSZgZBZzVlcd2UC7GE6hHI=;
        b=hsEt9v+5Vu7bRNZb52WyiA0S/4pcmPz6cj8dEI5c2qA6ecwJsfvDz2xZVgaReKp0uJ
         nMA2mdU7WBqBJLpfdfyVqO5ecq7vvdkQvSJDoLIufQgICAD9yzY3DrWflDIGCTIpIvq8
         OUUIDokTphRO1Jq4MXLC/RKVr+5mxr8kzIuB4s1/XLaF9qHvyAkuQP+EPee47Wjk2p9S
         j9bVhiVg5F5WzT/65RMGX5q/M2YlsEnbH4kzG0g3EJlbaAeH45jlumxqIk7b7gCkZCP7
         SIzxYm6liZECS8zrrSYtBX4HaXXtb5FWiBdHdlvfe0T3mOzMNOk7tSkNymW4p3jSPjDC
         2Qrg==
X-Gm-Message-State: APjAAAUpWWkd5mPmPM0aOcEsT8KDOen6tGr/EpxuBdCkDiouZuLOH1DF
        OkhdaB8BJ7LMUTY0qs/VwEs=
X-Google-Smtp-Source: APXvYqwymhuy1y05JGC5Cx5fr3Bj8oUlR665vj/lUDz59KKc+AuODbNbeuiAgOVLL2CuZisSTVM4EA==
X-Received: by 2002:a63:d00f:: with SMTP id z15mr65191432pgf.143.1577616209060;
        Sun, 29 Dec 2019 02:43:29 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b128sm43732589pga.43.2019.12.29.02.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 02:43:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        bgolaszewski@baylibre.com, arnd@arndb.de, sboyd@kernel.org,
        mchehab+samsung@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        phil.edworthy@renesas.com, suzuki.poulose@arm.com,
        saravanak@google.com, heikki.krogerus@linux.intel.com,
        dan.j.williams@intel.com, joe@perches.com,
        jeffrey.t.kirsher@intel.com, mans@mansr.com, tglx@linutronix.de,
        hdegoede@redhat.com, akpm@linux-foundation.org,
        ulf.hansson@linaro.org, ztuowen@gmail.com,
        sergei.shtylyov@cogentembedded.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] platform: goldfish: pipe: switch to platform_get_irq
Date:   Sun, 29 Dec 2019 10:43:24 +0000
Message-Id: <20191229104325.10132-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229104325.10132-1-tiny.windzz@gmail.com>
References: <20191229104325.10132-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it
was not retrieved earlier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index cef0133aa47a..a1ebaec6eea9 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -913,11 +913,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r)
-		return -EINVAL;
-
-	dev->irq = r->start;
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq < 0)
+		return dev->irq;
 
 	/*
 	 * Exchange the versions with the host device
-- 
2.17.1

