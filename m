Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B77C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6361F218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="SFc+lpia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbfJIWbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:31:04 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:56458 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbfJIWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:31:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id B2C6A3FC4D;
        Thu, 10 Oct 2019 00:30:55 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=SFc+lpia;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PB4vzlwCoQlL; Thu, 10 Oct 2019 00:30:54 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id F01223FC5F;
        Thu, 10 Oct 2019 00:30:50 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4FCC13600A4;
        Thu, 10 Oct 2019 00:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570660250; bh=xLq6mlUzqsfrlLQEbGLDSaiVAsnEbL9m0HBY5Z4lgls=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SFc+lpia0lDB6X6OZyq0vMGyOoZJ4Z0Y/OHj02v/e2yplb/kQ3pO23hC8FbXn4RJ2
         BjGpYH5DaYvQU845eooL46Ynk5ePu1BpemDezEIA3CAHw4louz0TU9u7C30WqmHRrb
         wTJQz+phJEJ/aCEuTENzrGjXclkIxw4g+yBPPlfY=
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
 <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org>
 <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
 <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org>
 <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
Date:   Thu, 10 Oct 2019 00:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 10:20 PM, Linus Torvalds wrote:
> On Wed, Oct 9, 2019 at 1:06 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> On 10/9/19 9:20 PM, Linus Torvalds wrote:
>>> Don't you get it? There *is* no PTE level if you didn't split.
>> Hmm, This paragraph makes me think we have very different perceptions about what I'm trying to achieve.
> It's not about what you're trying to achieve.
>
> It's about the actual code.
>
> You cannot do that
>
>> -               split_huge_pmd(walk->vma, pmd, addr);
>> +               if (!ops->pmd_entry)
>> +                       split_huge_pmd(walk->vma, pmd, addr);
> it's insane.
>
> You *have* to call split_huge_pmd() if you're doing to call the
> pte_entry() function.
>
> I don't understand why you are arguing. This is not about "feelings"
> and "intentions" or about "trying to achieve".
>
> This is about cold hard "you can't do that", and this is now the third
> time I tell you _why_ you can't do that: you can't walk the last level
> if you don't _have_ a last level. You have to split the pmd to do so.
It's not so much arguing but rather trying to understand your concerns 
and your perception of what the final code should look like.
>
> End of story.

So is it that you want pte_entry() to be strictly called for *each* 
virtual address, even if we have a pmd_entry()?
In that case I completely follow your arguments, meaning we skip this 
patch completely?

My take on the change was that pmd_entry() returning 0 would mean we 
could actually skip the pte level completely and nothing would otherwise 
pass down to the next level for which split_huge_pmd() wasn't a NOP, 
similar to how pud_entry does things. FWIW, see

https://lore.kernel.org/lkml/20191004123732.xpr3vroee5mhg2zt@box.shutemov.name/

and we could in the long run transform the pte walk in many pmd_entry 
callbacks into pte_entry callbacks.


>
>> I wanted the pte level to *only* get called for *pre-existing* pte entries.
> Again, I told you what the solution was.
>
> But the fact is, it's not what your other code even wants or does.
>
> Seriously. You have two cases you care about in your callbacks
>
>   - an actual hugepmd. This is an ERROR for you and you do a huge
> WARN_ON() for it to let people know.
No, it's typically a NOP, since the hugepmd should be read-only. 
Write-enabled huge pages are split in fault().
>
>   - regular pages. This is what your other code actually handles.
>
> So for the hugepomd case, you have two choices:
>
>   - handle it by splitting and deal with the regular pages: "return 0;"
Well, this is not what we want to do, and the reason we have the patch 
in the first place.
>
>   - actually error out: "return -EINVAL".

/Thomas


