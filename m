Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEAC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F5D20578
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ObGxVqBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfIQIQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:16:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfIQIQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:16:00 -0400
Received: from nazgul.tnic (unknown [193.86.95.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1BCF1EC0C1A;
        Tue, 17 Sep 2019 10:15:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568708155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RrtNIUMohCox+BYKXI+e26vky+21ewyw44X+ixcBCsY=;
        b=ObGxVqBTR4bHZeDtH2hxlu4CfRnKND+hG1Mv8X0k1YnQ/fIFsolnTuVDnmwWxcv+SPIswz
        F+VnE+hAa6lHi8caBRAzzdletHRDF93eCmjoVxW5oR0GT77v6qOHUxLqiN6XkJVM4zFeSX
        csvrxCk2vZ6/nsbDFHhaRvuWBUvAq0g=
Date:   Tue, 17 Sep 2019 10:15:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190917081549.GB12174@nazgul.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
 <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic>
 <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:25:25AM -0700, Linus Torvalds wrote:
> So the "inline constant sizes" case has advantages over and beyond the
> obvious ones. I suspect that a reasonable cut-off point is somethinig
> like "8*sizeof(long)". But look at things like "struct kstat" uses
> etc, the limit might actually be even higher than that.

Ok, sounds to me like we want to leave the small and build-time known
sizes to gcc to optimize. Especially if you want to clear only a subset
of the struct members and set the rest.

> Also note that while "rep stosb" is _reasonably_ good with current
> CPU's (ie roughly gen 8+), it's not so great a few generations ago
> (gen 6ish), and it can be absolutely horrid on older cores and/or
> atom. The limit for when it is a win ends up depending on whether I$
> footprint is an issue too, of course, but some of the bigger wins tend
> to happen when you have sizes >= 128.

Ok, so I have X86_FEATURE_ERMS set on this old IVB laptop so if gen8 and
newer do perform better, then we need to change our feature detection to
clear ERMS on those older generations and really leave it set only on
gen8+.

I'll change my benchmark to do explicit small-sized moves (instead of
using __builtin_memset) to see whether I can compare performance better.

Which also begs the question do we do __builtin_memset() at all or we
code those small-sized moves ourselves? We'll lose the advantage of the
partial struct members clearing but then we avoid the differences the
different compiler versions would introduce when the builtin is used.

And last but not least we should not leave readability somewhere along
the way: I'd prefer good performance and maintainable code than some
hypothetical max perf on some uarch but ugly and unreadable macro
mess...

> You can basically always beat "rep movs/stos" with hand-tuned AVX2/512
> code for specific cases if you don't look at I$ footprint and the cost
> of the AVX setup (and the cost of frequency changes, which often go
> hand-in-hand with the AVX use). So "rep movs/stos" is seldom
> _optimal_, but it tends to be "quite good" for modern CPU's with
> variable sizes that are in the 100+ byte range.

Right. If we did this, it would be a conditional in front of the REP;
STOS but that ain't worse than our current CALL+JMP.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
