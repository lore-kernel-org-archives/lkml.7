Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9935DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9572084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CxLtcMsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfHOSP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:15:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36635 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfHOSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:15:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so1370818plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kn0Di8JpH6OYSXfMr8qLZDKOrpw9hHzJyOkJdZzHsTw=;
        b=CxLtcMsE2fY06JhiVarc3sUWzUQxo1LyaSU00z4wrCckgdQ9NKise+GhWrgJA45TXF
         L4Hvv/Vj++GKup81A/rR7aRncpTRmqRH69EOs/yvELFjtO18hMuxUTOS5fvyTW5e5DaI
         hTKS3yt5WLGAc0vZD78FyKfn5CIzD/8jHHYJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kn0Di8JpH6OYSXfMr8qLZDKOrpw9hHzJyOkJdZzHsTw=;
        b=P1S16NaGmPhhURCyVDwmG08MmPl0N1VZzjPaaZ7rmLGlhoR0Z63Y2hr4XiKSU+CiNn
         I20ZlYvh78S1cbGW+M8/b/b1q9JmjXi4YkhVMJzf2+y5MXmt/lfl+JDqkTfeKoKiq5US
         kdMGG8/fP0Wb2I/cUmWNnrc6hlFVh0vB7rSADnsVfSgM0u8SN84dy1X4SUQQlJpqDznO
         ypIfdEDOZhI3qom7V/SpuswGbLUiwFKWd5iIqnQJFOgHPCbcxWbzJiWzEcwwQC1pSjwm
         l1cdBHNBYAH5aBMUHub44GgZae1aGKKqlzRy91u2+nHqJekdG5xigM5iJzo1adEcSIcO
         CkjQ==
X-Gm-Message-State: APjAAAWZWI7vldp1KQ6viLufKyFxoJnFHlDZXpPA5qEnETDR1b4IpUZY
        uhNmtdu8X1apgBCYQ7gozPxIkQ==
X-Google-Smtp-Source: APXvYqxCI29Fbpj2N6FySny8bkSiZPGZRXDMSpyCGHCynsJ3UykI9XqvKtz48QIsLb+V1iS6GDT3Sw==
X-Received: by 2002:a17:902:1e3:: with SMTP id b90mr4619377plb.82.1565892954953;
        Thu, 15 Aug 2019 11:15:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a189sm3694948pfa.60.2019.08.15.11.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 11:15:54 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:15:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     hpa@zytor.com, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <201908151049.809B9AFBA9@keescook>
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

I want to recant my position on Coverity coverage being a requirement
here. While I was originally concerned about suddenly adding thousands
more warnings to Coverity scans (if it doesn't support the flag --
I should know soon), it's been made clear to me we're now at the point
where this is about to happen for Clang instead (since _it_ doesn't
support the comment-style marking and never will but is about to gain
C support[1] for the detection -- it only had C++ before).

With that out of the way, yes, let's do a mass conversion. As mentioned
before, I think "fallthrough;" should be used here (to match "break;").
Let's fork the C language. :)

-Kees

[1] https://reviews.llvm.org/D64838

-- 
Kees Cook
