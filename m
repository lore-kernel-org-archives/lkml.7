Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F52070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gzhvT3Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfHLRu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:50:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38903 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:50:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so105326380wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYFGvb7oXPg06EB4hMkcpx/M0H50/uoG4GdzYeuMMDQ=;
        b=gzhvT3Y31bmaJgXF9bJ1bBvQrLxKqF5bIvlL1gIfFRH4sN4vFcSizEsc4gk8uVVa+a
         E5Ddrfy9r2Dp95i6Z0TaqRdjFP1hm++W8xQLTPimXf1oJg/eDVaDuFnNIofx5WRZsX6y
         GBrRnNMTDLNQckra2ycTiYjs/ArMlsZSY/ez8uqa91OCt7VkXlydXef1j6x8k8dZg+Cx
         Wu7xk1IHXJSugjBI/yBA2PA4ymO6MoRcArCOzYv7daBnX3pZ0u4bHNM0xoeiPqDlWQ1J
         +a2imMYHv7it3o9mYkq7RF0SzHqmbBUsco7ZIY76ouQWdxVrG0IZAjoXPAW9wjdKFvyr
         8cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYFGvb7oXPg06EB4hMkcpx/M0H50/uoG4GdzYeuMMDQ=;
        b=FVST26GQAl+l7hoHs5An6+7yYp2ecxkPAw1xiY1PR9DvnkTwUyOoALZHhfPItSmFhc
         cwQuDvjSUU+LDvp9bUbm8pO6VCDwV6nRYIeuXM+IMvaMKbZG2dHlRNJpmrvVseCqZZ5j
         L8t3TspunkuDF3bP8jXsf7Etdq7/lS1HBZ+5Ahyi9kW4lBDBM/5q8+9w/nTFbY52ziBL
         T74ZM2xsILu8actotfihGTubnsDlJEfelIproCBjapdyOsDhXyEt0a/zzAUrgYneQoeA
         OhtVu8VUW2oJoOS8YWTq5rQL/yEr7GsxLvoLbDBmBNjs3QNOPOPStBb5rpECC2xArQTd
         bsrg==
X-Gm-Message-State: APjAAAWo3JsJmznu6kHRX9hdKs8lenXmq5Il51Wy9lwkff1iCstGbk+7
        Lc+1P96xtRfz7AvrrAAqbFo=
X-Google-Smtp-Source: APXvYqxWnv0ITEtR3W0OiUar6RwPSC+dvO5i525YNm4PyQOdB40LxzasVZGae86n5vj7QVJ+kOecxQ==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr45051993wrx.51.1565632226276;
        Mon, 12 Aug 2019 10:50:26 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C1F600059A26DE113A463E.dip0.t-ipconnect.de. [2003:f1:33c1:f600:59a:26de:113a:463e])
        by smtp.googlemail.com with ESMTPSA id u7sm4084858wrp.96.2019.08.12.10.50.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 10:50:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux.amoon@gmail.com, ottuzzi@gmail.com, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] ARM: dts: meson8b: odroidc1: use the MAC address stored in the eFuse
Date:   Mon, 12 Aug 2019 19:50:04 +0200
Message-Id: <20190812175004.24943-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812175004.24943-1-martin.blumenstingl@googlemail.com>
References: <20190812175004.24943-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid-C1 uses the MAC address stored in eFuse at offset 0x1b4 (which is
defined as a "standard" offset for all Meson8 and Meson8b boards, but
testing shows that MXQ doesn't have the eFuse values programmed and
EC-100 stores it's MAC address in eMMC).

Add the nvmem cell which points to the MAC address and asssign it to the
Ethernet controller as "mac-address".
As result of this the MAC address which is stored in the eFuse is now
assigned to the Ethernet controller and consistent across reboots.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 90f66dc45115..a24eccc354b9 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -190,6 +190,12 @@
 	cpu-supply = <&vcck>;
 };
 
+&efuse {
+	ethernet_mac_address: mac@1b4 {
+		reg = <0x1b4 0x6>;
+	};
+};
+
 &ethmac {
 	status = "okay";
 
@@ -200,6 +206,9 @@
 	phy-handle = <&eth_phy>;
 	amlogic,tx-delay-ns = <4>;
 
+	nvmem-cells = <&ethernet_mac_address>;
+	nvmem-cell-names = "mac-address";
+
 	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
-- 
2.22.0

