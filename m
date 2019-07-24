Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB72C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BE72189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZErFtEZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfGXRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:23:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49584 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfGXRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563988644; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIriiq9JGjn7qTwBo98NXm62pmdJaJ+8q8iT7KUut5Y=;
        b=ZErFtEZHBzIcWuJuJwnqWJFNM6VE5yKwlDZARlq+PnufTIh6/5uyYyONuNSavYdONjJ8kX
        kiQDVz9XDjsCzii0jzNqElqOyWD3fdA1HyrUC4gIsCs15wPHPcHSaH66xJQOG4+2aBp73H
        UB44XeBsKHKjbhYJP6nP4k4vG1V0WcY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 08/13] clk: jz4740: Add TCU clock
Date:   Wed, 24 Jul 2019 13:16:10 -0400
Message-Id: <20190724171615.20774-9-paul@crapouillou.net>
In-Reply-To: <20190724171615.20774-1-paul@crapouillou.net>
References: <20190724171615.20774-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing TCU clock to the list of clocks supplied by the CGU for
the JZ4740 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v5: New patch
    
    v6-v15: No change

 drivers/clk/ingenic/jz4740-cgu.c       | 6 ++++++
 include/dt-bindings/clock/jz4740-cgu.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 4c0a20949c2c..67f8a0e14284 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -222,6 +222,12 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 5 },
 	},
+
+	[JZ4740_CLK_TCU] = {
+		"tcu", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 1 },
+	},
 };
 
 static void __init jz4740_cgu_init(struct device_node *np)
diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/jz4740-cgu.h
index 6ed83f926ae7..e82d77028581 100644
--- a/include/dt-bindings/clock/jz4740-cgu.h
+++ b/include/dt-bindings/clock/jz4740-cgu.h
@@ -34,5 +34,6 @@
 #define JZ4740_CLK_ADC		19
 #define JZ4740_CLK_I2C		20
 #define JZ4740_CLK_AIC		21
+#define JZ4740_CLK_TCU		22
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4740_CGU_H__ */
-- 
2.21.0.593.g511ec345e18

