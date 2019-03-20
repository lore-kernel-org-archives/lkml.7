Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4226C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63B9218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvoZbYfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCTU0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:26:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45087 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfCTUZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:25:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so2588522pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuSiKoPWJiqg1hj1t8kPtVcU/YwHIsgZLXBJh+g7glI=;
        b=dvoZbYfdHCSu3bqwnHUvI4PQz1/AgCXtQ+RvuNo3d8mGJGLO92JpGmcdoU8hEeJD0r
         2oSalPEVqq5dLmZrMFBNpcgGQPh7sFTREDlpRNE/O6VGtplkZjEjy+NDBKTWykOYXGdI
         AuVMCZ0XjSHOCN91QBRcAEdLBJRorxrwzw5YQCrWer9ai5/CANwknd7fR9VodeotK4Z+
         cjw/s99pbPHIZyIQNisBs+lWkM9XBSbv0xQk/nn/NlYABvrl6gkb6f8TTufeOKJqYcBv
         3LhCzNMTLH4EGwxIIUvHdS4KBa+jLIo1xlcafL8GIM4OcR9ocyXjP4R2F25RboGMeTBT
         uURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuSiKoPWJiqg1hj1t8kPtVcU/YwHIsgZLXBJh+g7glI=;
        b=KwbXAGkFlVlSxIVtS3niANwIGFosUgh1rf9W2bW8Y2sm89Sn5FQT1ed9/jGIuips1i
         bE4IUv8FAv6EO+m/PvnbIxa4ezyg8bZicVBimIEcFvtMBFM1b9KWXeo91+1vJJicP4tL
         jS4YJfEi3sQLsqf8tPPs9xmPpdr37pUjgTo2xPPlfa9uI/ZqDVVPkwtTokaCvojjZCz1
         aq8ihqOniAaGeujbxmBvSrb2cubA7mXmXGhlaTjNQ5Mw3duSA6YfHBNa/yJ7/ZuFKGAI
         MhWuTxO8Y5SLUnw3PdwW6KJMOnaibQZ5A8NUjJXusrkSrBOm6N5XCd+o/3YmHl1jaLUT
         TEHA==
X-Gm-Message-State: APjAAAXh7wss6d1P5CjgmKg4wQdFyoRljC9undK9S9gdeCKv2sCX4F4v
        0P9sEhRGdsjiIrIr53MrKPqXt+xxvPU=
X-Google-Smtp-Source: APXvYqzwQ6RZFvdYwgHTYaQHBtoqC2EKxmLBefxD53Cv05EQPzqEcun6sRJErq/a41B9TQw4wbBc7Q==
X-Received: by 2002:aa7:8117:: with SMTP id b23mr10275844pfi.2.1553113549912;
        Wed, 20 Mar 2019 13:25:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u187sm866338pfu.113.2019.03.20.13.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 13:25:49 -0700 (PDT)
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
Subject: [PATCH 3/3] arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask
Date:   Wed, 20 Mar 2019 13:25:40 -0700
Message-Id: <1553113540-28726-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
References: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
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
index fb5498d..aa6a8ad 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -560,7 +560,7 @@
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

