Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3456C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0270206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTbhzaNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfGaU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:29:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbfGaU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so71156798wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QWLof1O3nhMlU7i5ZCEmG2qQ6v7dulP8/K2lF3I37g=;
        b=HTbhzaNqyovbAnQuDvhDg8INCa+ZqREMmYKvP/IP7VZmoIHoXZy9+yTfOKfonIc8K1
         lvYdcgIs6Y4hxtwJ3+zfFeWuoEgmdV8OJva7TSClx+z9y+u7rAMAX1P+PA62gJTihcbn
         DDWniV2DuXQBfhuZHEDcys3J4Kw4MFc0nWUoESe3dK8/S6gqVZo115EJUyjCYcow+/Iq
         Yp1v7weDG0Mfyec3xJW8ZHlOhDf1eE3vX98vvHoouFPb0R47RAY26b7S1sPUFDmM5NZ0
         Ywi+FjkWEv9MTPfQyPAjCqeFX0ZA+ZTDNTKHNRK6EW4tilAx70huWyjwV2CO36weuwCw
         tLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QWLof1O3nhMlU7i5ZCEmG2qQ6v7dulP8/K2lF3I37g=;
        b=mQKc6rAT14DNCdtLHb+uS64BaTpyptJqW8MmPfhCtn1BXK/aGGw280mN5+uwZZU5rc
         AUQPeMPHvkKqn3Qb5AojuHMIGSMTyHgno4/19PP6YuC3ONmKBoQVg/RIoje2+sE2xPuX
         efIoaXtdipH9H9jh7+K7z56U2U6g2sOnydpA+npq39ncy7jN327dKU1uN5s0vZmduTNb
         4NWPBwLF0Nhb+y/qlqdjSBlhN91Uygz1jp+dmcweMMlsFVphVy3iwnDcSJXydu3K2QAp
         wjQHC8om7OU1a91jqG9pGU2WlANoKKfg5Dfxy0fUOXFa3EAbpJ04LJzVicLmylXm3Wka
         gxlA==
X-Gm-Message-State: APjAAAVytLdAazQIjd6/vsj02yGQWbEhthHmbExbS3ml8o5eOl5kWbHQ
        zCyPSiP0zoxwywPYjuVKjubNJw==
X-Google-Smtp-Source: APXvYqx3tHzOXqkGAVmST3DAPob5FWvERg2GNMlAJyDGVUw68lh98g0y9MMruSZQqYSjX2eMZe3jmQ==
X-Received: by 2002:adf:e442:: with SMTP id t2mr1361399wrm.286.1564604994823;
        Wed, 31 Jul 2019 13:29:54 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:54 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 11/13] arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
Date:   Wed, 31 Jul 2019 22:29:27 +0200
Message-Id: <20190731202929.16443-12-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3714099306b7..5b7d6258e9bf 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -857,6 +857,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-- 
2.22.0

