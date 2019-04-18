Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7772083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="z/DkybaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfDRM1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:27:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388981AbfDRM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:27:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so2702090wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eaKPE/g0y6iUlWbfT4skrkOkZEE1ERPb5jvRgG6sZk=;
        b=z/DkybaEpi41ZxHh4W0TpCqea7mEf0swv+NpRbClwbiGpMH3QFtsVF4vmgGZoxs9Up
         mHfANPWk1cQn8o3jImRFvSNlZRJp1scCEp/s9usXZnKupsthdPuAxn3c6DzCLCaQEV3E
         DsMW/royy7O1+Tkve1ag8ddiMm30jqOD8Tv3PxnTfvNce1McukJArZj1yc6tCl4/P/xE
         q3acyIv6zFqNLpzlp2clVGxh3x/poTx5/aJsaVBh/JDT9E/E/iisELIRLac/RBZgaNom
         FPhqJ7TzG1YIgo9d77OKjJqT7l69hCv2KSHCdM2GRIpUlsHo1A2/n8wQWRxvuWRyafze
         H/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4eaKPE/g0y6iUlWbfT4skrkOkZEE1ERPb5jvRgG6sZk=;
        b=pQ73QK3yrXVM0zgDcEvQUTU0IhYLD68O55WGlLCz4Bb0z+KBQEf4W3wpAsk+LDwI0j
         /38eJz6L4O5tv/Tszal2tqLS+X+6ihy1a+JRq6C4AJPLhNqfmdYnaSXIX0UR/UH5BOkL
         QQRUcGy9G0D/jxTsk4350ryJ+qKWpiNXNFMR9YOPva+S+//qg7C3DKkpCljDzpzr7FUU
         cshLW/swIP3n4bLaq768LpWCOGW+Pt9mByQGS57ojEViD7fzICtvRyenBo1SzJwbvnah
         RiFaCzhhqcK2+i6LCreowURBkPwOxEktyxwlE0hs1E+bipgeLJCEROvngefJLRlQJA6C
         4/uQ==
X-Gm-Message-State: APjAAAWVHVxxLcPodJ4z97w11KiXYQ780DyuJkpfBNAlnOtzpzedLDLZ
        6mMqe8l0Y5HnWbki/XxqFUEecg==
X-Google-Smtp-Source: APXvYqxusOzwcmCqRLArpuFoJt81dp91tzHecWlc12b0XclIzBDHyBDD2Izdb885lEWoPwg/XddMQQ==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr2903203wml.34.1555590450923;
        Thu, 18 Apr 2019 05:27:30 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z14sm1510110wro.81.2019.04.18.05.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 05:27:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 6/6] arm64: dts: meson: vim2: remove sd hs and hs400 modes from emmc
Date:   Thu, 18 Apr 2019 14:27:14 +0200
Message-Id: <20190418122714.30805-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418122714.30805-1-jbrunet@baylibre.com>
References: <20190418122714.30805-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sd highspeed mode make no sense for an eMMC and HS400 is not working
at the moment.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 766194ab0aa8..c5f3f90a42ae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -372,14 +372,12 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
 	vmmc-supply = <&vcc_3v3>;
-- 
2.20.1

