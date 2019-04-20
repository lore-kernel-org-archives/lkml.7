Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDDC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E463F21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfDTD5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:57:31 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:45450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfDTD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:57:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E1C88182CED28;
        Sat, 20 Apr 2019 03:57:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blade53_5ddfc643d6a28
X-Filterd-Recvd-Size: 4767
Received: from XPS-9350 (unknown [162.249.177.49])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Apr 2019 03:57:24 +0000 (UTC)
Message-ID: <fc2875ed63b9d2b2e94893f9af425cbbedb75d3e.camel@perches.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in
 kdb summary
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Date:   Fri, 19 Apr 2019 20:57:05 -0700
In-Reply-To: <20190419135830.0e3273e223fb83947e5adb0d@linux-foundation.org>
References: <20190323015227.245455-1-dianders@chromium.org>
         <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
         <20190416163034.3e642818ebf27ed6891c1981@linux-foundation.org>
         <CAK7LNAR4Ty8835sfo4HSvBsMCsV65mY2HOajFSY2TOYurmkFdw@mail.gmail.com>
         <20190418160651.40cb6a11186a6c6028e9d20d@linux-foundation.org>
         <CAK7LNAQe2uaVfKee1F6R4siVvUSCMgSaYAnUQfz8MS5PeFqpGA@mail.gmail.com>
         <e5f29ca9b6067fff9ea68cb25e15906659cd51ad.camel@perches.com>
         <20190419135830.0e3273e223fb83947e5adb0d@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-19 at 13:58 -0700, Andrew Morton wrote:
> On Fri, 19 Apr 2019 04:14:27 -0700 Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-04-19 at 12:28 +0900, Masahiro Yamada wrote:
> > > Can you detect redundant Cc: by checkpatch?
[]
> > I'm not sure why it's useful or necessary.
[]
> The issue here is redundant Cc: lines in the changelog.

CC: entries have very little actual value in a changelog anyway.

> > --- a/scripts/checkpatch.pl
[]
> > @@ -2688,6 +2688,19 @@ sub process {
> >  				$signatures{$sig_nospace} = 1;
> >  			}
> >  
> > +# Check for a cc: line with another signature -by: by the same author
> > +			if ($sig_nospace =~ /^cc:/) {
> > +				my $sig_email = substr($sig_nospace, 3);
> > +				foreach my $sig (sort keys %signatures) {
> > +					next if ($sig =~ /^cc:/);
> > +					$sig =~ s/^[^:]+://;
> > +					if ($sig eq $sig_email) {
> > +						WARN("BAD_SIGN_OFF",
> > +						     "Unnecessary CC: as there is another signature with the same name/email address\n" . $herecurr);
> > +					}
> > +				}
> > +			}
> > +
> >  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
> >  			if ($sign_off =~ /^co-developed-by:$/i) {
> >  				if ($email eq $author) {
> 
> Thanks.  But my checkpatch.pl is different from yours.
> 
> q:/usr/src/25> grep "immediately followed by" scripts/checkpatch.pl
> q:/usr/src/25> 

I almost always write patches against -next

$ git grep "immediately followed by" next-20190418 -- scripts/checkpatch.pl
next-20190418:scripts/checkpatch.pl:# Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
next-20190418:scripts/checkpatch.pl:                                             "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
next-20190418:scripts/checkpatch.pl:                                         "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);

You seem to be missing

commit 6c5d24eef7be7adfcb608f2852ab69b58935133b
Author: Sean Christopherson <sean.j.christopherson@intel.com>
Date:   Fri Mar 22 14:11:37 2019 -0700

    checkpatch: Warn on improper usage of Co-developed-by
    
    The purpose of Co-developed-by: is to give attribution to authors who
    aren't already attributed by the From: tag, i.e. who aren't the nominal
    patch author.  Because Co-developed-by: is essentially a variation of
    From:, it must be accompanied by a Signed-off-by: of the associated
    co-author.  To ease the burden of determining whether or not co-authors
    have signed off, Co-developed-by and Signed-off-by: must be explicitly
    paired, i.e. on consecutive lines for a given co-author.
    
    Suggested-by: Joe Perches <joe@perches.com>
    Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>


