Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C67C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F273206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 18:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfG0SnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:43:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbfG0SnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:43:14 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrRer-00084q-Tj; Sat, 27 Jul 2019 20:43:06 +0200
Date:   Sat, 27 Jul 2019 20:43:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [5.2 REGRESSION] Generic vDSO breaks seccomp-enabled userspace
 on i386
In-Reply-To: <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907272042310.1791@nanos.tec.linutronix.de>
References: <201907221012.41504DCD@keescook> <alpine.DEB.2.21.1907222027090.1659@nanos.tec.linutronix.de> <201907221135.2C2D262D8@keescook> <CALCETrVnV8o_jqRDZua1V0s_fMYweP2J2GbwWA-cLxqb_PShog@mail.gmail.com> <201907221620.F31B9A082@keescook>
 <CALCETrWqu-S3rrg8kf6aqqkXg9Z+TFQHbUgpZEiUU+m8KRARqg@mail.gmail.com> <201907231437.DB20BEBD3@keescook> <alpine.DEB.2.21.1907240038001.27812@nanos.tec.linutronix.de> <201907231636.AD3ED717D@keescook> <alpine.DEB.2.21.1907240155080.2034@nanos.tec.linutronix.de>
 <20190726180103.GE3188@linux.intel.com> <CALCETrUe50sbMx+Pg+fQdVFVeZ_zTffNWGJUmYy53fcHNrOhrQ@mail.gmail.com>
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

On Sat, 27 Jul 2019, Andy Lutomirski wrote:

> On Fri, Jul 26, 2019 at 11:01 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > +cc Paul
> >
> > On Wed, Jul 24, 2019 at 01:56:34AM +0200, Thomas Gleixner wrote:
> > > On Tue, 23 Jul 2019, Kees Cook wrote:
> > >
> > > > On Wed, Jul 24, 2019 at 12:59:03AM +0200, Thomas Gleixner wrote:
> > > > > And as we have sys_clock_gettime64() exposed for 32bit anyway you need to
> > > > > deal with that in seccomp independently of the VDSO. It does not make sense
> > > > > to treat sys_clock_gettime() differently than sys_clock_gettime64(). They
> > > > > both expose the same information, but the latter is y2038 safe.
> > > >
> > > > Okay, so combining Andy's ideas on aliasing and "more seccomp flags",
> > > > we could declare that clock_gettime64() is not filterable on 32-bit at
> > > > all without the magic SECCOMP_IGNORE_ALIASES flag or something. Then we
> > > > would alias clock_gettime64 to clock_gettime _before_ the first evaluation
> > > > (unless SECCOMP_IGNORE_ALIASES is set)?
> > > >
> > > > (When was clock_gettime64() introduced? Is it too long ago to do this
> > > > "you can't filter it without a special flag" change?)
> > >
> > > clock_gettime64() and the other sys_*time64() syscalls which address the
> > > y2038 issue were added in 5.1
> >
> > Paul Bolle pointed out that this regression showed up in v5.3-rc1, not
> > v5.2.  In Paul's case, systemd-journal is failing.
> 
> I think it's getting quite late to start inventing new seccomp
> features to fix this.  I think the right solution for 5.3 is to change
> the 32-bit vdso fallback to use the old clock_gettime, i.e.
> clock_gettime32.  This is obviously not an acceptable long-term
> solution.

Sigh. I'll have a look....

Thanks,

	tglx

