Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD99FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D9C2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfDBTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:21:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:21:38 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBOyU-0006lf-Rf; Tue, 02 Apr 2019 21:21:34 +0200
Date:   Tue, 2 Apr 2019 21:21:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
In-Reply-To: <4db4323f-3416-54a8-27e3-c491827a2fbd@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1904022109250.1812@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <4db4323f-3416-54a8-27e3-c491827a2fbd@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Rasmus Villemoes wrote:

> On 02/04/2019 17.48, Thomas Gleixner wrote:
> > On Tue, 2 Apr 2019, Josh Poimboeuf wrote:
> >> On Tue, Apr 02, 2019 at 12:19:46PM +0200, Thomas Gleixner wrote:
> >>> +/*
> >>> + * Array of exception stack page descriptors. If the stack is larger than
> >>> + * PAGE_SIZE, all pages covering a particular stack will have the same
> >>> + * info.
> >>> + */
> >>> +static const struct estack_pages estack_pages[ESTACK_PAGES] ____cacheline_aligned = {
> >>> +	[CONDRANGE(DF)]		= ESTACK_PAGE(DOUBLEFAULT_IST, DF),
> >>> +	[CONDRANGE(NMI)]	= ESTACK_PAGE(NMI_IST, NMI),
> >>> +	[PAGERANGE(DB)]		= ESTACK_PAGE(DEBUG_IST, DB),
> >>> +	[CONDRANGE(MCE)]	= ESTACK_PAGE(MCE_IST, MCE),
> >>
> >> It would be nice if the *_IST macro naming aligned with the struct
> >> cea_exception_stacks field naming.  Then you could just do, e.g.
> >> ESTACKPAGE(DF).
> > 
> > Yes, lemme fix that up.
> > 
> >> Also it's a bit unfortunate that some of the stack size knowledge is
> >> hard-coded here, i.e #DB always being > 1 page and non-#DB being
> >> sometimes 1 page.
> > 
> > The problem is that there is no way to make this macro maze conditional on
> > sizeof(). But my macro foo is rusty.
> 
> Eh, but why do you need the CONDRANGE thing at all? [5 ... 5] is a
> perfectly fine designator, equivalent to [5]. So you can just use
> PAGERANGE in all cases, no?

Indeed. I tried that before and at some point GCC barfed, but probably due
to some other slipup. The macro expansion error messages are soo helpful...

Thanks,

	tglx

