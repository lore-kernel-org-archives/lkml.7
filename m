Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF8C2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qMErbalm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfDONCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:02:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32822 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727373AbfDONCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:02:10 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FCuLsS020737;
        Mon, 15 Apr 2019 15:01:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0D8QaGMp+ho9NyKV21ZELDgWD3YCd5O2OzDEWt68Ytg=;
 b=qMErbalmbFbfa9n7cUpf4omFlj5ADqyA3yPZ2S9XAn3vmi4TWY7+B52IMS9zHnWdEX1w
 Q5Efq6noWY2hUTJz4CirGsXZgjCv837ipMwPFjJ0W+m26OMPk4ULZJ9wxfFow0dzzKvJ
 9FdUrLWvq4UGag7bupi8pjGbAlDvW1gyCziNCDfiOHIsrDNvBRsEZQXRJRhOHFFPp1Pk
 h2SFlFuX5VX+RhUeeFDkcjZDgzfSpVBjbIylsHlOetItiD+Q/VhNrInQQHiE5RUAmg7E
 OPkult4+YVccMJ1T6RbjO/XJ7hPfABB+OGX3POpIkcTur0foKE4jIFaAuLNCADkmu23o xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6ngjmqe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Apr 2019 15:01:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80EB03A;
        Mon, 15 Apr 2019 13:01:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FB862510;
        Mon, 15 Apr 2019 13:01:09 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Apr 2019 15:01:08
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <rdunlap@infradead.org>
CC:     <sfr@canb.auug.org.au>, <benjamin.gaignard@linaro.org>,
        <linux-next@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 2/2] iio: adc: stm32-dfsdm: fix triggered buffer build dependency
Date:   Mon, 15 Apr 2019 15:00:51 +0200
Message-ID: <1555333251-4422-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555333251-4422-1-git-send-email-fabrice.gasnier@st.com>
References: <1555333251-4422-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes build errors seen when CONFIG_STM32_DFSDM_ADC is set, as
stm32-dfsdm-adc driver now also relies on triggered buffer API:

Fixes: 11646e81d775 ("iio: adc: stm32-dfsdm: add support for buffer modes")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b1b2bde..f3bd32e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -823,6 +823,7 @@ config STM32_DFSDM_ADC
 	select REGMAP_MMIO
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Select this option to support ADCSigma delta modulator for
 	  STMicroelectronics STM32 digital filter for sigma delta converter.
-- 
2.7.4

