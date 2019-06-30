Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC61C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022402089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDI+oZls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfF3VFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:05:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45851 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfF3VEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so10894887lje.12;
        Sun, 30 Jun 2019 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=mDI+oZlsTjMZ011aaWfEOzGbNWiemzxQO7S1znKAjaG9I4rRDjx5EWabNeNZQ66jyC
         row9h2FgywRmlwPif8BkAuj52pWOQ2xZqHeulXTwLSjxkzpwd93F92IHymOoVOKgZCxx
         zU0DfjYHCkvy7Zn+iVoGseJDq3KZaLBlgXIuY/klh4dqhrOmwHs/OG2fPbISrt0lEUuW
         Eg1OJxOEvOeTzGBwO+gDr74Zf1j9c0QlFormhMF8mxDFborDgdOzrKFx1NDPiox+pK1G
         nF8dWqjO/jYtLPcZfM59nYrr08Kgs5bsTcBb78nx+9kZXvKXImhAZhGjaIwfPBhVsP7i
         HfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ErUctKt9CJ3rgf9ZExT4u2Tmx1X1fVjtqY74IUmVOo=;
        b=uDiQKGrxb9eW5fr7ePOQz6sD2zf1LgZ3dz+vmF7qjTuJKSTUlJBXUpd1WqWJrpw30Y
         nv2MZlBgIQFc4edb1girgABN3phn+xTktrZgXGLb/l42SdNLxj7oZ2PogAI/vsq2BlwR
         RK3LyvIntmch4EKbgbZ5A7ozIRNyuV5hdLeXWbX/LWhQt1+e94aWSE5KbHNEatQJgx3f
         s/uIQBr/ssyD4bYZud/Qz4lxdhbaC01q2z2de/WQHDFKzPc3ZIzWoQPNtPJAaOLTeanp
         y+gHOMTX0fkTWY39N0UfV9QA9Lz3BoX+pHBHuPe0JM56Y4j+zD0F55MbHMtq9dYBv4vd
         ncGg==
X-Gm-Message-State: APjAAAUSPGKYN0587WTWhETYu7ahs1QLOD8KjT8xM551BuBd6HeDKiqu
        d59fGDiKC7S+uk+4ayGvcl4=
X-Google-Smtp-Source: APXvYqxMSOrFJP6zHqgaD4UXKs1yS4doambgrEVLaOY6bgg0oynk4XyWhKJMI02wb5r/vMxpeHVJFw==
X-Received: by 2002:a2e:8847:: with SMTP id z7mr12128141ljj.51.1561928692491;
        Sun, 30 Jun 2019 14:04:52 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:51 -0700 (PDT)
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
Subject: [PATCH v6 15/15] ARM: dts: tegra30: Add External Memory Controller node
Date:   Mon,  1 Jul 2019 00:00:19 +0300
Message-Id: <20190630210019.26914-16-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
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

