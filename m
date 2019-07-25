Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659CBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F7720840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH7fJaRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390866AbfGYJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:56:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfGYJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:56:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so22495629pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WbY06pGx4xfBMBjQ3bM8KhDBbMliaCTCe0/xa/K2Ezk=;
        b=IH7fJaRbcSgL+CYKVO82kjihUDaMMuveROBAAcl0U58wpsySgNR4ZbgQ8HzLV1opPe
         PlINuCAXy0AE3sUUejcUdgVSld2I1sUgazyK4JPuAYeiV9O8jaOWg1zUAU+rmMNZlChU
         jGZr9aqKxGNrUbO9YG6VA5q/nMJirmLnjKW9TE8D+Swko05OX4FWRG6O/mtN+UU52bCp
         eexyRSUN9G5GlDXaTn7MPP1wCJE+XHlptKtO7IFLC51rhbe/gVwcU4OoPymaDrooew9A
         XFr7qHyvbXFA09qtZKFb9PVOrhK5Ra2zEBG9vgNv59oU5BmHJuh2u9pDz5+SVtOWI//f
         S1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WbY06pGx4xfBMBjQ3bM8KhDBbMliaCTCe0/xa/K2Ezk=;
        b=SkGvkdEPtfYFeLqY5Uos8FB6Ib213M5puzc7zbnubKrG/G+ldzZhC8pl+RSsOwqtS/
         Zn0yy9jfvMRdOw2McIV5UgxN3QjZ93+lOHYMMh74Wx3BmqLAy/0KLyUxRNoY5bKlY2HG
         mXp93trm5WWsgFRHWz2IxsXmGEncoBKyYZpwdffiIydZHAB1rAmiH2agzDlo2EfENN91
         TUMF3osZijhif3Blz4XAT3AVnAfIU/roCPvtvmuW2qcpXKef1IH2JDFf0H6gNTVQYeCX
         rmlJG/n4bR/ENRS8iM4V6cbJOWufGmUpfzdsai+NgRFl2NQQmLtf5Trycp4xLFs/DSh3
         pFPQ==
X-Gm-Message-State: APjAAAUQNaN/cLoVonunkBOq0rodkTCtQjiCaT2F51KcQ/RxWC5zv7oY
        Fq973bhR0EBOsZaU2R5S7mYySA==
X-Google-Smtp-Source: APXvYqyuG8cSKtYKaq8SMZvcaSnlLN88gS7Vc2pHbKryBUh9RET50OhDriRg8rg6qipLaUuuEdEw/A==
X-Received: by 2002:a62:b408:: with SMTP id h8mr15431548pfn.46.1564048608476;
        Thu, 25 Jul 2019 02:56:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l26sm44006103pgb.90.2019.07.25.02.56.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 02:56:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: sprd: Change to use devm_platform_ioremap_resource()
Date:   Thu, 25 Jul 2019 17:56:30 +0800
Message-Id: <ff410d312ed0047b5a36e5113daf7df78bcf1aa8.1564048446.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_platform_ioremap_resource() function wraps platform_get_resource()
and devm_ioremap_resource() in a single helper, thus use it to simplify
the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index c31b581..a32e809 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -1020,7 +1020,6 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 	struct sprd_pinctrl *sprd_pctl;
 	struct sprd_pinctrl_soc_info *pinctrl_info;
 	struct pinctrl_pin_desc *pin_desc;
-	struct resource *res;
 	int ret, i;
 
 	sprd_pctl = devm_kzalloc(&pdev->dev, sizeof(struct sprd_pinctrl),
@@ -1028,8 +1027,7 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 	if (!sprd_pctl)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sprd_pctl->base = devm_ioremap_resource(&pdev->dev, res);
+	sprd_pctl->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sprd_pctl->base))
 		return PTR_ERR(sprd_pctl->base);
 
-- 
1.7.9.5

