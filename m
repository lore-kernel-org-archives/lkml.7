Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45780C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCBF2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU5hKulO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfC2IjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:39:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36965 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbfC2IjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:39:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id q6so702875pll.4;
        Fri, 29 Mar 2019 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5eG+BJ2Wvt73uhFfrT6FHlC65RAt94NCZNgKksaa4=;
        b=lU5hKulOw/3mICPGiX9W8LovhwuGzPAO5JVLz1bk3UqBlclOpotJHDaG1PowvZOPEj
         XJyL2dbgTgG1+s9ObcKxoH82PFI5SgKHgcsyKbBUvnWwd7KGnJVJfAX2JQKHqUl5Tt3d
         9EyHpPlUNd85Nl2JfRI3gbwbApIPE+/dw3JmJ461NcTjbRuSc37nP5hEVq2yddb6uDyy
         8NukreULiIJb93wGnsj4tIG7YZSxIIeyeqtFU/P3dlxQL6WbaIpMr86k+5MdEoapUL3K
         X7Z0IzvF0+yJ92dU+rUGbd2MMdinszlLyw2OmzrxjfakN+vXrih5XRcX6p+xdpOObtJK
         B6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5eG+BJ2Wvt73uhFfrT6FHlC65RAt94NCZNgKksaa4=;
        b=nSpnr2wmGz3nQ1Z91ZV8a9UAC9mzT2kjdKbBe3faoPm0REdNv2D2qyYChRsKztpxkd
         Uss97Zp5wGtLYJE96R9aKsouJF/FHdbmToqvx7ZPe8ucDnB92/o43ew9XlYM4nHwtJv1
         gz06kRoMikXKBJc8BpEDVDj1DdnpGS0b2uteyKnOO8apvNBPdp55MCXbHZQANUOzb2L7
         K18md6ELiTlT79KDmAiWn5lLqqE24M2GcydodO++rMYZNxGMey9joiP8m9kPcrex6Uxd
         X9k6yftjysc5NLzgsWYuckNQBisMw+V4c7hkBmlYrEk7lTL9WI2ZNlh5MNJkaYOq7RoT
         EaEQ==
X-Gm-Message-State: APjAAAVn+gnbbDvK5WpAKtww/YznP1lYNEzAxN1tX+N8RKWe/dTwj+PI
        cPaVAKsN1PhhuMAqaYz9w8c=
X-Google-Smtp-Source: APXvYqzzN48SjzHapixr5sj4AW7eDLjCb0DDI8yi28SgaRlbbHqh9y61tg3CXZIlLEvN2ME5dwbOTg==
X-Received: by 2002:a17:902:5a2:: with SMTP id f31mr47348673plf.119.1553848753493;
        Fri, 29 Mar 2019 01:39:13 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z21sm1889690pfn.139.2019.03.29.01.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:39:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: iio: imx7d-adc: Add #io-channel-cells to required
Date:   Fri, 29 Mar 2019 01:38:55 -0700
Message-Id: <20190329083858.9988-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #io-channel-cells to list of required properties. Needed to be
able to reference that node by phandle.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
index 5c184b940669..f1f3a552459b 100644
--- a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
@@ -10,6 +10,7 @@ Required properties:
 - clocks: The root clock of the ADC controller
 - clock-names: Must contain "adc", matching entry in the clocks property
 - vref-supply: The regulator supply ADC reference voltage
+- #io-channel-cells: Must be 1 as per ../iio-bindings.txt
 
 Example:
 adc1: adc@30610000 {
@@ -19,4 +20,5 @@ adc1: adc@30610000 {
 	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
 	clock-names = "adc";
 	vref-supply = <&reg_vcc_3v3_mcu>;
+	#io-channel-cells = <1>;
 };
-- 
2.20.1

