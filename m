Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82192C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F264218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1pCWZkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfCTUZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:25:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42967 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfCTUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:25:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so2596811pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L+i8r+Ov28fU+nFY1Y6bbaTmlcsDjinSwAthT9sIfbw=;
        b=N1pCWZkqdRt+/zwSfF3Dozr1kvZuge0KCJt6rJoqj9fLsA2OgLL65Frvr4kvOapgF/
         6T8hBFtIpLMg5Qe8qdT1epc4e0qLxUwC4UMOcAXRLaSyLL3+92ti1dYbEcBaHlcZL3+o
         e92MZvxHU4n2xpc6tJdlmrul4XV28QtaHwFxusx4KhgrBTvpcjDGe6zW4LtCASA0DNvl
         PasCllZ/UCms+h2JTsHMKNZ2wTUiN6KUZ3Ngq5wWsBV8aGxNFabfLiCZaL5egr9auIGS
         x8DVDIFZH5Vd/faf4Hh9BhbzNFwzBg9qDGtjkpXyBknj6icugwAktcHcrUyJXifTP0F7
         MumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L+i8r+Ov28fU+nFY1Y6bbaTmlcsDjinSwAthT9sIfbw=;
        b=PrSw6Jpd9ijFdTB9iMPIMdSJQ54ZaKEu2sDMISOcPFuK8vrfq/AQEn5NrJEmJo6md2
         KbUGZ9ZR37LueFxJMhSvye86Db1q3vGRiwviwkdc6Gy4/rqp4trMs2JqYNlTPxE1BhTe
         jinnhV4ZTMME5fnvsKqZGyJrRJD2YC0J/E8FmlUaL40PW3Ucb4+ypdCHQluM4I41QSU5
         FFXNzM+56wHKZRmNThP32+kW6Jq1Bew5LeN5sqQguD2BJI4cV3A8i5XyizOOCSkJaMvK
         1NiC7sX1y9SjXNt+4CXHGo1YVRBVkkIx1e6jQzYAcEFC+gBQ6qAyGTzyHrFGBHDbBYOe
         uymA==
X-Gm-Message-State: APjAAAXkm8pu0WDFUvUEzHsXM72GUTE+8zXeOwIM9yD364R9sV7AxbeT
        yr97PS+deR+XZlzPmJGLK6lXNSExe5o=
X-Google-Smtp-Source: APXvYqxG9PgqnD0R2mBm3PGLhzwpCZvemlb/tuMsdUsM+3lQrsRZeEffCSmU6L1EAQxKw6KKx63hrw==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr10336596plq.262.1553113548417;
        Wed, 20 Mar 2019 13:25:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u187sm866338pfu.113.2019.03.20.13.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 13:25:47 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/3] arm64: dts: hi3660: Add hisi asp dma device
Date:   Wed, 20 Mar 2019 13:25:39 -0700
Message-Id: <1553113540-28726-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
References: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Add asp-dma device to hi3660 dts

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Removed undocumented bindings
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index a3eeab1..fb5498d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -567,6 +567,16 @@
 			dma-type = "hi3660_dma";
 		};
 
+		asp_dmac: dma-controller@e804b000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "asp_dma_irq";
+		};
+
 		rtc0: rtc@fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x0 0Xfff04000 0x0 0x1000>;
-- 
2.7.4

