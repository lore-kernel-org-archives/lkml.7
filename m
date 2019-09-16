Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20543C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF08420830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfIPTnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:43:50 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:38724 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfIPTnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:43:49 -0400
Received: from [192.168.1.41] ([90.126.97.183])
        by mwinf5d90 with ME
        id 2Kjj2100R3xPcdm03Kjj1q; Mon, 16 Sep 2019 21:43:47 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Sep 2019 21:43:47 +0200
X-ME-IP: 90.126.97.183
Subject: Re: [PATCH] iommu/arm-smmu: Axe a useless test in
 'arm_smmu_master_alloc_smes()'
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190915193401.27426-1-christophe.jaillet@wanadoo.fr>
 <de9ee628-9efb-3078-590c-6852be61c7d2@arm.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5babe7b3-07ba-cb07-82b0-4105d8e8b4fc@wanadoo.fr>
Date:   Mon, 16 Sep 2019 21:43:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <de9ee628-9efb-3078-590c-6852be61c7d2@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/09/2019 à 12:46, Robin Murphy a écrit :
> On 15/09/2019 20:34, Christophe JAILLET wrote:
>> 'ommu_group_get_for_dev()' never returns NULL, so this test can be 
>> removed.
>
> Nit: typo in the function name.
>
> Otherwise, there definitely used to be some path where a NULL return 
> could leak out, so I would have had that in mind at the time I wrote 
> this, but apparently I never noticed that that had already been 
> cleaned up by the time this got merged.
>
Hi,

Maybe fixed by 72dcac633475 ("iommu: Warn once when device_group 
callback returns NULL")


CJ

> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> Thanks,
> Robin.
>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/iommu/arm-smmu.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c3ef0cc8f764..6fae8cdbe985 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1038,8 +1038,6 @@ static int arm_smmu_master_alloc_smes(struct 
>> device *dev)
>>       }
>>         group = iommu_group_get_for_dev(dev);
>> -    if (!group)
>> -        group = ERR_PTR(-ENOMEM);
>>       if (IS_ERR(group)) {
>>           ret = PTR_ERR(group);
>>           goto out_err;
>>
>

