Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B0BC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BDB20851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z68C9m4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFNKZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:25:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35906 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFNKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:25:09 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so4658800ioh.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTlZwBpQOZGvfo9M/qsELW5H/5S4OXYm4x9oeMMV64Y=;
        b=Z68C9m4rei/U9YZ8xm4SGtBJ7DtNtjfQzvA89J5Ujh4+GaZH+ovdMdyWmXiGKt1a+h
         64XaYbmGQAMC0nwYZj8CFpQ3NStkRXhmIPcEx4lw5lQIXJeSKBL2VV98aF6xwQAk1Z9o
         Psn8b7L/gt8BYHxQ0d5PXy83Mrai/MeH/c/fnxGL3meEkJ8xmT7PjwgU7bKEEB1tdQkY
         O5ZMYBrYOvepT4IQh7LIhqDH91oOvT44gpEdqFwHXG0N9ROb0vzpyiZVUitVMmkgpOc2
         4QN28jYnNmho6XHP9/NzqQIvQoeyMjgcM08BrB0eLl/KOj0o1iHuHCgjoQm/KFbto8UV
         6Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTlZwBpQOZGvfo9M/qsELW5H/5S4OXYm4x9oeMMV64Y=;
        b=N0yJlwt5YMeN7fD3L9w6avRmpnLSJ21ctrv5MB+s9vSAwX8hH3HIAyfHzDPbiR5l/Z
         m6WJLE3fhtS5t1skVxQodbIcAep0haHaCBZtvij079hDpAbmSvMlQcCq9IF6M2z1j82o
         VIBX8UnPv25hINH3mml62G85aiqNePCRFzU3A1/yncrlUCnUSc4RGo+vsWcJ3FWPMHf8
         87fWpKz/p44PP3VnisxfWJCo7GhMnjWFAaSxatOOGTNCR1LuRBlMZpkgjFUgnF+CtnyS
         WZbyywSgoh8cSoH1Q/gf9+apZOU/UqZ8R0k1/JM46OZumfID1B1F74CLXc7RHR0dYR26
         8/QQ==
X-Gm-Message-State: APjAAAU9xA63+/UEJgl/S6q4ZQtvYmuj8JV7BR6znjeJVz2wVv+iOnok
        YFoHZz0imQCp1FC4QC4uzsO5XWP5gwTq0jzBFLcL6M7Aay0=
X-Google-Smtp-Source: APXvYqyhJKWfx8hlWAwDXO1oAD4MzoKSs+Q1qwCrsEYGJs4tVIXrJmtDkJDq65AR6ZqM0grvv4RhAHbFCd4wJp338B0=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr54103661ion.65.1560507908192;
 Fri, 14 Jun 2019 03:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com> <20190506181039.GA2875@brain-police>
 <20190518042424.GA28517@dc5-eodlnx05.marvell.com> <CAKv+Gu9U9z3iAuz4V1c5zTHuz1As8FSNGY-TJon4OLErB8ts8Q@mail.gmail.com>
 <20190522160417.GF7876@fuggles.cambridge.arm.com> <20190612040933.GA18848@dc5-eodlnx05.marvell.com>
 <20190612093151.GA11554@brain-police> <20190614070914.GA21961@dc5-eodlnx05.marvell.com>
 <20190614095846.GC10506@fuggles.cambridge.arm.com>
In-Reply-To: <20190614095846.GC10506@fuggles.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Jun 2019 12:24:54 +0200
Message-ID: <CAKv+Gu_Kdq=UPijjA84FpmO=ZsdEO9EyyF7GeOQ+WmfqtO_hMg@mail.gmail.com>
Subject: Re: [RFC] Disable lockref on arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jan Glauber <jglauber@marvell.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 at 11:58, Will Deacon <will.deacon@arm.com> wrote:
>
> [+Kees]
>
> On Fri, Jun 14, 2019 at 07:09:26AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > On Wed, Jun 12, 2019 at 10:31:53AM +0100, Will Deacon wrote:
> > > On Wed, Jun 12, 2019 at 04:10:20AM +0000, Jayachandran Chandrasekharan Nair wrote:
> > > > Now that the lockref change is mainline, I think we need to take another
> > > > look at this patch.
> > >
> > > Before we get too involved with this, I really don't want to start a trend of
> > > "let's try to rewrite all code using cmpxchg() in Linux because of TX2".
> >
> > x86 added a arch-specific fast refcount implementation - and the commit
> > specifically notes that it is faster than cmpxchg based code[1].
> >
> > There seems to be an ongoing effort to move over more and more subsystems
> > from atomic_t to refcount_t(e.g.[2]), specifically because refcount_t on
> > x86 is fast enough and you get some error checking atomic_t that does not
> > have.
>
> Correct, but there are also some cases that are only caught by
> REFCOUNT_FULL.
>

Yes, but do note that my arm64 implementation catches
increment-from-zero as well.

> > > At some point, the hardware needs to play ball. However...
> >
> > Even on a totally baller CPU, REFCOUNT_FULL is going to be slow :)
> > On TX2, this specific benchmark just highlights the issue, but the
> > difference is significant even on x86 (as noted above).
>
> My point was more general than that. If you want scalable concurrent code,
> then you end up having to move away from the serialisation introduced by
> locking. The main trick in the toolbox is cmpxchg() so, in the absence of
> a zoo of special-purpose atomic instructions, it really needs to do better
> than serialising.
>
> > > I was hoping we could use LDMIN/LDMAX to maintain the semantics of
> > > REFCOUNT_FULL, but now that I think about it I can't see how we could keep
> > > the arithmetic atomic in that case. Hmm.
> >
> > Do you think Ard's patch needs changes before it can be considered? I
> > can take a look at that.
>
> I would like to see how it performs if we keep the checking inline, yes.
> I suspect Ard could spin this in short order.
>

Moving the post checks before the stores you mean? That shouldn't be
too difficult, I suppose, but it will certainly cost performance.

> > > Whatever we do, I prefer to keep REFCOUNT_FULL the default option for arm64,
> > > so if we can't keep the semantics when we remove the cmpxchg, you'll need to
> > > opt into this at config time.
> >
> > Only arm64 and arm selects REFCOUNT_FULL in the default config. So please
> > reconsider this! This is going to slow down arm64 vs. other archs and it
> > will become worse when more code adopts refcount_t.
>
> Maybe, but faced with the choice between your micro-benchmark results and
> security-by-default for people using the arm64 Linux kernel, I really think
> that's a no-brainer. I'm well aware that not everybody agrees with me on
> that.

I think the question whether the benchmark is valid is justified, but
otoh, we are obsessed with hackbench which is not that representative
of a real workload either. It would be better to discuss these changes
in the context of known real-world use cases where refcounts are a
true bottleneck.

Also, I'd like to have Kees's view on the gap between REFCOUNT_FULL
and the fast version on arm64. I'm not convinced the cases we are not
covering are such a big deal.
