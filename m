Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659FDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F054216C8
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lbql9c8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfIHNnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:43:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36178 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIHNnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:43:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so11027073wrd.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xt1ffsoUiU7bT/Gov0+R38ESRfVKrIaJ7x08/AD9uzc=;
        b=lbql9c8+5mvR7s5hfpeYHEGX44nXAwByd9MoEUudRXKDCdeTIQe/4v38PDvQWQfZld
         2IBA1YQXWdhy3Ww/R6HXHYdLi8j/vGRDOeMIB++OCr/0aQjHEY6Qq5JJ07scDhYtHBeh
         7/DBLZbcBSPfOPrpuo1se9tVTrcHpCYDJiNShaWxyMwrHO2zKWMQCqRCjyYvZc7hz5rP
         QLlBcksMZAX0b29TqiokQP9D91edjPv55/xfEc4U3PvTL8ZoxUb4leLIrg1jv9zpAlQe
         hByQQF4mjzB8y20bZSXdFBvUeLXG2PneuC7fvxJKn3bkIwXNrHyNSuQG7qzj+0WozHmd
         +OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xt1ffsoUiU7bT/Gov0+R38ESRfVKrIaJ7x08/AD9uzc=;
        b=aTMFa/n4nyAjr9iaJyN1OxKuLIiMrLvabKydFyc5aTgwLhU/XZiBu1n0gsF/dSWClR
         rXCLy43QCIzOfDA65/bNH15PZR29Sl8sMTB6jfRm9pnUJjfAd6ubsbnJmxxSiWtQd5Hs
         QIO7kd3ohtgBdJPVqSCqTJKMBm2FRXpKz8622yojiJD8kK8zmRvha8GwiR02npwK6NUL
         NmvO/x27vwDb9VlWEvyXeBzd85B8c7MNs4nuOX5J7AXu8QR7ZxD/Z2b/5OAA0OvdEUQh
         eN6QAYl5+9aaoOzLQ6I3oS1u112+iOvEKE+T7E64IFYr5g6NrMx3Ioqawbytl0qbELgQ
         Gnwg==
X-Gm-Message-State: APjAAAWPubbHBe3DpwDPltsgYhdDmJANsV6YjgmHsQPFTB85z3F6dOdJ
        5maks33XAv0Lq+/rXL3Wi5B5ow==
X-Google-Smtp-Source: APXvYqyS25653EfNGnpyjyb3kIdPuTAn8ZaDNoaRLdF9Ag8xPDJ7VA8Zq5/dKaLqURBcQaOjHotmOA==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr14661533wrv.180.1567950184983;
        Sun, 08 Sep 2019 06:43:04 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        devicetree@vger.kernel.org
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: pci: amlogic,meson-pcie: Add G12A bindings
Date:   Sun,  8 Sep 2019 13:42:53 +0000
Message-Id: <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIE bindings for the Amlogic G12A SoC, the support is the same
but the PHY is shared with USB3 to control the differential lines.

Thus this adds a phy phandle to control the PHY, and sets invalid
MIPI clock as optional for G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.17.1

