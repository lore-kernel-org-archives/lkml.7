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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B33C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2572190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwFSW8tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfGYGnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:43:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43169 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:43:47 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so33665041lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zMjDy0l3gHU0qfVupdWJIxO6sqcC5KQ2Rmjl8R1IVqM=;
        b=iwFSW8tOdbAN+Vddws0YUzKlThaVBuZ1OlSL+y74gy14h0Efh0JIwsJWEvECHxgQA1
         iMc1y6MfSGTzi8PwLqhlTnU6kqXoSOTubxCfx9WNM32hnq8nrYb5rkIKRF8guZ3X0AgN
         RBxoMqs3v1cAGG/zWZ0yIwMFWuHPm8yvef0J4iN7g/x2r+1TbIoFl4ockpSGRWFZ8mz8
         OExXXLazuTjVKlaeqn+Ajo1NS+BRY4oieKWXKc9xx56zpid8Cf7UnzjUMvBvvozhZN6u
         aKoZ8AtjXwLO/usyj6IPT/CnOONTEn8NqG41CmCIeNf54ZppGQ/wH/1S9ufoNqrH7nzF
         mcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zMjDy0l3gHU0qfVupdWJIxO6sqcC5KQ2Rmjl8R1IVqM=;
        b=nIjXdzQxTUKUWVPC5qYauplvIwzjZl8FDaEv3y/peEBnoRbM6fBr4lp9I5aKsIXGi0
         M6MRRKNTXApg29v3PPj7H0KX1Za8Lpo3m9angkiDvbUPuyzXds21G4l01bOBWGdZgI+P
         ufJucsPt8ECSI1znZ6rCl9DpI/yB5hTEqXbh+oSgGTqnH6n+i8mpDoUww7pzxbaEwewY
         BEk5043c4frxsH+ZdlvJpqeelQ4J+lN1PWd/DGU3u24ehFn5dHS+cLC/rSRpXefgsEGv
         OtrC4Q2dKrDSYasS3ahUQsxSfGiSTube8atqS8SUPwiREiikPc0HIsbepKgwiyIjEGGN
         KXDQ==
X-Gm-Message-State: APjAAAWMnFG5kuOJlvWIejhHK1HDxlPke6XKN3JYSujVvCKiVS5jxMug
        MsrFvB1ADiCDd9VSds9Hgdo=
X-Google-Smtp-Source: APXvYqwNNwKY7C1m/gQEMZVuyh1VEbus9TPV6eSoa9O8Z/SXKQ0hs6FwQQi7Yy3ZMkppUHXEPVlpow==
X-Received: by 2002:a19:6e4d:: with SMTP id q13mr40977242lfk.6.1564037025498;
        Wed, 24 Jul 2019 23:43:45 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id e87sm10204631ljf.54.2019.07.24.23.43.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 23:43:44 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max8997: Use irq mask IRQF_ONESHOT
Date:   Thu, 25 Jul 2019 08:43:34 +0200
Message-Id: <20190725064334.6550-1-gomonovych@gmail.com>
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
 drivers/extcon/extcon-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 172e116ac1ce..c347365242d2 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -660,7 +660,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 
 		ret = request_threaded_irq(virq, NULL,
 				max8997_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
-- 
2.17.1

