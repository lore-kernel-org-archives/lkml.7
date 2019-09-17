Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC12C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF22067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hs8Q69x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfIQMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:39:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:20734 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbfIQMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:39:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8HCVred000451;
        Tue, 17 Sep 2019 14:38:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=cOyzcoGBpVBGscxdizJshAfCpisInpaxvUv0kh4n7UA=;
 b=hs8Q69x5uVUWDQzS2+p3YDWMe3MHcsv37AZeQ3/0xoguP34cw7Za/Do82lGa69wlPong
 X8Spmagds8nN6KBS31/XpP1tvHJK6x+gGpB3fOtQw20MFfwiJloVOZrxG5ykp4NoOfS8
 /le8tsuXyZhJXCptBSWxeYMui10Wgpufzu9EtEdqlXDLFrxGt9Gyi0GrgqVisvDIxsOS
 jtm71AHG6V1jp3snHSjYWxyg19leJI/8yKsbnPNBIifPWYmNdwYMOfQGdbMQA9gQmAs4
 RoD5bv5Rqg0HESvBG5rafAEhSb35U+wgxG6Y4Y0VkB5xcIUNb+hAiEmVpbrGITiJ+smP lA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v0nb9hpgw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Sep 2019 14:38:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5491C23;
        Tue, 17 Sep 2019 12:38:34 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1C7C2BDA7E;
        Tue, 17 Sep 2019 14:38:33 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep
 2019 14:38:33 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep 2019 14:38:33 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/2] iio: stm32-adc: fix a race with dma and irq
Date:   Tue, 17 Sep 2019 14:38:14 +0200
Message-ID: <1568723896-19063-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-17_06:2019-09-17,2019-09-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a race condition observed when using several ADCs with DMA
and irq.
There's a precusor patch to the fix. It keeps registers definitions as a whole
block, to ease readability and allow simple (readl) access path to EOC bits in
stm32-adc-core driver.

---
Changes in v2:
- Add a precursor patch to follow Jonathan's comment on readability

Fabrice Gasnier (2):
  iio: adc: stm32-adc: move registers definitions
  iio: adc: stm32-adc: fix a race when using several adcs with dma and
    irq

 drivers/iio/adc/stm32-adc-core.c |  70 +++++++++++---------
 drivers/iio/adc/stm32-adc-core.h | 137 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32-adc.c      | 109 -------------------------------
 3 files changed, 177 insertions(+), 139 deletions(-)

-- 
2.7.4

