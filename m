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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC384C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997B020896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEFU5ZcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfDNSeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:34:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDNSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:34:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so7455765plj.8;
        Sun, 14 Apr 2019 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5eG+BJ2Wvt73uhFfrT6FHlC65RAt94NCZNgKksaa4=;
        b=eEFU5ZcOA2S2a2QM6qYgE7Nrfcbv07ty1yiNwo/+rk2jmmZWgrueIoHxT3v4XpLAOW
         F+7SsINOjqxptHUi3khN7xShjzMeueh50uj4F42XceSY9EDKvEaH9gzwssbH8wQItlql
         JIHwpG9DyfT/Mjxsd9M2g0WynNzl5Y7qx73LdQddK9slJESXiavjjIrZim5ZfY7rs0bX
         C04mz2WeAf1rltNAMiHqjp2MR3BLhglawbgSYtZZho9oX+tL0MUMdMQgIIwiPKKgQXpb
         zvXOgXyVlUh0u6sdnqfy0Y9x21wmfxpLmh9Ll5aXbzx9HIDtYYbkJXQKroICaU+XMRfC
         weog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5eG+BJ2Wvt73uhFfrT6FHlC65RAt94NCZNgKksaa4=;
        b=dyHmnpIq0iMU7h2R9SknKWnNQXyWd01S80rfgOsc/6kH6fJX/hCc7V5hPO8uQOhiUl
         s9R+ZMuhWWSKOieL8219tYEWY999JoeQUNA5g1Df6YVdUb+CURwEoh9pS1O46ArTKsJz
         aa9utW5jDWV6RSl0Ai3kbjuxLWpX70yP4GIc6z8nY68MUf0EvisRzVdFYqkXmkzUlwC0
         HMzujQHSM77wUh2/euwHS+9S9lxn2OdeN2A9AQW6HYX/ZWDkWTKT8u4kU6XOUZMbg4wr
         GMKF3ADPdakCSbJZdYkVgxCpbKk9lzEG0tuwE6UFc7VQfPxkchyYS+sNW6sBHUslwZ39
         7t8w==
X-Gm-Message-State: APjAAAW54P25z7W4Q1jSwPVOktSinAyDtknoPwU6fBV2zIUQxutHeZAr
        Uc/oLQg2GZbxQw54LZv5VNaDCK8R
X-Google-Smtp-Source: APXvYqxyBbWzYzLwU0Np85fVlFcX/V2/tvZzM561VaPz5QoaO/9o2Pd6LAQ8QJe89EvETj82zEGHtw==
X-Received: by 2002:a17:902:167:: with SMTP id 94mr41868017plb.108.1555266854274;
        Sun, 14 Apr 2019 11:34:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 10sm70159439pft.100.2019.04.14.11.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:34:12 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: iio: imx7d-adc: Add #io-channel-cells to required
Date:   Sun, 14 Apr 2019 11:34:00 -0700
Message-Id: <20190414183403.21538-1-andrew.smirnov@gmail.com>
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

