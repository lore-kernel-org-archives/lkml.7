Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF98C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9680621852
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad3wN7DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfGYGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:42:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:42:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so46864204ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iLLujW1HGNBaF9vKINmm53NiqEEyiuOnag8cOAMvxrM=;
        b=Ad3wN7DZ3DaVX+qdSYY/n7Z4eYa16reqYoVCW+9CBctuSaBnpjaAvPba+UtR8oySFW
         u2KPeLEjFl4v6b7KMThnfz3FPRvIH8j/3SGRLZMB5ugb19gStbP4E1M7XvJNMUnHTWsm
         oetHuZxAeHuOWt2EvdJjRwRMCvkoStHqYMgR7/K0/sExhy2Nv7R66BCyZd8C/Xf1OJAU
         2gc3iNJZMKUTjiMirznRujiLizt1BmbNt2ssMqJo46o7FRk5g0P5RrwkG66ZAN+iEbMW
         pC5No+YIvzF29e3l5AaEUgDlWiX8anV4KFBU779QKe2mmVAKat2MmqL8HH4ICXh4MPp4
         LlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iLLujW1HGNBaF9vKINmm53NiqEEyiuOnag8cOAMvxrM=;
        b=dI0Xi5cDY3yjA611jm7MwGj3iTblJwfglTNfS1AxummuNiHVatFjgUlW/LrDZpJULC
         B6bJu1F0WQ3pd0dt6bUt0o1seT/Z8J8b6a8uYA/HIm/wBrj19OWU70htK4VMY7I7hu5y
         BrI6y08sKfioYlc14vGtQUGMrvYEAK6u8bPzUlC8w2qocDpg81yUO8eYIUzNy9fUxkk9
         8Dkk5mcXVUNIuMXJ4W7h7H6yqTRWd5RfzVXOzCIxxpwXjKyajUOyaFMnqh9abFpzgTqz
         dY4ZYXyMo82zbPP3HgaBUYhkvZV9XBeXnADvAKmjxnJ5DG8/m+YcCfrsTwskhHjm1lqH
         kgNA==
X-Gm-Message-State: APjAAAWy169LcnFSTcD6CjiCKsLs+op9A0ga8dGfbvdT+ntu56Zp6Apx
        VsUQGt4Uf2zKuF5JPkvhZDEDqTgHw3K5Cw==
X-Google-Smtp-Source: APXvYqyW+vA7mbpMIyfZrwAhHjjVFXaBRgs6XTatIDRIjn84TD2zzAs1Lubyx0Bi85WhcW4tWfspIg==
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr45397271lje.240.1564036969025;
        Wed, 24 Jul 2019 23:42:49 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id k4sm8939218ljg.59.2019.07.24.23.42.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 23:42:48 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        myungjoo.ham@samsung.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max14577: Add irq mask IRQ_ONESHOT
Date:   Thu, 25 Jul 2019 08:42:38 +0200
Message-Id: <20190725064238.6435-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fire irq again until thread done
This issue was found by code inspection
Coccicheck irqf_oneshot.cocci

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/extcon/extcon-max14577.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 32f663436e6e..97c021512ffc 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
 				max14577_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
-- 
2.17.1

