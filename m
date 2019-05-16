Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E0C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B4120873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfEPBrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfEPBMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DB4385A04;
        Thu, 16 May 2019 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5C7C19733;
        Thu, 16 May 2019 01:12:31 +0000 (UTC)
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
References: <20190430074421.7852-1-lijiang@redhat.com>
 <20190430074421.7852-3-lijiang@redhat.com> <20190515133006.GG24212@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <4707fb2d-b7d3-34e3-a488-8aa9bdca05f1@redhat.com>
Date:   Thu, 16 May 2019 09:12:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190515133006.GG24212@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 16 May 2019 01:12:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年05月15日 21:30, Borislav Petkov 写道:
> On Tue, Apr 30, 2019 at 03:44:20PM +0800, Lianbo Jiang wrote:
>> When SEV is active, the second kernel image is loaded into the
>> encrypted memory. Lets make sure that when kexec builds the
>> identity mapping page table it adds the memory encryption mask(C-bit).
>>
>> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/machine_kexec_64.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index f60611531d17..11fe352f7344 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -56,6 +56,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>>  	pte_t *pte;
>>  	unsigned long vaddr, paddr;
>>  	int result = -ENOMEM;
>> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
>>  
>>  	vaddr = (unsigned long)relocate_kernel;
>>  	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
>> @@ -92,7 +93,11 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>>  		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
>>  	}
>>  	pte = pte_offset_kernel(pmd, vaddr);
>> -	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
>> +
>> +	if (sev_active())
>> +		prot = PAGE_KERNEL_EXEC;
>> +
>> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
>>  	return 0;
>>  err:
>>  	return result;
>> @@ -129,6 +134,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>>  	level4p = (pgd_t *)__va(start_pgtable);
>>  	clear_page(level4p);
>>  
>> +	if (sev_active()) {
>> +		info.page_flag |= _PAGE_ENC;
>> +		info.kernpg_flag = _KERNPG_TABLE;
> 
> kernpg_flag above is initialized to _KERNPG_TABLE_NOENC so you can do here
> 
> 		info.kernpg_flag |= _PAGE_ENC;
> 
> too, to make it even more clear what this does, right?
> 
OK, i will modify it according to your suggestion and post again.

Thanks.
Lianbo

> IOW:
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 783ce5184405..16c37fe489bc 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -135,8 +135,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>         clear_page(level4p);
>  
>         if (sev_active()) {
> -               info.page_flag |= _PAGE_ENC;
> -               info.kernpg_flag = _KERNPG_TABLE;
> +               info.page_flag   |= _PAGE_ENC;
> +               info.kernpg_flag |= _PAGE_ENC;
>         }
>  
>         if (direct_gbpages)
> 
> 
