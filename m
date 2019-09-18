Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F19C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD7D214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eoBhni1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfIRJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:29:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55970 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfIRJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:29:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8I9TEKI003295;
        Wed, 18 Sep 2019 04:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568798954;
        bh=vsbH6rLafkiptTfcuqawPRZcaFsNYSCvZqDodrB1HXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eoBhni1+j0mzz1sgm/0bpvD9AQ2MvsRpZ0ejLF7zOL7hwMbyyaYsRwXiwzjBNvQ4Z
         Cl7YncVOSl9Hrhzi9wXAXhNK777+1jYGxxxvkCLLYB/ryoMHkwhr7wxvluwRb7Wil7
         0lTX26Jstsrt6rt5wA4uhIZBS5/Pheie/GTAx1fI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8I9TEqb100328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 04:29:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 04:29:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 04:29:10 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8I9TB5M037955;
        Wed, 18 Sep 2019 04:29:12 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: use
 devm_platform_ioremap_resource() to simplify code
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        YueHaibing <yuehaibing@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        <ivan.khoronzhuk@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>
References: <20190821124850.9592-1-yuehaibing@huawei.com>
 <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <12c00786-980f-5761-3117-3e741e63d7b3@ti.com>
Date:   Wed, 18 Sep 2019 12:29:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXdd4oiHqTpFTYBTSeCB6A78_gSGmwPy5EgPRZXibOqZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/09/2019 21:35, Geert Uytterhoeven wrote:
> Hi YueHaibing,
> 
> On Wed, Aug 21, 2019 at 2:51 PM YueHaibing <yuehaibing@huawei.com> wrote:
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/net/ethernet/ti/cpsw.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 32a8974..5401095 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -2764,7 +2764,7 @@ static int cpsw_probe(struct platform_device *pdev)
>>          struct net_device               *ndev;
>>          struct cpsw_priv                *priv;
>>          void __iomem                    *ss_regs;
>> -       struct resource                 *res, *ss_res;
>> +       struct resource                 *ss_res;
>>          struct gpio_descs               *mode;
>>          const struct soc_device_attribute *soc;
>>          struct cpsw_common              *cpsw;
>> @@ -2798,8 +2798,7 @@ static int cpsw_probe(struct platform_device *pdev)
> 
> And just out-of-context, we also have:
> 
>          ss_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>          ss_regs = devm_ioremap_resource(dev, ss_res);
>          if (IS_ERR(ss_regs))
> 
> which was not detected as being the same pattern?
> 
> Interesting...

ss_res is used below to determine phys address of CPPI RAM.

> 
>>                  return PTR_ERR(ss_regs);
>>          cpsw->regs = ss_regs;
>>
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -       cpsw->wr_regs = devm_ioremap_resource(dev, res);
>> +       cpsw->wr_regs = devm_platform_ioremap_resource(pdev, 1);
>>          if (IS_ERR(cpsw->wr_regs))
>>                  return PTR_ERR(cpsw->wr_regs);

-- 
Best regards,
grygorii
