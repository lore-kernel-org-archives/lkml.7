Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B66C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEC721479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Cbqk3Ii8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfETNOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:14:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfETNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:14:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so8949179wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgNiUlcyTLppuY9tH0ogOnTGm4dNQIA4Aw7Xw6YAiwk=;
        b=Cbqk3Ii8e7bOSzJ0ptEJRWFqbnaWoT1kfUF2zytpr1axifZncBF183TsnnWcfTbOGt
         BHyQ7+XEBgVfKlMuQozejU9acPZExKrOqegeVRi8BiftxAAkKE8qaGAheclhfJWSGUfG
         jh1JJUSq1Mcp5p3laR6tVKstrK6MFuhL/HylVWiA+CZMALnfFKkYCP7K7iT0Bdy9nkfc
         MxGcel7qYSvjjevanb1DaCxRcu7rhB8jcpYXic7+7UM3OWJOeNANMPjGQoE7OfZkYePY
         xTluxTb+dThkZFvy2KiR+PSnZwZPc7dbb4DrrE6iY6Sl0ss9xlDOcZZh5J0MN6m/x1rY
         CR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgNiUlcyTLppuY9tH0ogOnTGm4dNQIA4Aw7Xw6YAiwk=;
        b=q5lhXBiu4Cl94ZkgAGDp9HkpWZ3PAICARcCkxxSD8VVg3Rz0Fz3m7T+6+KmKE5HOPA
         i/V4BjWQ3mhDaXLsY9uZ8ihmyfC7OKf+vAnwqNx+J9vL+TF8sQNcgWW6p3d9YtuEwbwL
         twEqxynR2AiDxx9IabuUtfK88Tao8G245nNezDvkoUsH0y35Y8vRmqN9EtC+Ah36rrIy
         Z4eI/LcJcL3MfUQZi9YQay5SXQfr8+4Bi7N27jT1n6InoNSQnJapURdiaQy83c05NB2b
         PELfUg+oCNYXBnH3uY5USTwTCvskAxGUvHcuAWTcduS1HEgESw5LlPTSECnfIciM/ZIU
         3ldw==
X-Gm-Message-State: APjAAAWxYGObY5rjwXtgcDE9AnbWvq6PI5OR4g8SgJ3yD4kYeNMrG8sG
        8n5UGKZtk2LojRjAK7WyZv0hIw==
X-Google-Smtp-Source: APXvYqyWr5RHhb38v+c9DGSDDjroLx1VJ4vpASEZv3rClG1SjtEohEjSfWfel9sbjtvmOB5JVHNoHQ==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr11482879wmd.30.1558358050598;
        Mon, 20 May 2019 06:14:10 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z8sm18054284wrh.48.2019.05.20.06.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:14:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: dts: meson: g12a: add ethernet pinctrl definitions
Date:   Mon, 20 May 2019 15:13:58 +0200
Message-Id: <20190520131401.11804-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520131401.11804-1-jbrunet@baylibre.com>
References: <20190520131401.11804-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ethernet pinctrl settings for RMII, RGMII and internal phy leds

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 1d16cd2107ea..def02ebf6501 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1109,6 +1109,43 @@
 						};
 					};
 
+					eth_leds_pins: eth-leds {
+						mux {
+							groups = "eth_link_led",
+								 "eth_act_led";
+							function = "eth";
+							bias-disable;
+						};
+					};
+
+					eth_pins: eth {
+						mux {
+							groups = "eth_mdio",
+								 "eth_mdc",
+								 "eth_rgmii_rx_clk",
+								 "eth_rx_dv",
+								 "eth_rxd0",
+								 "eth_rxd1",
+								 "eth_txen",
+								 "eth_txd0",
+								 "eth_txd1";
+							function = "eth";
+							bias-disable;
+						};
+					};
+
+					eth_rgmii_pins: eth-rgmii {
+						mux {
+							groups = "eth_rxd2_rgmii",
+								 "eth_rxd3_rgmii",
+								 "eth_rgmii_tx_clk",
+								 "eth_txd2_rgmii",
+								 "eth_txd3_rgmii";
+							function = "eth";
+							bias-disable;
+						};
+					};
+
 					tdm_c_din2_z_pins: tdm-c-din2-z {
 						mux {
 							groups = "tdm_c_din2_z";
-- 
2.20.1

