Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F2C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F0F218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="GeA+SrrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfJIXu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:50:59 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:26992 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbfJIXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:50:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 400B83F839;
        Thu, 10 Oct 2019 01:50:56 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GeA+SrrO;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ibc0yJzAbMJS; Thu, 10 Oct 2019 01:50:55 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id CB6493F835;
        Thu, 10 Oct 2019 01:50:50 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 187533600A4;
        Thu, 10 Oct 2019 01:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570665050; bh=/mXBG9fUSN09uVUSznrWUrKQ++9rbFkU/mzTR08+/2s=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=GeA+SrrOMNr6lhvJ2Q2/28UsCPDub1BZHgWz7m2Vu71tMVhQutH2OkL+5nlJ0ZoBZ
         l9thmhwXVC4yToimTkvopjgKI3JUiihZt36pN9rXKZp8+GGbmtoYcf0R0KEFUAR1bn
         BKzVILbWZSfanwjBHnBP10es3FeULLF0MnsWrJ6U=
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
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
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
Organization: VMware Inc.
Message-ID: <54e65cdd-1b6a-d4d6-0305-dcb36bc49c41@shipmail.org>
Date:   Thu, 10 Oct 2019 01:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 12:30 AM, Thomas Hellström (VMware) wrote:
> On 10/9/19 10:20 PM, Linus Torvalds wrote:
>> On Wed, Oct 9, 2019 at 1:06 PM Thomas Hellström (VMware)
>> <thomas_os@shipmail.org> wrote:
>>> On 10/9/19 9:20 PM, Linus Torvalds wrote:
>>>> Don't you get it? There *is* no PTE level if you didn't split.
>>> Hmm, This paragraph makes me think we have very different 
>>> perceptions about what I'm trying to achieve.
>> It's not about what you're trying to achieve.
>>
>> It's about the actual code.
>>
>> You cannot do that
>>
>>> - split_huge_pmd(walk->vma, pmd, addr);
>>> +               if (!ops->pmd_entry)
>>> +                       split_huge_pmd(walk->vma, pmd, addr);
>> it's insane.
>>
>> You *have* to call split_huge_pmd() if you're doing to call the
>> pte_entry() function.
>>
>> I don't understand why you are arguing. This is not about "feelings"
>> and "intentions" or about "trying to achieve".
>>
>> This is about cold hard "you can't do that", and this is now the third
>> time I tell you _why_ you can't do that: you can't walk the last level
>> if you don't _have_ a last level. You have to split the pmd to do so.
> It's not so much arguing but rather trying to understand your concerns 
> and your perception of what the final code should look like.
>>
>> End of story.
>
> So is it that you want pte_entry() to be strictly called for *each* 
> virtual address, even if we have a pmd_entry()?
> In that case I completely follow your arguments, meaning we skip this 
> patch completely?

Or if you're still OK with your original patch

https://lore.kernel.org/lkml/CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com/

I'd happily use that instead.

Thanks,

Thomas


