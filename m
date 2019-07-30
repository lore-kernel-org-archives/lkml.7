Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D713C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1569B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfG3UOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:14:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58460 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfG3UOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:14:14 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsYVg-0000Tv-CI; Tue, 30 Jul 2019 22:14:12 +0200
Date:   Tue, 30 Jul 2019 22:14:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 3/5] lib/vdso/32: Provide legacy syscall fallbacks
In-Reply-To: <CALCETrXmu8BtZ47AE-qo2bax9n1PyOM90yLSjkzE6rekbxv9zQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907302212410.1786@nanos.tec.linutronix.de>
References: <20190728131251.622415456@linutronix.de> <20190728131648.786513965@linutronix.de> <20190729144831.GA21120@linux.intel.com> <alpine.DEB.2.21.1907301134470.1738@nanos.tec.linutronix.de>
 <CALCETrXmu8BtZ47AE-qo2bax9n1PyOM90yLSjkzE6rekbxv9zQ@mail.gmail.com>
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

On Tue, 30 Jul 2019, Andy Lutomirski wrote:

> On Tue, Jul 30, 2019 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > To address the regression which causes seccomp to deny applications the
> > access to clock_gettime64() and clock_getres64() syscalls because they
> > are not enabled in the existing filters.
> >
> > That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
> > clock_getres64() syscalls in the fallback path.
> >
> > Add a conditional to invoke the 32bit legacy fallback syscalls instead of
> > the new 64bit variants. The conditional can go away once all architectures
> > are converted.
> >
> 
> I haven't surveyed all the architectures, but once everything is
> converted, shouldn't we use the 32-bit fallback for exactly the same
> set of architectures that want clock_gettime32 at all in the vdso?

Yes. That's why I want to remove the conditional once all all converted
over, that's x86/aaarg64 in mainline and a few in next.

Thanks,

	tglx
