Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6A4C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B50420882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlPyZQe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDDIQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43776 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfDDIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id m10so767125plt.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8TATOwz6aXOPqLspdWK5FSdnAdwr3+Rn9JXDFFJJK1Y=;
        b=qlPyZQe2k4wk6pI34bnrMhkkRZAsgZ//8T3OV8/7UGiCthavaNdAmsoxLLn2DhBr0J
         fFRYvVVtuDiTHfbzsL3QBWEb9Px27LuXrIIqqVuLLZQfKMBbufQlcVgpCdul0L+J6JRM
         HO916R/L1nLQsrVJU62l1qjr8cqIMu2lSQCgdCQHjUjTze7L4U0nqvO9FmZxsGL/9SdG
         p+OgKbZt37sijCUVLZ9yiI5i9FB+JrejOB3rnrFEwzFQTB4oA9vEudF972/4tsD+IzM1
         HXieFxpvBsb3vwJFlWTgwHSXgJ2wLEbPr29UxX8+7x2xooPga9J77H5rNx3pxRZX7RQL
         t9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8TATOwz6aXOPqLspdWK5FSdnAdwr3+Rn9JXDFFJJK1Y=;
        b=Jpn7NqcSqpm+sFHT8tyne4Tjs0D3Cn0qUvD9URERIzopmNxNP6m+mdClxKOpGr3Set
         jIz/aoRYpslRp+Q4rT/COpbrI+wpSo/fNqpReN3dgcgsU4/ClB5M9T1gzWkrVDJrOvbG
         YdVX0NmB3UQQB75v68DNMazqqPnkX3T/E1Z9Q638MrLOzrYbyRhDCVz68386ZTKqkNQ7
         92pz/CT24LNyNY7Z8GMTptKcOQiYSwoblF7Wyu2Es+PGZNdbn77HmaQjhInn1x1DkLOY
         E8wZPNnmqEbcEVBXMBPRq62pR90BhtqJ40Z4IFYfQOvkv67xEcj+lOD5M6mCitqxJZ3g
         sU1Q==
X-Gm-Message-State: APjAAAXfcdX86T3Mmcy/z1rGBISZ6LuhAGOqs8ABWFCMhHGe9gu/wUbl
        vepM2LM34MEzUYu1bcEFvmlLs4j4QqE=
X-Google-Smtp-Source: APXvYqye00pzihCc2KsJ33XnWNuJwdLWM74dx5TRNOni3qA70wB7lHM099I81RCMo2nW6Ego8xb4+Q==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr5040322pls.82.1554365801186;
        Thu, 04 Apr 2019 01:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id d129sm26041389pfa.142.2019.04.04.01.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 01:16:39 -0700 (PDT)
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
Subject: [RESEND][PATCH 2/3] arm64: dts: hi3660: Add hisi asp dma device
Date:   Thu,  4 Apr 2019 01:16:27 -0700
Message-Id: <1554365788-25610-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
References: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
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
index 37a997a..7f92049 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -573,6 +573,16 @@
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

