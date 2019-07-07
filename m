Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA68C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D908420673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlXHeBGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGGWz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35568 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfGGWzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so16325054qto.2;
        Sun, 07 Jul 2019 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=JlXHeBGDcgPOSpehTvZEUAPwg/03JUwV5Oib3l8ccCErTyvUSFpKvVXITpSsuA5HzZ
         CZ6UqCpB/q5sef/EOkgQ+RsNCm+A+sejBBhaTqvqalSylNB+1z72WqFs4hGxaL6+kTLx
         r2AYuXIBh2hRcjmmVkIZ+ofmon6UkniG1b16MVJK3t7bykOnH3VeebDj5Mf8gtetiy3w
         l23+w1477IPOqnjYRFfQN+gVtIRb6eML5Ua0AXJOpOI8veBT1wkZ9Hkaqnhed6YwRWF+
         POemOi6hU9+/cb+G6ei/SF0+GceH7PAbstYAin10hez1zUwXJxw8m5XPlg4jlXYCSEAV
         b9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=sWzGiyt942qXq8zzrqt/dEppl+Hpk9lwWBIJ0vvzCCC0HjRquxo3bmXL/sr5Z1CDCs
         +kkzCn/oGoUMg1tKvsuasv/1ihI+RqDGaTfdgbBtfRU8RA6WDCEdnUbcQ4qO4HW2oFp2
         X2+38mx4F8CI+Ttfgnqd5lFmVAu55VjKeMlsKu4XtT9yNleXjrcolBEwiIjKcgZAMT9+
         FsSv0SKWdr3Ya6umaQpMO2Xk02F6sMApUTIF4m6TMM7JZyTrFNFn9QFpNQFR7nUicfwE
         OcFTpDJJnqiU70QDIlufF6bnXdvJwhkTVIeGhY33cjv+D1QX5F4OmOz/fjkJ/WJX/K4G
         op4A==
X-Gm-Message-State: APjAAAUEf++3KKLOfbSoCy/UVSvVqCKyo/JND/2Vh4UOu6odoJcmU5Dj
        6cbxA18vwCJnivgYiGCfn20=
X-Google-Smtp-Source: APXvYqxAEVv5dxzJ388e9Q4kk1sMyPRq1q9tmbkqaHtnpponx5iIEAxZARkOStaKXXWWHRbiGikZJw==
X-Received: by 2002:ac8:26c8:: with SMTP id 8mr11617758qtp.308.1562540122068;
        Sun, 07 Jul 2019 15:55:22 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/13] ARM: dts: tegra30: Add External Memory Controller node
Date:   Mon,  8 Jul 2019 01:54:24 +0300
Message-Id: <20190707225424.9562-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add External Memory Controller node to the device-tree.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e074258d4518..8355264e2265 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -732,6 +732,15 @@
 		#reset-cells = <1>;
 	};
 
+	memory-controller@7000f400 {
+		compatible = "nvidia,tegra30-emc";
+		reg = <0x7000f400 0x400>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_EMC>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	fuse@7000f800 {
 		compatible = "nvidia,tegra30-efuse";
 		reg = <0x7000f800 0x400>;
-- 
2.22.0

