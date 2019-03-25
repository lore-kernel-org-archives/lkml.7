Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D11C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7997E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cxptG/8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfCYO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so10551022wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufyFUHV9MYGt1xCCC/qB6iPXh5pMY/z0nQhLBwQ98yE=;
        b=cxptG/8mWah8bEph4tDrzfs4MMIET6v3/pp4JpGq68S/DTcPil9NN6P8BdHT8OaZad
         BFVZU1j4r29YVd2PLL6sNrC9qAX/SjEwD4o20qUMKOt1wPvFK3em4Z14cm3s8ffl1gLw
         xbWd1qw9ygu4Zhp1T/S+9kEegwGKnQQtM1AzahakmYv55XVv2TmDfQomTWOWB498h7EV
         XcZaFvdzm+UNsNZIByg5lI5+gaGJJjJzW85txBd/VZqoOroOqdGsb4DfB3XueJI9C/dC
         6jrC8BdaHFkGqWSTr8ZXdapj1QV7fGBWNQnReN4REIHEwKMFZSmI7dIB2JHu61B9IKNu
         EKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufyFUHV9MYGt1xCCC/qB6iPXh5pMY/z0nQhLBwQ98yE=;
        b=Yz/OEwdb1jBLM9hqzO74rGcjJZBFyk6CCHHayG08A9c1yxsMzgmQoPVpo1sCMKmQ5p
         UbSCz0DGHsOxK4Ar5HjxfVreRCnmutEFukM94KNu25Hp3AxJR9kCQg/549BcJhLqyppG
         aQCl9TYRCwM4GbHZ7LlTKJ56+zwO4lQWzI75L9wVkuqnQyHsr+n6+OHl118bjaWCf17l
         T5TP4sKrykKJtdWzyWZBHuKJx00Z1rJ3lnmeXfcs/dMKvJDl+Nxyj12eL5xjP9JkP2M5
         w1JhLzamDZzKBcYvLZe/qxh9C2zxXKl/tqd9GAnw9jRYOioj7ElptObt3b7NifyX6YuC
         iDsQ==
X-Gm-Message-State: APjAAAV02zNqu0tuV6856pV4F5lQOpoQkUzWodDlGovu+cHdub72STOi
        1bsY0VqctrpyaSnY+2ubZwKpsA==
X-Google-Smtp-Source: APXvYqwQuNjHn/LKrhYAODYvi5Z6dbejaSh7FedfsWLyzHYS6Qri97GbLnYtEWnSqs8PVKGA2bswmw==
X-Received: by 2002:adf:f309:: with SMTP id i9mr11048923wro.258.1553525959906;
        Mon, 25 Mar 2019 07:59:19 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: meson-g12a: Add AO-CEC-A nodes
Date:   Mon, 25 Mar 2019 15:59:11 +0100
Message-Id: <20190325145914.32391-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325145914.32391-1-narmstrong@baylibre.com>
References: <20190325145914.32391-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A embeds 2 CEC controllers :
- AO-CEC-A the same controller as in GXBB, GXL & GXM SoCs
- AO-CEC-B a new controller

Note, the two controller can work simultanously since 2 Pads can
handle CEC, thus this SoC can handle 2 distinct CEC busses.

This patch adds the nodes for the AO-CEC-A controller until AO-CEC-B
is supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index b0ff649bca46..915e00833718 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -161,6 +161,14 @@
 						gpio-ranges = <&periphs_pinctrl 0 0 86>;
 					};
 
+					cec_ao_a_h_pins: cec_ao_a_h {
+						mux {
+							groups = "cec_ao_a_h";
+							function = "cec_ao_a_h";
+							bias-disable;
+						};
+					};
+
 					hdmitx_ddc_pins: hdmitx_ddc {
 						mux {
 							groups = "hdmitx_sda",
@@ -397,6 +405,16 @@
 				};
 			};
 
+			cec_AO: cec@100 {
+				compatible = "amlogic,meson-gx-ao-cec",
+					     "amlogic,meson-g12a-ao-cec";
+				reg = <0x0 0x00100 0x0 0x14>;
+				interrupts = <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clkc_AO CLKID_AO_CEC>;
+				clock-names = "core";
+				status = "disabled";
+			};
+
 			sec_AO: ao-secure@140 {
 				compatible = "amlogic,meson-gx-ao-secure", "syscon";
 				reg = <0x0 0x140 0x0 0x140>;
-- 
2.21.0

