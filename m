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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E08C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA476207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjZhdwZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfL2Iex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 03:34:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34083 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfL2Iex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 03:34:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id x17so13520202pln.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 00:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KfH/WTQPO3RAECd+zAOPLsSZgZBZzVlcd2UC7GE6hHI=;
        b=HjZhdwZFBILUa0gDqSqR/mg+0PQwknRsIcB/VLzPUY+J+KMvw9OungGwFD89RHhSkE
         EJiA7z5nkLPYbEyIuAY3IVyfmsnS/wgwShJmDjEqjBYs8QV3V5WbO7rVqruuxCs02Cxo
         VG7Beby37w6OC9vJGZWgaOIovtAvtIdP30nxzaWO1bq7UogRyYh2k7x7RloFVcuV/zeR
         +iMHzyTinyElHp5ankRYcCVfT1dnsQJyFb8acxL7YCOAA5rY1szoL6AxvVVVhjaxPrUb
         /Q2D4kmslrhN7eMuygWxjfl2NcoZRu8zsz7RP0+riWKuZ/dCw0hkoqjlpbftgg7MPpbf
         dgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KfH/WTQPO3RAECd+zAOPLsSZgZBZzVlcd2UC7GE6hHI=;
        b=bgJgJt60tHd6EDpSinpW6nSt2EtLg1lJFtsV+bWpsvoDFbPixjwJ7oZSviX0F6t9Sa
         rYgDId1+x7lJYQlnaHgNd6W8DRm7tfsWYQCZ3TWSX8iny9nFSBwtyRI2EZGqlGXP0eDw
         s9fnihjDaiLNXDGk3EIvUv51EBkbRJ1Ep+gbBWztxybr2cnBy1TqU9L9VUM8o8zbaQdl
         75cW42U3pHZ7aeyYHUfvbmAxXHumg+N+pg+dVRUEEcSad2SPx2+zat7P34Xg+Ku6+JWp
         DLnv4ifphynUVrtf4Ezf+G6lTVYiQ915M6U+1WThI1hZJIRpJ+6dW4BV8Pfv79mTzpcn
         lwRw==
X-Gm-Message-State: APjAAAVByCundIkezGbxbo5HhzMSK4d0MlOUSoPx9eDEKHCgh2Njcsfj
        E23OWq8GbCagsy4y/909Xc0=
X-Google-Smtp-Source: APXvYqzbiowcOGtzTTQUN2pAqzBokwRtvlna4OMKNSR1mYzHhsYfAJP3oRRLZpQCCvEh/oZLdtTBPg==
X-Received: by 2002:a17:90b:1115:: with SMTP id gi21mr38495722pjb.95.1577608492912;
        Sun, 29 Dec 2019 00:34:52 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id f30sm43166569pga.20.2019.12.29.00.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:34:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ira.weiny@intel.com, hubcap@omnibond.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] platform: goldfish: pipe: switch to platform_get_irq
Date:   Sun, 29 Dec 2019 08:34:50 +0000
Message-Id: <20191229083450.8178-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
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

