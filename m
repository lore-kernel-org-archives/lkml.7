Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1054C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD0920838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfHAV7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:59:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfHAV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:59:51 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htJ6w-0003CC-Kb; Thu, 01 Aug 2019 23:59:46 +0200
Date:   Thu, 1 Aug 2019 23:59:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
In-Reply-To: <20190801214813.GB2332@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908012352390.1789@nanos.tec.linutronix.de>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com> <20190801211613.GB3578@hirez.programming.kicks-ass.net> <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com> <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
 <20190801214813.GB2332@hirez.programming.kicks-ass.net>
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

On Thu, 1 Aug 2019, Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 11:34:23PM +0200, Thomas Gleixner wrote:
> > Avoid the whole NMI mess, make the PMC interrupt a proper vector in the
> > highest prio bucket and instead of using CLI/STI use CR8. That would have
> > the additional advantage that we could prevent perf "NMI" then occsionally :)
> 
> Exactly, and not only the PMC, we can basically start giving out actual
> vectors on register_nmi_handler() and do away with all that shared line
> crap.
> 
> And then the actual NMI line will be mostly empty again, and it can read
> its stupid slow reason port again.
> 
> One complication though; IRET et al only do EFLAGS, not CR8, so that's
> going to be massive fun :-(
> 
> Did I say I hates the x86 interrupt scheme?

You're not alone.

That stuff definitely violates article 3 of the Convention for the
Protection of Human Rights and Fundamental Freedoms.


