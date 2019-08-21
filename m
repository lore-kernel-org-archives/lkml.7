Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF63C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D2233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U/VJAIWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfHUOWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:22:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfHUOU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:20:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so2211676wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBn+s7shYC39K9Spwq6+NMMR/jl0g0PIkiRbeqrATnM=;
        b=U/VJAIWr87HIEPwTw6ElLTU+BjcfdWObT+soaik9zxpQDIVHoX/0bjZK/FOEiirw/M
         SS69viIfEFVAfR6Q1dHPajmwVRdN9bo/ooyrTLtz9E3+TCcV8ngieuMQg0q18YgRFMqa
         l6HgIUuyPsRBWKCIzcWjNtpf0k3KxlaTT40Pc4ri5V/wus7rC5QFXeJt4A5/5iQ3fXIs
         5j8XdCSRKHz6eYplrYr/+QD+TlmN0GRfsBAWYjQTIMbWalua40oYT/Xjqm3lnJoIKz2F
         I/scEtrhlncrq01IxhTSVmqfoUZO1dDtfVgovHbiDk05CeM40zvC5Ce4vsHJKC5eZi3g
         VzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBn+s7shYC39K9Spwq6+NMMR/jl0g0PIkiRbeqrATnM=;
        b=G0xeXLNgVobZkYVqxKxxTq6cH2k3AqLuXAGZ3yqjzyiIkzya7ppVze6a1iSKMdG5LG
         3PzfOAn9WuOZO0kOZQbpwyuTvSHJijNV7GpaZXL9iZGiHUz8tsWwKt7saKa6MMzQ+FxE
         P0ol9r5Ti07fQLaX+wwDLcUY47kq8CvWm/S8lHuy44ahfnPhLaKLUPre9MJOazqCZorI
         8SzsjVGcHr9T0z2BnRe9E8OHzp4BiADunx0KEan3tUYrSihN8yGdCnVZ9poIcCnoh6g8
         UKr+uUISfNS1C3oVfhxTu8lG5bNuhPNY8EfxkS+Kjy2Q71behJkxOppDLEm2qTwR0uJt
         RgHA==
X-Gm-Message-State: APjAAAVyYnJEae5LbChYyUekG7h5xe3bOgYKOnfNDTsDILcxROrLHloF
        6mb2j+Y7m0wH8o/0cSDtRlSamg==
X-Google-Smtp-Source: APXvYqxy04ouXX3eyK6f9Fi/iYrgL3Vj5mFrNuT90x0YMz28UBE0Fi9V1zFuiKfoH/mxJeevShFsXQ==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr40633375wru.255.1566397255042;
        Wed, 21 Aug 2019 07:20:55 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 02/14] arm64: dts: meson-gx: drop the vpu dmc memory cell
Date:   Wed, 21 Aug 2019 16:20:31 +0200
Message-Id: <20190821142043.14649-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: Additional items are not allowed ('dmc' was unexpected)
meson-gxl-s805x-libretech-ac.dt.yaml: vpu@d0100000: reg-names: ['vpu', 'hhi', 'dmc'] is too long

The 'dmc' register area was replaced by the amlogic,canvas property
which was introduced in commit f1726043426c73 ("arm64: dts: meson-gx:
add dmcbus and canvas nodes.") and commit cf34287986d0b6 ("arm64: dts:
meson-gx: Add canvas provider node to the vpu")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index faff77175486..c2d3fffea8a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -528,9 +528,8 @@
 		vpu: vpu@d0100000 {
 			compatible = "amlogic,meson-gx-vpu";
 			reg = <0x0 0xd0100000 0x0 0x100000>,
-			      <0x0 0xc883c000 0x0 0x1000>,
-			      <0x0 0xc8838000 0x0 0x1000>;
-			reg-names = "vpu", "hhi", "dmc";
+			      <0x0 0xc883c000 0x0 0x1000>;
+			reg-names = "vpu", "hhi";
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.22.0

