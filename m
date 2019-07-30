Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF8EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13D3216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnygVzhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfG3Q6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40949 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfG3Q6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so66553256wrl.7;
        Tue, 30 Jul 2019 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=HnygVzhc23N0TVSn56fyEHozfoday5Q5qyZSBDgvJBGlsLMdm3Qbts7SA/Vnnk5IlX
         m9/PIoh03y3kOh2AZGvg9CTQOQaJoES2oGjp+fJ9m1zEJSp+7WevhikwyFBWTKIRVo38
         cOxtmLwqyK58zBBXCb6dyQWmEkc8UTAWKfautl+SCi+y2FKdvunIpCJg0WdOfvvbZFyK
         0UYNcDmIHji5GbKuywnNSQA4gmwIJq8l8AWFSDGr8GIDT6WzGwth+5Dcm+Q8BtIWKNIb
         /77rN9rwYSX0WbPWF3XxuMbMzXkLwtHJibQNrXG+vnTLu7Sqz3G/KhyAYA0Ik5QnyNRr
         tbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=n6acDeorev20HlhmFvgx88n+sqx2mJEy079LhE7Mki05wd4et3Gpxitap2mjg48lrF
         TN08oYAghUtu52Iz2QDE0SD5jkbB3IV8g8DJjX+wbWFo1cQPN2lq+zMQfEIZ3+sYqjsW
         2YzWQRykjO/4/rw12M7FT3J58Q8QpsjNO9VWXHWSkhJarnPYSSj82gLU3+F+6m2lkpIX
         Wlb1nASkp2J1BcrwEpm7AQVXe3EO57y3KuLVvh32Je8aCoXB6xHNlAFtoV+rWUHgCNwy
         V65HGGtR6E80yPkL1KSlUi7a3CMWWuh5mfGjr3xHht8VSUQCWvMktDP2DGE6U7XKXfOD
         p/gQ==
X-Gm-Message-State: APjAAAVDN353Tk5VYluONZLDn7GoJs8u0RhNU0fney/Z0xVKRc8Dbpf1
        VDPzj8iRBHvf8sqBSJ3iRxQ=
X-Google-Smtp-Source: APXvYqx/6LmFrKfTmYiDLP053J634y1HszPItk3QNsNQK0mRdBV3YW6Fc9O5fM9aKNJ6EuYMU+4R+g==
X-Received: by 2002:adf:b1d1:: with SMTP id r17mr129414217wra.273.1564505909913;
        Tue, 30 Jul 2019 09:58:29 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:29 -0700 (PDT)
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
Subject: [PATCH v9 15/15] ARM: dts: tegra30: Add External Memory Controller node
Date:   Tue, 30 Jul 2019 19:56:18 +0300
Message-Id: <20190730165618.10122-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
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

