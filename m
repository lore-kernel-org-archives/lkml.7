Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71422087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfC0Myo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:54:44 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:35867 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0Myn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:54:43 -0400
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4CC6A20000A;
        Wed, 27 Mar 2019 12:54:35 +0000 (UTC)
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
 <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
 <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
 <87pnqcws2u.fsf@linux.ibm.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <95819dc9-7910-f273-681c-a241fee62dd2@ghiti.fr>
Date:   Wed, 27 Mar 2019 13:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87pnqcws2u.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2019 11:05 AM, Aneesh Kumar K.V wrote:
> Alexandre Ghiti <alex@ghiti.fr> writes:
>
>> On 03/27/2019 09:55 AM, Aneesh Kumar K.V wrote:
>>> On 3/27/19 2:14 PM, Alexandre Ghiti wrote:
>>>>
>>>> On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
>>>>> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
> .....
>
>>> This is now
>>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>>> static inline bool gigantic_page_runtime_supported(void)
>>> {
>>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>>          return false;
>>>
>>>      return true;
>>> }
>>>
>>>
>>> I am wondering whether it should be
>>>
>>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>>> static inline bool gigantic_page_runtime_supported(void)
>>> {
>>>
>>>     if (!IS_ENABLED(CONFIG_CONTIG_ALLOC))
>>>          return false;
>> I don't think this test should happen here, CONFIG_CONTIG_ALLOC only allows
>> to allocate gigantic pages, doing that check here would prevent powerpc
>> to free boottime gigantic pages when not a guest. Note that this check
>> is actually done in set_max_huge_pages.
>>
>>
>>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>>          return false;
>> Maybe I did not understand this check: I understood that, in the case
>> the system
>> is virtualized, we do not want it to hand back gigantic pages. Does this
>> check
>> test if the system is currently being virtualized ?
>> If yes, I think the patch is correct: it prevents freeing gigantic pages
>> when the system
>> is virtualized but allows a 'normal' system to free gigantic pages.
>>
>>
> Ok double checked the patch applying the the tree. I got confused by the
> removal of that #ifdef. So we now disallow the runtime free by checking
> for gigantic_page_runtime_supported() in  __nr_hugepages_store_common.
> Now if we allow and if CONFIG_CONTIG_ALLOC is disabled, we still should
> allow to free the boot time allocated pages back to buddy.
>
> The patch looks good. You can add for the series
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> -aneesh
>

Thanks for your time Aneesh,

Alex
