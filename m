Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67503C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4585020650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfJOQkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:40:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46511 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJOQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:40:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so17359290oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCEIjy3ZeRG5elKhqsYsGhVL5vKH8XQWJHZa/dHTiZY=;
        b=fVh+tK1OuW5UiuFAZjWx8FC5euZfwGMmrNHQtggVqFhpiMP7XNojpg05YadIcP26IF
         I2jD0ZdyetFF13WJZIWLKFsxG/0+b5B9p6D51tkLhLp4TfZvRZ7tWmdWe0KGwzI46d/H
         DycFcqH+WFhOCGtnbyUUkXudVUk6PjXyfr4rFmme7KjSkyOaQna8RQjC8H0uRaD5D8x4
         cJEs5xaVP/Jl67zw4kP7PdQPHeGFTUqyBnLr2VoHzsTimYjlckAzhEetXVdXFsKxhiky
         WzU5OiaLrqt759TEzBB6RczAFzIq2QxJAiAF4HC44407AyowMUJQLjCrQwIBuzSoLugM
         aVeA==
X-Gm-Message-State: APjAAAUBdzkr1NKm90RhCVByEdpeH0auxJWXkEsTCFjHfNRAByeetkbu
        yny5u20jHG60xgqNGMHc+YzzybV9xpVJgfG9lZcxQ+TK
X-Google-Smtp-Source: APXvYqw3ubKBylwMS0d4kkMpFJTqclSWCV2kf6t8698FSO4lFwUowU9nzE6mRXTH436ScESa+2RQ+mL/+/G4zutSHpo=
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr4744553oia.102.1571157619424;
 Tue, 15 Oct 2019 09:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be>
 <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
 <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
 <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
 <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
 <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
 <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
 <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com> <e09057e0eefb221549ef9686826e2d190ef36a9c.camel@perches.com>
In-Reply-To: <e09057e0eefb221549ef9686826e2d190ef36a9c.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Oct 2019 18:40:08 +0200
Message-ID: <CAMuHMdUvoQz7a7NmLHdpNjRnAUMdbqxFRvB2vdLhHj8pw4Z9Rw@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Oct 15, 2019 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-10-15 at 08:49 +0200, Geert Uytterhoeven wrote:
> > On Mon, Oct 14, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2019-10-14 at 11:20 +0200, Geert Uytterhoeven wrote:
> []
> > > > I gave your solution a try.
> > > > It only enables the reset-on-next-patch feature when using stdin.
> > > > Thanks to the printed subject, it's now obvious to which patch a
> > > > message applies to.
> > > > However, the output is significantly different than when passing
> > > > a split patch series.  Can this be improved upon?
> > > >
> > > > Note that the only reason I'm using stdin is that I use formail to split
> > > > a bundle in individual patches.  Once checkpatch supports bundles (or
> > > > mboxes) containing multiple patches, there's no longer a need for
> > > > using formail, and the reset-on-next-patch feature should be
> > > > enabled unconditionally.
> > >
> > > Using your collection of little tools idea,
> > > why not write a trivial script like:
> > >
> > >         grep "^Subject:" $1
> > >         checkpatch.pl $1
> > >
> > > and use that as the command line for formail
> > > instead of adding unnecessary complexity to
> > > checkpatch?
> >
> > That would be another possibility.
> >
> > But given more maintainers are starting to apply patchwork bundles (cfr.
> > the workflows discussions), it makes sense to make their lives easier.
>
> But given this particular change only works for stdin, then this
> patch splitting idea wouldn't generically work.
>
> > This is also useful for maintainers who save all patches to apply into a
> > single mbox, and run checkpatch+git-am on that.
>
> Which also wouldn't generally work for checkpatch <mbox>

formail -s scripts/checkpatch.pl < <mbox>

> > Summarized: git-am handles multiple patches, checkpatch requires
> > splitting.
>
> I still think it's better to introduce YA script that disaggregates
> aggregated patches/emails and feeds each individual patch to
> checkpatch rather than making checkpatch learn how to disaggregate.
>
> Using "git mailsplit" as part of some additional script could work.

Thanks, didn't know git was assimilating formail functionality...

[reading git-mailsplit(1)]

The advantage of formail over git-mailsplit is that the former doesn't
create a bunch of files that need to be stored in a temporary place,
and cleant up afterwards.
But hey, that can be handled in yet-another-script...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
