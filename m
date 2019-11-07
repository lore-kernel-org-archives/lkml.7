Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C2C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C42087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfKGK2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:28:51 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:14670 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfKGK2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:28:50 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xA7ARuBv015631;
        Thu, 7 Nov 2019 11:27:56 +0100
Date:   Thu, 7 Nov 2019 11:27:56 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     hpa@zytor.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107102756.GD15536@1wt.eu>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com>
 <20191107091704.GA15536@1wt.eu>
 <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
 <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 02:19:19AM -0800, hpa@zytor.com wrote:
> >Changing ioperm(single port, port range) to be ioperm(all) is going to
> >break a bunch of test cases which actually check whether the permission
> >is restricted to a single I/O port or the requested port range.
> >
> >Thanks,
> >
> >	tglx
> 
> This seems very undesirable... as much as we might wish otherwise, the port
> bitmap is the equivalent to the MMU, and there are definitely users doing
> direct device I/O out there.

Doing these, sure, but doing these while ranges are really checked ?
I mean, the MMU grants you access to the pages you were assigned. Here
with the I/O bitmap you just have to ask for access to port X and you
get it. I could understand the benefit if we had EBUSY in return but
that's not the case, you can actually request access to a port range
another device driver or process is currently using, and mess up with
what it does even by accident. I remember streaming 1-bit music in
userland from the LED of my floppy drive in the late-90s, it used to
cause some trouble to the floppy driver when using mtools in parallel :-)

Willy
