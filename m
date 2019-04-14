Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD1C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E52082E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsvKl3oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfDNU3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:29:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNU3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:29:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so7546249pfn.3;
        Sun, 14 Apr 2019 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX9jSPoknvc5J7MjiliCqU6YnL7woTcrtYt9debrJo8=;
        b=hsvKl3oP2H45EQWX3A72oYlNJ7x/o5nSi6DQuXrkIQJ8VEuG0dzAqoiysbKeB4VSYS
         1/nozr4AxmOSnWvTIEaEHNwx3yzAdEahqiRnoLODtF00xYgkV7bMZ3fPmHNwcWtgFqC4
         /QYoIcIv1lrq5Qm3+Y0If+sFn7CBIwIf14wE27933vuyWeFI5erZadEsWP7qAc878hft
         dBqa6LUgl8xM+xUyRiFM8WbwSul9TEaW+dd0XEC/4U3pcNRJ7oKGjGhGrYz6Q+lNHqeK
         UvzL9GqrZWYbKJYoY4/jwTw+kzzaDxNTH53dohNHNoypANXy/jANMCVx0Kd1sQZQiFS7
         RBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX9jSPoknvc5J7MjiliCqU6YnL7woTcrtYt9debrJo8=;
        b=N+hn2phorgm45nEkgaRks5SUFADPuhBJCv0fHmddPMF0YdR1PVqCVlXfPJyGrvCcso
         ls1GbM60yg36pJjSbgyKxAIHBfaesBguPUJkMLN0+PXYFxwA/72wUEovZKCyh0SbyL4/
         Mfu2n/M+nDrezs9IUc0vgJU6vHsSoUJzu53mX4986i3v2PwLZIhkTugEGKUvE9wyJRk3
         8b8nhz931XS0XL9S0Zaj3woxVYtRSIL+gHfDpO0K3j2yjhqZLz8dVQc4cNoERq+mElyl
         CkFUwhWKUnMfOw86Csvincna2tmFCfWAZPkVRCCJP+TkKzWPn4zCjfLwchW8A2K15GTr
         dTIQ==
X-Gm-Message-State: APjAAAXYd503QKynOpgpLk11eDuq8gDPA8Ks2nyrPn1vsG3S3SJCzMFQ
        8+0Yr8wvRibGFVVGoiK5j5M=
X-Google-Smtp-Source: APXvYqyivyx7VAiJmBz/mI2C9T6g0nOyQJ/6MrTKK+aziahQCSQguEg6dmdXl5aimYqvnMDXcOa8kw==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr64262362pgk.387.1555273792598;
        Sun, 14 Apr 2019 13:29:52 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m25sm63142091pfa.175.2019.04.14.13.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 13:29:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: tegra30: Add External Memory Controller node
Date:   Sun, 14 Apr 2019 23:20:09 +0300
Message-Id: <20190414202009.31268-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414202009.31268-1-digetx@gmail.com>
References: <20190414202009.31268-1-digetx@gmail.com>
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
2.21.0

