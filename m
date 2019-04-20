Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBEC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD8F21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DkVfbgQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfDTJdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:33:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36639 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfDTJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:33:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so5132231wrw.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 02:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQ+tn26yoSTxpsC/FCAOuzkhs/vTmJv3gslqGviFWhE=;
        b=DkVfbgQvvjGuK8Az1uYDPffYw0jFhUcl1uDHsogv2Rv04vz3a2Ha7GWX2FRfzWD/ox
         pbnOIbslpKUFJXdvw5PL74GVtw40g6gPzQb7q25fdcWEW/sYKnLQjsfrozOiFzHqVn1S
         YgSpWncgsblFP8x4FqFO5LV8RIizrTt1p7mIXynsBq9CrNonUc8UHNgXGwM8dKsSQjmy
         gq562idPbg+kFBv3BOT3uBioX/evlN4I2YibH62hi6Ar2lbpt7hhcP8lkmW5J467JWPJ
         rIE1DjSn0+rvw9CZIKVJXAcocidaUQQa+4pHvAz6gLL6oWHwViOe8MfOWE+7qQxIiIOC
         oyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQ+tn26yoSTxpsC/FCAOuzkhs/vTmJv3gslqGviFWhE=;
        b=Ad3xJOilogMKlZdbc/Nt1VWj3i98U73uZqylDKPnF3kntCeCc/Mpfrwb3irfqYJ9pv
         U627Cc+Nqjrqf5B6uyv4FA4XK9Bx9dv8bEe26oRihEuP8A3RXl/WyHP1Yh86Y9VNboCL
         RkF2iSkYyp6PsoKK9xzooIhy6EReljpYBhtXCsyV5CNiiWbOYHbad9M2unvDYWOy6kP8
         8BmQrwV1E96qvZfEAeT3/tBo8jY7rD1+fDeh4qfPrSkUHdJtr7LFKH+NJTXEj3utfgQ4
         QhSpOJfHNHopwHgl+40U6NHlPmvhZe9TwCWqT98RP0dqdfBlikw/mCllgF8YthoWvsUz
         loUg==
X-Gm-Message-State: APjAAAXn98csesA8ofL7V2b5f7xTO20gCEjrcNaEq7gqGQiuYctXERDX
        GWWygJ+FaB4lcLtcJ0BYuo4=
X-Google-Smtp-Source: APXvYqz44BVdQ6SIXDaTxW3Sxyrgkr340DMrA9/sYxJIqOgJDR+MEBnI+oqq4Oqs6aHOt1p+4l7XyQ==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr6365248wrp.129.1555752794023;
        Sat, 20 Apr 2019 02:33:14 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0028C4739A57449001.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:28c4:739a:5744:9001])
        by smtp.googlemail.com with ESMTPSA id w11sm12858244wre.15.2019.04.20.02.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 02:33:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson8: fix GPU interrupts and drop an undocumented property
Date:   Sat, 20 Apr 2019 11:32:57 +0200
Message-Id: <20190420093258.2012-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
References: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupts in Amlogic's vendor kernel sources are all contiguous.
There are two typos leading to pp2 and pp4 as well as ppmmu2 and ppmmu4
incorrectly sharing the same interrupt line.
Fix this by using interrupt 170 for pp2 and 171 for ppmmu2.

Also drop the undocumented "switch-delay" which is a left-over from my
experiments with an early lima kernel driver when it was still
out-of-tree and required this property on Amlogic SoCs.

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 7ef442462ea4..40c11b6b217a 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -248,8 +248,8 @@
 				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
@@ -264,7 +264,6 @@
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
 			operating-points-v2 = <&gpu_opp_table>;
-			switch-delay = <0xffff>;
 		};
 	};
 }; /* end of / */
-- 
2.21.0

