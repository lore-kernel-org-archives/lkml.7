Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BDFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8DF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cq29vIO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfC2Vm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:42:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7041 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2Vm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:42:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9e91660000>; Fri, 29 Mar 2019 14:43:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 29 Mar 2019 14:42:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 29 Mar 2019 14:42:58 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 21:42:58 +0000
Subject: Re: [PATCH v2 01/11] mm/hmm: select mmu notifier when selecting HMM
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-2-jglisse@redhat.com>
 <d4889f44-0cc5-3ef6-deeb-7302c93c1f90@nvidia.com>
 <20190329211529.GA6124@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <c05dabd3-dd06-74d9-951c-ae409da31cd5@nvidia.com>
Date:   Fri, 29 Mar 2019 14:42:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190329211529.GA6124@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553895782; bh=ftvuRkYU+0Pcq3Bvvq5Vs+GUVHhY3V3UTjr/Mr6sOlA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cq29vIO84NPcmqlscz0xP2ghrrNtfG58xG8IeG2S5j3JMf2uMQT2PbH4VUxI9JrVP
         YSrp9EQQsZHAtWMWBtnl7retYbnRyovtnqaerVcmXnAOptOmijP2pAS+DDBDcUI2XV
         uzPDI4uNt/Zmk38Rokgisgmha45YMUJkFE+coI1kNeRRtFRXwOeq0N1hOO8GhS+vtW
         j88vpq+OMnYzqXEtRMs/2M5fedthcQaMTjshAXQErGygJCi3iPMAmnuUtCYyFkkwOv
         LvbNp2IIQSTJgXNxT+63xnvFbHhQmI47l2Y9D9+bDu1W79BhHAxT6jlsQ7+Ni19/dC
         YkX7pItTbh6gg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 2:15 PM, Jerome Glisse wrote:
[...]
>> Yes, this is a good move, given that MMU notifiers are completely,
>> indispensably part of the HMM design and implementation.
>>
>> The alternative would also work, but it's not quite as good. I'm
>> listing it in order to forestall any debate: 
>>
>>   config HMM
>>   	bool
>>  +	depends on MMU_NOTIFIER
>>   	select MIGRATE_VMA_HELPER
>>
>> ...and "depends on" versus "select" is always a subtle question. But in
>> this case, I'd say that if someone wants HMM, there's no advantage in
>> making them know that they must first ensure MMU_NOTIFIER is enabled.
>> After poking around a bit I don't see any obvious downsides either.
> 
> You can not depend on MMU_NOTIFIER it is one of the kernel config
> option that is not selectable. So any config that need MMU_NOTIFIER
> must select it.
> 

aha, thanks for explaining that point about the non-user-selectable items,
I wasn't aware of that. (I had convinced myself that those were set by
hard-coding a choice in one of the Kconfig files.)

>>
>> However, given that you're making this change, in order to avoid odd
>> redundancy, you should also do this:
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0d2944278d80..2e6d24d783f7 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -700,7 +700,6 @@ config HMM
>>  config HMM_MIRROR
>>         bool "HMM mirror CPU page table into a device page table"
>>         depends on ARCH_HAS_HMM
>> -       select MMU_NOTIFIER
>>         select HMM
>>         help
>>           Select HMM_MIRROR if you want to mirror range of the CPU page table of a
> 
> Because it is a select option no harm can come from that hence i do
> not remove but i can remove it.
> 

Yes, this is just a tiny housecleaning point, not anything earthshaking.

thanks,
-- 
John Hubbard
NVIDIA

