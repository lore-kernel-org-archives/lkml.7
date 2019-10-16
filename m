Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EEC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401A520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gc/KMCmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbfJPHfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41495 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390374AbfJPHfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so14144257pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=K+JloZswXmm4BpvcNOHfxY9LNAmaq3HM2wD0uVSFvPc=;
        b=gc/KMCmIeHHhA5CTiQuXhuXCGs8zdCkC0+uXOGsRaewyOVs3PwC8r5E2WjzwjXxZnR
         iFmRDhGszAMo5AnU1BhzDVdlXBedkCtZUjiZzJhGWuXWgjIhBT5Q4145dmaZpuDPs7pX
         6rx3SuzudupipdVWV2LQeuuFOi7vO+/PhqV0cCfB9O6vkt3I5D+i60vv8JGSRqpZWemb
         dVWEMwyqWldf4vE/7AvgMpTzZPro4CMXdq42i7ZYfKSyx7tYT/a6Ef0uulvNv020OAPD
         jKd7sqRbpLTGIlgm8auFOmqUDk+eBROQvmyH/xW5XBX1Wt1GtEpVvfkLPuZvadrcKz6T
         e0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=K+JloZswXmm4BpvcNOHfxY9LNAmaq3HM2wD0uVSFvPc=;
        b=iysdiFkGMV+BISt6xLa0Aw8ZYlzOtZHJCWsFTx3L22DgzDZ4uJQRsUCjRcBcSGJqOB
         avDaP92gsWWKO1sVf6x/ssWXkaMI2ZXcPkZeUE2auPSmv6qqxtIrTMHLKGtkoq7eUfuh
         YYni3UxGE8NOSE3l/LgVFSxhbj+4AHOL1m37vSDocQRSAOfn5hBuhQj5b3mu4UZN+/zO
         GJjYNXlVeZMqIyznZlovK4BrM2Ac3sKmMSrqcD0tTwJu+zOyWmIcVsImfqJUgtrIeJmI
         mMg40UupubHuDLvCCZXoXtq9CSGNezBsV64dVGx4q3v+08W2ifCa7aQT7e7Df4NYc1G3
         ouPA==
X-Gm-Message-State: APjAAAW6rT9lkRtfsHcsw4GeJqfKLfIk61nCI5DaWC1tvWtb1whM1JdR
        pue4cd7WVNg5fUNODEga+ZMe/qxNlmlfDA==
X-Google-Smtp-Source: APXvYqyM69gXN9ucY0u0Z331l43PMGaxd5Nz0wHcYtRF/zyAnePozLUY3rayNt3oewSq4CFpEwzWrg==
X-Received: by 2002:a65:5586:: with SMTP id j6mr614871pgs.252.1571211306505;
        Wed, 16 Oct 2019 00:35:06 -0700 (PDT)
Received: from localhost ([49.248.175.127])
        by smtp.gmail.com with ESMTPSA id c4sm4194968pgd.3.2019.10.16.00.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 00:35:05 -0700 (PDT)
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
Subject: [PATCH 12/15] arm: dts: msm8974: thermal: Add interrupt support
Date:   Wed, 16 Oct 2019 13:04:11 +0530
Message-Id: <a2a70ff28e72a14b163a9a9b93ef474ab0836398.1571210269.git.amit.kucheria@linaro.org>
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
Tested-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 33c534370fd5..c1a3a7d7161c 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -531,6 +531,8 @@
 			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
 			nvmem-cell-names = "calib", "calib_backup";
 			#qcom,sensors = <11>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

