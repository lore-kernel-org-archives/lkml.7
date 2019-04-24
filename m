Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBCAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20932084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EyC+f3ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfDXQ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:28:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37742 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731712AbfDXQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:28:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so9561061ply.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEN2W+v6pgouEEfFD37KZh1dWnVdRXyGFpqTmwD1WQ4=;
        b=EyC+f3yaLCjLCTirXfvokWi9XxT6btSBjFEbUBPGBHs6cQbAFJjZI5MA7NRUM062GA
         m6XTadILWuKlY7CXbKYA95Wzx5hYNaAJ5NEYUzcu614SOky4Tm+TmSncwkQSFWWIDXAR
         3qhR68/U6FKaxdZHF+46cIX9YFJfkS/BvyCsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEN2W+v6pgouEEfFD37KZh1dWnVdRXyGFpqTmwD1WQ4=;
        b=crR9b9Fu4W786YoQUvLGlLKmk6cmTBqfBw4UPOH3EsS2YGRzzNbCHBwGKeQ1hcnYWk
         LlL2PEowSYdDaOfeD3rl7xlHoSUhz6tFygC4/adYjJl1KL5Ohw8Zaavy35oQWimGyfw/
         Db5H0iljrgw8CJbqvzhemN+esYP9g0cr72b9oZ8prD4+odH3Hjlf94Ie+k15CPIfOzpy
         SZV74RNpfRMddrPkK0dJe5d+b8tVTT71cxECF+//WgsH+19No4sPv0A89MUwIvRTG3hV
         X5ZJtlpHU2RXqcAlup3ijTl+6bHA0e31Nh5LHp0/BlNiWsp1pOZoiQs0IInTARuDqBnb
         rN2A==
X-Gm-Message-State: APjAAAVi6vcMqDusGhad74FKnonFTg1OAqRzF9VCghsuMbHt8r4SncXI
        YBYUPmciLLbDpIApXlQiM409SA==
X-Google-Smtp-Source: APXvYqwFPCfE8+/E8Fov81OeEeHagvauypmx7lx4cxzqzOtjXT7s5MTOPaqGS/OqzlmYKsQNAExZjQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59mr33408584plp.294.1556123317990;
        Wed, 24 Apr 2019 09:28:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c3sm26089905pfo.2.2019.04.24.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:28:37 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
Date:   Wed, 24 Apr 2019 09:28:27 -0700
Message-Id: <20190424162827.5297-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU of the rk3288 can be used as cooling device, add
a #cooling-cells entry for it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm/boot/dts/rk3288.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index ca7d52daa8fb..767e62908a6e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1275,6 +1275,7 @@
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		operating-points-v2 = <&gpu_opp_table>;
+		#cooling-cells = <2>; /* min followed by max */
 		power-domains = <&power RK3288_PD_GPU>;
 		status = "disabled";
 	};
-- 
2.21.0.593.g511ec345e18-goog

