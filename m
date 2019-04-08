Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8AAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF482084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QJoM8NsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDHFyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:54:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42552 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfDHFyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:54:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so5474338pfi.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxx5ypZqGFJEVdHb1LskbC0G/Dn/FbT8LG6QdiUJVeY=;
        b=QJoM8NsNDJBoTMO9r/0ePkPfIeEXqpKa2FFz8CKo42xCSNuLXMlVPekUlJc+8VBfbY
         3O9v8CfvrAahR5faK47S3EW2PVJQkQuQSsMmQ+9zetegFbFNTVsFrKaTUWRd3loP58zs
         bDX9zQSKrYKgEwTpe2ZCtdLO0WenRFhKvCtug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxx5ypZqGFJEVdHb1LskbC0G/Dn/FbT8LG6QdiUJVeY=;
        b=eXmPCpAZ1ovSvL9xOSu6xCMuDjwY+8qsEYUj1gNnZoDLGwN6cE7LxDu+RAMjm2szVD
         MqLvhJUDQLyGK0+HGglKxToxWS9DKmpc1iiauFCAHse73HlVpwcYTn7Onv4zSDl2Olu5
         YpsJwf6ZehSenFBDtbUujJ7oKJeQuUdsAKKAWiryIPmRwS0kJRSmGmBfeD60J+3pefY/
         7xwpLLXQaiuABhfAGsovWF1OnDDYxHy5OLw9rwuvurWrAe2Q90x7RtBkxBnZcdwEDr2m
         DMfkHSkEcbLzw2vL3FsWlFlmHNzErugEScvdQuIB58m+c/E66Pl/h0kBu2QyUCcppXiG
         reKg==
X-Gm-Message-State: APjAAAXNUykeGu66BgFNEstJsADxsZZBFArKl4MoHSKRQzW1hypKNlk6
        241gf63i5YAcroavlPaTl5t6wI8CdIk=
X-Google-Smtp-Source: APXvYqyFPQiC5fkC4W7hGUE7Xc7Snl3DRIdvT50w1uG32k3NnurmAdtEx4CHhEYdz7aBUXuQ3d6qhQ==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr28095617pff.152.1554702878402;
        Sun, 07 Apr 2019 22:54:38 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.217])
        by smtp.gmail.com with ESMTPSA id l1sm31076164pgp.9.2019.04.07.22.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:54:37 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP
Date:   Mon,  8 Apr 2019 11:24:15 +0530
Message-Id: <20190408055415.1374-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190408055415.1374-1-jagan@amarulasolutions.com>
References: <20190408055415.1374-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.

The CTP connected to board with,
- SDA, SCK from i2c0
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH11 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 6a2154525d1e..5b0631929a6c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -37,6 +37,28 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VDD_CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
+&i2c0_pins {
+	bias-pull-up;
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.18.0.321.gffc6fa0e3

