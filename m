Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD32064A
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfHAVeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:34:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHAVea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:34:30 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htIiO-0002Tq-7E; Thu, 01 Aug 2019 23:34:24 +0200
Date:   Thu, 1 Aug 2019 23:34:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
Message-ID: <alpine.DEB.2.21.1908012331550.1789@nanos.tec.linutronix.de>
References: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com> <20190801211613.GB3578@hirez.programming.kicks-ass.net> <b4597324-6eb8-31fa-e911-63f3b704c974@amd.com>
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

On Thu, 1 Aug 2019, Lendacky, Thomas wrote:
> On 8/1/19 4:16 PM, Peter Zijlstra wrote:
> > On Thu, Aug 01, 2019 at 06:57:41PM +0000, Lendacky, Thomas wrote:
> >> From: Tom Lendacky <thomas.lendacky@amd.com>
> >>
> >> It turns out that the NMI latency workaround from commit 6d3edaae16c6
> >> ("x86/perf/amd: Resolve NMI latency issues for active PMCs") ends up
> >> being too conservative and results in the perf NMI handler claiming NMIs
> >> to easily on AMD hardware when the NMI watchdog is active.
> >>
> >> This has an impact, for example, on the hpwdt (HPE watchdog timer) module.
> >> This module can produce an NMI that is used to reset the system. It
> >> registers an NMI handler for the NMI_UNKNOWN type and relies on the fact
> >> that nothing has claimed an NMI so that its handler will be invoked when
> >> the watchdog device produces an NMI. After the referenced commit, the
> >> hpwdt module is unable to process its generated NMI if the NMI watchdog is
> >> active, because the current NMI latency mitigation results in the NMI
> >> being claimed by the perf NMI handler.
> >>
> >> Update the AMD perf NMI latency mitigation workaround to, instead, use a
> >> window of time. Whenever a PMC is handled in the perf NMI handler, set a
> >> timestamp which will act as a perf NMI window. Any NMIs arriving within
> >> that window will be claimed by perf. Anything outside that window will
> >> not be claimed by perf. The value for the NMI window is set to 100 msecs.
> >> This is a conservative value that easily covers any NMI latency in the
> >> hardware. While this still results in a window in which the hpwdt module
> >> will not receive its NMI, the window is now much, much smaller.
> > 
> > Blergh, I so hate all this. The proposed patch is basically duct tape.
> 
> Yeah, I'm not a fan either.
> 
> > 
> > The horribly retarded x86 NMI infrastructure strikes again :/
> > 
> > Tom; do you have any idea how expensive it is to twiddle CR8 and play
> > games with interrupt priorities instead of piling world + dog on this
> > one NMI line? (as compared to CLI/STI)
> 
> I can check on that.  What are you thinking?

Avoid the whole NMI mess, make the PMC interrupt a proper vector in the
highest prio bucket and instead of using CLI/STI use CR8. That would have
the additional advantage that we could prevent perf "NMI" then occsionally :)

Thanks,

	tglx
