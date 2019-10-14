Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F8C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA620882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="EhVRSGM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfJNGWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:22:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35398 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNGWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:22:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so9473454pgl.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMERlWSqQRpIHeocTwvdTvcdslf3WCnckyLXrl+iP2k=;
        b=EhVRSGM/LVYHndUx4a8Zhw+E2VhZIauOz0cXdSAihhZcoRRe1lcywXPeUWJLUyo8Yq
         yOHvDRn1xC82Y7kBakikHc8wW1FqjCoAx5tl0zLn8jC9CP5sOsLBF1+eqnPpGBLoc+dD
         5OyjOhz3Z0U147rH8M9ZpDD5Zuo1/E5yr6vOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMERlWSqQRpIHeocTwvdTvcdslf3WCnckyLXrl+iP2k=;
        b=o9X2lusQterZMZ00HNEsU8+WH3RkJyVBu9dBAnZIc3R2Y8A0R3IUetZYL8yXLuk4qO
         0qCb2hAiO164SBd3sqKZZUqBS/DYoxb4X7HwADz08FB7HAKOi02tyS0I82YlRisVfMlJ
         0vHNka15JSSYi0sO0sMU+1BLA9xjnfDrGLpFyIFFAjIFDdG57TFy0k6ocM7ONHZKuh7J
         EL+NaZDtFm1EMmBEoj7ghqF4b/IKVdVN1HYvLc7xqr7G8xJD6StzuidVdS4whf1AJHrd
         5Zi6mswPy3yvw6wBRxkRpHJq+ea7e3SamScF19PUwJVhSII/Ydof/YYxFUvRvhrWuMUh
         83YA==
X-Gm-Message-State: APjAAAU0/UxMllIIWIWLARC55/NT2ww2hxb6/G4/GD7h3H5sWd/qP7x3
        OIKAQS0a11NuumArWoMjQfa7hg==
X-Google-Smtp-Source: APXvYqy3/l0QJtpAHiodbnHKrO53hokveu9msEsRRqy/09MKQZsPbt/kdZKbFPRJlmD1RtGRgsX36w==
X-Received: by 2002:a62:4ed6:: with SMTP id c205mr29952341pfb.170.1571034137207;
        Sun, 13 Oct 2019 23:22:17 -0700 (PDT)
Received: from shiro.work (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.googlemail.com with ESMTPSA id g24sm16874074pfi.81.2019.10.13.23.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 23:22:16 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     daniel@0x0f.com, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: mstar: Add dts for msc313e based BreadBee board
Date:   Mon, 14 Oct 2019 15:15:59 +0900
Message-Id: <20191014061617.10296-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014061617.10296-1-daniel@0x0f.com>
References: <20191014061617.10296-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BreadBee is an opensource development board based on the
MStar msc313e SoC.

Hardware details, schematics and so on can be found at:
https://github.com/breadbee/breadbee

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/infinity3-msc313e-breadbee.dts   | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bf0aa53d3a13..e546dfafef55 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1276,6 +1276,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
+dtb-$(CONFIG_ARCH_MSTAR) += infinity3-msc313e-breadbee.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
diff --git a/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
new file mode 100644
index 000000000000..cf185878c412
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "infinity3-msc313e.dtsi"
+
+/ {
+	model = "thingy.jp breadbee";
+	compatible = "thingyjp,breadbee", "mstar,infinity3", "mstar,infinity";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		bootargs = "console=ttyS0,115200";
+	};
+
+	aliases {
+		console = &pm_uart;
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.23.0

