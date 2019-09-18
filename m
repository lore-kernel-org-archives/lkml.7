Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AD4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F6218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="I1Zy9RDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfIRJdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:33:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50884 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfIRJdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:33:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8I9LiLC012659;
        Wed, 18 Sep 2019 11:33:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=w2DW76qUSewnb1/9cIUq9BbK5Drmqq+tMdxCCn/J9V8=;
 b=I1Zy9RDpW/qOpImzeliSW2ZhFKIYE8lxtzo/CF1AWxe4+MUxtIhUp3wyGNcWHCcEuJIv
 9aJCw9kB3R88uCEbYslFaKO/y7xUYyFSggCKFamcvKDhSiTijdJ249Pbb+pBRxumeHgc
 3htuC9vMVKdNB9dMsXDwjm7qFub3LaFR2E8c4hlb4ng4ojoTKCCXb2CK2Buva2JntihK
 yaO6OEPgYskuDPWU8YSTw4G81dYeer/pCoJNwFSqWjJ4XU2GFRa/jG/3y9jhYDtq/cA2
 3dMHqy6mART+qbblqv5hqPxboPsTrna8U0+k49PX5fBvBfX8JOdeD3701d8x79NWS2xn Cg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v37kh39fw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Sep 2019 11:33:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2783951;
        Wed, 18 Sep 2019 09:33:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D249C2B06B4;
        Wed, 18 Sep 2019 11:33:09 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Sep
 2019 11:33:09 +0200
Subject: Re: [PATCH V6 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190905122112.29672-1-ludovic.Barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <940e3ce8-1a4f-7e03-dfec-25330051ea5f@st.com>
Date:   Wed, 18 Sep 2019 11:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190905122112.29672-1-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_06:2019-09-17,2019-09-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

Just a "gentleman ping" about this series and
https://lkml.org/lkml/2019/9/4/747

Regards
Ludo

Le 9/5/19 à 2:21 PM, Ludovic Barre a écrit :
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -On sdmmc the data timer is started on data transfert
> and busy state, so we must add hardware busy timeout support.
> -Add busy_complete callback at mmci_host_ops to allow to define
> a specific busy completion by variant.
> -Add sdmmc busy_complete callback.
> 
> V6:
> -mmci_start_command: set datatimer only on rsp_busy flag
> (remove host->mrq->data).
> -move max_busy_timeout in set_ios callback.
> -typo fix: err_msk, clks on one lines.
> 
> V5:
> -Replaces !cmd->data to !host->mrq->data to avoid overwrite
>   of datatimer register by the first command (cmd23, without data) of
>   SBC request.
> 
> V4:
> -Re-work with busy_complete callback
> -In series, move "mmc: mmci: add hardware busy timeout feature" in
> first to simplify busy_complete prototype with err_msk parameter.
> 
> V3:
> -rebase on latest mmc next
> -replace re-read by status parameter.
> 
> V2:
> -mmci_cmd_irq cleanup in separate patch.
> -simplify the busy_detect_flag exclude
> -replace sdmmc specific comment in
> "mmc: mmci: avoid fake busy polling in mmci_irq"
> to focus on common behavior
> 
> Ludovic Barre (3):
>    mmc: mmci: add hardware busy timeout feature
>    mmc: mmci: add busy_complete callback
>    mmc: mmci: sdmmc: add busy_complete callback
> 
>   drivers/mmc/host/mmci.c             | 183 +++++++++++++++++-----------
>   drivers/mmc/host/mmci.h             |   7 +-
>   drivers/mmc/host/mmci_stm32_sdmmc.c |  38 ++++++
>   3 files changed, 156 insertions(+), 72 deletions(-)
> 
