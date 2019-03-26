Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB106C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE12E206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbfCZVVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:21:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCZVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:21:32 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8tUw-0006Zt-09; Tue, 26 Mar 2019 22:20:42 +0100
Date:   Tue, 26 Mar 2019 22:20:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 09/14] watchdog/hardlockup: Make arch_touch_nmi_watchdog()
 to hpet-based implementation
In-Reply-To: <20190301011713.GA8058@ranerica-svr.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1903262219100.1789@nanos.tec.linutronix.de>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1551283518-18922-10-git-send-email-ricardo.neri-calderon@linux.intel.com> <20190227161758.GE4072@linux.ibm.com> <20190301011713.GA8058@ranerica-svr.sc.intel.com>
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

On Thu, 28 Feb 2019, Ricardo Neri wrote:
> > > 
> > > -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF) || \
> > > +    defined(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET)
> > 
> > Why not instead make CONFIG_X86_HARDLOCKUP_DETECTOR_HPET select
> > CONFIG_HARDLOCKUP_DETECTOR_PERF?  Keep the arch-specific details
> > in the arch-specific files and all that.
> 
> Thanks for your feedback, Paul! The HPET implementation does not use
> perf. Thus, in my opinion is not correct for the HPET HLD to select
> the perf implementation. Patch 8 of this series splits the perf-specific
> code and the generic hardlockup detector code. Does this make sense?

That's what intermediate config symbols are for.

config HARDLOCKUP_DETECTOR_CORE
       bool

And make both PERF and HPET select it.

Thanks,

	tglx
