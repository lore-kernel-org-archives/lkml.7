Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B20FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425E72067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404851AbfJPPTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:19:40 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:36015 "EHLO
        4.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbfJPPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:19:39 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 11:19:39 EDT
Received: from player698.ha.ovh.net (unknown [10.108.42.119])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 1E54311C798
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:41:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
        (Authenticated sender: clg@kaod.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id CCEE9B08ECE7;
        Wed, 16 Oct 2019 14:41:08 +0000 (UTC)
Subject: Re: [PATCH -next] ipmi: bt-bmc: use devm_platform_ioremap_resource()
 to simplify code
To:     minyard@acm.org, YueHaibing <yuehaibing@huawei.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>
References: <20191016092131.23096-1-yuehaibing@huawei.com>
 <20191016141936.GN14232@t560>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <789af3ff-9ed8-5869-05c4-9cfb2ac5e9d5@kaod.org>
Date:   Wed, 16 Oct 2019 16:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016141936.GN14232@t560>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3174193315413003016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2019 16:19, Corey Minyard wrote:
> On Wed, Oct 16, 2019 at 05:21:31PM +0800, YueHaibing wrote:
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
> 
> Adding the module author and others. I can't see a reason to not do
> this.

yes. Looks good to me.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> -corey
> 
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/char/ipmi/bt-bmc.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
>> index 40b9927..d36aeac 100644
>> --- a/drivers/char/ipmi/bt-bmc.c
>> +++ b/drivers/char/ipmi/bt-bmc.c
>> @@ -444,15 +444,13 @@ static int bt_bmc_probe(struct platform_device *pdev)
>>  
>>  	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
>>  	if (IS_ERR(bt_bmc->map)) {
>> -		struct resource *res;
>>  		void __iomem *base;
>>  
>>  		/*
>>  		 * Assume it's not the MFD-based devicetree description, in
>>  		 * which case generate a regmap ourselves
>>  		 */
>> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -		base = devm_ioremap_resource(&pdev->dev, res);
>> +		base = devm_platform_ioremap_resource(pdev, 0);
>>  		if (IS_ERR(base))
>>  			return PTR_ERR(base);
>>  
>> -- 
>> 2.7.4
>>
>>

