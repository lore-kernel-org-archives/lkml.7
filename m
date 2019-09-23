Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9AC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ewfXG73b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437389AbfIWIOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:14:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36864 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437230AbfIWIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so9385234lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaEGfYYzHwOCfVyIlgvVjUBZGDRTASgoNwVywAAbPHY=;
        b=ewfXG73buI74XMq7fZvVCWZKlgR+0TiV4JG9jO/fe49Cgrg27am4riX0e0bPmvYroq
         u1b3ifBwwoH+Hu3VVrsI7kvp9IgLIBUnoVgqO1+NL1lZp+dR74yHyrgZ1unaAXzC4J6X
         kayGRA9zv0hm5PTVKc5F3g/2+TsbFV+athuPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaEGfYYzHwOCfVyIlgvVjUBZGDRTASgoNwVywAAbPHY=;
        b=m8Bv3+2BpdU9fcoLAHav6YYPgijpJ+pS1PgK6wVoqEj58KLEkIhCxyOpoRyDbb9qSk
         FbzfQj3ESmFfOTfxDVZmBhIYONqZYTrsiAcV8UCTqhar/p7u1vfY9PUz+PPRMCv7PV/g
         hm8hi1BFewtnFv0+iICC9avAdfFeKtZgguJBI6pGkjTZy1q4LiC6n9gYmW9UjvS4eveE
         AGueWE/eUGvlrTiCkE3rpsm9yYje5KtTzU8EaCiLNz/qYWb4nzUn0qvBn9YJ/3nxC0IX
         IPs8kurxWnsZ+8xgaHM+7OOnOFslIj/vRUuDmzGvPI3MGE/Md6rPv2X6LgUKFYFaUdNB
         GePA==
X-Gm-Message-State: APjAAAUrdnE6oqAMsCkN7SlmEBdbP6sFAmJerfKQmxvZ/it9U/470Sz3
        s0L1LD1ken6KCVt5j8RojYKfmw==
X-Google-Smtp-Source: APXvYqwa45HyJC3lNRp5/zE7lrzcpW7gGM4PVnCUaEY3v11W5wPXc/WNYcX42D8uo4bAGlw71Tm2Fg==
X-Received: by 2002:a19:c396:: with SMTP id t144mr16546948lff.14.1569226436978;
        Mon, 23 Sep 2019 01:13:56 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:56 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Date:   Mon, 23 Sep 2019 10:13:48 +0200
Message-Id: <20190923081348.6843-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to increase the pwm-cells for the optional flags parameter, in
order to implement support for polarity setting via DT.

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

