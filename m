Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B0CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197720665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfFWMh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:37:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33336 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:37:58 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf1kj-0000ro-CY; Sun, 23 Jun 2019 14:37:49 +0200
Date:   Sun, 23 Jun 2019 14:37:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/9] x86: Concurrent TLB flushes and other improvements
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
Message-ID: <alpine.DEB.2.21.1906231431340.32342@nanos.tec.linutronix.de>
References: <20190613064813.8102-1-namit@vmware.com>
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

Nadav,

On Wed, 12 Jun 2019, Nadav Amit wrote:

> Patch 1 does small cleanup. Patches 2-5 implement the concurrent
> execution of TLB flushes. Patches 6-9 deal with false-sharing and
> unnecessary atomic operations. There is still no implementation that
> uses the concurrent TLB flushes by Xen and Hyper-V. 

I've picked up the patches which make sense independent of the TLB
optimization. So they are out of your way :)

> There are various additional possible optimizations that were sent or
> are in development (async flushes, x2apic shorthands, fewer mm_tlb_gen
> accesses, etc.), but based on Andy's feedback, they will be sent later.

Vs. x2apic shorthands. It's not only x2apic. We generally do not make use
of shorthands when CPU hotplug is enabled as that needs some deep care
vs. the state whether a present CPU had been brought up at least once,
similar to the MCE issue which causes us to do the online/offlie dance for
SMT control at boot. There are a few other nasty details like the APIC
state on CPU hot unplug and NMI shorthands.

I have a WIP series in the pipeline which I'm going to post soon. I'll put
you on CC.

For the TLB related parts, I delegate the review happily to our x86 mm/tlb
wizards. Hint, hint ...

Thanks,

	tglx
