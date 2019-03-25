Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047F720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfCSSn1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfCYSaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:30:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36049 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYSaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:30:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id k2so346351plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIZK9l/PSo/azPAD1wVNltgu5UI5I+sb6w/ogJ7GQDY=;
        b=PfCSSn1k3fYKB6CvxNvYt/8YbWDO5ndMWqlhwOJqWWucEY5hf1+sFplX8hxLOrRgsB
         ILaGHbbcHTJIdInhfYQWgL2ExTVBJsMumI3SZFr/QUM278m+fqBBxaUVbtMcrCGFht/w
         1jtPSPaZMEQwI8Sd1ZpoW1t7aSn/5q9helDuWzYYMwpL9gf2kfOVvPpcF7d+VUnwdTAU
         G2IxU+PmpTxhJ/RDMpAipZLT0g/oY9KI0aGDQr3d/Vl1Fthx2c6rKBFZkOk9oHyU30HR
         I/ihM0uPnzDz3ZGVsmZ2Vwb6XHpX38BsSoNnTptbpjnKfQio3ebqS76Qu8Tyn1FnoVSD
         cdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIZK9l/PSo/azPAD1wVNltgu5UI5I+sb6w/ogJ7GQDY=;
        b=Og3fnWRal4uiLnUQnTQL2amJR5uP/J5aNpEYCtpYSaxc2SZh8UqFIqLMYpnxXNGUF4
         Mdtp3OUTd8kCdOJ/sXXEqOAHYr3FrLqBoHxGtckqV2h7Ps/x7zW2g/Q+XzAx7HfgHyo6
         QQtXfI1KKQZtgBHbj/HgEfvkGr0eBA1E7Uku8qpi7xFcsgbZPW1UGGuXE4YWA8pLPmef
         D6i4LNOYRYJEP5voNT7ooqwwDKlSU0K2q61IuBJEApWUpjfswPiCK8bBxiU3vWkQGq7y
         SgMKBOlRlK/lwCnPnDVqtEezSeAnbepzJ05tc0N6Qk7AG/vXXDZZmB3fBzVbklMAkqCM
         iv9Q==
X-Gm-Message-State: APjAAAVGo7/4ashb85AhUMYUdQo76xFz6fDZ9tA5awE26kCoZDAl3sxl
        TvJSKPDfzL7MnaBDzHRikGM=
X-Google-Smtp-Source: APXvYqxAHqgnQXRYg+2ciIRVOrb8xTbUvqJYT34H3pUAoj7CYY2OEVRZVsDWCDQFqt7u6w6b6gy9Iw==
X-Received: by 2002:a17:902:b593:: with SMTP id a19mr7780932pls.300.1553538624598;
        Mon, 25 Mar 2019 11:30:24 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d137sm24399887pfd.133.2019.03.25.11.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:30:23 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610-zii-cfu1: Disable NOR flash/SPI controller
Date:   Mon, 25 Mar 2019 11:30:17 -0700
Message-Id: <20190325183017.22278-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a certain number of CFU1's come with NOR flash populated. Disable
it by default to avoid trying to probe NOR flash on devices that don't
have it. Devices that do have it can rely on the bootloader to enable
this node.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index 6c78122401a1..afc25b33bd3b 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -87,7 +87,12 @@
 	bus-num = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_dspi1>;
-	status = "okay";
+	/*
+	 * Some CFU1s come with SPI-NOR chip DNPed, so we leave this
+	 * node disabled by default and rely on bootloader to enable
+	 * it when appropriate.
+	 */
+	status = "disabled";
 
 	m25p128@0 {
 		#address-cells = <1>;
-- 
2.20.1

