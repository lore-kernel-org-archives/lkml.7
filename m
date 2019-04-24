Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951EAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629AD218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1LRsLPpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfDXMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:52:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729107AbfDXMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:52:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OCfGXP016096;
        Wed, 24 Apr 2019 14:51:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ctm+W81ZWox/COgWpf+FCLXq5fOtwKtzTtyPOJXJ5IQ=;
 b=1LRsLPpm3ncNy5btDO6Aut0vHyE4Io1S73hgxZ5PhprbdDiPzJmXWTbjdZa3aJ10kDFs
 8z7/BQyABgKaiV5lHkPe+C3kkSSBDEzL7jbZJ5PKx/cFmT8t5zd8k0QKflj4xjgra24k
 vqproO0SgVCZ6cRWtGA+Vd47LIlh+d2EakDmhuis4jfIksvq1vu70w/YS8JIs7GYVX09
 ZnV4SC2fhBOCjgmkdGrSOakyuSqrYr1Hyeisxwo0fMLLIZitgtccwq9TdvzxSFUmbc0X
 lDa3Dax26Bwa8UdvIb0zwO8EuMMVHHqfHZLikb0XyVUywieGpKP4et8+fhWNruMGkbGU Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad6khw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 14:51:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8CCB3A;
        Wed, 24 Apr 2019 12:51:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7AA1125C5;
        Wed, 24 Apr 2019 12:51:38 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 14:51:38 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 14:51:38
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH 2/2] iio: adc: stm32-dfsdm: missing error case during probe
Date:   Wed, 24 Apr 2019 14:51:26 +0200
Message-ID: <1556110286-1526-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
References: <1556110286-1526-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, check the devm_ioremap_resource() error value.
Also return the devm_clk_get() error value instead of -EINVAL.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 0a4d374..26e2011 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -233,6 +233,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	}
 	priv->dfsdm.phys_base = res->start;
 	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->dfsdm.base))
+		return PTR_ERR(priv->dfsdm.base);
 
 	/*
 	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
@@ -242,8 +244,10 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
 	 */
 	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
-		return -EINVAL;
+		ret = PTR_ERR(priv->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
+		return ret;
 	}
 
 	priv->aclk = devm_clk_get(&pdev->dev, "audio");
-- 
2.7.4

