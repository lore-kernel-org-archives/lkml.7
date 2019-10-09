Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A04ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BDA206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570652474;
	bh=Jz+0zP6kjCebTLSMhZozTigwtKKdK+MEHwUAXZfkX3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RL0cIqMLopbu/vngi11JhH5X1hPuS4xJxD0MBl2CwWrfZlhyB6JO4ij3oIYCxHWfG
	 6TocgmQDCm8SbdR+KY7YTrxFsmGXE2Ndn+BOBEL/yL49i7A3ULYyWyOUzReICHyDAw
	 CEYTXMbvDGa4qi0odg1qv7vpJEm9/OCjdd8EoqtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfJIUVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:21:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38286 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIUVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:21:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so2636287lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GlgeX0Ygqdnp378F8QBhg6BFeJvuPAg5XojAuf1oJ2g=;
        b=UpSNO8QCClf9VcHjWM0Hjwto0+28wfNusUT00UXUQBjAmHOaa9HxF7bKTwbsA/vdE3
         NkRabkO+gobWSgMKvzL3uaBbwmDIJ5WFNwn4+/XpWySL+IwoDBhr4sVWyZTypkSLiMCA
         A/pO07zlE5BkaMfmai5ehv3kry48PHPYcjaUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GlgeX0Ygqdnp378F8QBhg6BFeJvuPAg5XojAuf1oJ2g=;
        b=DgwPl/FvMiQe22m7ZoSPC5/H/QtszyYhXRsUWtoCYzzqWEh+7rt644SETP6t0WSuq2
         UHm53TeLV7qW6oo5XbG6Y682unMb4Syts937JzPIdENpJskMNf7zEI8oeUqIRQ6+nXyE
         4auapA+vbID0INC8GMpA75t06X5s+xq3A4SL19zwBfhzPfSPSP76c/pDFEhzyoZ57IRm
         MfLkfbTb4MQ3F+hh9gbOkXXqJL73DIyWKzZP2VTht4ore8nHSw0CvQDdVnc/ny+ZG7s6
         0WuodKgXHOOZyoW6EdKLU6vzpg9iAEJ8mwHYLIRF+Vs2R+EwipYQrGgA6CuXNWv3Cjh9
         0HFQ==
X-Gm-Message-State: APjAAAWLc3CsFmeid3a6xW+tKkt1jlVoUSFPE8iHVUGjVBEvVtrKUQiw
        2+xu9/CPK9RpBniNgB6SSOROaqwcx3U=
X-Google-Smtp-Source: APXvYqw6d3PEQbDId2vwNzTL96CT73JRG/PoVKFnZvkwErcH7j0Z8pbHomHCdwzKImzCQ7/Ow0yAQw==
X-Received: by 2002:a19:6001:: with SMTP id u1mr3190422lfb.190.1570652469574;
        Wed, 09 Oct 2019 13:21:09 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 14sm724384ljs.71.2019.10.09.13.21.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 13:21:08 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d17so2635663lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:21:08 -0700 (PDT)
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr3299222lfo.61.1570652467845;
 Wed, 09 Oct 2019 13:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191008091508.2682-1-thomas_os@shipmail.org> <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box> <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org> <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
 <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
 <CAHk-=wgy-ULe8UmEDn9gCCmTtw65chS0h309WrTaQhK3RAXM-A@mail.gmail.com> <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org>
In-Reply-To: <c054849e-1e24-6b27-6a54-740ea9d17054@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Oct 2019 13:20:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
Message-ID: <CAHk-=wgmr-BPMTnSuKrAMoHL_A0COV_sZkdcNB9aosYfouA_fw@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 1:06 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 10/9/19 9:20 PM, Linus Torvalds wrote:
> >
> > Don't you get it? There *is* no PTE level if you didn't split.
>
> Hmm, This paragraph makes me think we have very different perceptions abo=
ut what I'm trying to achieve.

It's not about what you're trying to achieve.

It's about the actual code.

You cannot do that

> -               split_huge_pmd(walk->vma, pmd, addr);
> +               if (!ops->pmd_entry)
> +                       split_huge_pmd(walk->vma, pmd, addr);

it's insane.

You *have* to call split_huge_pmd() if you're doing to call the
pte_entry() function.

I don't understand why you are arguing. This is not about "feelings"
and "intentions" or about "trying to achieve".

This is about cold hard "you can't do that", and this is now the third
time I tell you _why_ you can't do that: you can't walk the last level
if you don't _have_ a last level. You have to split the pmd to do so.

End of story.

> I wanted the pte level to *only* get called for *pre-existing* pte entrie=
s.

Again, I told you what the solution was.

But the fact is, it's not what your other code even wants or does.

Seriously. You have two cases you care about in your callbacks

 - an actual hugepmd. This is an ERROR for you and you do a huge
WARN_ON() for it to let people know.

 - regular pages. This is what your other code actually handles.

So for the hugepomd case, you have two choices:

 - handle it by splitting and deal with the regular pages: "return 0;"

 - actually error out: "return -EINVAL".

There simply are no other choices from looking at the users you added.

> Surely those must be able to exist even if we don't split occasional huge=
 pmds in the pagewalk code?

And I told you how to handle that case when you eventually hit it.

But that is immaterial. Because it's not what you actually do right
now. Right now you have a huge WARN_ON().

                Linus
