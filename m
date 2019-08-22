Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D340C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26C7233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfHVKJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:09:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbfHVKJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:09:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3587F15A2;
        Thu, 22 Aug 2019 03:09:07 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13E43F246;
        Thu, 22 Aug 2019 03:09:02 -0700 (PDT)
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
To:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>
Cc:     youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
 <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
 <1566464186.11621.7.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
Date:   Thu, 22 Aug 2019 11:08:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566464186.11621.7.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-22 9:56 am, Yong Wu wrote:
> On Wed, 2019-08-21 at 16:24 +0100, Will Deacon wrote:
>> On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
>>> MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
>>> the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
>>> respectively. Meanwhile the iova still is 32bits.
>>>
>>> Regarding whether the pagetable address could be over 4GB, the mt8183
>>> support it while the previous mt8173 don't, thus keep it as is.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
>>>   include/linux/io-pgtable.h         |  7 +++----
>>>   2 files changed, 28 insertions(+), 11 deletions(-)
>>
>> [...]
>>
>>> @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>>>   {
>>>   	struct arm_v7s_io_pgtable *data;
>>>   
>>> -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>>> +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
>>> +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
>>> +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
>>
>> Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
>> ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?
> 
> Here I only simply skip the oas checking for our case. then which way do
> your prefer?  something like you commented before:?
> 
> 
> 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> 		return NULL;
> 
> 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> 		else if (cfg->oas > 34)
> 			return NULL;
> 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> 		return NULL;
> 	}

All it should take is something like:

	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
		max_oas = 34;
	else
		max_oas = 32;
	if (cfg->oas > max_oas)
		return NULL;

or even just:

	if (cfg->oas > 32 ||
	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT && cfg->oas > 34))
		return NULL;

(and if we prefer the latter style, perhaps we could introduce some kind 
of "is_mtk_4gb()" helper to save on verbosity)

We shouldn't need to care about the size of phys_addr_t either way - the 
fact is that the MTK format can still encode up to 34 bits of PA 
regardless of whether callers can actually pass addresses that large.

Robin.
