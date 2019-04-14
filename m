Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340FAC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041BD2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oExD2+co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDNSeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:34:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNSeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:34:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7484804pgs.8;
        Sun, 14 Apr 2019 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tNX9lqbdxBrzBF/VOrW4xdBdOFofMDoTAphhz+2oEg=;
        b=oExD2+coWkiyA73ghrokXryolK0FkMW+hiW519kw4nd9zWTZXf1WuhufcM2qds1iua
         U3VITrpSgwJZPLhHDHl16OMaBNeQKdlhsrdywXBfFVSg2H0y6DIT9p4XQb2HSjnohZUG
         R9y+bd3aNQdhDIjHbY2x7MIbWdVY8OYMbBFBgaZnuyj1ZLRcy1yN4Y9we0/S0EmIaUpG
         EutUH0VcvxbDZHN3DjeloPitlkcvJuEYVRyneRKpXShnqFvsv5SYix+VKpVY5I89tE0u
         PpvoXfyzfs1V4nmdBjoq1v8iA/Sx1FXWQSBGE/d26pdNDQIjk4HeFrnesT8skCTfeIkv
         ShXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tNX9lqbdxBrzBF/VOrW4xdBdOFofMDoTAphhz+2oEg=;
        b=Xwq0ui2n/Qs35KRJzRHKQ7024KDkNjjtMUWkkoIKc5iumK8m0cvsLAo1yOSpd1srbO
         EnuhHmeRUSr2PH5I+QqxBKZ1ymz9mSVH4BSjpLxHdWXxYNAmVBl0WeAIZjFKYIcTyRTK
         ZPAy/Y5HX7wHI7zZH/WkMJchyQy8TY/Zy4UgO5H6NK+uUPDeCYarBboBIbabdBmkiELU
         hnbBfun/q+p5ZtuGIRCU9TLr5Wc/adKN3Wn7JvGRGBUiivu0g8gO4VklkUUGqEluixNL
         lfBHLfMGXrPUp/8gUQZNI/ckn4ZQkdcvsFuKQwkgNozcVR3uC1/r1IcoJltjvGb8A6Ne
         81Dw==
X-Gm-Message-State: APjAAAWlnTcE6FWrx37X41rCDc7f8qXbfzUaNwpaM43vVurVyqSARvp/
        0bAFEEMloY5+fTAQkm/lBvQ=
X-Google-Smtp-Source: APXvYqwBeJNb0CPRM+VwiyHZtKuj7b1kt3v8wwnx6KAhZl41CHac6ii7vmZYO6ZoHIU8FfwRZE3MFg==
X-Received: by 2002:a63:c145:: with SMTP id p5mr63686786pgi.339.1555266855872;
        Sun, 14 Apr 2019 11:34:15 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 10sm70159439pft.100.2019.04.14.11.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:34:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: imx7s: Specify #io-channel-cells in ADC nodes
Date:   Sun, 14 Apr 2019 11:34:01 -0700
Message-Id: <20190414183403.21538-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183403.21538-1-andrew.smirnov@gmail.com>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
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

