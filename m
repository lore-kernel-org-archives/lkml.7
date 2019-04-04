Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D4C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AB12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhYzhED6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDDIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46882 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so763281pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhgbgRH9XeCw4nvk0p0Dwx+VqDYiBCuQQlEnM4jc05A=;
        b=YhYzhED6uUTkU6u5uXoQT6MfOcOxtdeQW9GLsDdBais6mrTPxgTYFn94nawBmaXxFe
         Obxq1eTY3pi9dhxkYIKp3l9cyNO67By+aX/RWbQhVCEICXxgkpIIQn++sgtmdJSWt0Vj
         rvqg7QWjdM39RPu7y509kp1x7rhTNemBT0lzNYneeHW9uehGluK4Ulv2BhxuVjdUpbTW
         EKg2i2H+2rK8Sfw4Qa6fxaLX9dhniwmwi+byPmBz+96asrdCfLEa/S86uhy5Sq0tLNra
         1NViXS+tdOM52X8KHf9IPY1egsj/8l1b2xe1Q/rmiZsyiKyLUbCLg4cO6qMRRUr3+emw
         Stog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KhgbgRH9XeCw4nvk0p0Dwx+VqDYiBCuQQlEnM4jc05A=;
        b=E1/VbfiAs4zRK+Dkehv1Ml/iV2JsHkFJwvr+RzHKxKVlPo0j1XuxQOpLklF07w+HzE
         zgAzqdpv8bkCVrBYBn3jYDDnunxxPIQ6ctF0Ptv52pDV9eL0YeR9KwvfKMaUfrhmmYYL
         YRvDNAWcTvWNSDoaea2xf2kLCgmrMxMDw06OUG+zTTAAKPvxSnPo6WoPLdWJoFaH3hsz
         zn6cio3mdx3PCBMPKMUseOILiugYe8t979LYt7Rd31XE/NmYIuWozP5OfvFVu5ymPq40
         /4DeZu5F+GUneZUe/L9GbkpIFFxBZWPzFyhBRdMAXL/o+qXf5Lc7PXUBUi1x2FTMaHtw
         6qkA==
X-Gm-Message-State: APjAAAXqNtMW3qAXyZ3ZWutMRT4GYXCrZiDC/mK/65IY1Ethi2+Y2fl8
        HLuqLZIIt1AvwfVCE2003HpNJJAmQdI=
X-Google-Smtp-Source: APXvYqwwZPtQ7nXCXE18CoJJUaXicMvExbJma7NjlfgZEKKuCiHkylHkUZOtjkoNXxhyRop2fE116w==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr4868134plb.233.1554365802824;
        Thu, 04 Apr 2019 01:16:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id d129sm26041389pfa.142.2019.04.04.01.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 01:16:41 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RESEND][PATCH 3/3] arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask
Date:   Thu,  4 Apr 2019 01:16:28 -0700
Message-Id: <1554365788-25610-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
References: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A undocumented and unimplemented binding got into the hi3660
dtsi, and this switches that binding to the now documented one.

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
v4: Renamed to dma-channel-mask
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 7f92049..7a49aa9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -566,7 +566,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			dma-channel-mask = <0xfffe>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.7.4

