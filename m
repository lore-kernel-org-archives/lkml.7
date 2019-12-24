Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BFC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2320706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfLXGOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:14:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfLXGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:14:46 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A384698883F1BF9557CF;
        Tue, 24 Dec 2019 14:14:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 14:14:35 +0800
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To:     Auger Eric <eric.auger@redhat.com>, Marc Zyngier <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
 <c084aa29c029f97cdfb1b5dc9e6b29ac@www.loen.fr>
 <1225d839-3cf7-d513-778e-698e12e94875@huawei.com>
 <12a1e25b-617d-6b04-6a5a-4c67a39565a5@redhat.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5df2ebf7-f1e0-5d55-cdae-15b2fd1675d6@huawei.com>
Date:   Tue, 24 Dec 2019 14:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <12a1e25b-617d-6b04-6a5a-4c67a39565a5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/24 12:45, Auger Eric wrote:
> Hi Zenghui,
> 
> On 12/24/19 3:52 AM, Zenghui Yu wrote:
>> Hi Marc, Eric,
>>
>> On 2019/12/23 22:07, Marc Zyngier wrote:
>>> Hi Zenghui,
>>>
>>> On 2019-12-23 13:43, Zenghui Yu wrote:
>>>> I noticed there is no userspace access callbacks for GICR_PENDBASER,
>>>> so this patch will make the PTZ field also 'Read As Zero' by userspace.
>>>> Should we consider adding a uaccess_read callback for GICR_PENDBASER
>>>> which just returns the unchanged vgic_cpu->pendbaser to userspace?
>>>> (Though this is really not a big deal. We now always emulate the PTZ
>>>> field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
>>>> only indicates whether KVM will optimize the LPI enabling process,
>>>> where Read As Zero indicates never optimize..)
>>>
>>> I don't think adding a userspace accessor would help much. All this
>>> bit tells userspace is that the guest has programmed a zero filled
>>> table. On restore, we'd avoid a rescan of the table if there was
>>> no LPI mapped.
>>
>> Yes, I agree.
>>
>>> And thinking of it, this fixes a bug for non-Linux guests: If you write
>>> PTZ=1, we never clear it. Which means that if userspace saves and
>>> restores
>>> PENDBASER with PTZ set, we'll never restore the pending bits, which is
>>> pretty bad (see vgic_enable_lpis()).
>>
>> But I'm afraid I can't follow this point. After reading the code (with
>> Qemu) a bit further, the Redistributors are restored before the ITS.
> 
> This is also part of the kernel documentation:
> Documentation/virt/kvm/devices/arm-vgic-its.txt (ITS restore sequence)

Yeah, I see. Thanks for the pointer, Eric!


Zenghui

>   So
>> there should be _no_ LPI has been mapped when we're restoring GICR_CTLR
>> and enabling LPI, which says we will not scan the whole pending table
>> and restore pending by vgic_enable_lpis()/its_sync_lpi_pending_table(),
>> regardless of what the PTZ is.
>>
>> Instead, vgic_its_restore_ite()/vgic_v3_lpi_sync_pending_status() is
>> where we actually read the guest RAM and restore the LPI pending state.
> yes the pending state is restored from
> vgic_its_restore_ite/vgic_add_lpi/vgic_v3_lpi_sync_pending_status and
> this path ignores the PTZ.
> 
> Thanks
> 
> Eric
>> Which means we will still do the right thing even for non-Linux guests.
>> Not sure if I've got things correctly here.
>>
>> In the end, let's keep the patch as it is.
>>
>>>
>>> This patch on its own fixes more than one bug!
>>>
>>
>> If so, just by luck ;-)

