Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F66C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975E32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="WwLE8t7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfJJBKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:10:01 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:22274 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfJJBKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:10:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2537C3F9B2;
        Thu, 10 Oct 2019 03:09:53 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=WwLE8t7s;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vbBQEgZy4jr5; Thu, 10 Oct 2019 03:09:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 729EA3F5AE;
        Thu, 10 Oct 2019 03:09:46 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C64E33600A4;
        Thu, 10 Oct 2019 03:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570669785; bh=yhoqZq1dWFgqwXfLKur8dWwpo5yJEUMTDoY2BRrUUyc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WwLE8t7seTqc3s5L3lr09eRAyIIXPrg48QruZoC7H/rBglxE212WMVkSjJClT5Ouc
         5W0CgKzjFbBjp9gC8R3oJekSD6w5a7C4JrsILOjE8QJbKzm5ya8MYf8+WXDkhp+Vdz
         Lcr6QLMI1zJvqZ/WCI3+j24iY8xWCEXuxk9t0VRk=
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
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
 <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <6d3ef513-ca9d-9778-10da-86f368a57cd0@shipmail.org>
Date:   Thu, 10 Oct 2019 03:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/19 1:51 AM, Linus Torvalds wrote:
> On Wed, Oct 9, 2019 at 3:31 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> On 10/9/19 10:20 PM, Linus Torvalds wrote:
>>> You *have* to call split_huge_pmd() if you're doing to call the
>>> pte_entry() function.
>>>
>>> End of story.
>> So is it that you want pte_entry() to be strictly called for *each*
>> virtual address, even if we have a pmd_entry()?
> Thomas, you're not reading the emails.
>
> You are conflating two issues:
>
>   (a) the conditional split_huge_pmd()
>
>   (b) the what to do about the return value of pmd_entry().
>
> and I'm now FOR THE LAST TIME telling you that (a) is completely
> wrong, buggy crap. It will not happen. I missed that part of the patch
> in my original read-through, because it was so senseless.
>
> Get it through you head. The "conditional split_huge_pmd()" thing is
> wrong, wrong, wrong.
>
> And it is COMPLETELY WRONG regardless of any "each virtual address"
> thing that you keep bringing up. The "each virtual address" argument
> is irrelevant, pointless, and does not matter.
>
> So stop bringing that thing up. Really. The conditional
> split_huge_pmd() is wrong.
>
> It's wrong,  because the whole notion of "don't split pmd and then
> call the pte walker" is completely idiotic and utterly senseless,
> because without the splitting the pte's DO NOT EXIST.
>
> What part of that is not getting through?
>
>> In that case I completely follow your arguments, meaning we skip this
>> patch completely?
> Well, yes and no.
>
> The part of the patch that is complete and utter garbage, and that you
> really need to *understand* why it's complete and utter garbage is
> this part:
>
>                  if (!ops->pte_entry)
>                          continue;
> -
> -               split_huge_pmd(walk->vma, pmd, addr);
> +               if (!ops->pmd_entry)
> +                       split_huge_pmd(walk->vma, pmd, addr);
>                  if (pmd_trans_unstable(pmd))
>                          goto again;
>                  err = walk_pte_range(pmd, addr, next, walk);
>
> Look, you cannot call "walk_pte_range()" without calling
> split_huge_pmd(), because walk_pte_range() cannot deal with a huge
> pmd.
>
> walk_pte_range() does that pte_offset_map() on the pmd (well, with
> your other patch in place it does the locking version), and then it
> walks every pte entry of it. But that cannot possibly work if you
> didn't split it.

Thank you for your patience!

Yes, I very well *do* understand that we need to split a huge pmd to 
walk the pte range, and I've never been against removing that 
conditional. What I've said is that it is pointless anyway, because 
we've already verified that the only path coming from the pmd_entry 
(with the patch applied) has the pmd *already split* and stable.

Your original patch does exactly the same!

So please let's move on from the splitting issue. We don't disagree 
here. The conditional is gone to never be resurrected.

>
> Now, that gets us back to the (b) part above - what to do about the
> return value of "pmd_entry()".
>
> What *would* make sense, for example, is saying "ok, pmd_entry()
> already handled this, so we'll just continue, and not bother with the
> pte_range() at all".
>
> Note how that is VERY VERY different from "let's not split".
>
> Yes, for that case we also don't split, but we don't split because
> we're not even walking it. See the difference?
>
> Not splitting and then walking: wrong, insane, and not going to happen.
>
> Nor splitting because we're not going to walk it: sane, and we already
> have one such case.
>
> But the "don't split and then don't skip the level" makes zero sense
> what-so-ever. Ever. Under no circumstances can that be valid as per
> above.

Agreed.

>
> There's also the argument that right now, there are no users that
> actually want to skip the level.
>
> Even your use case doesn't really want that, because in your use-case,
> the only case that would do it is the error case that isn't supposed
> to happen.
>
> And if it *is* supposed to happen, in many ways it would be more
> sensible to just return a positive value saying "I took care of it, go
> on to the next entry", wouldn't you agree?

Indeed.

>
> Now, I actually tried to look through every single existing pmd_entry
> case, because I wanted to see who is returning positive values right
> now, and which of them might *want* to say "ok, I handled it" or "now
> do the pte walking".
>
> Quite a lot of them seem to really want to do that "ok, now do the pte
> walking", because they currently do it inside the pmd function because
> of how the original interface was badly done. So while we _currently_
> do not have a "ok, I did everything for this pmd, skip it" vs a "ok,
> continue with pte" case, it clearly does make sense. No question about
> it.
>
> I did find one single user of a positive return value:
> queue_pages_pte_range() returns
>
>   * 0 - pages are placed on the right node or queued successfully.
>   * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
>   *     specified.
>   * -EIO - only MPOL_MF_STRICT was specified and an existing page was already
>   *        on a node that does not follow the policy.
>
> to match queue_pages_range(), but that function has two callers:
>
>   - the first ignores the return value entirely
>
>   - the second would be perfectly fine with -EBUSY as a return value
> instead, which would actually make more sense.
>
> Everybody else returns 0 or a negative error, as far as I can tell.
>
> End result:
>
>   (a) right now nobody wants the "skip" behavior. You think you'll
> eventually want it
>
>   (b) right now, the "return positive value" is actually a horribly
> ugly pointless hack, which could be made to be an error value and
> cleaned up in the process
>
>   (c) to me that really argues that we should just make the rule be
>
>       - negative error means break out with error
>
>       - 0 means continue down the next level
>
>       - positive could be trivially be made to just mean "ok, I did it,
> you can just continue".
>
> and I think that would make a lot of sense.
>
Sure. I'm fine with this. So for next spin, I'll skip this patch, and do 
the positive value rework as part of the prerequisites for the huge page 
enablement. IIRC there is another user of positive values that should be 
trivial to fix.

Does that sound OK?

Thanks,

Thomas


