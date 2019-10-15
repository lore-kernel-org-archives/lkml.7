Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7ADC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D9720854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 06:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfJOGth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 02:49:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39323 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJOGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:49:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so15853214oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHb9tqb1iy1bqe7HHwB6j7A5lZqLTbS6CjsOhABP4fY=;
        b=LGgOr+BhUyjcBaW1XXl0H/cngpIvNvIn+qFnA4FYAK9o6tBY0A/Qe0+xz/zzFE6hpn
         p/j3h+fgwXJaUiVdo1aQNgFrVPWewkFh2cAGU/eHH/AZmteaYilNEvskLR5SHzl9yvEB
         jQ9sRrV7H8DasDaIjziqBTNSMzavYOZDOo4A03KDktk/z5E0xx8BOrBbf7CRdL8vGnIw
         BYuw1nK3x4uclJKaQqMU+y2BqIqMdV4V+vzfbpjq5b3wgrfY3D/BP05rtr85d70O3Qhw
         sgBmDsRy3m068cvmx+iXXMQIZyvae2ZIalumbdN4k5LRTOkgk5A1Bz4ClgCaDEezY7vS
         U03A==
X-Gm-Message-State: APjAAAVlPhzStKF7FYxZQQOxPBfe+q11xjY2TF4Oei4PR3XwUtPAyLF1
        polgzdcq6ecqb9CjM7YoKiukU6Kk25HNFiHT4pcVuQ==
X-Google-Smtp-Source: APXvYqx/HnsKia0Hq0npATVStqRtSIGU7XxpM9CwXEWvNmiVqF8aOi6OWsOiRooTGJvt90P/+nQ3wqN9VTyf8TtkCd0=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr17249201oie.131.1571122173578;
 Mon, 14 Oct 2019 23:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be>
 <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
 <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
 <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
 <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
 <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com> <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
In-Reply-To: <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Oct 2019 08:49:22 +0200
Message-ID: <CAMuHMdWSGzs7BHqeHC0W5qUEpYqJ8B3Os4wdY11JNzt5+xEaiQ@mail.gmail.com>
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

On Mon, Oct 14, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2019-10-14 at 11:20 +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 8, 2019 at 8:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Oct 8, 2019 at 7:02 PM Joe Perches <joe@perches.com> wrote:
> > > > On Tue, 2019-10-08 at 17:28 +0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > > > > > On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > > > > > > When reading a patch file from standard input, checkpatch calls it "Your
> > > > > > > patch", and reports its state as:
> > > > > > >
> > > > > > >     Your patch has style problems, please review.
> > > > > > >
> > > > > > > or:
> > > > > > >
> > > > > > >     Your patch has no obvious style problems and is ready for submission.
> > > > > > >
> > > > > > > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > > > > > > when checking patchwork bundles using:
> > > > > > >
> > > > > > >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> > > > > > >
> > > > > > > it is difficult to identify which patches need to be reviewed and
> > > > > > > improved.
> > > > > > >
> > > > > > > Fix this by replacing "Your patch" by the patch subject, if present.
> > > > > > []
> > > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > > []
> > > > > > > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> > > > > > >       }
> > > > > > >       while (<$FILE>) {
> > > > > > >               chomp;
> > > > > > > +             if ($vname eq 'Your patch') {
> > > > > > > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > > > > > +                     $vname = '"' . $subject . '"' if $subject;
> > > > > >
> > > > > > Hi again Geert.
> > > > > >
> > > > > > Just some stylistic nits:
> > > > > >
> > > > > > $filename is not quoted so I think adding quotes
> > > > > > before and after $subject may not be useful.
> > > > >
> > > > > Filename is indeed not quoted, but $git_commits{$filename} is.
> > > >
> > > > If I understand your use case, this will only show the last
> > > > patch $subject of a bundle?
> > >
> > > False.
> > > "formail -s scripts/checkpatch.pl < bundle-foo.mbox" splits
> > > "bundle-foo.mbox" in separate patches, and invokes
> > > "scripts/checkpatch.pl" for each of them.
> > >
> > > > Also, it'll show things like "duplicate signature" when multiple
> > > > patches are tested in a single bundle.
> > >
> > > False, due to the splitting by formail.
> > >
> > > > For instance, if I have a git format-patch series in an output
> > > > directory and do
> > > >
> > > > $ cat <output_dir>/*.patch | ./scripts/checkpatch.pl
> > > >
> > > > Bad output happen.
> > >
> > > Yeah, because you're concatenating all patches.
> > > Currently it works for single patches only.
> > >
> > > > Maybe this might be better:
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -2444,6 +2444,15 @@ sub process {
> > > >
> > > >                 my $rawline = $rawlines[$linenr - 1];
> > > >
> > > > +# if input from stdin, report the subject lines if they exist
> > > > +               if ($filename eq '-' && !$quiet &&
> > > > +                   $rawline =~ /^Subject:\s*(.*)/) {
> > > > +                       report("stdin", "STDIN", '-' x length($1));
> > > > +                       report("stdin", "STDIN", $1);
> > > > +                       report("stdin", "STDIN", '-' x length($1));
> > > > +                       %signatures = ();       # avoid duplicate signatures
> > > > +               }
> > > > +
> > > >  # check if it's a mode change, rename or start of a patch
> > > >                 if (!$in_commit_log &&
> > > >                     ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
> > >
> > > Perhaps.  Just passing the patchwork bundle to checkpatch, and fixing
> > > checkpatch to handle multiple patches in a single file was my first idea.
> > > But it looked fragile, with too much state that needs to be reset.
> > > I.e. the state is not limited to %signatures.  You also have to reset
> > > $author inside process(), and probably a dozen other variables.
> > > And make sure that future changes don't forget resetting all newly
> > > introduced variables.
> > >
> > > Hence I settled for the solution using formail.
> >
> > I gave your solution a try.
> > It only enables the reset-on-next-patch feature when using stdin.
> > Thanks to the printed subject, it's now obvious to which patch a
> > message applies to.
> > However, the output is significantly different than when passing
> > a split patch series.  Can this be improved upon?
> >
> > Note that the only reason I'm using stdin is that I use formail to split
> > a bundle in individual patches.  Once checkpatch supports bundles (or
> > mboxes) containing multiple patches, there's no longer a need for
> > using formail, and the reset-on-next-patch feature should be
> > enabled unconditionally.
>
> Using your collection of little tools idea,
> why not write a trivial script like:
>
>         grep "^Subject:" $1
>         checkpatch.pl $1
>
> and use that as the command line for formail
> instead of adding unnecessary complexity to
> checkpatch?

That would be another possibility.

But given more maintainers are starting to apply patchwork bundles (cfr.
the workflows discussions), it makes sense to make their lives easier.

This is also useful for maintainers who save all patches to apply into a
single mbox, and run checkpatch+git-am on that.

Summarized: git-am handles multiple patches, checkpatch requires
splitting.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
