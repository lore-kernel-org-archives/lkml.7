Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256552173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 06:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCMGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:34:11 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48092 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 02:34:11 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h3xSo-0003yD-G2 from Jiada_Wang@mentor.com ; Tue, 12 Mar 2019 23:34:06 -0700
Received: from [172.30.112.185] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 12 Mar 2019 23:34:02 -0700
Subject: Re: [PATCH 5/5] ASoC: rsnd: dma: use extended audio dmac registers
 when available
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <geert@linux-m68k.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20190313055811.26135-1-jiada_wang@mentor.com>
 <87h8c7gv73.wl-kuninori.morimoto.gx@renesas.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <eb7ac3a6-e386-09e8-54b0-2e0eda90ad66@mentor.com>
Date:   Wed, 13 Mar 2019 15:34:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87h8c7gv73.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san

thanks for your comments

On 2019/03/13 15:23, Kuninori Morimoto wrote:
> 
> Hi Jiada
> 
>> Some of SoCs have both basic and extended dmac registers set
>> basic set only supports busif0 ~ busif3, in order to use
>> busif4 ~ busif7, extended audio dmac registers need to be used.
>>
>> This patch changes to use extended dmac registers set when it is
>> available in device-tree.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
> 
> 1st of all, if you want to post this kind of patch-set,
> you *should* post driver side patch 1st, and if it was accepted,
> you need to post SoC side patch. Then, you need to indicate
> to SoC maintainer which branch/commit should be based.
> Otherwise, it will 100% breaks git-bisect.
> 
yes, you're right,
sorry about this

> 2nd, in my understanding, our conclusion at Renesas-ML
> is that we don't need to think about basic/extend DMAC register.
> Because extend area is 100% covering basic area.
> In other words, it is compatible.
> Driver side don't need to think about it.
>
I am a little confused,
because latest comment received from simon, suggests to let driver to 
decide which register set to use.

for me, I think it's not necessary, if extended register set is available,
driver shall always use it.

Thanks,
Jiada


>> --- a/sound/soc/sh/rcar/dma.c
>> +++ b/sound/soc/sh/rcar/dma.c
>> @@ -830,7 +830,10 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
>>   	/*
>>   	 * for Gen2 or later
>>   	 */
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "audmapp");
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "extaudmapp");
>> +	if (!res)
>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						   "audmapp");
>>   	dmac = devm_kzalloc(dev, sizeof(*dmac), GFP_KERNEL);
>>   	if (!dmac || !res) {
>>   		dev_err(dev, "dma allocate failed\n");
>> -- 
>> 2.19.2
>>
