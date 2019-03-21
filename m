Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAB621900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIHNMaC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfCURS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:18:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36716 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfCURSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id r124so4649932pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDhjjnKzvciBPxRXKZr8yRdui7H/ilutHNcJeHVcKgI=;
        b=fIHNMaC8pGvkwOaoBEGA2ai2qQa3B9rXlzrmbPcvcpiuyiJjYWjemS5GcbLDv4kIqX
         UC7ufYVo9qSSo1rESa7Gg3z2tUnDljs56HM5euZnZlig49IY7IOvK73Vuc5ogRqXjcz7
         rdAELindMhvI4k1AgS1DWppXriQeoMX8oAPNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDhjjnKzvciBPxRXKZr8yRdui7H/ilutHNcJeHVcKgI=;
        b=Nuf3j7ZsA2I5Pge07ZxhF1IRp1lbU8w0mmbAmM14x7wK4nNp10rcnwpS9IHwnWJzMg
         0nkYLZe9S3Y4ZGnk1erJYT/sGQEtn0FqKSrZNVMuXyADCJ37GuVca3V05vM0VuP85dUw
         kjKKsc9tyzsuqZ5W44OUNh7uryfh3UWh881fik/JE9KvOVATNSbYcFm6kJGeciiwQ8Yl
         fseRAwjPzy4R4gC4RwGg2zplSHm1scFCqhUAsgEgEFBikhB7dY90aby1g74GwEYJU2tk
         457TOiobBA+L9pxVIY253IXuh7962RTU1FyepsbsDNFE9m9qW13KqG1cXYLewh2UUYgN
         losQ==
X-Gm-Message-State: APjAAAVn5wLP1XyM4RO6esLtRU9BREaaWIQ3YeTnfklBhH3jsoghFG6x
        iT5Byb9SeqtpX01WUdz111KBwHMG4W9OQw==
X-Google-Smtp-Source: APXvYqwxhb6mZUoUO6R5/Lgjj1/wAv5hsGMB9kb1bL6lyz6TPrbafGmDcA0Sv9EbmeykDlW7rzfRpw==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr4540987plb.272.1553188704349;
        Thu, 21 Mar 2019 10:18:24 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z6sm20953866pgo.31.2019.03.21.10.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 10:18:23 -0700 (PDT)
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
Subject: [PATCH v5 5/8] arm64: dts: msm8996: Add UFS PHY reset controller
Date:   Thu, 21 Mar 2019 10:17:57 -0700
Message-Id: <20190321171800.104681-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321171800.104681-1-evgreen@chromium.org>
References: <20190321171800.104681-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset controller for the UFS controller, and wire it up
so that the UFS PHY can initialize itself without relying on
implicit sequencing between the two drivers.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c761269caf80..5683b727283e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -697,10 +697,11 @@
 			clock-names = "ref_clk_src", "ref_clk";
 			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
 				 <&gcc GCC_UFS_CLKREF_CLK>;
+			resets = <&ufshc 0>;
 			status = "disabled";
 		};
 
-		ufshc@624000 {
+		ufshc: ufshc@624000 {
 			compatible = "qcom,ufshc";
 			reg = <0x624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
@@ -756,6 +757,7 @@
 				<0 0>;
 
 			lanes-per-direction = <1>;
+			#reset-cells = <1>;
 			status = "disabled";
 
 			ufs_variant {
-- 
2.20.1

