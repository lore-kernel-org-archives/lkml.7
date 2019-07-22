Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B930C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5018421901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfGVSbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:31:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:31:44 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpd5y-0001S0-83; Mon, 22 Jul 2019 20:31:34 +0200
Date:   Mon, 22 Jul 2019 20:31:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <201907221012.41504DCD@keescook>
Message-ID: <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de>
References: <20190719170343.GA13680@linux.intel.com> <19EF7AC8-609A-4E86-B45E-98DFE965DAAB@amacapital.net> <201907221012.41504DCD@keescook>
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

On Mon, 22 Jul 2019, Kees Cook wrote:
> On Fri, Jul 19, 2019 at 01:40:13PM -0400, Andy Lutomirski wrote:
> > > On Jul 19, 2019, at 1:03 PM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > > 
> > > The generic vDSO implementation, starting with commit
> > > 
> > >   7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> > > 
> > > breaks seccomp-enabled userspace on 32-bit x86 (i386) kernels.  Prior to
> > > the generic implementation, the x86 vDSO used identical code for both
> > > x86_64 and i386 kernels, which worked because it did all calcuations using
> > > structs with naturally sized variables, i.e. didn't use __kernel_timespec.
> > > 
> > > The generic vDSO does its internal calculations using __kernel_timespec,
> > > which in turn requires the i386 fallback syscall to use the 64-bit
> > > variation, __NR_clock_gettime64.
> > 
> > This is basically doomed to break eventually, right?
> 
> Just so I'm understanding: the vDSO change introduced code to make an
> actual syscall on i386, which for most seccomp filters would be rejected?

No. The old x86 specific VDSO implementation had a fallback syscall as
well, i.e. clock_gettime(). On 32bit clock_gettime() uses the y2038
endangered timespec.

So when the VDSO was made generic we changed the internal data structures
to be 2038 safe right away. As a consequence the fallback syscall is not
clock_gettime(), it's clock_gettime64(). which seems to surprise seccomp.

Thanks,

	tglx
