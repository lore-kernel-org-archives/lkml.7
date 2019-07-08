Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93309C606C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S91Bo/iS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404004AbfGHRdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:33:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36411 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbfGHRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:33:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so18096696wrs.3;
        Mon, 08 Jul 2019 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86nG6aLjB0rQfTa1JeKBqtUNM26fhH8P2gspJ7zF79c=;
        b=S91Bo/iSQVilNEvDQZty21Czz8Xy6eSTLPIR5zKd1Rg3rP5WbxMvS/DJDOeyE/XVXW
         aHFHQjmdXwcK50Y4+jYXBYtJ1flCIXrr+hv3K83zh+T0ClE87unGP8Ase+6yhaoUxRkc
         NlXxB3Zlj5WCpM1b4n+Xrtzxp+0iAxSUa0Pos9bi6RDwo4CpGBfpNcsTpFuaXO9Wy0Xz
         OAmlBOT46F1pTnKUqTgqvOXEsiR2D1zso66KT8sXen593NvAguABVNshKJlE8cfbANZF
         D1iCIKKTJGv1/q0Knl1k9F3MhpY3FCEVKgaw4jtpS2fge1SVLP3Un54aAmOdwfnvWhgG
         zvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86nG6aLjB0rQfTa1JeKBqtUNM26fhH8P2gspJ7zF79c=;
        b=qtD1nF1lU8zOkH328U4Wwq5cKb7+kgmfHyP81SBLyTjsN+PlGXdn2HMw63ycj5/Okp
         LhapmRZIPp1W9uYfkrDijvp9gPI4HaCLi+2NdEt2ka5od02YXdYO0oHlvw2wh4rhovqi
         9M2v/OPQnR6vYaD8xYlp03DAkuts314S2tG/AZ1bwmyY9RMp0ROY98pD5VavTh0r/s3j
         JimKHLWlSO09kG3MMyBbfX3j0mrFamYiJC1Dom0mQK2O3Zhm4XMmzpMxzom8A49HSbAr
         lfdOEckM2gmHVBByii2WiAHmddhqxhFB9IMCuT27jlXTPXA+tlHSdlbIZSHwo+RueBvT
         aSyQ==
X-Gm-Message-State: APjAAAXjTeLJzqj02rT+umDd17A/ltlLHyNPAx7qyfM/YRJ3P7ab+u7C
        cZ3rY+UL9iErsKbB0oWYcn/I3JDc
X-Google-Smtp-Source: APXvYqyw4e6GErWNnFPJZiRpLoMeZMMHruQUP6TKeaX/SOIK6VvvXaEFtgy43V9iJD0S5KCpV+zQhw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr20530156wrn.123.1562607226315;
        Mon, 08 Jul 2019 10:33:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133D62000D8A33B20A298F2F2.dip0.t-ipconnect.de. [2003:f1:33d6:2000:d8a3:3b20:a298:f2f2])
        by smtp.googlemail.com with ESMTPSA id s3sm222975wmh.27.2019.07.08.10.33.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:33:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, jianxin.pan@amlogic.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
Date:   Mon,  8 Jul 2019 19:33:29 +0200
Message-Id: <20190708173330.13217-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the devicetree bindings for the SDHC MMC host controller
found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
HS200 mode (up to 100MHz clock).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/mmc/amlogic,meson-mx-sdhc.txt    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
new file mode 100644
index 000000000000..afe14210030c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.txt
@@ -0,0 +1,34 @@
+* Amlogic Meson6, Meson8, Meson8b and Meson8m2 SDHC controller
+
+The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
+card interface with 1/4/8-bit bus width.
+It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
+
+This file documents the properties in addition to those available in
+the MMC core bindings, documented by mmc.txt.
+
+Required properties:
+ - compatible : must be one of
+	- "amlogic,meson8-sdhc"
+	- "amlogic,meson8b-sdhc"
+	- "amlogic,meson8m2-sdhc"
+	preceded by the generic "amlogic,meson-mx-sdhc"
+ - reg : register base address and size
+ - interrupts : SDHC controller interrupt
+ - clocks : phandle to clock providers
+ - clock-names : "pclk", "clkin0", "clkin1", "clkin2" and "clkin3"
+		 ("pclk" is the module gate clock, and clkin are
+		  the inputs to the internal clock mux)
+
+Examples:
+	mmc@8e00 {
+		compatible = "amlogic,meson8-sdhc", "amlogic,meson-mx-sdhc";
+		reg = <0x8e00 0x42>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkc CLKID_SDHC>,
+			<&clkc CLKID_XTAL>,
+			<&clkc CLKID_FCLK_DIV4>,
+			<&clkc CLKID_FCLK_DIV3>,
+			<&clkc CLKID_FCLK_DIV5>;
+		clock-names = "pclk", "clkin0", "clkin1", "clkin2", "clkin3";
+	};
-- 
2.22.0

