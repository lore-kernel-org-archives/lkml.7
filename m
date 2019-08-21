Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14128C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E1B206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfHUPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:34:33 -0400
Received: from foss.arm.com ([217.140.110.172]:60232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfHUPec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:34:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB655337;
        Wed, 21 Aug 2019 08:34:31 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E11F53F718;
        Wed, 21 Aug 2019 08:34:28 -0700 (PDT)
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
To:     Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
 <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <22a79977-5074-7af1-97b8-8a3e549b23c1@arm.com>
Date:   Wed, 21 Aug 2019 16:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 16:24, Will Deacon wrote:
> On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
>> MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
>> the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
>> respectively. Meanwhile the iova still is 32bits.
>>
>> Regarding whether the pagetable address could be over 4GB, the mt8183
>> support it while the previous mt8173 don't, thus keep it as is.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>>   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
>>   include/linux/io-pgtable.h         |  7 +++----
>>   2 files changed, 28 insertions(+), 11 deletions(-)
> 
> [...]
> 
>> @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>>   {
>>   	struct arm_v7s_io_pgtable *data;
>>   
>> -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>> +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
>> +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
>> +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> 
> Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
> ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?

You mean oas, right? I believe the hardware *does* actually support a 
32-bit ias as well, but we shouldn't pretend to support that while 
__arm_v7s_alloc_table() still only knows how to allocate normal-sized 
tables.

Robin.

> 
> With that change:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Will
> 
