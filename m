Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC0C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 07:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC55B20862
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 07:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfJEHfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 03:35:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfJEHfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 03:35:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB8A2C049E17;
        Sat,  5 Oct 2019 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-49.pek2.redhat.com [10.72.12.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A7605D9DC;
        Sat,  5 Oct 2019 07:35:12 +0000 (UTC)
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
To:     Baoquan He <bhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, jgross@suse.com, dhowells@redhat.com,
        Thomas.Lendacky@amd.com, kexec@lists.infradead.org,
        Vivek Goyal <vgoyal@redhat.com>
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
 <20190928000505.GJ31919@MiWiFi-R3L-srv>
 <875zldp2vj.fsf@x220.int.ebiederm.org> <20190928030910.GA5774@MiWiFi-R3L-srv>
 <87zhimks5j.fsf@x220.int.ebiederm.org>
 <20191001074012.GK31919@MiWiFi-R3L-srv>
From:   lijiang <lijiang@redhat.com>
Message-ID: <7e97421d-d9a8-9d57-1aa0-406039f8421d@redhat.com>
Date:   Sat, 5 Oct 2019 15:35:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191001074012.GK31919@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 05 Oct 2019 07:35:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年10月01日 15:40, Baoquan He 写道:
> On 09/30/19 at 05:14am, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>>>> needs a little better description.  I know it is not a lot on modern
>>>> systems but reserving an extra 1M of memory to avoid having to special
>>>> case it later seems in need of calling out.
>>>>
>>>> I have an old system around that I think that 640K is about 25% of
>>>> memory.
>>>
>>> Understood. Basically 640K is wasted in this case. But we only do like
>>> this in SME case, a condition checking is added. And system with SME is
>>> pretty new model, it may not impact the old system.
>>
>> The conditional really should be based on if we are reserving memory
>> for a kdump kernel.  AKA if crash_kernel=XXX is specified on the kernel
>> command line.
>>
>> At which point I think it would be very reasonable to unconditionally
>> reserve the low 640k, and make the whole thing a non-issue.  This would
>> allow the kdump code to just not do anything special for any of the
>> weird special case.
>>
>> It isn't perfect because we need a page or so used in the first kernel
>> for bootstrapping the secondary cpus, but that seems like the least of
>> evils.  Especially as no one will DMA to that memory.
>>
>> So please let's just change what memory we reserve when crash_kernel is
>> specified.
> 
> Yes, makes sense, thanks for pointing it out.
> 

Sorry for the delay and thanks for your comment, Eric, Baoquan and Dave Young.

I will improve patch log and add the extra condition crash_kernel. I will post
v2 later.

Thanks.
Lianbo

>>
>>>> How we interact with BIOS tables in the first 640k needs some
>>>> explanation.  Both in the first kernel and in the crash kernel.
>>>
>>> Yes, totally agree.
>>>
>>> Those BIOS tables have been reserved as e820 reserved regions and will
>>> be passed to kdump kernel for reusing. Memblock reserved 640K doesn't
>>> mean it will cover the whole [0, 640K) region, it only searches for
>>> available system RAM from memblock allocator.
>>
>> Careful with that assumption.  My memory is that the e820 memory map
>> frequently fails to cover areas like the real mode interrupt descriptor
>> table at address 0.
> 
> OK, will think more about this. Thanks.
> 
