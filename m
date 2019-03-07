Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5AD2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x05kA46l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGPOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:14:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34375 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:13:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so17854081wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTKXutykj7vwY0VfsJAxh3ulcw4nav4DaRakY0rdQgM=;
        b=x05kA46l6Ub4SgMg1oVMBKRlw00P7ZOno653ZCbKjWvjaDW16/H9sw2Dll+a2S1WJG
         nay07eixuRsFC7gSdhiytqqDHI1n7wNlZGm5NIeeTOg2oCywv1YYaZFp2ifDLZg0GZJf
         HHLcrrgpjniUmnTKjbHYO7541ksgK5V7UzI9BdLl3+T6PpbtDT13uk4qkrkvqKpZXLTe
         CeRHB58iXswzThnyVz24DkXSDsDAHXYAerJyFmkeAeS5BalCu1Gfwu4tyYFzZQqsanzl
         cw7Y1aaea2Py1muGyTOapWwmBWgxOWZQnGabDE+e3xOagxNMBJaNdbvLkm/G3sOC9Tsz
         KBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTKXutykj7vwY0VfsJAxh3ulcw4nav4DaRakY0rdQgM=;
        b=NJW7Ck7w1O+tBC42fZoqqFf7H4LVdmRg0nDa67zMmWpgo0BiB3mAA0KKoWTq3RhzoZ
         fIGNr9QD2lbzCMHyxvLjxEuiUu/P02MAwVLoLec1T+CoFY/jUGJizPM/20mGd08e0Po7
         e/f+ecZD8sWLRZbKbhdVgEUeOzjSuA1v5eHIgx4BTGxcxZgyBaKVie3Z96nSJwrLxdnf
         8ymvL0iApC0BGlbGkBHSV2GYlllWZDmYavSX2v9HUChDysOCbN9ijVoI6PigP1iPigpq
         xpf9eUEPnCHetKuIfk/AryfYpWSvqhuB0EKpMoo5Cn+dSdgOUIqyLFSJ+6+6WZsUMJuP
         k95A==
X-Gm-Message-State: APjAAAUIo7w5njnF0k+8ijXsmeUGTtdwHwkF7NaVKdEXvXYdjGqWxVcv
        bR5qaekAzLdMbvqlb0XpvB/rI8ueiYwHrg==
X-Google-Smtp-Source: APXvYqzrBJHweFCZ+0W1kt+i0Xl1xJ7WPNLiGJgYkl9B+D0E4iAQkHB6LHd2tmZvp6+b3Fxkei0iVw==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr7310512wrm.25.1551971627071;
        Thu, 07 Mar 2019 07:13:47 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r15sm5756563wrt.37.2019.03.07.07.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 07:13:46 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/9] arm64: dts: meson: g12a: add uart_ao_a pinctrl
Date:   Thu,  7 Mar 2019 16:13:36 +0100
Message-Id: <20190307151342.7381-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307151342.7381-1-narmstrong@baylibre.com>
References: <20190307151342.7381-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Add the always on UART pinctrl setting to the g12a soc DT and
use it for the u200 reference design

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-g12a-u200.dts |  2 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c44dbdddf2cf..f2afd0bf3e28 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -25,5 +25,7 @@
 
 &uart_AO {
 	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index c141cc7f6b09..f8f055c49f9a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -177,6 +177,24 @@
 						#gpio-cells = <2>;
 						gpio-ranges = <&ao_pinctrl 0 0 15>;
 					};
+
+					uart_ao_a_pins: uart_a_ao {
+						mux {
+							groups = "uart_ao_a_tx",
+								 "uart_ao_a_rx";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
+
+					uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
+						mux {
+							groups = "uart_ao_a_cts",
+								 "uart_ao_a_rts";
+							function = "uart_ao_a";
+							bias-disable;
+						};
+					};
 				};
 			};
 
-- 
2.20.1

