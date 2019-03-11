Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1422C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9920643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326115;
	bh=j5S4QIfQLetUtid3JlR7CweXW0AlURoY5LfQbzy+GSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lRqHRHo18bN/kKlMt41y1vR+iCrkgt2bogtBp4ZLySO3Ji0JvqifNFOxO4iZqGSQm
	 nHOu3+lpDTQ/WXYAO06pAfXEjQhpG3JoJSOJg9MhQB4MZhDGYE8DgLc5yXp+//KFgI
	 CbvHCp2C0nYDcAAz5244YkMbfBIKvFM3DVXE9OJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCKRly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:41:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:41:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id w6so4863576ljd.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH0CO1nPZn884rt25Op3paRqxY7GEy9+iKKPeIy9v0s=;
        b=UZgfk5LHZ7YUR9c8z5B1Pk0v0gQ6hUpPLg1jlh4hgI0sHVLYqORKigaYlE5xDT894T
         y4VaOZCfchBXd1iU8R4RliirZisogyzwv9EsGOYrDa4k5AfYUAMNKI0iT5z4n0VSXXMi
         LAp68cQ7acyrFRF2Kee7Z1ZJTJ0FKI7oXFxEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH0CO1nPZn884rt25Op3paRqxY7GEy9+iKKPeIy9v0s=;
        b=OywPrOH1Xnj6AxwUzLI0kPyDZt8TN2eQmf+SB7vBnIGxLUQRwbTMrQaGNGcnWF11mX
         IZU93VR2r8qkj20WemmwZGX9znwrxgmvrufZ5YWWK0iKhLJLTCgK1O3M8OnrwYMaSLCm
         apu5UZT+ms46diD/fMwHndLXEs0rDnw36ttWRUopECCv7BTzDlrt1ooOARd6yHZ/A3tu
         bohTm0W/IafKj/YHxs6BZ5d7UMLJ3NK0OBp9r6gtFLI+OEXZZJe0viMlfR72VTAMjYh9
         VnfGUSOcRC/DUu+6gQha7Q5mxPtXcwmLH/DMvKwyN0nylh96DgB1OeZNu8yG07FPgUiJ
         Xgyw==
X-Gm-Message-State: APjAAAWeFLZaYwC8weTnQqx8kkBZZKu11iY/fU7oNGZNwER7O5f9F6VW
        nnYd0KTZsP22Py7BHfsVnLHrcs0OhGI=
X-Google-Smtp-Source: APXvYqy+4Ap7Y7BzJ4wUjYIbYzPOdu3LUnaEJ8N+Gv5Xc00t+QEH4zFtbX/ryFNPovT2Srbtx64LUA==
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr17470867ljc.139.1552326110665;
        Mon, 11 Mar 2019 10:41:50 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j14sm1048444lji.32.2019.03.11.10.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 10:41:49 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 197so4094623lfz.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:41:49 -0700 (PDT)
X-Received: by 2002:ac2:5542:: with SMTP id l2mr15824067lfk.136.1552326109287;
 Mon, 11 Mar 2019 10:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
 <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
 <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com> <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
In-Reply-To: <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 10:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
Message-ID: <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:55 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clarification, just so I get the design considerations adjusted
> correctly... I did this with a global because of the observation that
> once CPU setup is done, the pin mask is the same for all CPUs.

Yes. Once we're booted, it's all the same.

It's only during bootup that it has this issue.

> However, yes, I see the point about the chosen implementation
> resulting in a potential timing problem, etc. What about enabling the
> pin mask once CPU init is finished? The goal is to protect those bits
> during runtime (and to stay out of the way at init time).

Yes, that would fix things too, although I suspect you'll find that it
gets hairy for hotplug CPU's (including suspend/resume), because new
CPU's keep booting "forever".

One - and perhaps better - option is to really force the %cr4 bits for
all CPU's *very* early. We actually have some of that logic for %cr4
already, because %cr4 absolutely needs to enable things like PAE and
PGE very early it even enables paging, because those bits are already
set in the base kernel page tables that it loads.

At that point, the SMEP/SMAP/UMIP bits would *really* be set globally
after the first CPU boots.

Actually, I think it might be less important to initialize %cr4 itself
early, and more important to initialize 'cpu_tlbstate.cr4', but right
now that actually gets initialized from the early %cr4 value (see
'cr4_init_shadow()')

So what might be workable is to make 'cr4_init_shadow()' itself just
do something like

        this_cpu_write(cpu_tlbstate.cr4, __read_cr4() | cr4_pin);

but I did *not* check whether there might be some other random
accesses to %cr4 in various legacy paths..

The "use a percpu pinning mask" seemed to be the simplest solution,
but the above might work fairly easily too.

Hmm?

                  Linus
