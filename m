Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4CFC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FF720838
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce+EFQyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfL1TGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 14:06:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41348 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1TGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 14:06:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so16072826pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 11:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ExkNmsId9T+IvJawOK9l5XqVWSk7e/vQjn+tqWFgqBA=;
        b=Ce+EFQyTJmQ93Ihqs4/E8gy7ty2ORo+rR2upNWrFHg8HE55TplCoOOTq7fkVCLYpEA
         /B0gQ27VwJJka5SrxxJ23JpDXDkVBoCdBdq0LWKJZb3GfmD0FXxRv7ynK9cvVHCcmlwq
         8LlKAUfIafn4yBgpiICP65i2jMgUtyJ13YKAE5u16H4o3lqE8pCX7uzLNIBPfmxnu8gb
         cCphqsBKkLlBkRPe/Rg/pt18syTCsND0VU7MDo53p5LQGPA8HU7osvEqMK6x+5v/wM0b
         NGQq3H8GrKK1WCRvn9t5s4Q/tI4H1UcmjqKdLeDZXSvTuXnQ4jwmJckROY/y7+eqTndn
         XJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ExkNmsId9T+IvJawOK9l5XqVWSk7e/vQjn+tqWFgqBA=;
        b=sKL9+nETrrfL7agtrZA2vA3ywlBVlwQpEmfZmZzus6pX/DbzOIkliv0FR1wt3/TF5/
         Xgjg/OODfchhmJFy9PLngkNzZ+WHGLuQSUWcn1/tnVS8cfZIrKnCeEr0/qWdcx8VfUz+
         rTPX0ceqM+vANaqMwWQzi6soQb6kj/AxZIgnYu232Avhbr/uSvLJGy1zYeTSS+fJikJZ
         3AjLiuMGVsSYXXaIiLkNTBB727BY5q2iOWGyNs1ON9Qrm7soBXF2G87QRX6C3BRxPhae
         59qwRc/6skSTHK4src3f19ff90aC/9WfHsxy2jgPZ2+1v82joSMgLElvb/gxV1ghwIKN
         4EgQ==
X-Gm-Message-State: APjAAAVATu17OoJEoUbMWycZ7jzs/RZq5pWIbxTbuwWQ/wDG3h18DpK2
        Ds0HZOk3FQ28xEBkpEYEvJ4=
X-Google-Smtp-Source: APXvYqw6F3EIJfl5MzAdn7+WNC3mpGfr9bNTwK4QG6AMwATj/5WwYSBlLMxLhTsD1cjLhQewg4z4Kw==
X-Received: by 2002:a63:1502:: with SMTP id v2mr61363657pgl.376.1577559993191;
        Sat, 28 Dec 2019 11:06:33 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id x132sm44273943pfc.148.2019.12.28.11.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 11:06:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, andrew@aj.id.au, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] fsi: aspeed: convert to devm_platform_ioremap_resource
Date:   Sat, 28 Dec 2019 19:06:31 +0000
Message-Id: <20191228190631.26777-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/fsi/fsi-master-aspeed.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b310c2..edd0b287e7b7 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -422,7 +422,6 @@ static int aspeed_master_init(struct fsi_master_aspeed *aspeed)
 static int fsi_master_aspeed_probe(struct platform_device *pdev)
 {
 	struct fsi_master_aspeed *aspeed;
-	struct resource *res;
 	int rc, links, reg;
 	__be32 raw;
 
@@ -432,8 +431,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 
 	aspeed->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aspeed->base = devm_ioremap_resource(&pdev->dev, res);
+	aspeed->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aspeed->base))
 		return PTR_ERR(aspeed->base);
 
-- 
2.17.1

