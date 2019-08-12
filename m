Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B3720842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pm/i5Awv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHLSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:06:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45968 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfHLSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:06:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so49865290pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rkibUktkvDgvPaKzYudHbYv+zssBd9BVnmORpFK5sIM=;
        b=Pm/i5Awv+1wuEbKCQ7G++ON3VKecwo9wUwhdvsO4/YJuS0PP46xEGXgjDrgypxhqB1
         EZV4gC90lHCBFaUda5gn9lCqVYK6cLjjx5kHklAdvsV2533UxL6qZ5kKKQzdvSVhs8Yt
         0baWDmWgyor6cBKVrjFhiZkMlh5ninhAuqSQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkibUktkvDgvPaKzYudHbYv+zssBd9BVnmORpFK5sIM=;
        b=nBbdx50kVmrmKMPlL0AbD2F+rMV4KddpMlwC204JafADo6eB9xDKiuyt+Lj1XcMPGC
         sBeuoDSpTsU/l9jOmPjWWpc9mTLbVHiVfuQJoSPdraObHbai3w8bAOaF8yoDC3B6o+fq
         XiBqfSxvfQBeljWtTp0wf0hWTmlRWzZfINFtEukU4S8EzOUsiMBM23+bDPdEJcS20pkf
         C6pl/UbRlsFz960/vnpoCKfcNK2L0XWohh3OJXNXEIA/yk4sV/TIO9gAUd1qopRuJpUR
         6/4+wzzoRJMLT/x6I8hzWCgRiM9geS7/W4+X3GPkTGs2Bymc18FVlbByt6yeojPCrVAF
         G8YA==
X-Gm-Message-State: APjAAAUw2C3SPk8FMD+7DywTDflxvIizq1p2NVjYPEbxckcWHQAIHowg
        FZiG5uq+4dvdfcpHsOiXWzJjgZckl1Q=
X-Google-Smtp-Source: APXvYqwQNDswXhVN3SaWKfAiYZ9PFI71KTrt+N0THLB/Nq1EPI+5R3W5gBzqamh9PGPVG4SeUiySkA==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr35369354pfi.221.1565631483928;
        Mon, 12 Aug 2019 10:38:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u3sm153514pjn.5.2019.08.12.10.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 10:38:03 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:38:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Chaignon <paul.chaignon@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <201908121035.06695C79F@keescook>
References: <20190809182621.GA4074@Nover>
 <CAO5pjwSe+U70tSPjKOgFsqqF=gCKXPDREzYF81NCZ03kGAyWww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5pjwSe+U70tSPjKOgFsqqF=gCKXPDREzYF81NCZ03kGAyWww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:58:33AM +0200, Paul Chaignon wrote:
> On Fri, Aug 9, 2019 at 8:26 PM Paul Chaignon <paul.chaignon@orange.com> wrote:
> >
> > We need BPF_MOD to match system calls against whitelists encoded as 32-bit
> > bit arrays.  The selection of the syscall's bit in the appropriate bit
> > array requires a modulo operation such that X = 1 << nr % 32.
> 
> Of course, X = 1 << nr & 0x1F, and we can do without BPF_MOD in our case.
> I'll put that on a lack of sleep...

No worries! Changing the dialect of seccomp BPF isn't something I'd like
to do without really good reason since it creates a split in the filter
correctness from userspace (i.e. a filter using BPF_MOD on an older
kernel will fail). So there would need to be a distinct flag set
somewhere, etc. So, if you do end up discovering later you really want
BPF_MOD, we can figure that out, but for now if you can get by with "&",
that would be best. :)

Thanks!

-Kees

> 
> >
> > Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> > ---
> >  kernel/seccomp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 811b4a86cdf6..87de6532ff6d 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -205,6 +205,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
> >                 case BPF_ALU | BPF_MUL | BPF_X:
> >                 case BPF_ALU | BPF_DIV | BPF_K:
> >                 case BPF_ALU | BPF_DIV | BPF_X:
> > +               case BPF_ALU | BPF_MOD | BPF_K:
> > +               case BPF_ALU | BPF_MOD | BPF_X:
> >                 case BPF_ALU | BPF_AND | BPF_K:
> >                 case BPF_ALU | BPF_AND | BPF_X:
> >                 case BPF_ALU | BPF_OR | BPF_K:
> > --
> > 2.17.1

-- 
Kees Cook
