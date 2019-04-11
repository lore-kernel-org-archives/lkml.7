Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A24C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD23217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxZoSA75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfDKPe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:34:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40942 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDKPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:34:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so7300038wmi.5;
        Thu, 11 Apr 2019 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SozNhT2OtvD1y/bOycdOEJJ/v75NKtQxo1gdu9KLF8o=;
        b=dxZoSA75YT9PfcuIAR/lxfUfb3vjmYNwSoUklHaA5x15otrXzSoBi6p2diI2H9TfbD
         wGLohdtDEQYf+JttyQ7/laI3La0GGphWJHKB+bMbygO/u5lcEe1SOM6e/bL/wW35QOrW
         pp04z2Ufxc9yIQIVSyXffUbV0PkBuHJobfkSaR0Zvr8vqAQI3kpG3SwfVowk68R3FrB0
         jy5YyhjozOdKSI+fx6s73mGbY1nNJhkA+6xWgHN0x7FGxc4rgmZfYgk5OW+kbsLgvG6T
         VDadsRJdnOaHgb7AedQNHBUdtN2qDc5ifjWSLzqMZIihYRQWBpDyCxsDxDdj60SVIcIB
         IzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SozNhT2OtvD1y/bOycdOEJJ/v75NKtQxo1gdu9KLF8o=;
        b=OuKS1/HNMOcLXkbRDbCkC7p9+2ixSldVDf850aQeuFc0TSzjafKugyh3rS1w02Fjpe
         yOVWV0FFT0DHA7TCPWJWH7+rNPPuIA+1yw/T0OaqADdeBbeWGq6JTGSjFEJZMGcdS1gd
         C9DkwKkQNQLby7iJL/3uZdoENCuJKJR8bFhEh2Adt/M0WNFt3QZ0nmShrBy/W8e1WZ35
         F5yYWhauPBQPnMm18n0y8QUbupfaq62s2WdneYs49+t5IPv4FPPxj52NPaRsdlqrpizJ
         br3Ac2mJOchaZPmjtiPCPWkRKsh8QSawpoND4KDrJjAO5zItrEJfNBB2UPnvW7bneslr
         eSsA==
X-Gm-Message-State: APjAAAUht/4NrGZvGHIjqrSV2zxqdfYu+4opJ/Qjh4rLOU6oYavFNCXJ
        URxi0v6PWXoqgH7BTzPQ0HA=
X-Google-Smtp-Source: APXvYqzDWIDY4EX535+8pXqQfcs5bOKhLxYyoGXH1kdfsJ3x1nSr+rCWgvvEOWUV37g655S+Wzo+Ng==
X-Received: by 2002:a1c:a8d3:: with SMTP id r202mr7471219wme.106.1554996865191;
        Thu, 11 Apr 2019 08:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id e12sm38327342wrt.94.2019.04.11.08.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:34:24 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: allwinner: h6: add r_watchog node
Date:   Thu, 11 Apr 2019 17:45:33 +0200
Message-Id: <20190411154534.25563-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411154534.25563-1-peron.clem@gmail.com>
References: <20190411154534.25563-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a r_watchdog similar to A64.

Declare it in the device-tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 5c2f5451227b..66dc684a378e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -622,6 +622,13 @@
 			#reset-cells = <1>;
 		};
 
+		r_watchdog: watchdog@7020400 {
+			compatible = "allwinner,sun50i-a64-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x07020400 0x20>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_intc: interrupt-controller@7021000 {
 			compatible = "allwinner,sun50i-h6-r-intc",
 				     "allwinner,sun6i-a31-r-intc";
-- 
2.17.1

