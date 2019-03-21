Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69721902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfCURwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:52:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCURwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:52:01 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h71r8-0002dL-Nt; Thu, 21 Mar 2019 18:51:54 +0100
Date:   Thu, 21 Mar 2019 18:51:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephane Eranian <eranian@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
In-Reply-To: <CABPqkBSZbAbU5h=t2f=oMre080ezSq78LaNQO5xEdRV1nczuew@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903211844010.1784@nanos.tec.linutronix.de>
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org> <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com> <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net> <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com> <20190320222220.GA2490@worktop.programming.kicks-ass.net> <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de> <CABPqkBSZbAbU5h=t2f=oMre080ezSq78LaNQO5xEdRV1nczuew@mail.gmail.com>
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

On Thu, 21 Mar 2019, Stephane Eranian wrote:
> On Thu, Mar 21, 2019 at 9:45 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, 21 Mar 2019, Peter Zijlstra wrote:
> > > Subject: perf/x86/intel: Initialize TFA MSR
> > >
> > > Stephane reported that we don't initialize the TFA MSR, which could lead
> > > to trouble if the RESET value is not 0 or on kexec.
> >
> > That sentence doesn't parse.
> >
> >   Stephane reported that the TFA MSR is not initialized by the kernel, but
> >   the TFA bit could set by firmware or as a leftover from a kexec, which
> >   makes the state inconsistent.
> >
> Correct. This is what I meant.
> The issue is what does the kernel guarantee when it boots?
> 
> I see:
> static bool allow_tsx_force_abort = true;
> 
> Therefore you must ensure the MSR is set to reflect that state on boot.
> So you have to force it to that value to be in sync which is what your
> new patch is doing.

The initial state should be that the MSR TFA bit is 0. The software state
is a different beast.

allow_tsx_force_abort

  false			Do not set MSR TFA bit (Make TSX work with PMC3) and
  			exclude PMC3 from being used.

  true			Set the MSR TFA bit when PMC3 is used by perf, clear it
  			when PMC3 is not longer in use.

Now, if the firmware or the kexec has the TFA bit set in the MSR and PMC3
is not in use then TSX always aborts pointlessly. It's not a fatal isseu,
but it's inconsistent.

So independent of the state of allow_tsx_force_abort the kernel has to
clear the MSR TSA bit when the CPUs are brought up.

The state of allow_tsx_force_abort is solely relevant after CPUs coming up
to decide whether PMC3 can be used by perf or not.

Thanks,

	tglx

