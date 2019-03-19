Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCSQCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:02:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfCSQCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:02:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7B9DC12E7D08A26FF24A;
        Wed, 20 Mar 2019 00:02:01 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 00:01:50 +0800
Subject: Re: [RFC PATCH] KVM: arm/arm64: Enable direct irqfd MSI injection
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <eric.auger@redhat.com>, "Raslan, KarimAllah" <karahmed@amazon.de>,
        <christoffer.dall@arm.com>, <andre.przywara@arm.com>,
        <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <mst@redhat.com>, <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guoheyi@huawei.com>
References: <1552833373-19828-1-git-send-email-yuzenghui@huawei.com>
 <86o969z42z.wl-marc.zyngier@arm.com>
 <428b2aac-5a0f-e9da-8d74-8045f99a8c74@huawei.com>
 <20190319100141.69821f8b@why.wild-wind.fr.eu.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4fedabbe-b2d0-c04c-e8ce-a1adbf419f8a@huawei.com>
Date:   Tue, 19 Mar 2019 23:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190319100141.69821f8b@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/3/19 18:01, Marc Zyngier wrote:
> On Tue, 19 Mar 2019 09:09:43 +0800
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
>> Hi all,
>>
>> On 2019/3/18 3:35, Marc Zyngier wrote:
>>> A first approach would be to keep a small cache of the last few
>>> successful translations for this ITS, cache that could be looked-up by
>>> holding a spinlock instead. A hit in this cache could directly be
>>> injected. Any command that invalidates or changes anything (DISCARD,
>>> INV, INVALL, MAPC with V=0, MAPD with V=0, MOVALL, MOVI) should nuke
>>> the cache altogether.
>>>
>>> Of course, all of that needs to be quantified.
>>
>> Thanks for all of your explanations, especially for Marc's suggestions!
>> It took me long time to figure out my mistakes, since I am not very
>> familiar with the locking stuff. Now I have to apologize for my noise.
> 
> No need to apologize. The whole point of this list is to have
> discussions. Although your approach wasn't working, you did
> identify potential room for improvement.
> 
>> As for the its-translation-cache code (a really good news to us), we
>> have a rough look at it and start testing now!
> 
> Please let me know about your findings. My initial test doesn't show
> any improvement, but that could easily be attributed to the system I
> running this on (a tiny and slightly broken dual A53 system). The sizing
> of the cache is also important: too small, and you have the overhead of
> the lookup for no benefit; too big, and you waste memory.

Not smoothly as expected. With below config (in the form of XML):

---8<---
     <interface type='vhostuser'>
       <source type='unix' path='/var/run/vhost-user/tap_0' mode='client'/>
       <model type='virtio'/>
       <driver name='vhost' queues='32' vringbuf='4096'/>
     </interface>
---8<---

VM can't even get to boot successfully!


Kernel version is -stable 4.19.28. And *dmesg* on host shows:

---8<---
[  507.908330] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  507.908338] rcu:     35-...0: (0 ticks this GP) 
idle=d06/1/0x4000000000000000 softirq=72150/72150 fqs=6269
[  507.908341] rcu:     41-...0: (0 ticks this GP) 
idle=dee/1/0x4000000000000000 softirq=68144/68144 fqs=6269
[  507.908342] rcu:     (detected by 23, t=15002 jiffies, g=68929, q=408641)
[  507.908350] Task dump for CPU 35:
[  507.908351] qemu-kvm        R  running task        0 66789      1 
0x00000002
[  507.908354] Call trace:
[  507.908360]  __switch_to+0x94/0xe8
[  507.908363]  _cond_resched+0x24/0x68
[  507.908366]  __flush_work+0x58/0x280
[  507.908369]  free_unref_page_commit+0xc4/0x198
[  507.908370]  free_unref_page+0x84/0xa0
[  507.908371]  __free_pages+0x58/0x68
[  507.908372]  free_pages.part.21+0x34/0x40
[  507.908373]  free_pages+0x2c/0x38
[  507.908375]  poll_freewait+0xa8/0xd0
[  507.908377]  do_sys_poll+0x3d0/0x560
[  507.908378]  __arm64_sys_ppoll+0x180/0x1e8
[  507.908380]  0xa48990
[  507.908381] Task dump for CPU 41:
[  507.908382] kworker/41:1    R  running task        0   647      2 
0x0000002a
[  507.908387] Workqueue: events irqfd_inject
[  507.908389] Call trace:
[  507.908391]  __switch_to+0x94/0xe8
[  507.908392]  0x200000131
[... ...]
[  687.928330] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  687.928339] rcu:     35-...0: (0 ticks this GP) 
idle=d06/1/0x4000000000000000 softirq=72150/72150 fqs=25034
[  687.928341] rcu:     41-...0: (0 ticks this GP) 
idle=dee/1/0x4000000000000000 softirq=68144/68144 fqs=25034
[  687.928343] rcu:     (detected by 16, t=60007 jiffies, g=68929, 
q=1601093)
[  687.928351] Task dump for CPU 35:
[  687.928352] qemu-kvm        R  running task        0 66789      1 
0x00000002
[  687.928355] Call trace:
[  687.928360]  __switch_to+0x94/0xe8
[  687.928364]  _cond_resched+0x24/0x68
[  687.928367]  __flush_work+0x58/0x280
[  687.928369]  free_unref_page_commit+0xc4/0x198
[  687.928370]  free_unref_page+0x84/0xa0
[  687.928372]  __free_pages+0x58/0x68
[  687.928373]  free_pages.part.21+0x34/0x40
[  687.928374]  free_pages+0x2c/0x38
[  687.928376]  poll_freewait+0xa8/0xd0
[  687.928378]  do_sys_poll+0x3d0/0x560
[  687.928379]  __arm64_sys_ppoll+0x180/0x1e8
[  687.928381]  0xa48990
[  687.928382] Task dump for CPU 41:
[  687.928383] kworker/41:1    R  running task        0   647      2 
0x0000002a
[  687.928389] Workqueue: events irqfd_inject
[  687.928391] Call trace:
[  687.928392]  __switch_to+0x94/0xe8
[  687.928394]  0x200000131
[...]
---8<---   endlessly ...

It seems that we've suffered from some locking related issues. Any
suggestions for debugging?

And could you please provide your test steps ? So that I can run
some tests on my HW to see improvement hopefully.

> 
> Having thought about it a bit more, I think we can drop the
> invalidation on MOVI/MOVALL, as the LPI is still perfectly valid, and
> we don't cache the target vcpu. On the other hand, the cache must be
> nuked when the ITS is turned off.

All of these are valuable. But it might be early for me to consider
about them (I have to get the above problem solved first ...)


thanks,

zenghui

> 
> Thanks,
> 
> 	M.
> 

