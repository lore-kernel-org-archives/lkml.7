Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61380C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F1320656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPjM1+R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgAHUxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40748 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgAHUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4914317wrn.7;
        Wed, 08 Jan 2020 12:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AxMtdkZbidqU4qSegQIGbWKhDhQTzvUyCgxXQsTeiok=;
        b=dPjM1+R2hMGVCwZTYrExkk5iU0B49uue9XETtcEtJTcoRMImhBwubvXCiLyuu317dw
         KpR1dEz6Wx7hAKOQeYeiobvyxaBFA0ZRfa4sEnyzqEeGoM/P7iD5tbz8GEf9gEuChD53
         8CS8h9TGGZSV9BRwPa5UAbFkIcAVKpX8ATkvg+Ljk0Bp/BQHYfzJ060OL1pmKVCiYEKT
         k0kBkxFv0tLhh9H2PrSagNcFQzY6F10KeqiO7pN0zgkL4snpQ4Fy4GmLqjbEfIRy6HGr
         80Ua+dfQ6wD+5ur/kLj6XOnyL2sw1NXnUT8Ofq67YjmngRa4dp0PEi2+FwD1R/nuQV5J
         zJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AxMtdkZbidqU4qSegQIGbWKhDhQTzvUyCgxXQsTeiok=;
        b=JcLdbuiqtfB0WMFFdl4OrgFxLchoQzePvxQin1J7V5PT1LHdFYz1KwPuwoCStmXzxY
         xcD5mhnC4idFic9lXXSkPfhpYB/t6ij6V5AUGaM7MPKp7QNkbd3g/sAB5AmaO/r6gZ++
         6Wbkg5tspCaWRfc5/FRmjFzoaIEyBjfK4KbaQyVHWtQcssWtQLkYTInteU7IKNnm/Ulk
         V2mi2b0IB5mPXsSsf2qLaHnFwFbooDxHxKyDkO0qjWRQ2GiStKkow88XTyilhK/qPGcA
         yMaTymDCbUaWQYnrwoPuJxFTLjLZk678nEp24qoicFgBeBJsy7jy/MD8SlZa0jvw6Fsv
         wCcQ==
X-Gm-Message-State: APjAAAUf6TJ1BOdZQRGJTXi3/zAGTH++Q4ly5gwi+m4MrmfNaQG6mrKR
        PswXfmg1eSv4o5x6ITremto=
X-Google-Smtp-Source: APXvYqz9RmWiol10rgzy3SRvE3DRlViUR+ALbAmkaXPnGDjuiszM6MaKzkQe22GqqlG0JDGp9p/e6g==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr6800400wrr.211.1578516830934;
        Wed, 08 Jan 2020 12:53:50 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:50 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 04/10] ARM: dts: rockchip: add nandc node for rk322x
Date:   Wed,  8 Jan 2020 21:53:32 +0100
Message-Id: <20200108205338.11369-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenping Zhang <wenping.zhang@rock-chips.com>

Add nandc node for rk322x.

Signed-off-by: Wenping Zhang <wenping.zhang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 340ed6ccb..44d612faa 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -707,6 +707,17 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@30030000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x30030000 0x4000>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC>, <&cru HCLK_NANDC>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	usb_otg: usb@30040000 {
 		compatible = "rockchip,rk3228-usb", "rockchip,rk3066-usb",
 			     "snps,dwc2";
-- 
2.11.0

