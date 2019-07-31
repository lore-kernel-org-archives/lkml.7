Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B278C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5726D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfGaWH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:07:57 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:39030 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbfGaWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:07:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 13F7718224D6B;
        Wed, 31 Jul 2019 22:07:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blade71_7ee4e03e7f750
X-Filterd-Recvd-Size: 3968
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 22:07:51 +0000 (UTC)
Message-ID: <beb1762387a4132a2bb4c47397b737d77dd88742.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Jul 2019 15:07:50 -0700
In-Reply-To: <CANiq72kMpP_PSBb0e5wMVNiuYvwSWdR+x_H_tPrEnQ_j1y7X+Q@mail.gmail.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <20190731171429.GA24222@amd>
         <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
         <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
         <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
         <201907311301.EC1D84F@keescook>
         <CANiq72kMpP_PSBb0e5wMVNiuYvwSWdR+x_H_tPrEnQ_j1y7X+Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 22:59 +0200, Miguel Ojeda wrote:
> On Wed, Jul 31, 2019 at 10:02 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Jul 31, 2019 at 08:48:32PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor.com wrote:
> > > > > > > +/*
> > > > > > > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > > > > > > + * must end with any of these keywords:
> > > > > > > + *   break;
> > > > > > > + *   fallthrough;
> > > > > > > + *   goto <label>;
> > > > > > > + *   return [expression];
> > > > > > > + *
> > > > > > > + *  gcc: >https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> > > > > > > + */
> > > > > > > +#if __has_attribute(__fallthrough__)
> > > > > > > +# define fallthrough                   __attribute__((__fallthrough__))
> > > > > > > +#else
> > > > > > > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > > > > > > +#endif
> > > > > > > +
> > > > If the comments are stripped, how would the compiler see them to be
> > > > able to issue a warning? I would guess that it is retained or replaced
> > > > with some other magic token.
> > > 
> > > Everything that has the warning (GCC-7+/CLANG-9) has that attribute.
> > 
> > I'd like to make sure we don't regress Coverity most of all. If the
> > recent updates to the Coverity scanner include support for the attribute
> > now, then I'm all for it. :)
> 
> We had this discussion a while ago (October) and the consensus was
> that we would like to wait for a while until all tools were ready to
> use the attribute and everyone's would be happy:
> 
>   https://lore.kernel.org/lkml/20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com/
> 
> Is everyone happy this time around? :-)

Note also that this doesn't actually _use_ fallthrough
it just reserves it.

Patches that convert /* fallthrough */ et al, to fallthrough
would only be published when everyone's happy enough.


