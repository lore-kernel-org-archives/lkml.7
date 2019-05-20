Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FDDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A310D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvEQWMOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfETTGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:06:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44587 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETTGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:06:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so25376985edm.11;
        Mon, 20 May 2019 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QLcESIrpuKvmGLuYzNttnrvxoFbU5Wzb2EEq5RaQWcI=;
        b=bvEQWMOcSw18XS8JoBz0bG4i2ezv+hVW585GGY5YJPSTvmuCLYqn1fNBPYsb8Ymg4B
         NhpnWTr2rwIvjX0dw1cwM408YbXHiQVGgwh8XbKzbd3prPdn4OQhGfNSeBB5GnR/F3XT
         64vcExWjTl5djcEgJWho45n+pRl4xeVRK580K6LPTelNw/5aac4JLR2kiUTdGb6wWot8
         139YRlWWFt8Jg9ySuN8k99GoOKa1SvtYa+MCgMC+9nlfIaCnS9sjFQgdxgEJiQoI8OSp
         RfiJfH8HZlSqKLfBa+1AiZn+cvrErjtV98LAqy62N580ls1EbNj6xgc5PUOBPrxm79ar
         yn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QLcESIrpuKvmGLuYzNttnrvxoFbU5Wzb2EEq5RaQWcI=;
        b=Y7jf38yWDBXidrly3CM/1q/SWO/ifAFWE5BUIs7ESEbq4ODz16EXmmwF0KT+819x7q
         1sXV1lxMTlc7v0coHXi8xe0j5lrKvuRCjvY6dQ/acoR3EF0nWPvJwP1Fgy1F/9/ZHkVf
         49FnfRLR/scCi5gX+7JpvEmXXt9o01cSiUblwFTYA2+ZpBdHtm1AYnb+YkTRZDpBDQ2k
         1hNZcw0qLqzY3iC521gNX4qEVAriwm/OFfIMD9CQsoju1SZzM/d7b2O4gs0of+ARECQG
         hD1yTI62cV1lItNg6SHBf43pSd3YZfsqODkMKD9/sSaqydkQ42PgQC2LlyeAQg3B0fsh
         2rtA==
X-Gm-Message-State: APjAAAXUR7B4OIU/aGRKXVxxObr3+1tYe2e1tN7z5ejQeC7Q09wnSEiQ
        lB+ubumf9BxheW5SKvPCfXI=
X-Google-Smtp-Source: APXvYqy1cvBYRYvUUPBq3x7QnOhRgMyNfx+sQ7tJyAHNBw0AcvHwtSZToEfucyN4dWcRcWP70hRsnA==
X-Received: by 2002:a50:b487:: with SMTP id w7mr79029009edd.45.1558379161539;
        Mon, 20 May 2019 12:06:01 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 11sm3201967ejv.64.2019.05.20.12.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 12:06:00 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional
Date:   Mon, 20 May 2019 15:05:11 -0400
Message-Id: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nand-ecc-strength and nand-ecc-step-size can be made optional as
brcmnand driver can support using raw NAND layer detected values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index bcda1df..29feaba 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -101,10 +101,10 @@ Required properties:
                               number (e.g., 0, 1, 2, etc.)
 - #address-cells            : see partition.txt
 - #size-cells               : see partition.txt
-- nand-ecc-strength         : see nand.txt
-- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
 
 Optional properties:
+- nand-ecc-strength         : see nand.txt
+- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
 - nand-on-flash-bbt         : boolean, to enable the on-flash BBT for this
                               chip-select. See nand.txt
 - brcm,nand-oob-sector-size : integer, to denote the spare area sector size
-- 
1.9.0.138.g2de3478

