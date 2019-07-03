Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989FC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7319721881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 05:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHbczLFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCFyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:54:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45469 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:54:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so971735lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 22:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fodI9RBCNqef8mpe31lNAJ/C8aPx3qCPQdaIULFPQEE=;
        b=AHbczLFRfqjuasmjmf30Hp49qfV0kAllz4rzpXWdPTIk4/ZlCNK3n/2EkaNRwYdgbz
         X+cN1RcUD9z36Tgkn2j1xJtIDZYR8Fht7jHZ/tMm4ZcIxsyU60SOhe/boS6RwAnsXUJo
         X5J8ToDtvEIH/qsrWau/X0ci+4WSMh89blfdBk66hBhOxobWrJ2qD8o9ZcEQGbqHbRBp
         x98npKojErQCAkBd65rFWVqeJfetB9Eo8/8KJ8O3sa4sy2+ZAFvp8qNadLIbuyNccfhf
         cp+k5AgU1VUR+Tk6JLRN/QSawNvIrPCeZdT/pV2Yk23NdGrbnxVXdeUMAsgH+KKqWd8L
         5NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fodI9RBCNqef8mpe31lNAJ/C8aPx3qCPQdaIULFPQEE=;
        b=mt1Bmxr7ZybQ7vpwmOL9vcH1EyydBRnUsId0O+hAbBbN/wGTxBde52mQy0QaY55Da8
         B+wXGqroSkGDc1KMFK6z2UgO7sIdLy+HabtIcgwli6kWhHePiKEWs7oayiDztjNMFJpn
         txRM2+2pTLY2L7f40dgagHtjZQ5Kv95mhIxIOXbh2984ZestZZWuyDIwMErYhM6NJOfF
         HZtLwBl8F9EQtORVb62NpWr75FXMMwRGeohR2yBgF068huuxsKzd8YhUbd9Z+mkjNGYV
         jia0cJ49Grdgv6ZiY3hF0p/yFUHq8MLB/WzGms1h7a6BRakS78IjPQ3KsNVwnK/x33Ei
         sAKA==
X-Gm-Message-State: APjAAAXKrNQHp3mkHimcPF4AjoYudfn9cTqmsT7Ly8D2q745fb/p73qG
        t7orIaPNtQpPtUF38SNtEwT8M6IEMPdZwmV8RQ4=
X-Google-Smtp-Source: APXvYqwQEFSscdGA01+RoCapFWC3y9tcFL0+T1GOAo2m1WR3EkamuBGmQ24dndljkFKzDHi1wqKgkanBahuRl8HlrgY=
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr5330522ljg.168.1562133270780;
 Tue, 02 Jul 2019 22:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com> <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
 <CAGQXPTjU0xAWCLTWej8DdZ5TbH91m8GzeiCh5pMJLQajtUGu_g@mail.gmail.com>
 <20190702141930.e31bf1c07a77514d976ef6e2@linux-foundation.org>
 <CAGQXPTiONoPARFTep-kzECtggS+zo2pCivbvPEakRF+qqq9SWA@mail.gmail.com> <20190702152409.21c6c3787d125d61fb47840a@linux-foundation.org>
In-Reply-To: <20190702152409.21c6c3787d125d61fb47840a@linux-foundation.org>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Wed, 3 Jul 2019 07:53:32 +0200
Message-ID: <CAMJBoFOhXP36L6pZEA-7p24mJweDGe9iYb2fo1nNCxadYHcPzQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Henry Burns <henryburns@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:24 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 2 Jul 2019 15:17:47 -0700 Henry Burns <henryburns@google.com> wrote:
>
> > > > > > +       if (can_sleep) {
> > > > > > +               lock_page(page);
> > > > > > +               __SetPageMovable(page, pool->inode->i_mapping);
> > > > > > +               unlock_page(page);
> > > > > > +       } else {
> > > > > > +               if (!WARN_ON(!trylock_page(page))) {
> > > > > > +                       __SetPageMovable(page, pool->inode->i_mapping);
> > > > > > +                       unlock_page(page);
> > > > > > +               } else {
> > > > > > +                       pr_err("Newly allocated z3fold page is locked\n");
> > > > > > +                       WARN_ON(1);
>
> The WARN_ON will have already warned in this case.
>
> But the whole idea of warning in this case may be undesirable.  We KNOW
> that the warning will sometimes trigger (yes?).  So what's the point in
> scaring users?

Well, normally a newly allocated page that we own should not be locked
by someone else so this is worth a warning IMO. With that said, the
else branch here appears to be redundant.

~Vitaly
