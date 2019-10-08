Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7427C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981C420673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfJHM71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:59:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39894 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbfJHM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:59:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so14659426oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tGbLg5pDPWdBfHPDXrkGRg32Rty4rSohcbiylPKIHo=;
        b=qziPsC183Aq2h35Rf8aJVRy9mz/sdpPP8Jx84i8WAB3WpBjOFno4cBanTnz7xHxD4p
         VBzQMvpQFxQb5v0QDuLkzbfKDvFUCZFtlmNduL1Y96S9v+7mgd9ClhO9Erf3mS5n2T38
         tv0qUvmgoo5M8qqiw2YobdOaVNERAPgkUD9pfZ1BffoZCnxs//qELq118diCIkiwNmZz
         VMj50b+lbCh0Mq+EkgbhQAI1N9T+BUn4XzN61MS9EV5bJDfxHDefY15eJvvkQCFtoslx
         UQHDrhNI5oY+zE5LX+sWqQENrxbGAS1eHsnEYEnWZ74UHDxSPFafg7RRBZ576L8mEPy/
         qH3Q==
X-Gm-Message-State: APjAAAVZIFOfRFgyyoCCuQcncuz5KEQa54JvtLPINNPOQvLemHGiyi0R
        iVBMgxlga2osmHH/8KHCiyAJDXN1LybK/ffzp9apdg==
X-Google-Smtp-Source: APXvYqyAF+oJX3Gy9vgacsv7VQIijL40G0ACCrOWvMbKp0YqK7vgdkLf5ui04RiIYHn8zz9L5KYK/EW3gw666L7e06o=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr3551995oiy.148.1570539566417;
 Tue, 08 Oct 2019 05:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191008094006.8251-1-geert+renesas@glider.be> <5ccc9458aeb124d5c66baa8fd24e78e918609487.camel@perches.com>
In-Reply-To: <5ccc9458aeb124d5c66baa8fd24e78e918609487.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Oct 2019 14:59:15 +0200
Message-ID: <CAMuHMdW=qamydEn6=cEbeRe79jBi4FZ8LH+3OyTQp0S-w7+3WQ@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 2:50 PM Joe Perches <joe@perches.com> wrote:
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
>
> Seems sensible, thanks Geert
>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  scripts/checkpatch.pl | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 6fcc66afb0880830..6b9feb4d646a116b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> >       }
> >       while (<$FILE>) {
> >               chomp;
> > +             if ($vname eq 'Your patch') {
> > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > +                     $vname = '"' . $subject . '"' if $subject;
>
> trivia:
>
> Not a big deal and is likely good enough but this will
> cut off subjects that are continued on multiple lines.
>
> e.g.:
>
> Subject: [PATCH Vx n/M] very long description with a subject spanning
>  multiple lines
> From: patch submitter <submitter@domain.tld>

I know.

Fixing that is not that simple, I'm afraid.
And $vname is used before process() is called.

>
> > +             }
> >               push(@rawlines, $_);
> >       }
> >       close($FILE);
>


-- 
Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
