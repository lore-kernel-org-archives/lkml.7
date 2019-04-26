Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04572C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EE420679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJyPCLZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfDZQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39466 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDZQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id d12so2949329lfk.6;
        Fri, 26 Apr 2019 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuIU2BQoWzCiQ5FUAaKlSoiV2sVXtdwFfbdEhHMztTg=;
        b=nJyPCLZ3ErXNfXIjsfl5woXrqnWv2QZqmaztLmTuDHbc8Pm6jl+xN4GyYqWz4/+atE
         x/Krc5kqtqsgPSBxsx1kCTKIAyD7rMdQFUSpi3TwwZU7cAXHOKm+urN6HAoUiG3+pDde
         Z/7ar+DwOLS6ABUfEDthSB2ccA/Dwv1pCDbwYT3RpwBeJs8z1Qy0+DflkKU/IQmRwAKG
         105vW23kC0BwCHqVpmnxGRUYIPUJLEvLuVAN+xRAtxsBj1qoJPsvOci6zjmjDxqQ0faF
         7hCO88ooXCOZJNlba4guRggFXBcI4aixK6to8I9yrtAiU7M/X4+tausPBMSy0IFgwgZJ
         9eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuIU2BQoWzCiQ5FUAaKlSoiV2sVXtdwFfbdEhHMztTg=;
        b=GUFBKOUw8oxUa2j/txa9kW236wnEwpWDe44JFcn9ukBTT34pUvruKdbeTrWQRdq2n4
         ki61eWhW3qr44LPm3tHC4dpUpPWchehtyCEMe9UHM8MLOUFfUd4yWFNBj1nwNZpVsyER
         mtpHb/wn3D6Wl/MiClUFV/3GcIhi7rFNsqYsYDka3Q6kx89kzAk6AAwM/cA2EAF+wcpV
         xHtYkR31DkRoQCJGFQec1WZPeu2BE7ZBH9Px94ZLXI+oHeTDl+v2piOjLZgepjwzrvZo
         B9O89vJwofVE5uy5g/Kbwu/kXMHrdF4NgfBeEWNedCRnqnjOAGeWmsUEOBxRuoNY0zVK
         eflg==
X-Gm-Message-State: APjAAAUXMFZG7H5HazVqAVHf0laQc2z+tdtEvYjKzxD454MegI5c1vfa
        nt98lsmexOhwKt921ybFbzc=
X-Google-Smtp-Source: APXvYqxIhxB+pq7CSTz418WnS4sJZ3rJXeFB7fOmACoTnFhM5FbWtx1wP6RXgY3VH+fDux3BIpC9Ew==
X-Received: by 2002:ac2:5495:: with SMTP id t21mr24993782lfk.3.1556296958026;
        Fri, 26 Apr 2019 09:42:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:37 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree support
Date:   Fri, 26 Apr 2019 18:42:23 +0200
Message-Id: <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds dt-bindings for Samsung OneNAND driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onenand.txt

diff --git a/Documentation/devicetree/bindings/mtd/samsung-onenand.txt b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
new file mode 100644
index 000000000000..341d97cc1513
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
@@ -0,0 +1,46 @@
+Device tree bindings for Samsung SoC OneNAND controller
+
+Required properties:
+ - compatible : value should be either of the following.
+   (a) "samsung,s3c6400-onenand" - for onenand controller compatible with
+       S3C6400 SoC,
+   (b) "samsung,s3c6410-onenand" - for onenand controller compatible with
+       S3C6410 SoC,
+   (c) "samsung,s5pc100-onenand" - for onenand controller compatible with
+       S5PC100 SoC,
+   (d) "samsung,s5pv210-onenand" - for onenand controller compatible with
+       S5PC110/S5PV210 SoCs.
+
+ - reg : two memory mapped register regions:
+   - first entry: control registers.
+   - second and next entries: memory windows of particular OneNAND chips;
+     for variants a), b) and c) only one is allowed, in case of d) up to
+     two chips can be supported.
+
+ - interrupt-parent : phandle of interrupt controller to which the OneNAND
+   controller is wired,
+ - interrupts : specifier of interrupt signal to which the OneNAND controller
+   is wired; should contain just one entry.
+ - clock-names : should contain two entries:
+   - "bus" - bus clock of the controller,
+   - "onenand" - clock supplied to OneNAND memory.
+ - clock: should contain list of phandles and specifiers for all clocks listed
+   in clock-names property.
+ - #address-cells : must be 1,
+ - #size-cells : must be 1.
+
+For partition table parsing (optional) please refer to:
+ [1] Documentation/devicetree/bindings/mtd/partition.txt
+
+Example for an s5pv210 board:
+
+	onenand@b0600000 {
+		compatible = "samsung,s5pv210-onenand";
+		reg = <0xb0600000 0x2000>, <0xb0000000 0x20000>;
+		interrupt-parent = <&vic1>;
+		interrupts = <31>;
+		clock-names = "bus", "onenand";
+		clocks = <&clocks NANDXL>, <&clocks DOUT_FLASH>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
-- 
2.20.1

