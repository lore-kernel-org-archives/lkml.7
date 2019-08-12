Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B697C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417482067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTY7W2VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfHLSUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:20:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37842 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHLSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:20:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so17082050pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoezCAR1me+7cFfS2i+sInUoCX7c/pMG5shvp2EKg3M=;
        b=MTY7W2VRvKPWsGYqY7qWH0FY/AYMtPClo4fWhZfNtXs+qrADL8LCCz6eiTtsXbcV0K
         OrYsOpqjVYkm/FM0FH/gMt19dHHDeO/BmOG3dhgSvcYCGDwn1SU2u6S+Qgmx1fhBVBp4
         A7MoI25+wXQdSbia3Ldt0NhsoTlyCjQK+n6kRrEvi/W+VYJJ5WlYrGQ64HUdIX3iyQ1Z
         l3Kt8VyXFvkEob7WB3Iy5qLXtp4oggV/1XS9E4JHl7X/2dWZSQ2JFI/eQWE0umIxEM3Q
         oalL/GHKxyWR+2aQZEL3UReZkU8wt17YkOWDj9AQRDLarQ5nGcKx8ta5AiE/iBns8R/X
         Xs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoezCAR1me+7cFfS2i+sInUoCX7c/pMG5shvp2EKg3M=;
        b=KrLFSYq4d/CL+Jnn5zmwD/MVnW+Ys2u7CprwLNPRPq3jJHW3uYCi/zrus3FBZ8yZaU
         FeUFFH5YhoaWQQSPqNgNaWW4uAEV69rBogozx2N4Kgm5SzGpCMkEouc9lOj1gwoeKJfV
         6y4Hl0CYkT3fGnFe5SRPGE6PZQIscKWt9k1kbuiJv4k5Olu0TPH7ZcnmE0mHv5h/NUx/
         EDcucWSu3VzhTTyHsdwEu0qNSDf+O0grEbRn4NZps7ZKHc0AhB6pviUx3gmCaoHDUVtz
         YjaL6USmNh7pduJ+pWphDTqW9yktq7KtzxCyaMBqIMfIzekAqR/XpwQGdxIFCHVk4jha
         IMFA==
X-Gm-Message-State: APjAAAVtqF/VtDeZcrJUZFtUDDaOEl/0E91kiXEudw7hPEs6sMS1krZ5
        lAlVFazPsqhNz5VYHelfH/WY/2CRmm2JUiNSU68Bng==
X-Google-Smtp-Source: APXvYqzOocZWhOOh9uChs1o32P8zfVFuiIIAYx3Tz7VYgvDkl57EUtuk/Qb3VxBrnNChccuKM0TiPbsx6j2lBP7WY6c=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr510471pjt.123.1565634053897;
 Mon, 12 Aug 2019 11:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
 <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
 <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com> <4580cd399d23bbdd9b7cf28a1ffaa7bc1daef6a6.camel@perches.com>
In-Reply-To: <4580cd399d23bbdd9b7cf28a1ffaa7bc1daef6a6.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 11:20:42 -0700
Message-ID: <CAKwvOd=293uFBT1hLrC-vE9ekd2YOaTiiXj1HVeGfTjAk1rGvg@mail.gmail.com>
Subject: Re: checkpatch.pl should suggest __section
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 4:17 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-08-09 at 16:04 -0700, Nick Desaulniers wrote:
> > > how about:
> > > ---
> > >  scripts/checkpatch.pl | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 1cdacb4fd207..8e6693ca772c 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -5901,6 +5901,15 @@ sub process {
> > >                              "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
> > >                 }
> > >
> > > +# Check for __attribute__ section, prefer __section (without quotes)
> > > +               if ($realfile !~ m@\binclude/uapi/@ &&
> > > +                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> > > +                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> > > +                       my $new = substr($old, 1, -1);
> > > +                       WARN("PREFER_SECTION",
> > > +                            "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
> > > +               }
> > > +
> >
> > I can't read Perl, but this looks pretty good.
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I'll add a Suggested-by: for you.
>
> But a Tested-by would be more valuable than an Acked-by if you
> don't actually know how it works.

$ git am joes.patch
$ echo "int foo __attribute__((section(.hello)));" >> arch/x86/boot/a20.c
$ git commit arch/x86/boot/a20.c -sm "foo: bar\n baz"
$ git format-patch HEAD~
$ ./scripts/checkpatch.pl 0001-foo-bar.patch
total: 0 errors, 0 warnings, 4 lines checked

0001-foo-bar.patch has no obvious style problems and is ready for submission.

hmm...
-- 
Thanks,
~Nick Desaulniers
