Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8C620815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="t/Oa0ug/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfETNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:14:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732679AbfETNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:14:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so14555049wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IVz8trHJceMtUKXTFJMf0iW5MQvs73+t7piDB6eEsY=;
        b=t/Oa0ug/gh8v2UjVr9u3N68HSxROAKAU5Vtzp2apfkj9WbuYMDnkHj+q72LYrLC+TI
         Vwpq3Z75dZl3Kx+wZyvibkDZZh3NQ7YI9b28qhCE+V4lVhsyqBdyG8Ut6H6MnSguqTYd
         uHWU84E6TFWLsyZrnx+iAqdKAtr2jh2wseTpmO23TXm/sghNTJTnFBYS7/2/BGNbp5LI
         eL6i2hKjI1bmAvL4kbamX6FCKlnLIwhyYgiV3dntXgpN+nExsgxA9sP5RGuXaQRCVPYD
         rfw6obIdU4gzhxk1LSO6sCnKwCjCENsNFOugK0Z7OY/b4+wLmK7o1hfBI83zDAi/nT1y
         0/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IVz8trHJceMtUKXTFJMf0iW5MQvs73+t7piDB6eEsY=;
        b=mXAz/jGdv5gqCrA6r9udWcCwl/77gcJKZ0SJqRdm68PBbRB13+WFv4MH6+uV8ZgxHQ
         wpmatwjO+R9NjHAHCkOopO/WDPevd0rIq4e60KZodBlPOoT3rkSFU2pjGl4qgr0WRZfZ
         8QpjE2Q8PLp5mEG6a+bBHxSKK+TbxAiZLbyZYqjvbdKCa+O9sLlaxYuQ9Ua6pzwXg6Nn
         bav1jLZADIzTJHe9vYogqkeyn58XKhUEQjzzUEdIP5fh7TcUJ0KpSSEYvS41dJgd5ltN
         Fzlv0pVemCNGH/+8BTWeMaeZLJ2IqbCNDxGrryar2eJY3n+rKLBMrUn96SXz/11/mxDQ
         Rx9w==
X-Gm-Message-State: APjAAAVdlWjmf0gCNqqs/ZTkt3Ow/wfNPhLcEfVBOEbDRsnSECfalKL8
        w3z9yU8lQtHRHE4K11aNiF+uxA==
X-Google-Smtp-Source: APXvYqz9K/jjyMysacjgfl7KOksQHYbNEnXEErMcqBtLCrHy7XK7fIn7QXtDN0QBRM8DBBymdtlRGg==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr29721861wru.223.1558358049506;
        Mon, 20 May 2019 06:14:09 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z8sm18054284wrh.48.2019.05.20.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:14:09 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: dts: meson: g12a: add ethernet mac controller
Date:   Mon, 20 May 2019 15:13:57 +0200
Message-Id: <20190520131401.11804-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
index fd24fd29f4ed..1d16cd2107ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -137,6 +137,27 @@
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

