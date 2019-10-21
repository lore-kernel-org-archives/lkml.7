Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96481CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6498520B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b8B6lOgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJUO3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35999 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfJUO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so3928546wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n78tQVq9/plAz92sXVKu4tP9hWbwiMaXkerT080cL4k=;
        b=b8B6lOgoNis+uT9WeTDkEpstRZbzzFC6/3vDzjhz8m6KZvaEfukyLK9WO20A3gPeCQ
         uEERmRuWMkFNgbW7Z+mm/FJ9nyVvTyK/c6W6mlkQuSsnThCrP3SjSc03asVXKTcVaUxQ
         +mH7CcOORHKRGfA0a7C4jpT+QjKyjAQG3j8urpXqjuhC2YR0Ue5XtQ0xPjU7DMuoKyp3
         njRq3CdMflWesO4t4S/qVGEADwZSZys5FeBvuZ+SFEefXTGsrewBJkkI/74nVpDIk/6o
         0zjL+48M/Ev6Lm2vryoDh980gA7pKR43CxEnThIQWBI6isvkhgWBzFK/MFewl/+dSINv
         WUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n78tQVq9/plAz92sXVKu4tP9hWbwiMaXkerT080cL4k=;
        b=HqJTlZe2rbrvXQh8Kve5rdAaakZpsPChsfCBGgTjKTLb72IggzWad0py+onM9qjO97
         7FuNh5Z8XrZB2JpO0j33JywWjsLkA2asmyilkiUnhlJ1KnPyiDY5thd6XZwzfYFTlalk
         AHnznzxpzWv+TDMYodFbg/Lz1uURBt7599z9S5NjFcrRAuwJQI4LLyuwscoKsyttYQsM
         OnghdTMK75Ys0GkPtLJBtHkAaft2rbyn2pf2KF5792air98WOnOHlv15+UzU/q99Dy74
         PEhNDHU8+EQ2t410dhLkKDkkhs2rL/21impASgH2yuWDG7ScajWFKw7kPzy8H2mOChqU
         qGyg==
X-Gm-Message-State: APjAAAV5qYS7vvXjq+nKfFHStpNS4RTy2VIOeMHpu8OPeaqe1fhIn2pz
        f1ZPhaYIXaFKQb4u4QJe76Ajjg==
X-Google-Smtp-Source: APXvYqzuXnjhOxsZOJwteaURpR4IgYMNdjlr4hFzHFqPCiVyPffxvVGUoarHOGtpPpHrKSrn2edPfQ==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr19655952wmd.176.1571668148143;
        Mon, 21 Oct 2019 07:29:08 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/5] arm64: dts: meson-gxm: fix gpu irq order
Date:   Mon, 21 Oct 2019 16:29:01 +0200
Message-Id: <20191021142904.12401-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191021142904.12401-1-narmstrong@baylibre.com>
References: <20191021142904.12401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxm-khadas-vim2.dt.yaml: gpu@c0000: interrupt-names:0: 'job' was expected
meson-gxm-khadas-vim2.dt.yaml: gpu@c0000: interrupt-names:2: 'gpu' was expected

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index a0e677d5a8f7..5ff64a0d2dcf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -96,10 +96,10 @@
 		compatible = "amlogic,meson-gxm-mali", "arm,mali-t820";
 		reg = <0x0 0xc0000 0x0 0x40000>;
 		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "gpu", "mmu", "job";
+			     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&clkc CLKID_MALI>;
 		resets = <&reset RESET_MALI_CAPB3>, <&reset RESET_MALI>;
 
-- 
2.22.0

