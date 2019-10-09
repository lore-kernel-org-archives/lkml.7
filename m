Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F96ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B56206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570665101;
	bh=E1F6WKziMqYeAi5atS+9aJXtkW3YjvmSbcvllZPeV3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KssIe5LYAR7eEJWk4Mcadhgl3b3ah6bazzTzhyqP8uIWWuZQIVlB9wd+YRi8wRAXf
	 AlPJAsYSqm80Hpohl2bQM/MjASMHm2DSfxnYTz+q+KcQ7w7uAGB35eXpLY1+9eTpGS
	 0DZVvwrqrPXHDspEcUu3thLKwmQZuyAGB5BB0Syg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfJIXvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:51:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34584 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfJIXvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:51:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so4299952lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wN7eqaqgD8PGnx2NdYBPvo9kkG4OlPB7dBtrZrIzXFA=;
        b=aD3fPhV2qay24ISNCu4cfRObh/9NFabmR3Y+GVWglK2FIeQAuwtd7Qm+mAPFhVfecE
         f77w4Tnj2SKlLiFDd1jdP3SK1LyxgX1BdAAvZEIbErEcqPbJB0da7SFr3Gauo5qRmM3X
         iJMsS/tVcZh74nnwa/aYy8FkvNGa2MtphZqrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wN7eqaqgD8PGnx2NdYBPvo9kkG4OlPB7dBtrZrIzXFA=;
        b=RnlapDyL/YIz+zaFJ2oGACeiBMURA8dhLVr4xFgR1jSCSVare/O/4Fp36iNh3wFn6Z
         tWOvyYS7e7CESjkKUnTLEEeeVcYD2Poo9Uep/sdRaeUtitGS6EZ0U4sLKP8dnl+F5ibL
         qRXczLzh8fr0H7M54nnBjh9I/wT2EMdVE5LPkGI29PG+i2Ac9pQFnQ/ex6Mbu6RSfVBa
         QNUWWksTHFHsA/k2ngN91Lnnx9Yt6ZUn7y3q3sCW0r9k8OOyevyrQoi51M4+IVVccW+V
         5d6Dh5oVU1eSiV5q0ZXNW4FxdFlWqpG+F4bQkcZbLOsww8GMPGd79v8PskVdEPpbees2
         G/LA==
X-Gm-Message-State: APjAAAXDeSHjKhYpVPVZ+ZnsIjwLzwADHOd6q0NcfXN+rkcq2onBb1Nj
        2EDmYYMzbZVFQ2cKTMd5R/TYJ1VaBTM=
X-Google-Smtp-Source: APXvYqwLoncw6zjhjkr7T26+0YyE7eh+ELP64s4mWEP3ZtgmWCsDOJ2TpOYLMEv7XmGmrap6mM9SDQ==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr3871679ljk.152.1570665097181;
        Wed, 09 Oct 2019 16:51:37 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t10sm771622ljt.68.2019.10.09.16.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 16:51:36 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id b20so4258429ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:51:36 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr3973606ljr.1.1570665095619;
 Wed, 09 Oct 2019 16:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org> <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
 <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org> <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
 <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
In-Reply-To: <80f25292-585c-7729-2a23-7c46b3309a1a@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 16:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
Message-ID: <CAHk-=wg6n_nGRtJd4MeXZrA5QrrVViJeO4x2w37KDbcDmTh3dg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 3:31 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 10/9/19 10:20 PM, Linus Torvalds wrote:
> >
> > You *have* to call split_huge_pmd() if you're doing to call the
> > pte_entry() function.
> >
> > End of story.
>
> So is it that you want pte_entry() to be strictly called for *each*
> virtual address, even if we have a pmd_entry()?

Thomas, you're not reading the emails.

You are conflating two issues:

 (a) the conditional split_huge_pmd()

 (b) the what to do about the return value of pmd_entry().

and I'm now FOR THE LAST TIME telling you that (a) is completely
wrong, buggy crap. It will not happen. I missed that part of the patch
in my original read-through, because it was so senseless.

Get it through you head. The "conditional split_huge_pmd()" thing is
wrong, wrong, wrong.

And it is COMPLETELY WRONG regardless of any "each virtual address"
thing that you keep bringing up. The "each virtual address" argument
is irrelevant, pointless, and does not matter.

So stop bringing that thing up. Really. The conditional
split_huge_pmd() is wrong.

It's wrong,  because the whole notion of "don't split pmd and then
call the pte walker" is completely idiotic and utterly senseless,
because without the splitting the pte's DO NOT EXIST.

What part of that is not getting through?

> In that case I completely follow your arguments, meaning we skip this
> patch completely?

Well, yes and no.

