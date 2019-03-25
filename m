Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04939C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFCB2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 01:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCYB6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 21:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbfCYB6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 21:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 408F13084295;
        Mon, 25 Mar 2019 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E4710018F9;
        Mon, 25 Mar 2019 01:58:15 +0000 (UTC)
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, bhe@redhat.com
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
Date:   Mon, 25 Mar 2019 09:58:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190324150034.GH23289@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 25 Mar 2019 01:58:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月24日 23:00, Borislav Petkov 写道:
>> Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is active
> 
> The tip tree preferred format for patch subject prefixes is
> 'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
> 'genirq/core:'. Please do not use file names or complete file paths as
> prefix. 'git log path/to/file' should give you a reasonable hint in most
> cases.

Fine, thanks for your advice.

> 
> On Fri, Mar 15, 2019 at 06:32:01PM +0800, Lianbo Jiang wrote:
>> Currently, the arch_kexec_post_{alloc,free}_pages unconditionally
> 
> Please end function names with parentheses.

Ok, i will improve them next post.

> 
>> maps the kexec area as decrypted. This works fine when SME is active.
>> Because in SME, the first kernel is loaded in decrypted area by the
>> BIOS, so the second kernel must be also loaded into the decrypted
>> memory.
>>
>> When SEV is active, the first kernel is loaded into the encrypted
>> area, so the second kernel must be also loaded into the encrypted
>> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages does
>> not clear the memory encryption mask from the kexec area when SEV
>> is active.
> 
> Hold on, wait a minute!
> 
> Why do we even need this? As usual, you guys never explain what the big
> picture is. So you mention SEV, which sounds to me like you want to be
> able to kexec the SEV *guest*. Yes?

Yes. Just like the physical machines support kdump, the virtual machines also
need kdump. When a virtual machine panic, we also need to dump its memory for
analysis.

> 
> First of all, why?

For the SEV virtual machine, the memory is also encrypted. When SEV is enabled,
the first kernel is loaded into the encrypted area. Unlike the SME, the first
kernel is loaded into the decrypted area.

Because of this difference between SME and SEV, we need to properly map the kexec
memory area in order to correctly access it.

> 
> Then, if so...
> 
>> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index ceba408ea982..bcebf4993da4 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -566,7 +566,10 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>>  	 * not encrypted because when we boot to the new kernel the
>>  	 * pages won't be accessed encrypted (initially).
>>  	 */
>> -	return set_memory_decrypted((unsigned long)vaddr, pages);
>> +	if (sme_active())
>> +		return set_memory_decrypted((unsigned long)vaddr, pages);
> 
> ... then this looks yucky. Because, you're adding an sme_active() check here
> but then __set_memory_enc_dec() checks

For the SEV virtual machine, it maps the kexec memroy area as encrypted, so, no need to invoke
this function to change anything.


> 
> 	if (!mem_encrypt_active())
> 
> and heads will spin from all the checking of memory encryption aspects.
> 
> So this would need a rework so that there are no multiple confusing
> checks.

About the three functions, here i copied their comment from the arch/x86/mm/mem_encrypt.c
Please refer to it.

/*
 * SME and SEV are very similar but they are not the same, so there are
 * times that the kernel will need to distinguish between SME and SEV. The
 * sme_active() and sev_active() functions are used for this.  When a
 * distinction isn't needed, the mem_encrypt_active() function can be used.
 *


Thanks.
Lianbo

> 
> Thx.
> 
