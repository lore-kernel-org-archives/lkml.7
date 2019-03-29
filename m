Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D25EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AECB2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKyxaT6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfC2IjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:39:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbfC2IjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:39:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id p19so707670plo.2;
        Fri, 29 Mar 2019 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tNX9lqbdxBrzBF/VOrW4xdBdOFofMDoTAphhz+2oEg=;
        b=CKyxaT6TD1zOIpjnxNAqYpGB/HUS1R+i3DAl0gib9eQW0hPMJltpbXBp23GBO7GHlU
         ygaiKslxclDrphju4n9TTDpANmijcwV+VNAPsHPn1JJMnVge75I66Au8oQsEEKVu0fm3
         7KUT6GUHM7zt5p8Q/W6ycl4GI4ebtxVIEeHAEwCKhJnAlQXKaheuUHmO0YIr70a1E1uo
         xRgtcVLQYoeezl2Xc/+N30phKfXsJ3cjdk6yHYyT/1xpbc5yXNGQvY00SAhzvo48fTJM
         fUa7WsWfNaEGIURCBiOk2SzOIVBIeIUQr9+vLz8IrjX4TDHFuInYbM7aiBicKB9umjS3
         AxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tNX9lqbdxBrzBF/VOrW4xdBdOFofMDoTAphhz+2oEg=;
        b=Zks8lGvZQQUBqRtjkhx2X2e0SyNJUfGRYvxPrXIY75hFJ7GqjR7nSvByoof00/hkJ5
         P7XSTt+JBfgBaW3lmdZQr9lEd8z8qFad2lZaGObiVxTfmwFmsypbtWWstnCKrbhHmTvY
         DMn1IebWaNSYTLPW0aJYSPv64lWHnrj9c9o5V4exuIIFHzQJw3PZFOys8sC5wGTwyQRh
         OjPB3KSInMBNKnVB/V0cEXB7L/s+E/PbuurKQHpzviCYdSJtLAKzzK7mtyCCDsicJwcT
         m87N1T2QyxyBbB5LZ+jZoMsduuaNLfglbFVvXpJivAIJL5PTwzoT6F9aYetNwPjHeZNE
         6K5A==
X-Gm-Message-State: APjAAAUTTGLSJjOeRTseV7GGjnOuhZ4DrvN6ayz8skS8Muq4sPIMb8W8
        OhMrNJBbWzHKOoj2kJt8l2c=
X-Google-Smtp-Source: APXvYqxUwlt8X7X+SQWcrGJ/Th+ubCcSf8wZWMnkiGWO4pAUoCoaTkGKBcb6ueHduWoFPuEhUuHQAw==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr47899713plo.271.1553848754804;
        Fri, 29 Mar 2019 01:39:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z21sm1889690pfn.139.2019.03.29.01.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:39:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: imx7s: Specify #io-channel-cells in ADC nodes
Date:   Fri, 29 Mar 2019 01:38:56 -0700
Message-Id: <20190329083858.9988-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329083858.9988-1-andrew.smirnov@gmail.com>
References: <20190329083858.9988-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify #io-channel-cells in ADC nodes. Needed to be able to reference
them by phandle.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/imx7s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index e88f53a4c7f4..0e1723c95978 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -628,6 +628,7 @@
 				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
 				clock-names = "adc";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
@@ -637,6 +638,7 @@
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
 				clock-names = "adc";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.20.1

