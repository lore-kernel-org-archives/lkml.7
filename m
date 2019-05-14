Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22784C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA20B21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gV1IFuQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfENO1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:27:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55693 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfENO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:27:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so3099698wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0eVRocZPCT0aug7aBTiFNphdt5giEcrh3D7mF/GVRU=;
        b=gV1IFuQpOmQFw5EBRP9Mnk6+S0wuKsb+R8Y/h6VC4FFIzEYHChCYPhCQ2ImKUDE3lS
         h2bCYZSdaC7lFj4tklHmk3M2mnYJkajT4VXzI+vSivcxbPbSbV7eVfCGAnHED5lvEHl4
         TJxTDL0E0jb+NcRHCqwHDa0g64xNzRVbnx/xs5n76zII97qMeEkIe6atSMur/ZYpQLBK
         Lg0wtHBRG28V5vcRl0W+pbtrysUSxHBvjuxokNyOhLc9cZYHl7WrzA2GiS6cQhUM1vVC
         lghBEZaCZyN+uMcDURK3PKVz0locfVwKYVUEnVqF2UfGfcx6S6EJ4Hc8AyNia93C2DPN
         epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0eVRocZPCT0aug7aBTiFNphdt5giEcrh3D7mF/GVRU=;
        b=Xu7yytz1QCQCErZe0NoYSHKTuGsDadAuzY8mw4ct68spYrkIIpeOVdvyjXUW3g87Gw
         /HzykG5ZPgjVzcNoLwh64unbi3FBKeaZN3NyPo2sCtVGXMmPo+RtF3B0gziiMxD43hn4
         O5C3Kh90jyCOzsQNVF88zjkZXMtodPZek4jF0yCxvS+zw3W75ckJjQeYHukljI2MTDTO
         h7D6JlZSjSi+KT861Swh1rVSp7DGgvxcwkiYFmRbcCMPP/6CJKdTQp31Y8RnovVbGBn8
         glVkHol2j4sNzBvh4zo6nR6DUL7VLevQyyXSPySvtGnd9PZc/Czq5vLyF/WuyBqgdcFs
         MxZQ==
X-Gm-Message-State: APjAAAUbPB6GFTrfriG3B5X1MAP2cggJkhAUimxb+jnbcxTI7ytIe4DP
        lJSq27A6jvcCtaLJ5sfmQ/SrzQ==
X-Google-Smtp-Source: APXvYqyra4gqxcH2sf1ZTeW4iRYuoO9yamYWDI8dEYSE9FcH+wiZmXCr9laJzB7zMx9u0Rv8eezA3g==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr19118868wmj.37.1557844023781;
        Tue, 14 May 2019 07:27:03 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm12343642wru.52.2019.05.14.07.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:27:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: meson: g12a: enable hdmi_tx sound dai provider
Date:   Tue, 14 May 2019 16:26:49 +0200
Message-Id: <20190514142649.1127-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514142649.1127-1-jbrunet@baylibre.com>
References: <20190514142649.1127-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the sysnopsys hdmi i2s driver provides a single playback
DAI. Add the corresponding sound-dai-cell to the hdmi device node.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index d6c6408281e9..4fd1ed4d434b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -158,6 +158,7 @@
 				clock-names = "isfr", "iahb", "venci";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#sound-dai-cells = <0>;
 				status = "disabled";
 
 				/* VPU VENC Input */
-- 
2.20.1

