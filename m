Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACD0C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239C2222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QLFFDcVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbfJDNdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:33:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45411 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388638AbfJDNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:33:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so6504963ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJd8sbimmy5mnSq6QgFxWdBMbJR5jACe59+ThyKK82g=;
        b=QLFFDcVHI2EhaLtxhPso76+poBjMJHw10fNMzcHwmoy9Cx7Afn8Mk5EQT7FCzlOnBI
         YhUhbpnEWCSXynuZYJcKXvG2a71t2R0i9EybdRZHp3LNjkXGueILouvZUvIxp9OnQl5a
         T4QtdWuCdh0huq8+tgQQPgcDyr9ovSMCjdFsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJd8sbimmy5mnSq6QgFxWdBMbJR5jACe59+ThyKK82g=;
        b=F66ksQNxijMCoGrqABYbuRZgZzFI6wkyAj5Ua+/QXLPEk7tDB7Ew0+mtjaOd/gTuQw
         URR/qQVC3W9PXB0oA2HvBiBcqhJfBPt8lD3KjO3llycNF7RU0OKniQyYa2fMYYlM5bGM
         w8p1Os6+NJqMruaFHfQ11APY2IupZI4dm3NwBkpYjf1hdLxitVZSTrJRHP2pgY73U/Ed
         KYqfd2bItaVNI2smgfi6cy2FXVX5lVLI8LCoVHeWW040USoPtXsNXRCe2kweIvVA/Hlp
         MAC1y3vwLimjG3KpGJSMRgI0BNCHPYB74GCL8xlXwk3/4wCZSkHTCt9go8ITWknY5JKp
         TYEw==
X-Gm-Message-State: APjAAAVggrTX7OeLNW/t5h+VI8mn/3S7Iy9EN8yvasPvfw2m54uHCmn3
        EwRQR5O5rXs4Gze5eCnk3hS9Ow==
X-Google-Smtp-Source: APXvYqwvmj9emNdcSYaeyQ5bIj8DBfAdIXf//abqi9CfcXTehTrWUROGkbvTAyHXk/O4qK9ZmcUc3Q==
X-Received: by 2002:a2e:9f12:: with SMTP id u18mr9775583ljk.23.1570195984389;
        Fri, 04 Oct 2019 06:33:04 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:33:03 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Date:   Fri,  4 Oct 2019 15:32:05 +0200
Message-Id: <20191004133207.6663-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to increase the pwm-cells for the optional flags parameter, in
order to implement support for polarity setting via DT.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
index 96cdde5f6208..1697dcd3b07c 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.txt
@@ -3,7 +3,7 @@ Freescale MXS PWM controller
 Required properties:
 - compatible: should be "fsl,imx23-pwm"
 - reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
   the cells format.
 - fsl,pwm-number: the number of PWM devices
 
@@ -12,6 +12,6 @@ Example:
 pwm: pwm@80064000 {
 	compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 	reg = <0x80064000 0x2000>;
-	#pwm-cells = <2>;
+	#pwm-cells = <3>;
 	fsl,pwm-number = <8>;
 };
-- 
2.20.1

