Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB375C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA07E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258128;
	bh=GEzVkmtQcm34vN5nXXEpUAE8jZFGhIhzKkeXmb8d8w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O9F9HMbNkS+svwaEzHORHRubSHAzQDdVjssyBL3gF6UIPE1TBlBPLupKloi8pcHAB
	 XnyjhfibvXVNmcHlmDk9afHfbaweWJQRgnEm1wPtwW58cQBjCk8J5PtSQJki7dklmk
	 aKTWdUt4KO4OGDG5QmaVv/YUQfXPqplEsWBuwoww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbfCVMf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388887AbfCVMMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:12:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8812082C;
        Fri, 22 Mar 2019 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256743;
        bh=GEzVkmtQcm34vN5nXXEpUAE8jZFGhIhzKkeXmb8d8w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5mmowx2gjkDLpmFJwKJESfC2i2vB9/AX90J1z1Hxq/zOFHm4a2/5j+K58oNIzMex
         fPEfFHJTcF/tq1lb18h7xWUBIYQE+oNFXacXQ88eBPk1ob8lvsF2yyr5gvDD0ScDPF
         DnNndkRXctdYEF5DfUQFjY1037F67zJCTiYjNmnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.0 007/238] iio: adc: exynos-adc: Use proper number of channels for Exynos4x12
Date:   Fri, 22 Mar 2019 12:13:46 +0100
Message-Id: <20190322111258.728510789@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 103cda6a3b8d2c10d5f8cd7abad118e9db8f4776 upstream.

Exynos4212 and Exynos4412 have only four ADC channels so using
"samsung,exynos-adc-v1" compatible (for eight channels ADCv1) on them is
wrong.  Add a new compatible for Exynos4x12.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt |    4 +-
 drivers/iio/adc/exynos_adc.c                                     |   17 ++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
@@ -11,11 +11,13 @@ New driver handles the following
 
 Required properties:
 - compatible:		Must be "samsung,exynos-adc-v1"
-				for exynos4412/5250 controllers.
+				for Exynos5250 controllers.
 			Must be "samsung,exynos-adc-v2" for
 				future controllers.
 			Must be "samsung,exynos3250-adc" for
 				controllers compatible with ADC of Exynos3250.
+			Must be "samsung,exynos4212-adc" for
+				controllers compatible with ADC of Exynos4212 and Exynos4412.
 			Must be "samsung,exynos7-adc" for
 				the ADC in Exynos7 and compatibles
 			Must be "samsung,s3c2410-adc" for
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -115,6 +115,7 @@
 #define MAX_ADC_V2_CHANNELS		10
 #define MAX_ADC_V1_CHANNELS		8
 #define MAX_EXYNOS3250_ADC_CHANNELS	2
+#define MAX_EXYNOS4212_ADC_CHANNELS	4
 #define MAX_S5PV210_ADC_CHANNELS	10
 
 /* Bit definitions common for ADC_V1 and ADC_V2 */
@@ -271,6 +272,19 @@ static void exynos_adc_v1_start_conv(str
 	writel(con1 | ADC_CON_EN_START, ADC_V1_CON(info->regs));
 }
 
+/* Exynos4212 and 4412 is like ADCv1 but with four channels only */
+static const struct exynos_adc_data exynos4212_adc_data = {
+	.num_channels	= MAX_EXYNOS4212_ADC_CHANNELS,
+	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
+	.needs_adc_phy	= true,
+	.phy_offset	= EXYNOS_ADCV1_PHY_OFFSET,
+
+	.init_hw	= exynos_adc_v1_init_hw,
+	.exit_hw	= exynos_adc_v1_exit_hw,
+	.clear_irq	= exynos_adc_v1_clear_irq,
+	.start_conv	= exynos_adc_v1_start_conv,
+};
+
 static const struct exynos_adc_data exynos_adc_v1_data = {
 	.num_channels	= MAX_ADC_V1_CHANNELS,
 	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
@@ -493,6 +507,9 @@ static const struct of_device_id exynos_
 		.compatible = "samsung,s5pv210-adc",
 		.data = &exynos_adc_s5pv210_data,
 	}, {
+		.compatible = "samsung,exynos4212-adc",
+		.data = &exynos4212_adc_data,
+	}, {
 		.compatible = "samsung,exynos-adc-v1",
 		.data = &exynos_adc_v1_data,
 	}, {


