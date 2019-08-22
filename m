Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22931C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BC9233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfHVK5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:57:15 -0400
Received: from foss.arm.com ([217.140.110.172]:43742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbfHVK5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:57:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D431596;
        Thu, 22 Aug 2019 03:57:13 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4A43F246;
        Thu, 22 Aug 2019 03:57:10 -0700 (PDT)
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
To:     Will Deacon <will@kernel.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
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
 <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
 <20190822101749.3kwzd5lb7zinsord@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e6652176-763d-5298-9e10-8c1fbe1b3c0d@arm.com>
Date:   Thu, 22 Aug 2019 11:57:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822101749.3kwzd5lb7zinsord@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-22 11:17 am, Will Deacon wrote:
> On Thu, Aug 22, 2019 at 11:08:58AM +0100, Robin Murphy wrote:
>> On 2019-08-22 9:56 am, Yong Wu wrote:
>>> On Wed, 2019-08-21 at 16:24 +0100, Will Deacon wrote:
>>>> On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
>>>>> MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
>>>>> the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
>>>>> respectively. Meanwhile the iova still is 32bits.
>>>>>
>>>>> Regarding whether the pagetable address could be over 4GB, the mt8183
>>>>> support it while the previous mt8173 don't, thus keep it as is.
>>>>>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>    drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
>>>>>    include/linux/io-pgtable.h         |  7 +++----
>>>>>    2 files changed, 28 insertions(+), 11 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>>>>>    {
>>>>>    	struct arm_v7s_io_pgtable *data;
>>>>> -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>>>>> +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
>>>>> +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
>>>>> +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
>>>>
>>>> Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
>>>> ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?
>>>
>>> Here I only simply skip the oas checking for our case. then which way do
>>> your prefer?  something like you commented before:?
>>>
>>>
>>> 	if (cfg->ias > ARM_V7S_ADDR_BITS)
>>> 		return NULL;
>>>
>>> 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
>>> 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>>> 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
>>> 		else if (cfg->oas > 34)
>>> 			return NULL;
>>> 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
>>> 		return NULL;
>>> 	}
>>
>> All it should take is something like:
>>
>> 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
>> 		max_oas = 34;
>> 	else
>> 		max_oas = 32;
>> 	if (cfg->oas > max_oas)
>> 		return NULL;
>>
>> or even just:
>>
>> 	if (cfg->oas > 32 ||
>> 	    (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT && cfg->oas > 34))
>> 		return NULL;
>>
>> (and if we prefer the latter style, perhaps we could introduce some kind of
>> "is_mtk_4gb()" helper to save on verbosity)
> 
> I wondered the same thing, but another place we'd want the check is in
> iopte_to_paddr() which probably needs the PHYS_ADDR_T check to avoid GCC
> warnings, although I didn't try it.

I'm pretty sure I confirmed that "paddr |= BIT_ULL(32)" doesn't warn 
when phys_addt_t is 32-bit - it's well-defined unsigned integer 
truncation after all, and if GCC starts warning about all the valid 
no-op code it optimises away then it's going to run up against 
IS_ENABLED() first and foremost ;)

> So if we did:
> 
> static bool cfg_mtk_ext_enabled(struct io_pgtable_cfg *cfg)
> {
> 	return IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
> 	       cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT;
> }
> 
> Then I suppose we could do this in _alloc():
> 
> 	if (cfg->oas > cfg_mtk_ext_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS)
> 		return NULL;
> 
> and then this in iopte_to_paddr():
> 
> 	[...]
> 
> 	paddr = pte & mask;
> 	if (!cfg_mtk_ext_enabled(cfg))
> 		return paddr;
> 
> 	if (pte & ARM_V7S_ATTR_MTK_PA_BIT32)
> 		paddr |= ...
> 
> 	[...]
> 
> What do you reckon?

Yeah, that's the general shape of things I was picturing - I'm not that 
fussed about the PHYS_ADDR_T_64BIT thing, especially if it's wrapped up 
in just one place, so if you do want to keep it as belt-and-braces I'll 
just consider it a slight code size optimisation for 32-bit builds.

Robin.
