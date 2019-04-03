Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C90C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8E72147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCNPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:15:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCNPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:15:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C92A78;
        Wed,  3 Apr 2019 06:15:06 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407743F59C;
        Wed,  3 Apr 2019 06:15:03 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
To:     Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, david@redhat.com,
        logang@deltatee.com, cai@lca.pw, pasha.tatashin@oracle.com,
        james.morse@arm.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <ed4ceac4-b92c-47f4-33b0-ed1d0833b40d@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e191ddcb-271c-57f3-091f-eacaac2e86e0@arm.com>
Date:   Wed, 3 Apr 2019 14:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ed4ceac4-b92c-47f4-33b0-ed1d0833b40d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 13:37, Robin Murphy wrote:
> [ +Steve ]
> 
> Hi Anshuman,
> 
> On 03/04/2019 05:30, Anshuman Khandual wrote:

<snip>

>> diff --git a/arch/arm64/include/asm/pgtable.h
>> b/arch/arm64/include/asm/pgtable.h
>> index de70c1e..858098e 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -355,6 +355,18 @@ static inline int pmd_protnone(pmd_t pmd)
>>   }
>>   #endif
>>   +#if (CONFIG_PGTABLE_LEVELS > 2)
>> +#define pmd_large(pmd)    (pmd_val(pmd) && !(pmd_val(pmd) &
>> PMD_TABLE_BIT))
>> +#else
>> +#define pmd_large(pmd) 0
>> +#endif
>> +
>> +#if (CONFIG_PGTABLE_LEVELS > 3)
>> +#define pud_large(pud)    (pud_val(pud) && !(pud_val(pud) &
>> PUD_TABLE_BIT))
>> +#else
>> +#define pud_large(pmd) 0
>> +#endif
> 
> These seem rather different from the versions that Steve is proposing in
> the generic pagewalk series - can you reach an agreement on which
> implementation is preferred?

Indeed this doesn't match the version in my series although is quite
similar.

My desire is that p?d_large represents the hardware architectural
definition of large page/huge page/section (pick your naming). Although
now I look more closely this is actually broken in my series (I'll fix
that up and send a new version shortly) - p?d_sect() is similarly
conditional.

Is there a good reason not to use the existing p?d_sect() macros
available on arm64?

I'm also surprised by the CONFIG_PGTABLE_LEVEL conditions as they don't
match the existing conditions for p?d_sect(). Might be worth double
checking it actually does what you expect.

Steve
