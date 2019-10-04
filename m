Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E7C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA0C222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="EKp2245J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfJDM7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:59:11 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40572 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfJDM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:59:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E70573F26D;
        Fri,  4 Oct 2019 14:59:02 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=EKp2245J;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a6_p0rlj7ybT; Fri,  4 Oct 2019 14:59:01 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 539123F226;
        Fri,  4 Oct 2019 14:59:00 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8C520360377;
        Fri,  4 Oct 2019 14:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570193939; bh=qgSUkdiyuBtU2hbp/UlypVGgHsicKssCex7weSpn608=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EKp2245Jl7DGyJt5yKBuH8qGBjfgv55SJSimotyr1HR7WahlvBIHEHQhjvo/Vl1Da
         P5dyJfl3UytU6popJb4YPdblBMu3fjSg9RNNZmFNwbrJRTf6JdGLNcr1kz6H+96LgL
         lX0z1wyf2I2ioEh0YqjeVyCaWPwsClV6yqJk6kVc=
Subject: Re: [PATCH v3 2/7] mm: Add a walk_page_mapping() function to the
 pagewalk code
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-3-thomas_os@shipmail.org>
 <20191003111708.sttkkrhiidleivc6@box>
 <d336497b-3716-0748-d838-378902399439@shipmail.org>
 <20191004123732.xpr3vroee5mhg2zt@box.shutemov.name>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <8ef9fff3-df8d-cc14-35f9-d83db62e874f@shipmail.org>
Date:   Fri, 4 Oct 2019 14:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191004123732.xpr3vroee5mhg2zt@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 2:37 PM, Kirill A. Shutemov wrote:
> On Thu, Oct 03, 2019 at 01:32:45PM +0200, Thomas Hellström (VMware) wrote:
>>>> + *   If @mapping allows faulting of huge pmds and puds, it is desirable
>>>> + *   that its huge_fault() handler blocks while this function is running on
>>>> + *   @mapping. Otherwise a race may occur where the huge entry is split when
>>>> + *   it was intended to be handled in a huge entry callback. This requires an
>>>> + *   external lock, for example that @mapping->i_mmap_rwsem is held in
>>>> + *   write mode in the huge_fault() handlers.
>>> Em. No. We have ptl for this. It's the only lock required (plus mmap_sem
>>> on read) to split PMD entry into PTE table. And it can happen not only
>>> from fault path.
>>>
>>> If you care about splitting compound page under you, take a pin or lock a
>>> page. It will block split_huge_page().
>>>
>>> Suggestion to block fault path is not viable (and it will not happen
>>> magically just because of this comment).
>>>
>> I was specifically thinking of this:
>>
>> https://elixir.bootlin.com/linux/latest/source/mm/pagewalk.c#L103
>>
>> If a huge pud is concurrently faulted in here, it will immediatly get split
>> without getting processed in pud_entry(). An external lock would protect
>> against that, but that's perhaps a bug in the pagewalk code?  For pmds the
>> situation is not the same since when pte_entry is used, all pmds will
>> unconditionally get split.
> I *think* it should be fixed with something like this (there's no
> pud_trans_unstable() yet):
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d48c2a986ea3..221a3b945f42 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -102,10 +102,11 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   					break;
>   				continue;
>   			}
> +		} else {
> +			split_huge_pud(walk->vma, pud, addr);
>   		}
>   
> -		split_huge_pud(walk->vma, pud, addr);
> -		if (pud_none(*pud))
> +		if (pud_none(*pud) || pud_trans_unstable(*pud))
>   			goto again;
>   
>   		if (ops->pmd_entry || ops->pte_entry)

Yes, this seems better. I was looking at implementing a 
pud_trans_unstable() as a basis of fixing problems like this, but when I 
looked at pmd_trans_unstable I got a bit confused:

Why are devmap huge pmds considered stable? I mean, couldn't anybody 
just run madvise() to clear those just like transhuge pmds?

>
> Or better yet converted to what we do on pmd level.
>
> Honestly, all the code around PUD THP missing a lot of ground work.
> Rushing it upstream for DAX was not a right move.
>
>> There's a similar more scary race in
>>
>> https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L3931
>>
>> It looks like if a concurrent thread faults in a huge pud just after the
>> test for pud_none in that pmd_alloc, things might go pretty bad.
> Hm? It will fail the next pmd_none() check under ptl. Do you have a
> particular racing scenarion?
>
Yes, I misinterpreted the code somewhat, but here's the scenario that 
looks racy:

Thread 1		Thread 2
huge_fault(pud)					- Fell back, for example because of write fault on dirty-tracking.
			huge_fault(pud)         - Taken, read fault.
pmd_alloc()                                     - Will fail pmd_none check and return a pmd_offset()
                                                   into thread 2's THP.

Thanks,

Thomas



