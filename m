Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D29C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7006A217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbfKEJ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:59:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfKEJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:59:31 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRvcS-0000Cb-W3; Tue, 05 Nov 2019 10:59:25 +0100
Date:   Tue, 5 Nov 2019 10:59:24 +0100 (CET)
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
In-Reply-To: <87woceslfs.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Florian Weimer wrote:
> * Shawn Landden:
> > If this new ABI is used, then bit 1 of the *next pointer of the
> > user-space robust_list indicates that the futex_offset2 value should
> > be used in place of the existing futex_offset.
> 
> The futex interface currently has some races which can only be fixed by
> API changes.  I'm concerned that we sacrifice the last bit for some
> rather obscure feature.  What if we need that bit for fixing the
> correctness issues?

That current approach is going nowhere and if we change the ABI ever then
this needs to happen with all *libc folks involved and agreeing.

Out of curiosity, what's the race issue vs. robust list which you are
trying to solve?

Thanks,

	tglx
