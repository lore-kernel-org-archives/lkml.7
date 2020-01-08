Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C86C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5BF20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U292Rre6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgAHUyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33528 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgAHUx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so4989670wrq.0;
        Wed, 08 Jan 2020 12:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vmr2fEFzigW7NnBmDNTwUzT4ArM8axMJAbkHVc4Ns/0=;
        b=U292Rre680z7wDSQHsQUS9uJRrA1Pr2tLM4NbXE/OrgCGOwMP5BmFcfZwtt7vl2TMF
         utIikDp5Fgy62sWQ0YgW4GrQv6ESGNQ4McMWmvGuDUnitKop7SNvajhSom44f/2UxpHi
         Nvh6iZtGbshUg+6hOO70D0QiCe7+aNjSB1qmEhRmTgZDfDqUoP247THopMK6wWT91uWw
         y3VclLEwrBuv1+eiYcVn5jngCkqsLi65cdzganyu3GlUGRLU7i42mMua93ISNYfbA+sg
         q7rh8GvGdX/pQwTApk6JetyqPLHQ5LhdCt46uOj1EZvEBA+aQwmrVKIVIeVe77uTAh+8
         dIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vmr2fEFzigW7NnBmDNTwUzT4ArM8axMJAbkHVc4Ns/0=;
        b=m+HROIsK4fpcWmp8EdqWufSqxW4O64snRG7gOdxxBhuV/aVCeCCQAHa9+pgwvRws58
         rfCXga6vTwq55WNUgtqv6uGUoCRIIzGbzoU3cPyeeZeq8UVNG1idX2LNqJB0q9oaF3RP
         mhE5lgFSo4JFTKTe7yzFYc/Pg1cddyIFyrf1N/bJ2/wtpbjFZk9BD4sSWbjLamKIvdVy
         4uah7t31LLhZZGhFe+/00Uvby3fR5s9WnUsGfRA00KFsCal3LatOnEsO+xjXCUWiPAIk
         Mk8diK10tjAGVvgWbUZvl/jc5u5yC/q9sjgKwdMiWRi1hvuGQqR8igUjLJ51ELbEJejm
         PPWw==
X-Gm-Message-State: APjAAAU4qF+t33DQPVfwri3MJ4h2JcferDt7KrSziA0ApIiccYN8p6uA
        krz7TRwfEIR1/JNdiu6AhF0=
X-Google-Smtp-Source: APXvYqzp9b6RWmOcElE6RzuN+ZS1z6743gaRIYOSvn+KxRtvbtfKLCOwJAdUYr8HSfaxwgfx2X3Rdw==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr7021876wrp.182.1578516835000;
        Wed, 08 Jan 2020 12:53:55 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:54 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 08/10] arm64: dts: rockchip: add nandc node for rk3308
Date:   Wed,  8 Jan 2020 21:53:36 +0100
Message-Id: <20200108205338.11369-9-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dingqiang Lin <jon.lin@rock-chips.com>

Add nandc node for rk3308.

Signed-off-by: Dingqiang Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 8bdc66c62..62df531d1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -627,6 +627,17 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@ff4b0000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x0 0xff4b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC>, <&cru HCLK_NANDC>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
-- 
2.11.0