The part of the patch that is complete and utter garbage, and that you
really need to *understand* why it's complete and utter garbage is
this part:

                if (!ops->pte_entry)
                        continue;
-
-               split_huge_pmd(walk->vma, pmd, addr);
+               if (!ops->pmd_entry)
+                       split_huge_pmd(walk->vma, pmd, addr);
                if (pmd_trans_unstable(pmd))
                        goto again;
                err =3D walk_pte_range(pmd, addr, next, walk);

Look, you cannot call "walk_pte_range()" without calling
split_huge_pmd(), because walk_pte_range() cannot deal with a huge
pmd.

walk_pte_range() does that pte_offset_map() on the pmd (well, with
your other patch in place it does the locking version), and then it
walks every pte entry of it. But that cannot possibly work if you
didn't split it.

See what I've been trying tog tell you? YOU CANNOT MAKE THAT SPLITTING
BE CONDITIONAL!

What can be done - and what the line above it does - is to skip
walking entirely. We do it when we don't have a pte_entry walker at
all, obviously.

But we can't do is "oh, we had a pmd walker, so now I'll skip
splitting". That is insane, and cannot possibly make sense.

Now, that gets us back to the (b) part above - what to do about the
return value of "pmd_entry()".

What *would* make sense, for example, is saying "ok, pmd_entry()
already handled this, so we'll just continue, and not bother with the
pte_range() at all".

Note how that is VERY VERY different from "let's not split".

Yes, for that case we also don't split, but we don't split because
we're not even walking it. See the difference?

Not splitting and then walking: wrong, insane, and not going to happen.

Nor splitting because we're not going to walk it: sane, and we already
have one such case.

> My take on the change was that pmd_entry() returning 0 would mean we
> could actually skip the pte level completely and nothing would otherwise
> pass down to the next level for which split_huge_pmd() wasn't a NOP,
> similar to how pud_entry does things.

And that would have been a sensible operation, and yes, you had that

+                       if (!err)
+                               continue;

and that was it. Fine.

BUT.

That was not all that your patch did. Kirill felt that your
PAGE_WALK_FALLBACK thing was hacky, which is why I looked more at the
patch to see what it really wanted to do, and noticed that crazy
conditional splitting that didn't make sense, and has *NOTHING* to do
with your "skip the level completely".

I _agree_ that skipping the level completely makes sense.

But the "don't split and then don't skip the level" makes zero sense
what-so-ever. Ever. Under no circumstances can that be valid as per
above.

There's also the argument that right now, there are no users that
actually want to skip the level.

Even your use case doesn't really want that, because in your use-case,
the only case that would do it is the error case that isn't supposed
to happen.

And if it *is* supposed to happen, in many ways it would be more
sensible to just return a positive value saying "I took care of it, go
on to the next entry", wouldn't you agree?

Now, I actually tried to look through every single existing pmd_entry
case, because I wanted to see who is returning positive values right
now, and which of them might *want* to say "ok, I handled it" or "now
do the pte walking".

Quite a lot of them seem to really want to do that "ok, now do the pte
walking", because they currently do it inside the pmd function because
of how the original interface was badly done. So while we _currently_
do not have a "ok, I did everything for this pmd, skip it" vs a "ok,
continue with pte" case, it clearly does make sense. No question about
it.

I did find one single user of a positive return value:
queue_pages_pte_range() returns

 * 0 - pages are placed on the right node or queued successfully.
 * 1 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
 *     specified.
 * -EIO - only MPOL_MF_STRICT was specified and an existing page was alread=
y
 *        on a node that does not follow the policy.

to match queue_pages_range(), but that function has two callers:

 - the first ignores the return value entirely

 - the second would be perfectly fine with -EBUSY as a return value
instead, which would actually make more sense.

Everybody else returns 0 or a negative error, as far as I can tell.

End result:

 (a) right now nobody wants the "skip" behavior. You think you'll
eventually want it

 (b) right now, the "return positive value" is actually a horribly
ugly pointless hack, which could be made to be an error value and
cleaned up in the process

 (c) to me that really argues that we should just make the rule be

     - negative error means break out with error

     - 0 means continue down the next level

     - positive could be trivially be made to just mean "ok, I did it,
you can just continue".

and I think that would make a lot of sense.

So I do think we can get rid of the PAGE_WALK_FALLBACK hack entirely.
It becomes "return 0", which is what everybody really does right now.
If there's a pte_entry(), it will split and call that pte_entry for
each pte, the way it does now. Sensible and simple.

And then - for _future_ uses - we can add that "positive return value
means that I already handled it" and the walker would just skip to the
next entry.

But - again - in no alternate reality, past, future or present, does
it make sense to skip the splitting if you walk pte's.

               Linus
