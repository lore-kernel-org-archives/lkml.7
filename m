Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C9D2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbfB1Lnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:43:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731013AbfB1Lnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9746280D;
        Thu, 28 Feb 2019 03:43:34 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30B8D3F738;
        Thu, 28 Feb 2019 03:43:31 -0800 (PST)
Subject: Re: [PATCH v3 18/34] s390: mm: Add p?d_large() definitions
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-19-steven.price@arm.com>
 <20190227184012.2e251154@mschwideX1>
From:   Steven Price <steven.price@arm.com>
Message-ID: <0ad6ff76-bbe8-122c-f0e1-54f567dc9753@arm.com>
Date:   Thu, 28 Feb 2019 11:43:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190227184012.2e251154@mschwideX1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 17:40, Martin Schwidefsky wrote:
> On Wed, 27 Feb 2019 17:05:52 +0000
> Steven Price <steven.price@arm.com> wrote:
> 
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information is provided by the
>> p?d_large() functions/macros.
>>
>> For s390, we don't support large pages, so add a stub returning 0.
> 
> Well s390 does support 1MB and 2GB large pages, pmd_large() and pud_large()
> are non-empty. We do not support 4TB or 8PB large pages though, which
> makes the patch itself correct. Just the wording is slightly off.

Sorry, you're absolutely right - I'll update the commit message for the
next posting.

Thanks,

Steve

>> CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
>> CC: linux-s390@vger.kernel.org
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  arch/s390/include/asm/pgtable.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 063732414dfb..9617f1fb69b4 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -605,6 +605,11 @@ static inline int pgd_present(pgd_t pgd)
>>  	return (pgd_val(pgd) & _REGION_ENTRY_ORIGIN) != 0UL;
>>  }
>>
>> +static inline int pgd_large(pgd_t pgd)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int pgd_none(pgd_t pgd)
>>  {
>>  	if (pgd_folded(pgd))
>> @@ -645,6 +650,11 @@ static inline int p4d_present(p4d_t p4d)
>>  	return (p4d_val(p4d) & _REGION_ENTRY_ORIGIN) != 0UL;
>>  }
>>
>> +static inline int p4d_large(p4d_t p4d)
>> +{
>> +	return 0;
>> +}
>> +
>>  static inline int p4d_none(p4d_t p4d)
>>  {
>>  	if (p4d_folded(p4d))
> 
> 

