Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFF9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3C20862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="VWznklJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbfJCSDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:03:19 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21767 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:03:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8492D3F6BB;
        Thu,  3 Oct 2019 20:03:16 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=VWznklJ6;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WyVX858MhJ0Q; Thu,  3 Oct 2019 20:03:15 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 56B7D3F6C6;
        Thu,  3 Oct 2019 20:03:12 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7768E36045B;
        Thu,  3 Oct 2019 20:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570125792; bh=GF/6FFSHugKxxdXl6zz5/RcxSTIvcJxXQzMLqjyEVXg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VWznklJ6n0kMQqXVmmtjzd79P17b+ulfFLyCH51ql0SSXWEZZUxCkS0fBXR5lH1lE
         NPdf2R3eI4WO+0SU+CSTdQcGOPNTWanD95BYsjkldc4mos9M2h7KttYU+1+gZmRqWq
         a3w48dyIelee8OhLI182zJh2EgVYmPH2o7xx8TGY=
Subject: Re: [PATCH v3 3/7] mm: Add write-protect and clean utilities for
 address space ranges
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
 <20191002134730.40985-4-thomas_os@shipmail.org>
 <CAHk-=wic5vXCxpH-+UTtmH_t-EDBKrKnDhxQk=t_N20aiWnqUg@mail.gmail.com>
 <516814a5-a616-b15e-ac87-26ede681da85@shipmail.org>
 <CAHk-=wgH=T5mcDxTaC6QbBN=iJD3d_amzcb2+GxbcV7XuEYL2A@mail.gmail.com>
 <MN2PR05MB61412DB4F703A5EE4F961593A19F0@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <a3aebf74-be74-bf15-f016-da9734ba435a@shipmail.org>
Date:   Thu, 3 Oct 2019 20:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj5NiFPouYd6zUgY4K7VovOAxQT-xhDRjD6j5hifBWi_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/19 6:55 PM, Linus Torvalds wrote:
>
>   d) Fix the pte walker to do the right thing, then just use separate
> pte walkers in your code
>
> The fix would be those two conceptual changes:
>
>   1) don't split if the walker asks for a pmd_entry (the walker itself
> can then decide to split, of course, but right now no walkers want it
> since there are no pmd _and_ pte walkers, because people who want that
> do the pte walk themselves)
>
>   2) get the proper page table lock if you do walk the pte, since
> otherwise it's racy
>
> Then there won't be any code duplication, because all the duplication
> you now have at the pmd level is literally just workarounds for the
> fact that our current walker has this bug.

I actually started on d) already when Kirill asked me to unify the 
pud_entry() and pmd_entry()
callbacks.

>
> That "fix the pte walker" would be one preliminary patch that would
> look something like the attached TOTALLY UNTESTED garbage.
>
> I call it "garbage" because I really hope people take it just as what
> it is: "something like this". It compiles for me, and I did try to
> think it through, but I might have missed some big piece of the
> picture when writing that patch.
>
> And yes, this is a much bigger conceptual change for the VM layer, but
> I really think our pagewalk code is actively buggy right now, and is
> forcing users to do bad things because they work around the existing
> limitations.
>
> Hmm? Could some of the core mm people look over that patch?
>
> And yes, I was tempted to move the proper pmd locking into the walker
> too, and do
>
>          ptl = pmd_trans_huge_lock(pmd, vma);
>          if (ptl) {
>                  err = ops->pmd_entry(pmd, addr, next, walk);
>                  spin_unlock(ptl);
>                  ...
>
> but while I think that's the correct thing to do in the long run, that
> would have to be done together with changing all the existing
> pmd_entry users. It would make the pmd_entry _solely_ handle the
> hugepage case, and then you'd have to remove the locking in the
> pmd_entry, and have to make the pte walking be a walker entry. But
> that would _really_ clean things up, and would make things like
> smaps_pte_range() much easier to read, and much more obvious (it would
> be split into a smaps_pmd_range and smaps_pte_range, and the callbacks
> wouldn't need to know about the complex locking).
>
> So I think this is the right direction to move into, but I do want
> people to think about this, and think about that next phase of doing
> the pmd_trans_huge_lock too.

>
> Comments?
>
>                  Linus

I think if we take the ptl lock outside the callback, we'd need to allow 
the callback to unlock to do non-atomic things or to avoid recursive 
locking if it decides to split in the callback. FWIW The pud_entry call 
is being made locked, but the only current implementation appears to 
happily ignore that from what I can tell.

And if we allow unlocking or call the callback unlocked, the callback 
needs to tell us whether the entry was actually handled or if we need to 
fallback to the next level. Perhaps using a positive PAGE_WALK_FALLBACK 
return value? That would allow current implementations to be unmodified.

/Thomas


