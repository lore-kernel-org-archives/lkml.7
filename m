Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB643C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99D520811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHbTU6IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbfC0GfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:35:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42271 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733057AbfC0GfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:35:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so9234312pfn.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q69uzChJtoAuSsBw165cu2bB+9J9hZYbB2aNHX+ivb0=;
        b=AHbTU6IVnbAmfvbWJrWP+uMEmRfYSWGT+caN2AcKJHinyPLhTy8JVrXiF9meMjdJaY
         7/AXPSmBgFSkkcaZhD7s6a1xT7tS2R8SJ+aKm/UJ+fFiyreqK6TkZ95upOG8NO2PQBue
         /KatWFveFxWv66Q7NqZdk3nB+HP7PuOcRldeWYPOXpCW/TVBXQnpkcQbdfMEwzCS5kd+
         WvnWOf2DQLWGQMsSYFDqdJhPA6yCY2+YEZJ19m25sZr8kxqA0OOTzf9n6i/j1u/UVRwN
         D7MbccUToK05tH2W+io6EGcH0d/9o+Os14o/toQ+tRjiEh9WcTQQq604NXBuBwQMy4Wt
         Zzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q69uzChJtoAuSsBw165cu2bB+9J9hZYbB2aNHX+ivb0=;
        b=QH6sTDT9XcxBtqh03uN5SRDT4iySYdXMi+CdW2B7UxiVLfaKR2W13Gfm3LQuxscHsz
         wwo6Gkug0JyfCdL0HrOdFaX+fqEECSGovaObHm3E6aRprdvLmCdsiFjgnEyDceKbExWD
         B6YWCK29I6HNUj8zf/iFo2eFn2+wtmxq1V7dcfMYpT8/G7DbKDi6JsDf0aMiu/Nnt5HL
         rtlnuybC9yvDDHwoQ1pGMoeeacUdzrRC3f4DBWCKrBrrejig8i2x3BJVOtMXYXEzm7ib
         QK/DjKKg0BP72Ba7tuVEl3QBX40n/R9eYm4bxCfj/sHvvQ9ett3Bczf7xqkOPxf9WvbR
         oAog==
X-Gm-Message-State: APjAAAXMfRQN8KMPSQIRGuYwXqi9bsdTCpDRcm0BtfSHFjpilX1p5YJu
        LBOlmoGNs0Mviqrc5K2tcLM=
X-Google-Smtp-Source: APXvYqwmP3g/k5dvwPJIzi2Sud76Pt4atW1kGWRYhFTFz2nwQpUr86C9loO+x9E4ij7marAPc0CDtw==
X-Received: by 2002:a63:fc64:: with SMTP id r36mr32909309pgk.280.1553668506123;
        Tue, 26 Mar 2019 23:35:06 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k1sm19950258pfo.121.2019.03.26.23.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:35:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: imx7d: Specify IMX7D_CLK_IPG as "ipg" clock to SDMA
Date:   Tue, 26 Mar 2019 23:34:51 -0700
Message-Id: <20190327063451.25629-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327063451.25629-1-andrew.smirnov@gmail.com>
References: <20190327063451.25629-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
clock to determine if it needs to configure the IP block as operating
at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
clocks as IMX7D_CLK_SDMA result in driver incorrectly thinking that
ratio is 1:1 which results in broken SDMA functionality. Fix the code
to specify IMX7D_CLK_IPG as "ipg" clock for SDMA, to avoid detecting
incorrect clock ratio.

Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/imx7s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index e88f53a4c7f4..2f45ef527e6c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1067,8 +1067,8 @@
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX7D_SDMA_CORE_CLK>,
-					 <&clks IMX7D_AHB_CHANNEL_ROOT_CLK>;
+				clocks = <&clks IMX7D_IPG_ROOT_CLK>,
+					 <&clks IMX7D_SDMA_CORE_CLK>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.20.1

