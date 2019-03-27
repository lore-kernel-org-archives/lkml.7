Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A523BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfC0I3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:29:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28597 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfC0I3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:29:00 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R8Q8S5024800;
        Wed, 27 Mar 2019 09:28:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rg4a68fdn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Mar 2019 09:28:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C383B3D;
        Wed, 27 Mar 2019 08:28:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92E452999;
        Wed, 27 Mar 2019 08:28:40 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Mar
 2019 09:28:39 +0100
Subject: Re: [PATCH V3 2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
 <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <b98b0692-c052-c4e1-f525-bf7ef4dffd1d@st.com>
Date:   Wed, 27 Mar 2019 09:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 6:46 PM, Ulf Hansson wrote:
> On Tue, 26 Mar 2019 at 10:11, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch defines get_dctrl_cfg callback for legacy variants
>> whatever DMA_ENGINE configuration.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 31 +++++++++++++++++++++++--------
>>   drivers/mmc/host/mmci.h |  3 +++
>>   2 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 9e6a2c1..4041e36 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -46,12 +46,6 @@
>>
>>   #define DRIVER_NAME "mmci-pl18x"
>>
>> -#ifdef CONFIG_DMA_ENGINE
>> -static void mmci_variant_init(struct mmci_host *host);
>> -#else
>> -static inline void mmci_variant_init(struct mmci_host *host) {}
>> -#endif
> 
> Looks like you are moving the declaration to the header file. I would
> rather keep it here as there is no point in sharing to another c-file
> (at least not yet). The same applies for the new ux500v2 init
> function.

no problem, I will resend a V4 to keep mmci and ux500v2 variant init in 
the c file.

> 
> Other than that, this looks good to me!

thanks

> 
> Kind regards
> Uffe
> 
