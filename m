Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20186C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E250E20643
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QupdzH8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDDNyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:54:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfDDNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:54:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so3955496wrp.2;
        Thu, 04 Apr 2019 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=moejC13WZI797yQmS6ECZGHivYF61Sd4vvOyZQQMR2M=;
        b=QupdzH8oRaY2N8vZjswij3QuRi0BbgBD4drvhBOHcdRFTpTbxoStsCQx5AS1Mk5HWU
         zDPKhC0TqOKj5tAbSndvWs8cNAo4JL0oNIapNijcLumVF3Ss/2hSlzwJUvDHboB0gw9l
         126Irvq7N/HSMH6sZKqTnpO+X68mnbP+pClyJflmOr2q87Yfh6X/IW5iqtCAq7lvlb3c
         aUXhZxBWMTcLSvDb589gPIXDo1cG+TrQkVB8LxPGlv2BweZmDQ1UeNcan/wM4r6YD5fa
         A5295z0c32BA01kDDUMHDvi9Wyk0EGv4HFLZASHLakxEY3rPfrownTmTdDwh1+qb+2F6
         blYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moejC13WZI797yQmS6ECZGHivYF61Sd4vvOyZQQMR2M=;
        b=kOSxRvSvuueBXZuJTshIEMTu6hw4Xmn7P2t3B1tXHffmr5Z+pQfTt/tiIulVIiYc56
         LuZxVoc5/4PeL2f9B+sdq9PEDhOVaRE/KuQKbDFjXImS1TlHRFCmILomx/1rVJ2cPhpv
         jJ0ziJ6iL3YAe01itFT8qoEMT+iJhEKgxQGTCqCQfEOwmrSEIncDibvtMm47MrSZXr/d
         kYVTMzkfVjV/DmfNekXL7dYDOysIWS5nveczqxqYZT/I3hYXWoHCOuq90h/KYqRbFkmn
         cLroNR1Q3KbYVgzPhzyUfrmRteCP/YPSLAv9ewsJiUfwaNYA9iqeuSt6Qn54pOPUcAR3
         QPVg==
X-Gm-Message-State: APjAAAUgzA3PwSnoNjUAWT2c2zLrezqiSs3imheLmqxfdOEwY64pTkpF
        DDZdXTFBsbPSmkyP+sgec38=
X-Google-Smtp-Source: APXvYqwaq7BnOsNVLOoSWrDW/TgCswdPY7TvwGMIrAguJ1bdh1ASsZNCQ+pfOYeQwXxiHojjYqV/Ow==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr4126033wre.55.1554386059245;
        Thu, 04 Apr 2019 06:54:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id w18sm28998092wru.24.2019.04.04.06.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 06:54:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] arm64: dts: h6: Add watchdog node
Date:   Thu,  4 Apr 2019 15:57:36 +0200
Message-Id: <20190404135736.8491-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404135736.8491-1-peron.clem@gmail.com>
References: <20190404135736.8491-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a watchog compatible with A31.

Declare it in the device tree.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index bc5dc44171b7..3c2d6d0538b7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -203,6 +203,12 @@
 			#reset-cells = <1>;
 		};
 
+		watchdog@30090a0 {
+			compatible = "allwinner,sun50i-h6-wdt","allwinner,sun6i-a31-wdt";
+			reg = <0x030090a0 0x20>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.17.1

