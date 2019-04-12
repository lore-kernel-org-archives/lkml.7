Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50A52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LUsrQuhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfDLMv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfDLMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so11096936wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Niok7+mQ1HMXYhWIferbfqJsQTk/gK20ga0eIZkuSs=;
        b=LUsrQuhyPX+sl/sci8Wxo10d+c5z2DVx3f3EnZ074fFT0jH7dLmqYugHEzwuwt4/L2
         UvGo6eC9cVmNy0bGM4OI36yNDLbAxOf8W0idOaWJox4mZ8YGIFCilpqqNZlN0rUKGY3f
         9PV4Aszv7H+uHYx0b45aNekCsrtXScFsXctc/CXoranGBWfc+/VhQGFhImQ756rNXZfd
         8Zdd2LDOS9lin8FztiZny6CeG/ACB8APOdQeH1m4X0I9k986bC3eVP3OCqZotiCrKOZw
         uwSaxXrEU5t9yXSNT+ZFGViQq/woq3KNGK6Wr4jh4Blg/Wy8V9/7R2mMdyn2CAubtP3C
         a+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Niok7+mQ1HMXYhWIferbfqJsQTk/gK20ga0eIZkuSs=;
        b=Q4yyQOIxRT/IVlN9Y4RYlDoYjBNFOfdwPXcerxsh19y4MO8hcMWYfTEjPakxcYqatN
         smb6MxLb3txw7zuAwcFij96bBN/QEGcsYHMwbvn33aA3KREAl2p6j3p0gOUO5zxb+hmi
         bxn21Loho9HvJGGN5oTk3SQ+Nis3pKjfXSSKPkLV6YmREP6uMLoCJCQ5pjVvMHOfItMB
         JEWuROx54x2O+vYLAvjnVTz37RndHUnuRlZgjV/qX8UkQuKlHB+0y5oaxtMzW+9eLY3v
         LAU9Rvmwoc2ku6FNluu6KluNAfXFFWNSmVljCw2/jz1yiPezKucMgeCTTk05gNhek6Ae
         pF3A==
X-Gm-Message-State: APjAAAUtJV1bYl/vgwTjBSGuAiXcLVlPp2maBFJFR50fo6vwUYT7/bKV
        3GdTp+Tq/3weMBdCfQgoIyTVQw+gEpA=
X-Google-Smtp-Source: APXvYqwkv/HuIzCLU2dgZttfVJ4dJ0e06IQmwSTo+V6pVJ+Cp/Lid5XtfgOmZK0WgM6dZWLq7DqetA==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr10691902wmc.1.1555073515021;
        Fri, 12 Apr 2019 05:51:55 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 5/7] arm64: dts: meson: g12a: add spdifouts
Date:   Fri, 12 Apr 2019 14:51:34 +0200
Message-Id: <20190412125136.28232-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125136.28232-1-jbrunet@baylibre.com>
References: <20190412125136.28232-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the spdif output devices of the g12a SoCs.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 5f5b8c67df49..90b23bacd51c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -414,6 +414,18 @@
 					status = "disabled";
 				};
 
+				spdifout: audio-controller@480 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x480 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
+
 				tdmout_a: audio-controller@500 {
 					compatible = "amlogic,g12a-tdmout";
 					reg = <0x0 0x500 0x0 0x40>;
@@ -455,6 +467,18 @@
 						      "lrclk", "lrclk_sel";
 					status = "disabled";
 				};
+
+				spdifout_b: audio-controller@680 {
+					compatible = "amlogic,g12a-spdifout",
+						     "amlogic,axg-spdifout";
+					reg = <0x0 0x680 0x0 0x50>;
+					#sound-dai-cells = <0>;
+					sound-name-prefix = "SPDIFOUT_B";
+					clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
+						 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
+					clock-names = "pclk", "mclk";
+					status = "disabled";
+				};
 			};
 		};
 
-- 
2.20.1

