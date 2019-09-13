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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B65C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AFA20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPrb+mY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbfIMXWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46765 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404271AbfIMXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so16007216pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmmruYs8eLLY9TVJPuXrREyshp3NHm54X/4qVh/jdCE=;
        b=pPrb+mY7Pqh3oU0e2Ay9qSY+dGvZPgz3JDtM9Wp2L/XRLc/6CFwKkoAI1KAO2DtLfT
         2usBq70LWC/JhY6OSVby9uNg10UdC3pVgH5Deh30IlsGNJoKbkEmH9PrjRuUdJrg3d6G
         T4SKr48QPtvGRf82mYWl2S4bTwmXNcZAydKrgsgtRPex4xhZyzg+W8ZiJZvbs6tmrrky
         46V+BE5r6mJldZxC3zwpoIng+b++YCV9esSbRj0rzulBR1ZBKpnytULVFcPDDNO/7ezn
         jSyj3Ea3R//I2SGwta1m/081eVx/Wh6lOJSlM/mTtGmT0d5lm2peSJ4l3YpSKufW/LPQ
         bBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmmruYs8eLLY9TVJPuXrREyshp3NHm54X/4qVh/jdCE=;
        b=FHfy23l5hl5iyWqo0y+YTgbTPcnGelKHhiJixDHxNlml9JoWSXl6789G3jMzcEg/Ra
         4xmeRVDL+GU4gRwI3wvtplsJe/K2qSesYf0jG5BERnpT54W2t5qH7nGuzqjoW62Dn/XF
         Jkj5lyi35dAjPiCbjBuocPz4KhZFXSR33PzFh3Ci8MmDrzYsKAd/mjapnrtb3qr85l3u
         mED8daN8OX1WarpQzoD4y1FKdXIaQhnjmZXXeAMkylSBMMD/+SZi2w+4TWeXcvuBrYYz
         II87bbFzbSkLEnDw/lTJkZP82cXlX3To68wyEKQgpGnNHJyzSau/G1TPWyiymUXewY2y
         K+MA==
X-Gm-Message-State: APjAAAXCkmYoyqEoPScvJCiCrwR5PDGgzJz+XG6vRW9j3mp6xPp07JBu
        vziCFb9aLL2tqRBW8SCPm9mnuu/MhA0=
X-Google-Smtp-Source: APXvYqz9Syk4O8ku4Et3+VBYyRsvqIbCTLX7ewdV0M2m774eoLH9nTxFpbBboRKPWB23gaICcSNDdA==
X-Received: by 2002:a63:741a:: with SMTP id p26mr4827089pgc.177.1568416966649;
        Fri, 13 Sep 2019 16:22:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/7] dt-bindings: interrupt-controller: Add brcm,bcm7211-armctrl-ic binding
Date:   Fri, 13 Sep 2019 16:22:31 -0700
Message-Id: <20190913232236.10200-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 features a second level interrupt controller similar in nature
to BCM2836, with a few modifications to the register offsets, document
that specific compatible string.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../interrupt-controller/brcm,bcm2835-armctrl-ic.txt        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
index 0f1af5a1c12e..0b07845b46e4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -12,7 +12,8 @@ interrupt there indicates that the ARMCTRL has an interrupt to handle.
 Required properties:
 
 - compatible : should be "brcm,bcm2835-armctrl-ic" or
-                 "brcm,bcm2836-armctrl-ic"
+                 "brcm,bcm2836-armctrl-ic" or
+		 "brcm,bcm7211-armctrl-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
@@ -25,7 +26,8 @@ Required properties:
   The 2nd cell contains the interrupt number within the bank. Valid values
   are 0..7 for bank 0, and 0..31 for bank 1.
 
-Additional required properties for brcm,bcm2836-armctrl-ic:
+Additional required properties for brcm,bcm2836-armctrl-ic and
+brcm,bcm7211-armctrl-ic:
 - interrupts : Specifies the interrupt on the parent for this interrupt
   controller to handle.
 
-- 
2.17.1

