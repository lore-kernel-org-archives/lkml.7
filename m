Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD43DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9510623891
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpnbn0HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE2PdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:33:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33565 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:33:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so4530674wmh.0;
        Wed, 29 May 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5W+VfwPfqMxuifytQsznT6sIYsecd+CfEiYRucHLtVw=;
        b=Fpnbn0HNja35ikeRV50pnLDukXTvZ8yfSsbNwOK438ie6IyOvAPt5PvjCLxjq8MQPH
         4ZYtaLQWPnexoXzWYmYAf+LDrMCMeB5hFGjSuNA1v4sKE9YbyBTGBXGGefd3ZITHm5F8
         WrUISOoGcPku4R+wXfliDsxAVY3ZoCWnIuothVksR0yPYWp2Kw0hPCjGMEMjG8Y90UWz
         fKWp4ZcWytL9/hIN5j+k0m7IgW+kIk+5VtEpQF92UFU2NJ1/lYs2Iwp6hRADpITIGMsB
         9tjZ4JVWthW+Z2sjBQlKmp1JruLrcs0ok5Tb9xk/ZKaAiBAGyWlPgfaqmKXlDIzyDKAP
         ZsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5W+VfwPfqMxuifytQsznT6sIYsecd+CfEiYRucHLtVw=;
        b=it5T9wxR5On1WHr4EGg2//i3NnoV2WPDokVZo+s2bL7XTIbRR9gO2NtwMcVm8/1w64
         VNEkA8hfOx+vtqhim95UBBR5Tj97f96gg3HRkKnSmewPBVyXxtu/9KkxJWqX7nD54MeM
         9mtxnaMU3fGvkHCnblB/GcwU245683q/zxbW1mX1iBs1jGERVExxWggQOSY73iMMhaTD
         TV5Or89hLz9foZ61+It0nGO4W+q5SdMzwS0nHvNqqomr0x0DDLoOd8tbAk5fJ7qZcuGP
         6Y+gtPvznn/evcb0wcCH74/L/UbWc7GBMWbB8LEgtH6S7GXR2mb5xDMp8O49jKoVd65J
         fobQ==
X-Gm-Message-State: APjAAAVsVsdGuj+g7SEce+qP37zjRAC6DLeNC7h23Ftrj+jbvRtpOunO
        k19z06cfMaHcmeeMEn3qgAHXY2gY
X-Google-Smtp-Source: APXvYqwDY7MrR1G0Ebmbd/oGtnz/upe08lmQ74Ra2glmRchate4lPg8V3/LoNaUcg9HKRwxBBfDugQ==
X-Received: by 2002:a7b:c8cb:: with SMTP id f11mr2194459wml.54.1559143991698;
        Wed, 29 May 2019 08:33:11 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.156])
        by smtp.gmail.com with ESMTPSA id c14sm19105489wrt.45.2019.05.29.08.33.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 08:33:10 -0700 (PDT)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] arm64: dts: allwinner: Add GPU operating points for H6
Date:   Wed, 29 May 2019 17:32:55 +0200
Message-Id: <20190529153255.40038-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPU driver needs them to change the clock frequency and regulator
voltage depending on the load.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Clément Péron <peron.clem@gmail.com>

---

Feel free to pick up this patch if you are going to keep pushing this
series forward.

Thanks,

Tomeu
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 66 ++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 6aad06095c40..decf7b56e2df 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -157,6 +157,71 @@
 			allwinner,sram = <&ve_sram 1>;
 		};
 
+		gpu_opp_table: opp-table2 {
+			compatible = "operating-points-v2";
+
+			opp00 {
+				opp-hz = /bits/ 64 <756000000>;
+				opp-microvolt = <1040000>;
+			};
+			opp01 {
+				opp-hz = /bits/ 64 <624000000>;
+				opp-microvolt = <950000>;
+			};
+			opp02 {
+				opp-hz = /bits/ 64 <576000000>;
+				opp-microvolt = <930000>;
+			};
+			opp03 {
+				opp-hz = /bits/ 64 <540000000>;
+				opp-microvolt = <910000>;
+			};
+			opp04 {
+				opp-hz = /bits/ 64 <504000000>;
+				opp-microvolt = <890000>;
+			};
+			opp05 {
+				opp-hz = /bits/ 64 <456000000>;
+				opp-microvolt = <870000>;
+			};
+			opp06 {
+				opp-hz = /bits/ 64 <432000000>;
+				opp-microvolt = <860000>;
+			};
+			opp07 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <850000>;
+			};
+			opp08 {
+				opp-hz = /bits/ 64 <408000000>;
+				opp-microvolt = <840000>;
+			};
+			opp09 {
+				opp-hz = /bits/ 64 <384000000>;
+				opp-microvolt = <830000>;
+			};
+			opp10 {
+				opp-hz = /bits/ 64 <360000000>;
+				opp-microvolt = <820000>;
+			};
+			opp11 {
+				opp-hz = /bits/ 64 <336000000>;
+				opp-microvolt = <810000>;
+			};
+			opp12 {
+				opp-hz = /bits/ 64 <312000000>;
+				opp-microvolt = <810000>;
+			};
+			opp13 {
+				opp-hz = /bits/ 64 <264000000>;
+				opp-microvolt = <810000>;
+			};
+			opp14 {
+				opp-hz = /bits/ 64 <216000000>;
+				opp-microvolt = <810000>;
+			};
+		};
+
 		gpu: gpu@1800000 {
 			compatible = "allwinner,sun50i-h6-mali",
 				     "arm,mali-t720";
@@ -168,6 +233,7 @@
 			clocks = <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
 			clock-names = "core", "bus";
 			resets = <&ccu RST_BUS_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
 			status = "disabled";
 		};
 
-- 
2.20.1

