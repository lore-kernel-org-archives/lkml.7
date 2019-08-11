Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70448C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F77216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGEd5UOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfHKVCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:02:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42143 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfHKVBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so10284489lfb.9;
        Sun, 11 Aug 2019 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=jGEd5UOL6f98H6d9lWDdBF0tDLQhodxBKsyskxAtdT7jABiBUDFoO8vGh4+W+9mF32
         BfM1g3CRpA6EMr6KrXdh4GI309W8Lz/j1Om4GHR5KA6eSYIMS89+5Ab2rvbAaiQtTbK4
         kzxUzQG4kBmKFrSuj82WftSfbq/mYQgSh9numgfPkcV28JIhMbH66G1h8FssMuLdEQOR
         gBrwPDfZ5BquYzFN2dygXZsSthLzb7g7D5wXL9khRVfB7W4gbRcAJreYw2fI3E1LheTl
         yX9Y+14iZOeznspLUe1EyY+EjA7LpjlKf46A28IJZUbqvidPZh39vpY039D1Ov+rEwii
         1d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=UIEFFvwT+tyZ2v/+Vqsaw9y5E+ajM0OZamLit0WzOD2njNHIZY2KfwFoQrNiAXOEtj
         xJVvFDzM9rq7qlSGikpjstpI87HRZ19Af2zj27HglOK9EwxL4X1gGGHnneVHx8EUy3Ri
         APm/A25grXHIjHqGt2pAtxWeuay5cl3tXL/InGXBc8lzuVmcf2Xgigu9OaFLYWhTvavP
         s8TMDfvGTf3l7+jpjCLVzWlkcGbt3pbGWxUXwKF3IlY++I7BYisvG9aYFLv8udfdF5ki
         JBqtcJ0MeuXOHmIVNO3ao+44DCwAx6abGFfPoLPR4FybRBdzs+gOl9yxPJ7L+NMNbcCg
         ff8Q==
X-Gm-Message-State: APjAAAXMU3tlIDWhgCeJdKs9onkzUSljbk5BQ7i0gsYkpuKdFJDQ9rAq
        Y8RpJ+To+hYYoRJeunfbXaQ=
X-Google-Smtp-Source: APXvYqwcVR/JomYFG2mKKrmisBy3ksrqMbR2iWb0QAH4erviQYOhWFCXudyo1pGkliRlHPg+71Ad9A==
X-Received: by 2002:a19:234c:: with SMTP id j73mr17739317lfj.96.1565557302583;
        Sun, 11 Aug 2019 14:01:42 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:42 -0700 (PDT)
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
Subject: [PATCH v10 15/15] ARM: dts: tegra30: Add External Memory Controller node
Date:   Mon, 12 Aug 2019 00:00:43 +0300
Message-Id: <20190811210043.20122-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
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

