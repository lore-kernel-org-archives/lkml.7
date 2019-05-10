Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A04C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1871721479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fBkrLJ1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfEJQtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:49:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35109 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfEJQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:49:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so4185933wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Is7gD3yeObgU922o5rXJFDawZvTxttvDjfnW9eFtyrw=;
        b=fBkrLJ1E5OA+08cH9MslvzFXxoKtzBq2o6KYAEOStp1jVLEwYxnEGZ5LY773CCHu1N
         e1feqfn5tkpY51KyGEPTgYBIHFRrpWN/7s7eaQMOzChMnoq0eRDSklFUQLC5DUHOFAKx
         uKG9NUhPFBVoLbo1O9nR8gFEckRBstGu0uUVchZnQdzHcsmGc1Pl4UQCVZBjkbEOAY0z
         UgJ5zuHRK3jsilfgLJRH3IFTWyPvuNUNajH2I6VaBJKDoQZb9viLbNhLjHFjv/qsr0G3
         hnPhCTicU9Z9eAIZlj8r1zspYcXdNnRZ2H91rYQqjzP6RqpBsU8C2am/2h6cPbsRArXj
         JNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Is7gD3yeObgU922o5rXJFDawZvTxttvDjfnW9eFtyrw=;
        b=bcqFioVvBnpk7BNDIGw0UIJVrJWrUV2IL5+N7+TBQB8WqbYj5GsZ+Lp6ZBp9Q+hVLH
         JERafarh6c8YjRx2b28KbTnSxjobbMenSKeI4eqBZfHKsAm4Q1US979Y1TvbCh/lmvHc
         0zlouaYqEDixIHF7UuO3+6m/sVO/0yljHz9qg3wqm9R8Swsow892smK4CjNT1bhU5A7K
         /wYN6xmTOgMnwjHB6B4dmdW+iwdNY+6zb4RRo9oLf10cEvyuv7nx1fjigcBMeMTRZbRG
         eraTxoir18ZRXjHcwyMSb8QTDGuLxEb3gmLyy4QGMn59rLcbwsWOgPWKoHV3ek++shP4
         MrsA==
X-Gm-Message-State: APjAAAX336jnd42JSNwc2+Fbh6tZCh3I5UyMeUBDrrsojZcL6657UnGN
        lIBLZg5FixqcqSbP5bsTfIfagw==
X-Google-Smtp-Source: APXvYqwMuN/bOnJi5zVCfLtc6oWWWxdwzjc1a80rDT+920MwLAt+4SZyEIccA37+vnMs1aIt2Rev3Q==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr8178833wmb.76.1557506986314;
        Fri, 10 May 2019 09:49:46 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q26sm5114308wmq.25.2019.05.10.09.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:49:45 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: meson: g12a: add ethernet mac controller
Date:   Fri, 10 May 2019 18:49:36 +0200
Message-Id: <20190510164940.13496-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510164940.13496-1-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the synopsys ethernet mac controller embedded in the g12a SoC family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 2f4f4dd54cba..a32db09809f7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -102,6 +102,27 @@
 		#size-cells = <2>;
 		ranges;
 
+		ethmac: ethernet@ff3f0000 {
+			compatible = "amlogic,meson-axg-dwmac",
+				     "snps,dwmac-3.70a",
+				     "snps,dwmac";
+			reg = <0x0 0xff3f0000 0x0 0x10000
+			       0x0 0xff634540 0x0 0x8>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clkc CLKID_ETH>,
+				 <&clkc CLKID_FCLK_DIV2>,
+				 <&clkc CLKID_MPLL2>;
+			clock-names = "stmmaceth", "clkin0", "clkin1";
+			status = "disabled";
+
+			mdio0: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+		};
+
 		apb: bus@ff600000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff600000 0x0 0x200000>;
-- 
2.20.1

