Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854AC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2228A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="OcLNUXkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfIKNh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:37:28 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1606 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfIKNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:37:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7097D3F738;
        Wed, 11 Sep 2019 15:37:20 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=OcLNUXkS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IHW01YaWejTE; Wed, 11 Sep 2019 15:37:16 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 184183F734;
        Wed, 11 Sep 2019 15:37:13 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7EE4F3601AA;
        Wed, 11 Sep 2019 15:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568209033; bh=3PG6dFlWy4tEZtyh5/983yf4ihrAZIfnFudxICqTBHc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OcLNUXkSt2k+0/N++IkRpPqmWylBGN+sIwbM85W0AEJhGtK1DqkhvjvWXRDUafbqP
         nPrUbSVRyJHkmOjRfhAbgcrHhViBbxkqfz6BlnPKtdY52+yY4NBfzBncHi8zwQaSUf
         Ww8v/qSNU815lB0Ku2OZPgTZivBbeb3/7X6rl96g=
Subject: Re: [PATCH v2 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "linux-graphics-maintainer@vmware.com" 
        <linux-graphics-maintainer@vmware.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190911124022.22423-1-thomas_os@shipmail.org>
 <20190911124022.22423-2-thomas_os@shipmail.org>
 <b63de7ad-21e3-b825-91a4-c4317e82b6c3@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <cb55bcfa-2767-9e32-989f-9688c1bc99df@shipmail.org>
Date:   Wed, 11 Sep 2019 15:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b63de7ad-21e3-b825-91a4-c4317e82b6c3@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 3:27 PM, Lendacky, Thomas wrote:
> On 9/11/19 7:40 AM, Thomas Hellström (VMware) wrote:
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> When SEV or SME is enabled and active, vm_get_page_prot() typically
>> returns with the encryption bit set. This means that users of
>> pgprot_modify(, vm_get_page_prot()) (mprotect_fixup, do_mmap) end up with
>> a value of vma->vm_pg_prot that is not consistent with the intended
>> protection of the PTEs. This is also important for fault handlers that
>> rely on the VMA vm_page_prot to set the page protection. Fix this by
>> not allowing pgprot_modify() to change the encryption bit, similar to
>> how it's done for PAT bits.
>>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>   arch/x86/include/asm/pgtable.h       | 7 +++++--
>>   arch/x86/include/asm/pgtable_types.h | 2 +-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 0bc530c4eb13..1e6bb4c25334 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -624,12 +624,15 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>   	return __pmd(val);
>>   }
>>   
>> -/* mprotect needs to preserve PAT bits when updating vm_page_prot */
>> +/*
>> + * mprotect needs to preserve PAT and encryption bits when updating
>> + * vm_page_prot
>> + */
>>   #define pgprot_modify pgprot_modify
>>   static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>>   {
>>   	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
>> -	pgprotval_t addbits = pgprot_val(newprot);
>> +	pgprotval_t addbits = pgprot_val(newprot) & ~_PAGE_CHG_MASK;
>>   	return __pgprot(preservebits | addbits);
>>   }
>>   
>> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
>> index b5e49e6bac63..e13084b3d6cb 100644
>> --- a/arch/x86/include/asm/pgtable_types.h
>> +++ b/arch/x86/include/asm/pgtable_types.h
>> @@ -123,7 +123,7 @@
>>    */
>>   #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
>>   			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
>> -			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
>> +			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | sme_me_mask)
> There is a _PAGE_ENC definition that you could use to make this more
> consistent with the current definition.

Ah yes.

I'll wait a bit to see if there are more concerns and include this in 
the next version.

Thanks,

Thomas



>
> Thanks,
> Tom
>
>>   #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
>>   
>>   /*
>>

