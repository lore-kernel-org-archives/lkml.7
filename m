Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59299C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3109E218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AXXxF24y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:37:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34672 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:37:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1777560plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhyRUTRIu1qpsqXn5o9IxSwcYlELpmg3DK5gV7vvo4k=;
        b=AXXxF24y4ZnmX35FkssBaHobBhB2G/2sniSMqPwRUcbbronGlChj6KUb34z6/0EDwg
         ry7q8B8r1kmpgoaejPsEEX3aeGji3B9DPbED4WmbyKbretJxCm4I4XskKNuWq2iXNb29
         A76Ep9fNh4Jp+0mlNKSmS/s2GpGqQ+2xjjzT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhyRUTRIu1qpsqXn5o9IxSwcYlELpmg3DK5gV7vvo4k=;
        b=CKxAZKFNdP3Dy8JvkJ2ivZ2QOCECOEuzSrHwWbK8cnlrbDnw3rxkuKjAm1aQf/kp3n
         Y6mY1omVKZti2IcFNMkHzI6qfhiuJq1iTlzgXuRxCFrVf7RkArBWntbyNe3SO22UziR6
         MNbiTQ1lRZYvBIafKTwtQAx9U/ikan6FAvNVYKex91Bk9kFBxu00ON1ArmBpqswTxWZP
         yPEqVpgbDGqZirtH4ipliwdSPC3EEovzVBIrigqUtVnPx/cWbI29avvCPd9iuVYWajAo
         p1qB56fi9wcACiFbk9g3zafUo/z/51uBn9tjV8KmCkP397xIFgAT9daMqtTEK+v0nq2o
         dgKw==
X-Gm-Message-State: APjAAAWP/fNmGdn80JijT2FhKpcxsEmukZJoExZ5sD9A/CW/++YdrBR6
        q+GV6aIjFqKXu+0wo5ZONTSloQ==
X-Google-Smtp-Source: APXvYqx2zcPaDUE+NEA7dMtqcm7Nr0Gll2dkZwmIPLTBF4nCY4JvXULR0j76QP0tqbRl/LAYHJpkzQ==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr43967938ply.170.1562182653824;
        Wed, 03 Jul 2019 12:37:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v4sm3227006pff.45.2019.07.03.12.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:37:33 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/7] dt-bindings: net: realtek: Add property to enable SSC
Date:   Wed,  3 Jul 2019 12:37:20 -0700
Message-Id: <20190703193724.246854-3-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190703193724.246854-1-mka@chromium.org>
References: <20190703193724.246854-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 'realtek,enable-ssc' property to enable Spread Spectrum
Clocking (SSC) on Realtek PHYs that support it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series (kind of, it already existed, but now
  the binding is created by another patch)
---
 Documentation/devicetree/bindings/net/realtek.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek.txt b/Documentation/devicetree/bindings/net/realtek.txt
index 63f7002fa704..71d386c78269 100644
--- a/Documentation/devicetree/bindings/net/realtek.txt
+++ b/Documentation/devicetree/bindings/net/realtek.txt
@@ -5,6 +5,10 @@ This document describes properties of Realtek PHYs.
 Optional properties:
 - realtek,eee-led-mode-disable: Disable EEE LED mode on this port.
 
+- realtek,enable-ssc : Enable Spread Spectrum Clocking (SSC) on this port.
+
+	SSC is only available on some Realtek PHYs (e.g. RTL8211E).
+
 Example:
 
 mdio0 {
@@ -15,5 +19,6 @@ mdio0 {
 	ethphy: ethernet-phy@1 {
 		reg = <1>;
 		realtek,eee-led-mode-disable;
+		realtek,enable-ssc;
 	};
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

