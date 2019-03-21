Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61082190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e7HGjSOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfCURSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:18:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40810 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfCURSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so4631432pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhKCahgOarX4GDkR5QSVNqxMg4FAl0Xz9vcCv1+uBfE=;
        b=e7HGjSOLBUK8HUyErB1b0bO5zYYUaeBbO6f6RAOjLah7VvhMjDfLmiHyJ4QfbOd7RU
         medBnmXeDSOrpZNrgKVJkkGxav6VT+XuCvW4nz/LviRw5PfyuceirS3rVOysvlSKWwnS
         bSQF+KDLNcTkPovjGxVCBDUBtrGEk0qAjhvVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhKCahgOarX4GDkR5QSVNqxMg4FAl0Xz9vcCv1+uBfE=;
        b=TSztFvRV5ygoWeL2OYECuvJAwQg3oC5F7CKqOMGDzODanc5ETb4TzdDagKd+Ztbs+y
         xc5/uMjr40qkhopU2WUjLF1oKPrP96HO0zBj84NVFFTvcRZtfmOvd6VcLPDTPLDAgoQI
         Y/c5uP4tGbi2fpsSL5V+x938PDCLfAAwglSrCx5FmCjaEC/UsT0VfkC1JW+mjwuDLTwL
         LQ63TqQqznbhU4qDFNN4o5avKvGKQeJjdjrLhk1zELBpF3QeZ1RRN0PbZzUWB1xxiazY
         fnszeQnE17LETs4P7Zs76JdOgUHfDhaeNUywWn7r+DrPSeZkfjUjbX1cDHiJgbURwbT7
         inxw==
X-Gm-Message-State: APjAAAXUotRgT552kEfltO3EZ6DqnVuyeXPgSDfM8KOv1IT7FSr2vK0v
        no+cUwYmh+4nv0xU0MiK1U7/Sg==
X-Google-Smtp-Source: APXvYqxX0VrbWoT5JwygmTltad4nA6wGJ5vIDvwYoQBgStrNGIstUPO/lhz1A6BPQ3KO3mtfJ+yb5g==
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr4674500pls.255.1553188702128;
        Thu, 21 Mar 2019 10:18:22 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z6sm20953866pgo.31.2019.03.21.10.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 10:18:21 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 4/8] arm64: dts: sdm845: Add UFS PHY reset
Date:   Thu, 21 Mar 2019 10:17:56 -0700
Message-Id: <20190321171800.104681-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321171800.104681-1-evgreen@chromium.org>
References: <20190321171800.104681-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the reset controller in the Qcom UFS controller for the PHY.
This will be used to toggle PHY reset during initialization of the PHY.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5308f1671824..66c77146585b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1033,6 +1033,7 @@
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			power-domains = <&gcc UFS_PHY_GDSC>;
+			#reset-cells = <1>;
 
 			iommus = <&apps_smmu 0x100 0xf>;
 
@@ -1078,6 +1079,8 @@
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
 			status = "disabled";
 
 			ufs_mem_phy_lanes: lanes@1d87400 {
-- 
2.20.1

