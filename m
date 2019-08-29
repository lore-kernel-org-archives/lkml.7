Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A20C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16984205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SYG5sitU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfH2LqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:46:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfH2LqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39FDEvdYRnlxX1A3HP6Hj2NjJAwRtcnGcB3gr3LYtD0=; b=SYG5sitUw8Ft+7l2eYZCLoAWl
        OOlm38WwtEms64hVeF3eOA+IGgqkHeA8AAHlZei78k+V7y0n3yfF14fxA9jQtIMWehj4xBlx6LNQo
        7TILupR7KvpNP0D9mAjia+AiTWgfaUub7L58dpGGH3CWMyK1alm8Edmb4sKAkwY8IxQWYVz7JWc8A
        gbvRIvY0Lrm/64yYAvbHNnl9TeSuSDoYZS9xm4XxV+dAl071KYrcqg8C+7uqJiTBXpAbfeLr0Hw+L
        wskBTlz4iXhTCMGEAB4Jn8g/K+/PLwKFscj550nSvbM3lt5dFeF445N4oJVXg2jJUrAaNlOPxa/ns
        s4KkOxeXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3IsP-0000W2-CG; Thu, 29 Aug 2019 11:46:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBD3C3074C6;
        Thu, 29 Aug 2019 13:45:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 311E22021D1A2; Thu, 29 Aug 2019 13:46:02 +0200 (CEST)
Date:   Thu, 29 Aug 2019 13:46:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Subject: Re: Tracing text poke / kernel self-modifying code (Was: Re: [RFC v2
 0/6] x86: dynamic indirect branch promotion)
Message-ID: <20190829114602.GR2369@hirez.programming.kicks-ass.net>
References: <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
 <20190109103544.GH1900@hirez.programming.kicks-ass.net>
 <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com>
 <20190829085339.GN2369@hirez.programming.kicks-ass.net>
 <d37f678f-cf1d-5c98-228f-05bed99f2112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37f678f-cf1d-5c98-228f-05bed99f2112@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:40:56PM +0300, Adrian Hunter wrote:
> Can you expand on "and ensure the poke_handler preserves the existing
> control flow"?  Whatever the INT3-handler does will be traced normally so
> long as it does not itself execute self-modified code.

My thinking was that the code shouldn't change semantics before emitting
the RECORD_TEXT_POKE; but you're right in that that doesn't seem to
matter much.

Either we run the old code or INT3 does 'something'.  Then we get
RECORD_TEXT_POKE and finish the poke.  Which tells that the moment INT3
stops the new text is in place.

I suppose that works too, and requires less changes.


