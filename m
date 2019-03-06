Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93EF206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfCFI4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:56:24 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58413 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729562AbfCFI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:56:22 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x268p4eU001192;
        Wed, 6 Mar 2019 09:55:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r0ju8yewp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:55:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 585C342;
        Wed,  6 Mar 2019 08:55:48 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0EE9423F7;
        Wed,  6 Mar 2019 08:55:48 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar 2019 09:55:47
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 1/8] iio: adc: stm32-dfsdm: make spi_master_freq more accurate
Date:   Wed, 6 Mar 2019 09:55:17 +0100
Message-ID: <1551862524-25098-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SPI clock isn't accurate, 'spi_master_freq' is filled in with
expected frequency. Use computed value instead:
- e.g. source clock / (CKOUTDIV + 1)
Also, current divider may be set to value that makes CKOUT to exceed
spi-max-frequency. Rather use lower value (e.g. round up divider when
ckout isn't accurate).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index bf089f5..65b7556 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -243,13 +243,18 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 		return 0;
 	}
 
-	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
+	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem);
+
+	/* round up divider when clkout isn't accurate (e.g. !rem) */
+	if (priv->spi_clk_out_div && !rem)
+		priv->spi_clk_out_div--;
+
 	if (!priv->spi_clk_out_div) {
 		/* spi_clk_out_div == 0 means ckout is OFF */
 		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
 		return -EINVAL;
 	}
-	priv->dfsdm.spi_master_freq = spi_freq;
+	priv->dfsdm.spi_master_freq = clk_freq / (priv->spi_clk_out_div + 1);
 
 	if (rem) {
 		dev_warn(&pdev->dev, "SPI clock not accurate\n");
-- 
2.7.4

