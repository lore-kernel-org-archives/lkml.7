Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6CCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EEB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HX/EPF1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfGaUCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:02:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40518 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbfGaUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:02:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so30903318pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wxJGZH7300Hgl5asMFjAs9ArUsIJe/EH5/uSYQ1iyTY=;
        b=HX/EPF1G9PXWWCeOuwtSGUYRGPz8KC0ErJdpABtKhERiS3N871Qmms8DCCGQlhE8LV
         I9IaFsrGl2wuuUB/Us84dpAaxGjTlPfCwe/nfUhmTCqX+Pr7R5VGvA/6OPrHfFph1rjd
         H8gKwwHigNku3W/W2ISHwc82SSQBos0giQSHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wxJGZH7300Hgl5asMFjAs9ArUsIJe/EH5/uSYQ1iyTY=;
        b=uj9cHTHabm2ru+g2uqjpirBBbD5llc2lnUEByBkzRDm9w/LtLlX/bBn0PSmyTM7m6i
         4oW7oSw9ik2AqX0sW+fEk6A4vEHhFRDB5kwyW31ML1zZb/noBFTvAYakjnNda/tH16qk
         QakQRAWn3xVYqInAe/FKOWdOCtv1ldslW1akd7SiriW+pRU7hJxvlifRkxdVA7gk54Hk
         u96rqEzPyIOEJuplNtdh7lyrcEIdEjkqnKYYTXwN6jymG9+qINce2fZwgXrxCR00PpR6
         lpbRmV7qRWSiYLW22obKULtaFLbVvTjPRlEigwtB5nc0HEPTi+r/Xxy8HKa+dCPKL7zu
         4SSQ==
X-Gm-Message-State: APjAAAViMcTpaC+/qnWN3NdMDTlQ34AqDU+KT22eSw9W6siybePvJTYI
        LWf3zoxNAih1lvCi3AQANwdU/A==
X-Google-Smtp-Source: APXvYqwj1zep+ZZXF3Ri3+Jyb3qYUQRgfqwHDJSbxfZDvAjGESsg9IbU6tepVSR5HREw2MVEik1giA==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr98479912pld.193.1564603329180;
        Wed, 31 Jul 2019 13:02:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm74088643pfy.167.2019.07.31.13.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 13:02:08 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:02:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <201907311301.EC1D84F@keescook>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 08:48:32PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor.com wrote:
> > >> > +/*
> > >> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > >> > + * must end with any of these keywords:
> > >> > + *   break;
> > >> > + *   fallthrough;
> > >> > + *   goto <label>;
> > >> > + *   return [expression];
> > >> > + *
> > >> > + *  gcc: >https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> > >> > + */
> > >> > +#if __has_attribute(__fallthrough__)
> > >> > +# define fallthrough                   __attribute__((__fallthrough__))
> > >> > +#else
> > >> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > >> > +#endif
> > >> > +
> 
> > If the comments are stripped, how would the compiler see them to be
> > able to issue a warning? I would guess that it is retained or replaced
> > with some other magic token.
> 
> Everything that has the warning (GCC-7+/CLANG-9) has that attribute.

I'd like to make sure we don't regress Coverity most of all. If the
recent updates to the Coverity scanner include support for the attribute
now, then I'm all for it. :)

-- 
Kees Cook
