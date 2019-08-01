Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCABC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2DD20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rxbEXkfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfHAMZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:25:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHAMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=76PMtUuXYo20gRdBZd0LzwX6gb729ry8PD/6QGfH56E=; b=rxbEXkfVTpCSWkHqNVUGWjqW/
        G6CbeuNUNEBx2iuuttyC7kmiXyMKvUEn0vH6nT9+5ytMOFMwWmPhk80EXTge3+Ovx+k8kzR4rQVup
        0E9Goaug7eD08an9MeWCsTWsNGG/GBc2WHuoELlWGvwzr3yD2IwfZcxcAXJjHnawtI9OUPBj+9D9J
        9gVk8otF2fXLA0S/CNL8QcMEabbymgacbnOK8GFrXoy6sShB3CJHOsQCLzq1i8eQrRp35RFQKqNdL
        i85AHsG9RreuQY4C8GbCzcWaK916qo5l0b0Ilo8fk4/NTFQe3pPOA+JPNVSXr0Scv7IdpxmTFzPqB
        fyKu2IMcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htA8G-0006R3-FR; Thu, 01 Aug 2019 12:24:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8150F2029F869; Thu,  1 Aug 2019 14:24:29 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:24:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190801122429.GY31398@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd>
 <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
 <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
 <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:10:36PM -0700, hpa@zytor.com wrote:
> On July 31, 2019 4:55:47 PM PDT, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> >On Wed, Jul 31, 2019 at 11:01 PM <hpa@zytor.com> wrote:
> >>
> >> The standard is moving toward adding this as an attribute with the
> >[[fallthrough]] syntax; it is in C++17, not sure when it will be in C
> >be if it isn't already.
> >
> >Not yet, but it seems to be coming:
> >
> >  http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf
> >
> >However, even if C2x gets it, it will be quite a while until the GCC
> >minimum version gets bumped up to that, so...
> >
> >Cheers,
> >Miguel
> 
> The point was that we should plan ahead in whatever we end up doing.

By reserving 'fallthrough' as a keyword we do exactly that. We can then
define it to whatever the compiler/tool at hand requires.

Once GCC gains support for that [[attribute]] nonsense, we can detector
that and use that over the __attribute__(())

[ Also the Cxx attribute syntax is an abomination -- just a lesser one
than reading actual comments :-) ]
