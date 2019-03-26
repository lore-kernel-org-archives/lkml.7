Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ECD20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfCZIzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:55:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23889 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbfCZIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:55:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8rPg3026892;
        Tue, 26 Mar 2019 09:55:03 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddht8tsa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Mar 2019 09:55:03 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3607E31;
        Tue, 26 Mar 2019 08:55:02 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3E3E2691;
        Tue, 26 Mar 2019 08:55:01 +0000 (GMT)
Received: from [10.48.1.93] (10.75.127.46) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Mar
 2019 09:55:01 +0100
Subject: Re: [PATCH v2] dmaengine: stm32-mdma: Revert "Add a check on
 read_u32_array"
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1553530915-1961-1-git-send-email-pierre-yves.mordret@st.com>
 <20190325162849.GS5348@vkoul-mobl>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <8a28e0d8-93d6-3cb7-a53a-26017aa89e16@st.com>
Date:   Tue, 26 Mar 2019 09:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325162849.GS5348@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/19 5:28 PM, Vinod Koul wrote:
> On 25-03-19, 17:21, Pierre-Yves MORDRET wrote:
>> This reverts commit 906b40b246b0 ("Add a check on read_u32_array")
> 
> This and patch title should contain:
> 906b40b246b0 ("dmaengine: stm32-mdma: Add a check on read_u32_array")
> 
> I have fixed it up and applied.

Darn it, sorry.
Many thanks btw :)

> 
> Thanks
> 
>> As stated by bindings "st,ahb-addr-masks" is optional.
>> The statement inserted by this commit makes this property
>> mandatory and prevents MDMA to be probed in case property not present.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v2:
>>        * review commit message
>>     v1:
>>        * Initial
>> ---
>> ---
>>  drivers/dma/stm32-mdma.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
>> index 4e0eede..ac0301b 100644
>> --- a/drivers/dma/stm32-mdma.c
>> +++ b/drivers/dma/stm32-mdma.c
>> @@ -1578,11 +1578,9 @@ static int stm32_mdma_probe(struct platform_device *pdev)
>>  
>>  	dmadev->nr_channels = nr_channels;
>>  	dmadev->nr_requests = nr_requests;
>> -	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>> +	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
>>  				       dmadev->ahb_addr_masks,
>>  				       count);
>> -	if (ret)
>> -		return ret;
>>  	dmadev->nr_ahb_addr_masks = count;
>>  
>>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -- 
>> 2.7.4
> 
