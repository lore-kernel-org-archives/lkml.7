Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A339DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3421849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxYDVOlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfGWDOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34127 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfGWDOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so20972910lfq.1;
        Mon, 22 Jul 2019 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=DxYDVOlEl8rKPL/ci93EyfaVTzc+8yfCy73tJKidJg7VeFXytimKbtwyICs1HRGMxm
         XRL4JqEAdjDJshHTDNcGfxVYmqCjC3TpPD7Bumwy4iV0dS9giQbhNzpQrAkK5cd5ZHJ4
         PibluzbmQH/HKBVyOngsS7cqH6RSALeHrxFeJHyIx4EXA+X4pIVh2uMR99V7vZZ0Qe2D
         HXW80+XNFiVMtseFgcMku/iw1GVMvi2rdy8BJHcqMaPCWfdxvDYODk4f3mxtDFMjsTj0
         adyNs9JDk9PFef6Lf1LDJl2Upy+PSPv49r+4lQsivVc/nN3t20ERfhqKT2x+TZYmaCZo
         MwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=L5V/JXEDf6j0iCxf/elJYJAggcPRRPq+uyTNoB+2yM7/8eQJoJdiTPe7wQmwgqstks
         q9spnqHoreZyfhw0c8HQ+MPzafKoYbkDkHNY5KkRzamQkQchpJNmEFyK1kI+mbp2y/ZR
         pfNTZAD3fEoNTxe38W/8BBAyeDcqmuphLd5+RNRyLZPaKFdruNf6DgwgmN0jetz3SBxU
         VEp1ec7WsSYPkk3i0MkjuBmVnz/B6R6AIVjXdRxniVI+JzL+nAL7CB/d29gmuuVAE298
         dMf/haZzmxNcx5E9IK0HrlzddeDC/yfFgc9SBxVunAS2QxcFuP0Nv8N6YaP5MQ52pPA/
         KoAg==
X-Gm-Message-State: APjAAAXOMgyN3w7ucUFCtlsisH2p0+dWgYBUw00lTGJKjIZPzClPf+Wd
        F8051fvVayMK7OSKeuVuYms=
X-Google-Smtp-Source: APXvYqy87FUsdrBC9bcR/my9clPr+8z90WPQYgpWUjHc6ywygY0we4FwIZK1EKQB2a+QS7KfLaja6A==
X-Received: by 2002:ac2:5a1c:: with SMTP id q28mr22515369lfn.131.1563851663068;
        Mon, 22 Jul 2019 20:14:23 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:22 -0700 (PDT)
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
Subject: [PATCH v8 15/15] ARM: dts: tegra30: Add External Memory Controller node
Date:   Tue, 23 Jul 2019 06:12:47 +0300
Message-Id: <20190723031247.31932-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
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

