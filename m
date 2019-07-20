Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0653C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA822084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 08:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGTIp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 04:45:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfGTIp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 04:45:27 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hokzE-0006jg-6h; Sat, 20 Jul 2019 10:45:00 +0200
Date:   Sat, 20 Jul 2019 10:44:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
In-Reply-To: <alpine.DEB.2.21.1907200039110.1782@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907201044150.1782@nanos.tec.linutronix.de>
References: <20190702053151.26922-1-devel@etsukata.com> <20190702072821.GX3419@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de> <20190702113355.5be9ebfe@gandalf.local.home> <20190702133905.1482b87e@gandalf.local.home>
 <20190719202836.GB13680@linux.intel.com> <alpine.DEB.2.21.1907200018050.1782@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907200039110.1782@nanos.tec.linutronix.de>
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

On Sat, 20 Jul 2019, Thomas Gleixner wrote:
> On Sat, 20 Jul 2019, Thomas Gleixner wrote:
> > On Fri, 19 Jul 2019, Sean Christopherson wrote:
> > > [    0.680477] Run /sbin/init as init process
> > > [    0.682116] init[1]: segfault at 2926a7ef ip 00007f98a49d9c30 sp 00007fffd83e6af0 error 14 in ld-2.23.so[7f98a49d9000+26000]
> > 
> > That's because the call into the context tracking muck clobbers RDX which
> > contains the CR2 value on pagefault. So the pagefault resolves to crap and
> > kills init.
> > 
> > Brute force fix below. That needs to be conditional on read_cr2 but for now
> > it does the job.
> 
> But it does it just for the context tracking case. TRACE_IRQS_OFF* will do
> the same damage.

Hmm, should not becasue that calls through the thunk which preserves RDX.

