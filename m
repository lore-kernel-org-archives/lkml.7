Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C24C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE43C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sFymQmSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfGaSsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:48:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfGaSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T7ULjvdqUswUXl7xdVoocHJnJnvyW9s8KsaXijspzNI=; b=sFymQmSbsIBXGw2JPbXmQWGsa
        8+7CEUKjwOY26lsLhmqwV2Th6QUZAX87HGNeH11Treo8bWR0RGYmRDRgu6JVc+yGnAHtTrsX/Sj5s
        76vKQYPbq8UDcGHDMhnFuQ8oQvmwoPjlBPBmFv3Z79ohxE102eY8bim2lV3d2U1Dx5BiVZPFTp+Bj
        hCkb9KhDKkeCLfFs49S0+xiPINUBlDwTL+9cSpOoQbtUGK0CBxAcCQ7wcrFEqovILqegDicPARS1+
        ld82x5BEfdAXsKq4B4IBnCcaZKpgt8s3OCXFRX7E3kWJtfLgwx3nVpEcvCY/SdwyDGUKANQlsOoSE
        6QIF1bZDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsteN-0000up-BM; Wed, 31 Jul 2019 18:48:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 060602029F4C5; Wed, 31 Jul 2019 20:48:33 +0200 (CEST)
Date:   Wed, 31 Jul 2019 20:48:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor.com wrote:
> >> > +/*
> >> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> >> > + * must end with any of these keywords:
> >> > + *   break;
> >> > + *   fallthrough;
> >> > + *   goto <label>;
> >> > + *   return [expression];
> >> > + *
> >> > + *  gcc: >https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> >> > + */
> >> > +#if __has_attribute(__fallthrough__)
> >> > +# define fallthrough                   __attribute__((__fallthrough__))
> >> > +#else
> >> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> >> > +#endif
> >> > +

> If the comments are stripped, how would the compiler see them to be
> able to issue a warning? I would guess that it is retained or replaced
> with some other magic token.

Everything that has the warning (GCC-7+/CLANG-9) has that attribute.

