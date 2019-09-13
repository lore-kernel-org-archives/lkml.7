Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7017520830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avvjYfke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbfIMXXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:23:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45116 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404288AbfIMXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so16016429pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MAMlkRnO5l7BTKTwRIiopLRzEQTrPpsCd+4MsukYmNc=;
        b=avvjYfke73Z96ZWvIbYCugt7OGDcicXE9i3gpl/jtc/mPF/nkwA0xUREeCTHc6/1Yo
         DvcG/w/Bapcvdhv6brjo01L2EV3Srmpd84r3TyQSho54RnmYc0uYGRmwIF0LZkMOzIq7
         eM28BvOangzerEIxjZYhfXvTyoLQHNN4sMUAIJl8QgnGj2nJn07IIJ0lxOTPkCcqyQz2
         qdloVaCV9GtiQYk8AiWpt3GlL3F9V04nlc1XOJNjVTGWissMygY+5hkxm6+eDOvdEQPo
         XiZXPIQwHTZ0od/QG+fHtrBRdBvZMHvT0UkhhHOBxkqXzzFqiY3rSwaBKSzqT9iaVgRj
         jniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MAMlkRnO5l7BTKTwRIiopLRzEQTrPpsCd+4MsukYmNc=;
        b=qOEZZOkiGce+f07Mk+NIMk8IRPokABAYqkAZecrYlH3FHyUT/zGft+fxZhWy5cDGLb
         HRpliDlJM9mdsHmb30xT2HzRda51Alj8UUV867E7QUPdHNgNkoynBuNxEjNG1ah5j5KR
         cv9d4MPlyHRn613p5fWvMuqs3FSWxgteAtkpbcmAH1opWQxGpJ6s/hj/fzbx8BmfruDP
         2NRS/UbIi8VDPkHv8lB2s+EbkjY5uhpWLZB7cfC7FfE3YiMW2Uj6wNa9Ky50kROjnCco
         zpSnYMix/sMi9yRifWH0sBjVnckIY2IZ9jagnuWTh/GI6tr58Gl4twbeGzx6yqo5xbrA
         XzPQ==
X-Gm-Message-State: APjAAAWHsyrsEUGhdp+883Q5hr09dZMR9gbczZbi+mUyES/J6MCtyxEj
        P1O/msDlKRo/ExS20j4h0+HmE2wm8GU=
X-Google-Smtp-Source: APXvYqzAIwKqeTSg6jM8eD1brvTKO5HP6rLyJWTl41+PZoAF+Zdi76XGeyWGwBdZIZYO4v6HhzU3yw==
X-Received: by 2002:a17:90a:c38a:: with SMTP id h10mr8186597pjt.129.1568416970743;
        Fri, 13 Sep 2019 16:22:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 6/7] irqchip: Build BCM283X_IRQ for ARCH_BRCMSTB
Date:   Fri, 13 Sep 2019 16:22:35 -0700
Message-Id: <20190913232236.10200-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that irq-bcm2835.c and irq-bcm2836.c have been updated to support
BCM7211 which is under ARCH_BRCMSTB, build both drivers for
ARCH_BRCMSTB.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d1bb20d23d27..ffd5f986172a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -116,7 +116,7 @@ config I8259
 config BCM283X_IRQ
 	bool
 	select IRQ_DOMAIN
-	default ARCH_BCM2835
+	default ARCH_BCM2835 || ARCH_BRCMSTB
 
 config BCM6345_L1_IRQ
 	bool
-- 
2.17.1

