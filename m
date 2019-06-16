Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47911C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A90C2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2yYGjNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfFPXgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39467 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFPXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so5144339lfo.6;
        Sun, 16 Jun 2019 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LoNLOLC4v22fCk8MRxYZiVyFU9l44MdyNDw1bDmHwQ=;
        b=m2yYGjNriXkaj18ueVpnD4vnoouUICdAj4mYFBxnqWOZGiwAaR5Bs62vrnNjku/2vP
         X67mpJWA+Abgp3FLwUmzC4yHD/IIBAci1l5sCvSuG+RQj1QTQ4TBNADrYYOoJbkuKhZB
         w56N3l17SwypZ6jd/tRs51e+XOyJr/UyXacC/6cZkB715iKmYAC2qQq3oVJZ2CdMIM8/
         xiqV/zALHGyJE0dADZZDSa2AGYqQoRM85PqPwEFDpRKyfwFdjgM1tJGkTjxbivOYl5Bv
         YlTMe6qRuDuKUcifzd1nvbQtVzFmLd8jB2MlIK4Zi0M+rUhN188PdRy25B6MGy6lxBzE
         +wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LoNLOLC4v22fCk8MRxYZiVyFU9l44MdyNDw1bDmHwQ=;
        b=JldVCg+NoqVj19IuB9My4zeUyA0WRDy70zx1prCZJ8lQANPP9hwpJMMqssyuW5GhZ9
         Bm/7kbbNLkehqyoNb1KPPEwuvFNqGQL9ZTK0fOpcVXyyWk9G4o0rfz8eZE5XiA0Qf48U
         nueNDBNzMIhTjLSClEweKB9E+XPi6xxzAvaBcGT266WBSfOOx5PCrazRHRsJBZXyQ3US
         eDJHLAhY+CHd2OHt9eeRy8YsPcxc8OcOvfbF6bl0bs7FJyKoCkgH8O7+Yh62+MBKg9Ui
         qMd/ph65XVD9hQl4IxY6fn6m/pxO4cmvu8wCfC+lLbKT1OMSgEtOPMqI1tqEyFvSBmsp
         Hclw==
X-Gm-Message-State: APjAAAVgmEFqD1DjY82Pzm8FkI72eO5uDmxu5DpoUFO8CC/skRLTVs5D
        7zyPTx4gWklVHPKwsVfiSHw=
X-Google-Smtp-Source: APXvYqzrZ4HrWxTmGdAtjCWvopnaULhASTi++CVRUtOFAy27Rd4qfCGCV/jA8t8SLbcC9nAlQ6DX4A==
X-Received: by 2002:ac2:5212:: with SMTP id a18mr46653296lfl.50.1560728176194;
        Sun, 16 Jun 2019 16:36:16 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:15 -0700 (PDT)
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
Subject: [PATCH v4 10/10] ARM: dts: tegra30: Add External Memory Controller node
Date:   Mon, 17 Jun 2019 02:35:51 +0300
Message-Id: <20190616233551.6838-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add External Memory Controller node to the device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e074258d4518..92c4aeafab29 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -732,6 +732,17 @@
 		#reset-cells = <1>;
 	};
 
+	memory-controller@7000f400 {
+		compatible = "nvidia,tegra30-emc";
+		reg = <0x7000f400 0x400>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_EMC>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	fuse@7000f800 {
 		compatible = "nvidia,tegra30-efuse";
 		reg = <0x7000f800 0x400>;
-- 
2.22.0

