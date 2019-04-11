Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B7BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165942133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sccOXgHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:37:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfDKMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:37:33 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BCaUBF005702;
        Thu, 11 Apr 2019 14:37:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=3u8EWgmvcGT1sUl/NEX/bjk452i79ERDljwHwv7Qnd0=;
 b=sccOXgHdgNG00iQnyoCKAmMXhrYh9nEgqyWjzqLEsEF7vpdeaqivMuFy//MGSZk4VWDD
 hJbAoe4HAxD5YjG0QP4/Y0PgkqYt5QiIXVbRDOkNgAKt9v1cppynrAYuA/qUh+LIzhV1
 yNUjd8WXsIyO4TXeCZto+Pm2QDu7Sxgfyq+JFociGhxfRH3ScbSvGhV1ggwcqTA/ejUr
 +NUJe91PGZqA/IKBTkrLGx/xyamP/GB+DaXntW/dCwNGaQr742fdu5XuuKTNJRhpm07Q
 ptJXg/N5vSwjxShz0LimmzzvsimsS67bV4MdT4d8cyhoQnfio+eU3b4AFiqxUxZQhFe9 CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rse78f377-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Apr 2019 14:37:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50D5E3A;
        Thu, 11 Apr 2019 12:37:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30EAD240E;
        Thu, 11 Apr 2019 12:37:18 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 11 Apr
 2019 14:37:17 +0200
Subject: Re: [PATCH 0/4] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
Date:   Thu, 11 Apr 2019 14:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf

Just a gentleman ping about this series.
I sent this series at same time of dt_mode
(no dependence between both).

BR
Ludo

On 3/5/19 5:10 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -Avoid to check and poll busy status when is not expected.
> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>   different.
> -Add hardware busy timeout with MMCIDATATIMER register.
> 
> Ludovic Barre (4):
>    mmc: mmci: avoid fake busy polling
>    mmc: mmci: fix clear of busy detect status
>    mmc: mmci: add hardware busy timeout feature
>    mmc: mmci: add busy detect for stm32 sdmmc variant
> 
>   drivers/mmc/host/mmci.c | 67 +++++++++++++++++++++++++++++++++++++++----------
>   drivers/mmc/host/mmci.h |  3 +++
>   2 files changed, 57 insertions(+), 13 deletions(-)
> 
