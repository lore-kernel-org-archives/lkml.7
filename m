Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11362075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfDBR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:27:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBR1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:27:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD0580D;
        Tue,  2 Apr 2019 10:27:54 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D674B3F59C;
        Tue,  2 Apr 2019 10:27:52 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to
 vmcoreinfo
To:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <Steve.Capper@arm.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
 <1553058574-18606-2-git-send-email-bhsharma@redhat.com>
 <2757805b-61cb-8f4a-1917-0c57012f09df@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
From:   James Morse <james.morse@arm.com>
Message-ID: <54efc2e4-6b3a-792a-16a6-8503c866ea2a@arm.com>
Date:   Tue, 2 Apr 2019 18:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035710C4@BPXM09GP.gisp.nec.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kazu,

On 27/03/2019 16:07, Kazuhito Hagio wrote:
> On 3/26/2019 12:36 PM, James Morse wrote:
>> On 20/03/2019 05:09, Bhupesh Sharma wrote:
>>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>>> which supports this extension can support a virtual address-space upto
>>> 52-bits.
>>>
>>> Since at the moment we enable the support of this extension in kernel
>>> via CONFIG flags, e.g.
>>>  - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52
>>>
>>> so, there is no clear mechanism in the user-space right now to
>>> determine these CONFIG flag values and hence determine the maximum
>>> virtual address space supported by the underlying kernel.
>>>
>>> User-space tools like 'makedumpfile' therefore are broken currently
>>> as they have no proper method to calculate the 'PTRS_PER_PGD' value
>>> which is required to perform a page table walk to determine the
>>> physical address of a corresponding virtual address found in
>>> kcore/vmcoreinfo.
>>>
>>> If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
>>> it can be used in user-space to determine the maximum virtual address
>>> supported by underlying kernel.
>>
>> I don't think this really solves the problem, it feels fragile.
>>
>> I can see how vmcoreinfo tells you VA_BITS==48, PAGE_SIZE==64K and PTRS_PER_PGD=1024.
>> You can use this to work out that the top level page table size isn't consistent with a
>> 48bit VA, so 52bit VA must be in use...
>>
>> But wasn't your problem walking the kernel page tables? In particular the offset that we
>> apply because the tables were based on a 48bit VA shifted up in swapper_pg_dir.
>>
>> Where does the TTBR1_EL1 offset come from with this property? I assume makedumpfile
>> hard-codes it when it sees 52bit is in use ... somewhere.

> My understanding is that the TTBR1_EL1 offset comes from a kernel
> virtual address with the exported PTRS_PER_PGD.
> 
> With T1SZ is 48bit and T0SZ is 52bit,

(PTRS_PER_PGD doesn't tell you this, PTRS_PER_PGD lets you spot something odd is
happening, and this just happens to be the only odd combination today.)


> kva = 0xffff000000000000    <--- start of kernel virtual address

Does makedumpfile have this value? If the kernel were using 52bit VA for TTBR1 this value
would be different.


> pgd_index(kva) = (kva >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1)
>                = (0xffff000000000000 >> 42) & (1024 - 1)
>                = 0x00000000003fffc0 & 0x3ff
>                = 0x3c0      <--- the offset (0x3c0) is included
> 
> This is what kernel does now, so makedumpfile also wants to do.

Sure, and it would work today. I'm worried about tomorrow, where we support something new,
and need to bundle new information out through vmcoreinfo. This ends up being used to
fingerprint the kernel support, instead of as the value it was intended to be.


>> We haven't solved the problem!
>>
>> Today __cpu_setup() sets T0SZ and T1SZ differently for 52bit VA, but in the future it
>> could set them the same, or different the other-way-round.
>>
>> Will makedumpfile using this value keep working once T1SZ is 52bit VA too? In this case
>> there would be no ttbr offset.
> 
> If T1SZ is 52bit, probably kernel virtual address starts from 0xfff0000000000000,

I didn't think this 'bottom of the ttbr1 mapping range' value was exposed anywhere.
Where can user-space get this from? (I can't see it in the vmcoreinfo list)


> then the offset becomes 0 with the pgd_index() above.
> I think makedumpfile will keep working with that.


Steve mentions a 52/48 combination in his kernel series:
https://lore.kernel.org/linux-arm-kernel/20190218170245.14915-1-steve.capper@arm.com/


I think vmcoreinfo-users will eventually need to spot 52bit used in TTBR1 and/or TTBR0,
and possibly: configured, but not enabled in either. (this is because the bits are also
used for pointer-auth, the kernel may be built for both pointer-auth and 52-bit VA, and
chose which to enabled at boot based on some policy)

I don't see how you can do this with one value.
I'd like to get this right now, so we user-space doesn't need updating again!


Thanks,

James
