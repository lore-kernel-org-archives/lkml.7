Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EDF2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHLS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:27:33 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:52507 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbfHLS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:27:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B789C18224D66;
        Mon, 12 Aug 2019 18:27:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist12_418bb9aa3a33d
X-Filterd-Recvd-Size: 3371
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Aug 2019 18:27:30 +0000 (UTC)
Message-ID: <225af64a285ed0760a893e2dae45f1054e2cf82f.camel@perches.com>
Subject: Re: checkpatch.pl should suggest __section
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 12 Aug 2019 11:27:28 -0700
In-Reply-To: <CAKwvOd=293uFBT1hLrC-vE9ekd2YOaTiiXj1HVeGfTjAk1rGvg@mail.gmail.com>
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
         <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
         <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com>
         <4580cd399d23bbdd9b7cf28a1ffaa7bc1daef6a6.camel@perches.com>
         <CAKwvOd=293uFBT1hLrC-vE9ekd2YOaTiiXj1HVeGfTjAk1rGvg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 11:20 -0700, Nick Desaulniers wrote:
> On Fri, Aug 9, 2019 at 4:17 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-08-09 at 16:04 -0700, Nick Desaulniers wrote:
> > > > how about:
> > > > ---
> > > >  scripts/checkpatch.pl | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 1cdacb4fd207..8e6693ca772c 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -5901,6 +5901,15 @@ sub process {
> > > >                              "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
> > > >                 }
> > > > 
> > > > +# Check for __attribute__ section, prefer __section (without quotes)
> > > > +               if ($realfile !~ m@\binclude/uapi/@ &&
> > > > +                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> > > > +                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> > > > +                       my $new = substr($old, 1, -1);
> > > > +                       WARN("PREFER_SECTION",
> > > > +                            "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
> > > > +               }
> > > > +
> > > 
> > > I can't read Perl, but this looks pretty good.
> > > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > I'll add a Suggested-by: for you.
> > 
> > But a Tested-by would be more valuable than an Acked-by if you
> > don't actually know how it works.
> 
> $ git am joes.patch
> $ echo "int foo __attribute__((section(.hello)));" >> arch/x86/boot/a20.c

Does this compile?

checkpatch is not a compiler.

I think you need

__attribute__((section(".hello")))

> $ git commit arch/x86/boot/a20.c -sm "foo: bar\n baz"
> $ git format-patch HEAD~
> $ ./scripts/checkpatch.pl 0001-foo-bar.patch
> total: 0 errors, 0 warnings, 4 lines checked
> 
> 0001-foo-bar.patch has no obvious style problems and is ready for submission.
> 
> hmm...

