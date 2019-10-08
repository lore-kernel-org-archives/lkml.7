Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41557C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5BF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfJHSjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:39:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35351 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfJHSjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:39:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so14946844otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElXCiw9Zg25bFpdaW1JH8OG73PxwKkNl6h9I6TcDnjw=;
        b=SqYHmsCkRM66MR0UcRI//DGZSdsAKxc4Ahhktoffjw+9WfNgrIT0MCr9NXEs+NNnvu
         9YEJQXIyZFeMgFJfKmUTh290PC/FtH7Ei8QDbs/UdWrtmzsvNv8eeCtkw9DuDyc4IWg6
         IGURD7RRpvhas7A/a+7JGQ//hH4VfS+gu/2uoGGKpspbh850OPHsrEj0gY4jZjeTGuTB
         s4DADn40Tooieq3DQMM+v+oAjvjNnRkgrA0EoPjJq7xl3Xj1upsADCQocExTKOmKxChU
         /bK3TPXBhUkcqwGFm6dlHNPsOuUbet/yo5skjdQpaeKfdRBv+vlg1GwiB5etct5WODPS
         G6yQ==
X-Gm-Message-State: APjAAAWrBR9QbI5BAr7KSXpfktoeOYe81JO324Js7WmrXiBy2ogTzUnp
        ORdri8TOxXlemlgXvw260UO7/HkWzK6GayWmRCV2yw==
X-Google-Smtp-Source: APXvYqxjypQn8K+o8FMldBUv8v+DeoBaALGkgOK1k1e2ratWmntfRI4jp+TILmi+w2hYgFDkxU7MORn3YrETRkalHOI=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr17099690oti.39.1570559955303;
 Tue, 08 Oct 2019 11:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be>
 <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
 <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
 <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
 <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com> <18e4ecf36ada8a9a90cfb1e96bdb04bdbca4a537.camel@perches.com>
In-Reply-To: <18e4ecf36ada8a9a90cfb1e96bdb04bdbca4a537.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 20:39:03 +0200
Message-ID: <CAMuHMdUpqimKRn_VO+K5TB7+jhvxay1p61kPqgyLVOLwAsfJFw@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 8:25 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2019-10-08 at 20:10 +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 8, 2019 at 7:02 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2019-10-08 at 17:28 +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > > > > > When reading a patch file from standard input, checkpatch calls it "Your
> > > > > > patch", and reports its state as:
> > > > > >
> > > > > >     Your patch has style problems, please review.
> > > > > >
> > > > > > or:
> > > > > >
> > > > > >     Your patch has no obvious style problems and is ready for submission.
> > > > > >
> > > > > > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > > > > > when checking patchwork bundles using:
> > > > > >
> > > > > >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> > > > > >
> > > > > > it is difficult to identify which patches need to be reviewed and
> > > > > > improved.
> > > > > >
> > > > > > Fix this by replacing "Your patch" by the patch subject, if present.
> > > > > []
> > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > []
> > > > > > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> > > > > >       }
> > > > > >       while (<$FILE>) {
> > > > > >               chomp;
> > > > > > +             if ($vname eq 'Your patch') {
> > > > > > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > > > > +                     $vname = '"' . $subject . '"' if $subject;
> > > > >
> > > > > Hi again Geert.
> > > > >
> > > > > Just some stylistic nits:
> > > > >
> > > > > $filename is not quoted so I think adding quotes
> > > > > before and after $subject may not be useful.
> > > >
> > > > Filename is indeed not quoted, but $git_commits{$filename} is.
> > >
> > > If I understand your use case, this will only show the last
> > > patch $subject of a bundle?
> >
> > False.
>
> Not really false, it's true.  Your use case just
> doesn't submit bundled patches as a single input
> to checkpatch.
>
> > "formail -s scripts/checkpatch.pl < bundle-foo.mbox" splits
> > "bundle-foo.mbox" in separate patches, and invokes
> > "scripts/checkpatch.pl" for each of them.
>
> Never used formail, it seems it was last updated in 2001.
>
> > > Also, it'll show things like "duplicate signature" when multiple
> > > patches are tested in a single bundle.
> >
> > False, due to the splitting by formail.
>
> Again, not false, just not your use.
>
> > > For instance, if I have a git format-patch series in an output
> > > directory and do
> > >
> > > $ cat <output_dir>/*.patch | ./scripts/checkpatch.pl
> > >
> > > Bad output happen.
> >
> > Yeah, because you're concatenating all patches.
> > Currently it works for single patches only.
> >
> > > Maybe this might be better:
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -2444,6 +2444,15 @@ sub process {
> > >
> > >                 my $rawline = $rawlines[$linenr - 1];
> > >
> > > +# if input from stdin, report the subject lines if they exist
> > > +               if ($filename eq '-' && !$quiet &&
> > > +                   $rawline =~ /^Subject:\s*(.*)/) {
> > > +                       report("stdin", "STDIN", '-' x length($1));
> > > +                       report("stdin", "STDIN", $1);
> > > +                       report("stdin", "STDIN", '-' x length($1));
> > > +                       %signatures = ();       # avoid duplicate signatures
> > > +               }
> > > +
> > >  # check if it's a mode change, rename or start of a patch
> > >                 if (!$in_commit_log &&
> > >                     ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
> >
> > Perhaps.  Just passing the patchwork bundle to checkpatch, and fixing
> > checkpatch to handle multiple patches in a single file was my first idea.
> > But it looked fragile, with too much state that needs to be reset.
> > I.e. the state is not limited to %signatures.  You also have to reset
> > $author inside process(), and probably a dozen other variables.
> > And make sure that future changes don't forget resetting all newly
> > introduced variables.
> >
> > Hence I settled for the solution using formail.
>
> I still think the patch I suggested is better as it
> functions for other use cases too.

I agree it would be better if checkpatch would handle the splitting in
patches itself, as that would be easier for the user.

However:
  1) That requires getting the state reset right,
  2) Using formail is the classical old UNIX way (combine small tools
     to get the job done ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
