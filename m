Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF78AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ED121479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VD9DKzz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfEJQuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:50:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41545 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfEJQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:49:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id d12so8643315wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymMWA7qGWKTKg4sjga2JHa1g3AkDQJanr/hpUl4TY20=;
        b=VD9DKzz95+nkF7M2qPqLJnLBiyRHTWMc45ShguOvHFsS+EbnWctH6q8qU2PaWi+MH2
         3DngXRS+8cYv2kTg4Yw8kJZRL2SGdgZLBo1a5DuSE1HN+qglmY++uOR02Abm+c5mlK1t
         wwPKvXg7TRDc8Dq5Ip+lyC8r4zF+jmDXLlIJ0OSrcIxbzQjxboRH/8yfM/mx1RdugAAj
         z17GQCVWWdsPK2DstD09KmUPn/E4jjb4WN4CrRjC1mq0/VqGTV7KnVcEjZIYHUAbTX5H
         ATm4YXxTJqEu/vy4UEJwmolN1lLDuDsmVs9dZnehUYhAmWdsphVJXAcaPaPNthAKmlHu
         W36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymMWA7qGWKTKg4sjga2JHa1g3AkDQJanr/hpUl4TY20=;
        b=LksGJ1af/3bD00dZnUS+vcDlQlAWT9rAxQWjJ3LoTN8O8OURRQmWH7UUYhWOi+gMfh
         cF5EqVv7LPdqRTl+TQo5eTi7xo7mj+Xk2uGuZlD36VvPQcl2xCTCya7ZZgFXPfTzLSoS
         /g+YMLoQD0pSjlnLfkiB0nErHw36Lka8vSEaaCg1fUTBAH5pssUh5yTIFwRQyrDZujxK
         uB/Z9iq7ScErdtBV28BQCcg3gnWZ258mphq+4L/OZ9y5qzngbTpOt/+qRFKXxRXMyVv6
         bfOFVth+wcvUmHK5svkU1kY501vY8kAQwnu/R/5zEBAjowyOyD0mjBmLVA/Bi3XlxPWv
         pqKQ==
X-Gm-Message-State: APjAAAV1AYlSE4xJ3OkepjSbgpek8N9gEvrBpQkK/vTPyQgzQ/oSvQRH
        2OHUrC1okfMRe6dBiSiYrLQasg==
X-Google-Smtp-Source: APXvYqzCTtFAhIiU7kp0M3POS//+ppjzgKaLXZ9pNB/HF4k19/83k7W5+CFc2VFcbAQUZbJnYoPQvw==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr8969231wrn.9.1557506987191;
        Fri, 10 May 2019 09:49:47 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q26sm5114308wmq.25.2019.05.10.09.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 09:49:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: meson: g12a: add ethernet pinctrl definitions
Date:   Fri, 10 May 2019 18:49:37 +0200
Message-Id: <20190510164940.13496-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510164940.13496-1-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
MIME-Version: 1.0
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
index a32db09809f7..fe0f73730525 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -206,6 +206,43 @@
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
+					eth_rmii_pins: eth-rmii {
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
 					hdmitx_ddc_pins: hdmitx_ddc {
 						mux {
 							groups = "hdmitx_sda",
-- 
2.20.1

