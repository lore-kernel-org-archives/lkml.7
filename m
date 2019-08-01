Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC12C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6287A214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oNrtWDmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfHAMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:25:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4br+Q3plR4iQD9exedxQ6jORxCMSk+q/1IT08N4btxQ=; b=oNrtWDmQoU84abGPgvjoBww7Y
        4gVPHqizMVovOZMhCZn7gvg4X8ZjmGD5ftSRyGsDq4zqTECHJadvfV144P/dcIsja3NDs2DrlIbUC
        S5Nr7S+68PJrSCxkY6W1pZOMi4SZrK4zC8Tm9qkimfDG+Z6tIHkEHz7w0nqRh9vJ+T6jQYWEZuG8J
        sVWMc2neFZAZAOu/3utKIYahTzjsY+BXGuvcUcr6jiRC+UQTTIEmzXuxK4qz+BamfrWLFCD2GwH83
        79QXXFpcWZ/zM/porl8oswtTJc6t9DgDC1sl2LI6BzPMwt+RdyLSseOi0EHhj7ZHQiW9WulR4ydaf
        /ynGskHSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htA92-0006RW-JK; Thu, 01 Aug 2019 12:25:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F00F42029F869; Thu,  1 Aug 2019 14:25:18 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:25:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     hpa@zytor.com, Joe Perches <joe@perches.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190801122518.GZ31398@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907311301.EC1D84F@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 01:02:07PM -0700, Kees Cook wrote:
> On Wed, Jul 31, 2019 at 08:48:32PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor.com wrote:
> > > >> > +/*
> > > >> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > > >> > + * must end with any of these keywords:
> > > >> > + *   break;
> > > >> > + *   fallthrough;
> > > >> > + *   goto <label>;
> > > >> > + *   return [expression];
> > > >> > + *
> > > >> > + *  gcc: >https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> > > >> > + */
> > > >> > +#if __has_attribute(__fallthrough__)
> > > >> > +# define fallthrough                   __attribute__((__fallthrough__))
> > > >> > +#else
> > > >> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > > >> > +#endif
> > > >> > +
> > 
> > > If the comments are stripped, how would the compiler see them to be
> > > able to issue a warning? I would guess that it is retained or replaced
> > > with some other magic token.
> > 
> > Everything that has the warning (GCC-7+/CLANG-9) has that attribute.
> 
> I'd like to make sure we don't regress Coverity most of all. If the
> recent updates to the Coverity scanner include support for the attribute
> now, then I'm all for it. :)

IMO Coverity can go pound sand, I never see its output, while I get to
look at the code and GCC output daily.
