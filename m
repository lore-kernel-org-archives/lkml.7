Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B16C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2E21924
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hGzPVFic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfIPMua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:50:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbfIPMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:50:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so10209803wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUfEPcm9zIxhFldZrxhkkyEwszDIg8DVmTXvmpvcNks=;
        b=hGzPVFic9jJ7l+dNqFEPZDAs17LUMFemybtUi2RQyKw4lNI31vG7ESwuhjCNfAhchl
         XL+JaCuTHmaduj2rp+jzvbG91jeWWFl1S9rh+MWdyOgDafQ3dHPu6spLWfinKamEXsYu
         k7J6v10E1nloeG+cbZ/Flvr4V7zrS9/24ysmPwpsMtcwmsC6Z6s2dyXzqyPMKgBDTPXE
         DbPgewVsW58oXs4phbQA2y/j4zIEN0faYeqmg0zyBS5BTYeL59yvrlEaFGFlFzr5IEwm
         l9RMFVTn1uiwphZ5Tf7dAoaD0AhtQYQ8F+B91Hhfkaknc14B0KVq7faVT4m9nScuyOuZ
         9+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUfEPcm9zIxhFldZrxhkkyEwszDIg8DVmTXvmpvcNks=;
        b=DCsDhBqUIpj2O/I93E1I3RFLjibYvFbMjRxKMAR3+SHtRqlSSGOFASu+UY5KBPWAZk
         5UUCfc3DmBhAwFe6PX60WmVYO6upJFJWZzJRB3YbRDSfG+eTG0mo1airQxtm5LLTqVDn
         gqvpz4hgBCA+WnLP5yYA5U95O/WODULX9R9nF540SKOTjUC9RnnAZV/ZEOL3nLWe1quO
         zTQD3nXtuc9UinVrh1uXFf8MCaHvyUvwM/HQSWJCpKm1Pob+dgUHKIY1ujFh9e1bcNzO
         5ZkdnblUvH6jWkGX+QoFAbbPg3z83HvbgemEZbG6/7JUalLs1ajVno9dsFnM7KwTJ3qf
         xmAQ==
X-Gm-Message-State: APjAAAVYXj/kW5EZBbYq92ukxIwHeI40ueQPszDcj3yHi1mC3DNdWHXn
        jp6KSA2dHr0ZyYCwXbA6SIm44w==
X-Google-Smtp-Source: APXvYqzlEUxhl3f79IATgDynHyFjQHa279fyhuqpYRKAX5RH9mVOwoSkz7D6xHrly5Fbd8jfpRx2NQ==
X-Received: by 2002:a1c:7fcc:: with SMTP id a195mr14283145wmd.27.1568638225511;
        Mon, 16 Sep 2019 05:50:25 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
Date:   Mon, 16 Sep 2019 14:50:17 +0200
Message-Id: <20190916125022.10754-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIE bindings for the Amlogic G12A SoC, the support is the same
but the PHY is shared with USB3 to control the differential lines.

Thus this adds a phy phandle to control the PHY, and only requires the
MIPI clock for the Amlogic AXG SoC Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
index efa2c8b9b85a..84fdc422792e 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
@@ -9,13 +9,16 @@ Additional properties are described here:
 
 Required properties:
 - compatible:
-	should contain "amlogic,axg-pcie" to identify the core.
+	should contain :
+	- "amlogic,axg-pcie" for AXG SoC Family
+	- "amlogic,g12a-pcie" for G12A SoC Family
+	to identify the core.
 - reg:
 	should contain the configuration address space.
 - reg-names: Must be
 	- "elbi"	External local bus interface registers
 	- "cfg"		Meson specific registers
-	- "phy"		Meson PCIE PHY registers
+	- "phy"		Meson PCIE PHY registers for AXG SoC Family
 	- "config"	PCIe configuration space
 - reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
 - clocks: Must contain an entry for each entry in clock-names.
@@ -23,12 +26,13 @@ Required properties:
 	- "pclk"       PCIe GEN 100M PLL clock
 	- "port"       PCIe_x(A or B) RC clock gate
 	- "general"    PCIe Phy clock
-	- "mipi"       PCIe_x(A or B) 100M ref clock gate
+	- "mipi"       PCIe_x(A or B) 100M ref clock gate for AXG SoC Family
 - resets: phandle to the reset lines.
 - reset-names: must contain "phy" "port" and "apb"
-       - "phy"         Share PHY reset
+       - "phy"         Share PHY reset for AXG SoC Family
        - "port"        Port A or B reset
        - "apb"         Share APB reset
+- phys: should contain a phandle to the shared phy for G12A SoC Family
 - device_type:
 	should be "pci". As specified in designware-pcie.txt
 
-- 
2.22.0

