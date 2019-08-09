Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9735C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC152086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfHIXR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 19:17:56 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:43541 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbfHIXR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:17:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E7F38182CF668;
        Fri,  9 Aug 2019 23:17:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: look33_61e18702cab14
X-Filterd-Recvd-Size: 2488
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 23:17:52 +0000 (UTC)
Message-ID: <4580cd399d23bbdd9b7cf28a1ffaa7bc1daef6a6.camel@perches.com>
Subject: Re: checkpatch.pl should suggest __section
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 09 Aug 2019 16:17:51 -0700
In-Reply-To: <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com>
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
         <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
         <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 16:04 -0700, Nick Desaulniers wrote:
> > how about:
> > ---
> >  scripts/checkpatch.pl | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 1cdacb4fd207..8e6693ca772c 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -5901,6 +5901,15 @@ sub process {
> >                              "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
> >                 }
> > 
> > +# Check for __attribute__ section, prefer __section (without quotes)
> > +               if ($realfile !~ m@\binclude/uapi/@ &&
> > +                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> > +                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> > +                       my $new = substr($old, 1, -1);
> > +                       WARN("PREFER_SECTION",
> > +                            "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
> > +               }
> > +
> 
> I can't read Perl, but this looks pretty good.
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

I'll add a Suggested-by: for you.

But a Tested-by would be more valuable than an Acked-by if you
don't actually know how it works.


