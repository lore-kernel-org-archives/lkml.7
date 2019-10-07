Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2EDECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBF920867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBinECWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJGNRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:17:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41742 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so8637922pfh.8;
        Mon, 07 Oct 2019 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQptgICcCtWSSBgk772ZatoxsYgICaTNG3vZM+tN2JI=;
        b=fBinECWVUCIqe34f6Zm6eVHxOd/IF8rHVCJXk63l1nCydtUcpyb2geWtuN+s+Ay4gU
         IYQjoki5Gx0y7dqhznL3n+0H0tkinm2T/CN9NHGCk9vudJJxYJdUrpB0OwWS/qXUivMC
         xB0CuWqI5T8ka+YYVaSXrrfA/WjJHKvkNImhg79hHxu6RaHhy0FIW0y6uYG1MoVnIbkP
         1b2C0xnlTfa8ddknz2jCcTmGEUPTAeITZ6YjXFfbjR/Emrtso122HF7IOeC6DiU9zUFv
         q30VrZtsw3M1yntt8ev2mhejPd5LRVFYqomJYMnX0ryYMAV8zu2Po9vZJOdttW1LnNHL
         Mxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQptgICcCtWSSBgk772ZatoxsYgICaTNG3vZM+tN2JI=;
        b=YHhJE5Qio5UlBTmAUdbRLyHo87e5LPyyn3Q4KGjPkSq0O0c/wwLzHELT6l7150ywTJ
         14y1EjzMzCSbZ7Pi11YtxxHHRzKvgZLnlKqwU7gN0wvT6g9+4MGLJ9PEI3T7n/JiJpPL
         Ea4kTTrIhbnfhIbvN6dbi4SgAbj9t/KvK5bQSYldDe8bNk/VSCcnrnpwixPKYeB+Cmto
         Fe3VUBZv+DpRR3CixkI9o5WPmI1NKUkbNH5xqBZ8R7n7lbIQZyr1eqt8kI6E3jM/dfXa
         qsfZ/QTNZas2RnDO1ZS712TKU7msKPafru3MkBJWgrWXDSgS4JAl0UKXkce/5AadR5kr
         X4Xw==
X-Gm-Message-State: APjAAAUpUKChweDBPvoW5BGJGcUcC8VcSEvYFX0hzlcj8891pSvkneJG
        bfpOXrl3TR1KYmtyln0ptBE=
X-Google-Smtp-Source: APXvYqzfY9skP87J/Jepml3CjVgEOVUZCdNt5zbuEYhEafhjGqPWB7v6/VCcFrt0DeUtkWOl/eN25Q==
X-Received: by 2002:a17:90a:380a:: with SMTP id w10mr33937550pjb.104.1570454232768;
        Mon, 07 Oct 2019 06:17:12 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:17:12 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 1/5] arm64: dts: meson: Add missing 5V_EN gpio signal for VCC5V regulator
Date:   Mon,  7 Oct 2019 13:16:45 +0000
Message-Id: <20191007131649.1768-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007131649.1768-1-linux.amoon@gmail.com>
References: <20191007131649.1768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per schematics add missing 5V_EN gpio signal to enable
VCC5V regulator node.

Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 42f15405750c..a9a661258886 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -94,6 +94,9 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 		vin-supply = <&main_12v>;
+		/* U12 NB679GD 5V_EN */
+		gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
+		enable-active-high;
 	};
 
 	vcc_1v8: regulator-vcc_1v8 {
-- 
2.23.0

