Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC74C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760B320675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfCFI40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:56:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56130 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729352AbfCFI4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:56:21 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x268q6XK022884;
        Wed, 6 Mar 2019 09:55:49 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkn6rck-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Mar 2019 09:55:49 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7EFC31;
        Wed,  6 Mar 2019 08:55:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4000C240E;
        Wed,  6 Mar 2019 08:55:47 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Mar 2019 09:55:46
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: [PATCH 0/8] iio: adc: stm32-dfsdm: add buffer modes
Date:   Wed, 6 Mar 2019 09:55:16 +0100
Message-ID: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for buffer modes, scan mode and triggers
in STM32 DFSDM ADC driver:
- 1st patch is an improvement
- Patch 2 to 5 are basically precursor patchs that reworks the way to
  configure the dfsdm for the audio part, so it can be common with the
  iio part.
- Last patchs add support for triggered buffer mode (with scan mode and
  hardware triggers)

Fabrice Gasnier (8):
  iio: adc: stm32-dfsdm: make spi_master_freq more accurate
  iio: adc: stm32-dfsdm: continuous mode depends on current mode
  iio: adc: stm32-dfsdm: move dma enable from start_conv() to
    start_dma()
  iio: adc: stm32-dfsdm: move dma slave config to start routine
  iio: adc: stm32-dfsdm: enable hw consumer
  iio: adc: stm32-dfsdm: add support for scan mode
  iio: adc: stm32-dfsdm: add support for buffer modes
  iio: adc: stm32-dfsdm: claim direct mode for raw read and settings

 drivers/iio/adc/stm32-dfsdm-adc.c  | 513 +++++++++++++++++++++++++++++--------
 drivers/iio/adc/stm32-dfsdm-core.c |   9 +-
 2 files changed, 408 insertions(+), 114 deletions(-)

-- 
2.7.4

