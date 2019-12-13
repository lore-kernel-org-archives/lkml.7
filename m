Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8D1C2D0DD
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BAC24712
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfLMOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:23:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbfLMOXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:23:05 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28B05E28028A971DDEF3;
        Fri, 13 Dec 2019 22:22:56 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 22:22:47 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped
 collections
To:     Marc Zyngier <maz@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
References: <20191213094237.19627-1-eric.auger@redhat.com>
 <d36b75e7-bd83-e501-3bd4-76bf0489c5ce@huawei.com>
 <9e9e3ed65ddf40ab72528187089e0997@www.loen.fr>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <066e4f57-9f92-2bd6-130a-b3c8bb0dcfc4@huawei.com>
Date:   Fri, 13 Dec 2019 22:22:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <9e9e3ed65ddf40ab72528187089e0997@www.loen.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/12/13 19:28, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2019-12-13 10:53, Zenghui Yu wrote:
>> Hi Eric,
>>
>> On 2019/12/13 17:42, Eric Auger wrote:
>>> Saving/restoring an unmapped collection is a valid scenario. For
>>> example this happens if a MAPTI command was sent, featuring an
>>> unmapped collection. At the moment the CTE fails to be restored.
>>> Only compare against the number of online vcpus if the rdist
>>> base is set.
>>
>> Have you actually seen a problem and this patch fixed it? To be honest,
>> I'm surprised to find that we can map a LPI to an unmapped collection ;)
>> (and prevent it to be delivered to vcpu with an INT_UNMAPPED_INTERRUPT
>> error, until someone had actually mapped the collection).
>> After a quick glance of spec (MAPTI), just as you said, this is valid.
> 
> Yes, this is one of the (many) odd bits in the architecture. And there is
> a bizarre wording in the MAPC description when V=0:
> 
> "Behavior is unpredictable if there are interrupts that are mapped to the
> specified collection, with the restriction that further translation 
> requests
> from that device are ignored."
> 
> It is really odd that:
> 
> - it is unpredictable to unmap the collection with mapped interrupts,
>    but mapping interrupts to an unmapped collection is fine

Yes, looks odd... Without Eric's patch, I won't even notice it.

I guess that unmapping the collection with mapped interrupts will make
it difficult for Hardware to manage those interrupts' internal states,
but only a guess.

> - the notion of "interrupts from that device" doesn't match any of the
>    MAPC parameters

Looks like a writing mistake, a better statement *might be*
"further translation requests targeting that ICID are ignored"?

> Do you hate the GIC already? ;-)

Not yet! (I'd like to continue being messed with GIC and see when I
will hate it :)

> 
>> If Marc has no objection to this fix, please add
>>
>> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> Thanks for that, I've applied it to the patch and will push out
> the update as soon as ra.kernel.org is reachable again.

Thanks,
Zenghui

