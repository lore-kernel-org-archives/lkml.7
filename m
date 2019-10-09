Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD347C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FABE20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570648860;
	bh=x0u3S30mcubcHvtacAww+Z9a66+nZ65gq2CzKM+6820=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NSzd8gr5mBsV+UcywtmND3SLH5DczwE4uvzuz+ePAkQ2u8ePBwEsTuaXQgnG3ZZo3
	 M+aW6Yf1yY05vQLkdwC6/x7dKXXDhTgzSf9r5ybb7aLwmeYemqfAftGGn5iwycoIra
	 lDZJjGiAufirn91p9QVeDqU7gyVr8rx2H0JnGVw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfJITU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:20:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45347 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:20:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so3629824ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPeGPmQ1EwLkB4czEwZbdMTSScSNuUeFvbx9+vGLyj8=;
        b=D46ylTyFQpmTxNtqelt7zxhnC3byp9q3f9PTo/a94ejiNeNdqMcUWmos4AUnosIsO+
         gqTW1DrlrDqXpkljL0stS9FtPlLnIfQBa4RDyvr49Gwqkoi+iy05ObLtvffsIACoNTqi
         qysGIPlWJMMJH9gr+V7z0SS/H1hLxX17nBkyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPeGPmQ1EwLkB4czEwZbdMTSScSNuUeFvbx9+vGLyj8=;
        b=RXeL61DmEaBPdjWYolZzr91RG+oqnUhpI/vhJFEeJuql1KJoEeunGP61oOGPey6CV2
         w0W7Ei+Ce9yJzebSuCPD+l7ppQ6x1Pk8X87JOukbDt71qUuAMb6zeErpTq+NHBggGTM4
         tp+lQCYJ73b1/m5eEBcbzFzcB1XxyV61Qbp0djy+T8wmLQmQGdcxkImBdnX/rOufntUY
         10sb2s0ZAyfawjiRF1nT/tZU5Mr8IkfpMNXgYt5IJRdHDkPAP2K8f7N/GVCTTvqq2+iC
         B/YZFn0Lwkz6yqXjOim0kekHsXDp6Aqnx72t1mtyXqGgp+kXS/0+kurCib/zbfRfyOmy
         2hIA==
X-Gm-Message-State: APjAAAWBF0+b+CwZOEuhNiutcSnUtg2j4LcqtdOINuUnU8e8sjmZNTRr
        73/uV23BSBsiDGuU5jvFy8FSD0PsyR0=
X-Google-Smtp-Source: APXvYqxufdZ7xNOm4LkDwVnfo5KUA9bJ1S0YWam7aAdfp/tmAIGj+3xWW1/DZxFE222crVHjPX6DCg==
X-Received: by 2002:a2e:9816:: with SMTP id a22mr3286336ljj.206.1570648855683;
        Wed, 09 Oct 2019 12:20:55 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y3sm716522lfh.97.2019.10.09.12.20.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 12:20:53 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q12so2497547lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 12:20:53 -0700 (PDT)
X-Received: by 2002:ac2:5306:: with SMTP id c6mr3143152lfh.106.1570648853109;
 Wed, 09 Oct 2019 12:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org> <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
In-Reply-To: <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 12:20:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
Message-ID: <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 11:52 AM Thomas Hellstrom <thellstrom@vmware.com> wrote:
>
> Hmm, so we have the following cases we need to handle when returning
> from the pmd_entry() handler.

No, we really don't.

> 1) Huge pmd was handled - Returns 0 and continues.

No.

That case simply DOES NOT EXIST.

The only case that exists is

"pmd was seen, we return 0 and then look at wherer pte level is relevant".

Note that this has nothing to do with huge or not.

> 2) A pmd is otherwise unstable, typically someone just zapped a huge
> pmd. Returns PAGE_WALK_FALLBACK, gets caught in the pmd_trans_unstable()
> test and retries.

No. PAGE_WALK_FALLBACK doesn't exist, is completely broken in your
patch, and is immaterial.

It falls under the previous heading: a pmd was seen, returns zero, and
we go on with life.

If you don't have a pte callback - like EVERY SINGLE CURRENT USER -
that "goes on with life" is just "go to the next pmd entry".

And if you do have a pte callback - like your new case, that "go on
with life" is to look at the pte cases.

> 3) A pte directory - Returns PAGE_WALK_FALLBACK, falls through, avoids
> the split and continues to the next level. Yeah that split avoidance
> test is indeed made unnecessary by the preceding pmd_trans_unstable() test.

Again, no. This case does not exist. It's the same case as above: it
returns 0 and goes on to the pte level.


> -               split_huge_pmd(walk->vma, pmd, addr);
> +               if (!ops->pmd_entry)
> +                       split_huge_pmd(walk->vma, pmd, addr);
>
> But as the commit message says, PAGE_WALK_FALLBACK is necessary to have
> a virtual address range being handled once and only once.

No. Your logic is garbage. The above code is completely broken.

YOU CAN NOT AVOID TRHE SPLIT AND THEN GO ON AT THE PTE LEVEL.

Don't you get it? There *is* no PTE level if you didn't split.

And your "being handled once and only once" is garbage too. If you ask
for both a pmd callback and a pte callback, you get both. It's that
simple.

There are zero users that actually do it now, and you don't want to do
it either, so all your arguments are just pointless.

> So we need the PAGE_WALK_FALLBACK.

No we don't. You make no sense. Your case doesn't want it, no existing
cases want it, nobody wants it.

When you actually have a case that wants it, let's look at it then.
Right now, you introduced fundamentally buggy code because your
thinking is fuzzy and broken.

So what you should do is to just always return 0 in your pmd_entry().
Boom, done. The only reason for the pmd_entry existing at all is to
get the warning. Then, if you don't want to split it, you make that
warning just return an error (or a positive value) instead and say
"ok, that was bad, we don't handle it at all".

And in some _future_ life, if anybody wants to actually say "yeah,
let's not split it", make it have some "yeah I handled it" case.

In fact, I would suggest that positive return values be exactly that
"I did it" case, and that they just add up instead of breaking out.
Only an actual error would break out, and 0 would then (continue to)
mean "continue with next level".

But right now, no such user even exists.

               Linus
