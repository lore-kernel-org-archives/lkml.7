Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B892C17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D402217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbfKEOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:48:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:48:38 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS08I-0005x6-1e; Tue, 05 Nov 2019 15:48:34 +0100
Date:   Tue, 5 Nov 2019 15:48:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Carlos O'Donell <carlos@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <87k18eqtod.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911051545530.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu>        <87woceslfs.fsf@oldenburg2.str.redhat.com>        <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>        <87sgn2skm6.fsf@oldenburg2.str.redhat.com>       
 <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>        <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com>        <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de> <87k18eqtod.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Florian Weimer wrote:
> * Thomas Gleixner:
> 
> > On Tue, 5 Nov 2019, Carlos O'Donell wrote:
> >> On 11/5/19 6:56 AM, Thomas Gleixner wrote:
> >> The other issue is this:
> >> 
> >> "Robust mutexes do not take ROBUST_LIST_LIMIT into account"
> >> https://sourceware.org/bugzilla/show_bug.cgi?id=19089
> >
> >   "The kernel limits the length of the robust mutex list to 2048 entries.
> >    This constant does not seem to be exported to user space."
> >
> > FWIW, the constant is defined in the UAPI futex header.
> >
> > The main concern here is not the actual number of futexes held by a task.
> >
> > The real issue is that the robust list could be circular by incident or
> > malice and there is no way for the kernel to figure that out. That would
> > prevent the task from exiting and make it iterate over the list until
> > doomsday, i.e. a nice unpriviledged DoS.
> >
> > So I fear the kernel cannot really help with this one.
> 
> I'm actually fine with treating ROBUST_LIST_LIMIT as an ABI constant.
> It's just not clear to me if the constant has this status today.  I
> suspect it was just split from the implementation headers at one point.

Yes, but we really can declare it as an ABI constant.

I think the limit is reasonably sized. But I'm not familiar with the lock
nesting expectations of insanely big enterprise applications.

Thanks,

	tglx
