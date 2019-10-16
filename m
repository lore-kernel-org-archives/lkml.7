Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A72ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7CE2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4D5Ac/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbfJPHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42437 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390610AbfJPHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so14153859pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=03jpeb+1aJx4bxpcdPiavfJJhVJ5WBvL1EOxBoz3J+I=;
        b=X4D5Ac/vX8qbhhnG/SRIM90B0+FmV6AycTSj/JtrullgPcisRI70iJjTkjiIMfyi/H
         QhssR6y42idqaSNfRGO5AVREd9915qBuIXFx5EV+4gIzMHAQr/p1a8REtGA9cfSZKsmI
         PWp5a2RaRyTOA8Ki2AoHQ3/WAxaO3Rg2RGtb1Z1GvMXas458/hA1SSPuRzfojyFyWFL7
         td8pqUQrvLIhjkogvgzcfK4BGdZzYFhJsEFJxSn26/snm4bs1h1urgmrwhLPPNyIxmWz
         ONpJaLJ3eApPbWqGwuOBFv5BOLamb9huJXIkx7cabTmnkVM7sFciLLaBHM7zV6jpwMvN
         g+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=03jpeb+1aJx4bxpcdPiavfJJhVJ5WBvL1EOxBoz3J+I=;
        b=eme3pwQjqelPDVPTixPo4G4iHHiGbj1af9TPYSXuPRKX8Ly6yj24BbZ6zjYvk3U/Bs
         WdDoPzhj9zioH9HgmVI88XeT7HIo/wI4u+VzLwZnb3/iQgc3TI2reAok9Ibd4X3aWmmX
         22SPLa8x0W8WDMZVDRvExz5qseHPGzadDdwyXjiDd1SlWmQJrtGgMzf/lnibrr8IBQs3
         4GrH0Y+MUb0ILVQIxnQP0+LFpyQhoZMWVncRhMQeOfz0Ujo+FtGLfwppps2LX1WnT0gH
         9t6fxskgDd4M5EiNoi/TtpPEUEvlkJpgz2djHthLJr56HkFVlqYS9aNYyCw1OkFWrOpE
         mEag==
X-Gm-Message-State: APjAAAWWqFzNQdPSo4BmgvHpsho/t+ASsWXHA2K2xmVQWf/KOtaOPl0Y
        OAbdCUK81QALsE1Q2R6n8fmjUYOhfa3cYQ==
X-Google-Smtp-Source: APXvYqxLAdFUelj0nGlA72+kn0HnBJlREcJf6ke7gmZg2QchUPKPdi3nc8YGKl4qzUSdSd5kYYWf0Q==
X-Received: by 2002:a63:c748:: with SMTP id v8mr43605412pgg.348.1571211310066;
        Wed, 16 Oct 2019 00:35:10 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id z4sm27413149pfn.45.2019.10.16.00.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:35:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH 13/15] arm64: dts: msm8916: thermal: Add interrupt support
Date:   Wed, 16 Oct 2019 13:04:12 +0530
Message-Id: <88eff964b708c8aff57b24370d2e14389ace09e9.1571210269.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571210269.git.amit.kucheria@linaro.org>
References: <cover.1571210269.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register upper-lower interrupt for the tsens controller.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905c..807f86a4535e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -816,6 +816,8 @@
 			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
 			nvmem-cell-names = "calib", "calib_sel";
 			#qcom,sensors = <5>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

