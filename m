Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5C8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74B2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfCUQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:48:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52975 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728602AbfCUQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:48:08 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LGkp20007997;
        Thu, 21 Mar 2019 17:47:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r8rwkek1h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Mar 2019 17:47:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBBC734;
        Thu, 21 Mar 2019 16:47:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A1FC75670;
        Thu, 21 Mar 2019 16:47:36 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Mar 2019 17:47:36
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH v2 1/8] iio: adc: stm32-dfsdm: make spi_master_freq more accurate
Date:   Thu, 21 Mar 2019 17:47:22 +0100
Message-ID: <1553186849-6261-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current ckout divider may be set to a value that makes ckout to exceed
spi-max-frequency. Rather use lower value (e.g. round up divider when
ckout isn't accurate).

Also when the SPI clock isn't accurate, 'spi_master_freq' is filled in
with expected frequency. Use computed value instead to be more accurate:
- e.g. source clock / (CKOUTDIV + 1)

Enforce checks on the divider: ckoutdiv range can be from 1-255 to provide
divider of 2-256.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- rework the way to determine ckoutdiv bitfield: deal with divider directly
  to explicitly handle the rounding, the range constraints of 2-256 and the
  divider = ckoutdiv + 1.
---
 drivers/iio/adc/stm32-dfsdm-core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index bf089f5..472b809 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -199,7 +199,7 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct resource *res;
-	unsigned long clk_freq;
+	unsigned long clk_freq, divider;
 	unsigned int spi_freq, rem;
 	int ret;
 
@@ -243,13 +243,20 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 		return 0;
 	}
 
-	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
-	if (!priv->spi_clk_out_div) {
-		/* spi_clk_out_div == 0 means ckout is OFF */
+	divider = div_u64_rem(clk_freq, spi_freq, &rem);
+	/* Round up divider when ckout isn't precise, not to exceed spi_freq */
+	if (rem)
+		divider++;
+
+	/* programmable divider is in range of [2:256] */
+	if (divider < 2 || divider > 256) {
 		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
 		return -EINVAL;
 	}
-	priv->dfsdm.spi_master_freq = spi_freq;
+
+	/* SPI clock output divider is: divider = CKOUTDIV + 1 */
+	priv->spi_clk_out_div = divider - 1;
+	priv->dfsdm.spi_master_freq = clk_freq / (priv->spi_clk_out_div + 1);
 
 	if (rem) {
 		dev_warn(&pdev->dev, "SPI clock not accurate\n");
-- 
2.7.4

