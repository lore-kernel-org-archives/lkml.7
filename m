Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3328C010C6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0CD20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfKEL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:56:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfKEL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:56:45 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRxRx-00034c-0y; Tue, 05 Nov 2019 12:56:41 +0100
Date:   Tue, 5 Nov 2019 12:56:40 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Shawn Landden <shawn@git.icu>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Florian Weimer wrote:
> * Thomas Gleixner:
> > On Tue, 5 Nov 2019, Florian Weimer wrote:
> >> * Shawn Landden:
> >> > If this new ABI is used, then bit 1 of the *next pointer of the
> >> > user-space robust_list indicates that the futex_offset2 value should
> >> > be used in place of the existing futex_offset.
> >> 
> >> The futex interface currently has some races which can only be fixed by
> >> API changes.  I'm concerned that we sacrifice the last bit for some
> >> rather obscure feature.  What if we need that bit for fixing the
> >> correctness issues?
> >
> > That current approach is going nowhere and if we change the ABI ever then
> > this needs to happen with all *libc folks involved and agreeing.
> >
> > Out of curiosity, what's the race issue vs. robust list which you are
> > trying to solve?
> 
> Sadly I'm not trying to solve them.  Here's one of the issues:
> 
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=14485>

That one seems more a life time problem, i.e. the mutex is destroyed,
memory freed and map address reused while another thread was not yet out of
the mutex_unlock() call. Nasty.

Thanks,

	tglx

 
