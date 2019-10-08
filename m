Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C15C206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfJHP2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:28:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44654 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:28:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so15085312oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JxOzL7BgcEmkBobMzImy8Ka+DHSs8rlcSpaTCR9JJU=;
        b=IlCR5VFls1QsO71KO4mXOG+XyQMJZ3g5MtiYeRCVTpXeD5VWP62zRz5pOs4XWFWCoU
         zaqgEjdSo2I3QY1VSuOOUjLKU+az69RJ7ao9i8TFkLwKwNtTu5oW0f1tHa32o1E5W7q+
         CUBWf3NQtESCVdCX2ipmFJTEyVCCJjSdDCzifM9AX98T/fBathUSfaeaZzhDKY92wYvd
         S4Z6X1ihy/+1pJM0+wYIWre4wgmYWm77H6NVXp3btAl3FF5ROLWp3O0dXQFU2NpeHy0x
         bRRo8qmTXOHmNrGtkV/XJcLkIFw9NpRTm/0iM7DvXt86WDe7i8zFNRwa64CEN3tyGcfB
         dHhw==
X-Gm-Message-State: APjAAAXIXN/Pv0GncXnbs4G8Pb4E+Lndm/yHmW8eZSRdxhljmMLRU50S
        2+y4k6IC3pq+OPXsHTZcFP57J/XFpeU053FI82sEkyD0
X-Google-Smtp-Source: APXvYqym2tpjmfD2zkKom+X+wa3Xen57Nwh/puisJlNGffw4FOcFYSfE8879Wh66Vy4wY3Kxt4F0mXsgUgsiXH7j/N8=
X-Received: by 2002:aca:b654:: with SMTP id g81mr4137878oif.153.1570548523577;
 Tue, 08 Oct 2019 08:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be> <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
In-Reply-To: <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 17:28:32 +0200
Message-ID: <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > When reading a patch file from standard input, checkpatch calls it "Your
> > patch", and reports its state as:
> >
> >     Your patch has style problems, please review.
> >
> > or:
> >
> >     Your patch has no obvious style problems and is ready for submission.
> >
> > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > when checking patchwork bundles using:
> >
> >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> >
> > it is difficult to identify which patches need to be reviewed and
> > improved.
> >
> > Fix this by replacing "Your patch" by the patch subject, if present.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> >       }
> >       while (<$FILE>) {
> >               chomp;
> > +             if ($vname eq 'Your patch') {
> > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > +                     $vname = '"' . $subject . '"' if $subject;
>
> Hi again Geert.
>
> Just some stylistic nits:
>
> $filename is not quoted so I think adding quotes
> before and after $subject may not be useful.

Filename is indeed not quoted, but $git_commits{$filename} is.

> Can you please use what checkpatch uses as a more
> common parenthesis style after an if?
>
> i.e. use:
>         if (foo)
> not
>         if foo
>
> so maybe:
>
>         if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/) {
>                 $vname = $1;
>         }
>
> or maybe
>
>         $vname = $1 if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);

Thanks, will give it a try...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
