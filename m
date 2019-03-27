Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35868C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0067820700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfC0VQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:16:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfC0VQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:16:04 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9Ftm-0002En-OI; Wed, 27 Mar 2019 22:15:50 +0100
Date:   Wed, 27 Mar 2019 22:15:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: New feature/ABI review process [was Re: [RESEND PATCH v6 04/12]
 x86/fsgsbase/64:..]
In-Reply-To: <20190326225638.GQ18020@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1903272147180.1789@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de> <20190326003804.GK18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de> <20190326225638.GQ18020@tassilo.jf.intel.com>
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

On Tue, 26 Mar 2019, Andi Kleen wrote:
> As long as everything is cache hot it's likely only a couple
> of cycles difference (as Intel CPUs are very good executing
> crappy code too), but if it's not then you end up with a huge cache miss
> cost, causing jitter. That's a problem for real time for example.

That extra cache miss is really not the worst issue for realtime. The
inherent latencies of contemporary systems have way worse to offer than
that. Any realtime system has to cope with the worst case and an extra
cache miss is not the end of the world.

> >   > Accessing user GSBASE needs a couple of SWAPGS operations. It is
> >   > avoidable if the user GSBASE is saved at kernel entry, being updated as
> >   > changes, and restored back at kernel exit. However, it seems to spend
> >   > more cycles for savings and restorations. Little or no benefit was
> >   > measured from experiments.
> > 
> > So little or no benefit was measured. I don't see how that maps to your
> > 'SWAPGS will be a lot faster' claim. One of those claims is obviously
> > wrong.
> 
> If everything is cache hot it won't make much difference,
> but if you have a cache miss you end up eating the cost.
> 
> > 
> > Aside of this needs more than numbers:
> > 
> >   1) Proper documentation how the mixed bag is managed.
> 
> How SWAPGS is managed?
> 
> Like it always was since 20+ years when the x86_64
> port was originally born.

I know how SWAPGS works.
 
> The only case which has to do an two SWAPGS is the 
> context switch when it switches the base. Everything else
> just does SWAPGS at the edges for kernel entries.

And exactly here is the problem. You are not even describing it correctly
now:

	You cannot do SWAPGS on _all_ edges.

You cannot do SWAPGS in the paranoid entry when FSGSBASE is in use, because
user space can write arbitrary values into GS. Which breaks the existing
differentiation of kernel/user GS. That's why you have the FSGSBASE variant
there. Is that documented?

The changelog has some convoluted description of it:

  "The FSGSBASE instructions allow fast accesses on GSBASE.  Now, at the
   paranoid_entry, the per-CPU base value can be always copied to GSBASE.
   And the original GSBASE value will be restored at the exit."

So that part blurbs about fast access and comes first. Really useful.

  "So far, GSBASE modification has not been directly allowed from userspace.
   So, swapping GSBASE has been conditionally executed according to the
   kernel-enforced convention that a negative GSBASE indicates a kernel value.
   But when FSGSBASE is enabled, userspace can put an arbitrary value in
   GSBASE. The change will secure a correct GSBASE value with FSGSBASE."

I can decode that because I'm familiar with the inner workings of the
paranoid entry code. But that changelog is just not providing properly
structured information and the full context.

What's worse is the comment in the code itself:

+ * When FSGSBASE enabled, current GSBASE is always copied to %rbx.

Where is the documentation that FSGSBASE is required to be used here and
why? I can blody well see from the code that the FSGSBASE path does this
unconditionally. But that does not explain why and it does not explain why
FSGSBASE is not used all over the place instead of SWAPGS and just here.

+ * Without FSGSBASE, SWAPGS is needed when entering from userspace.
+ * A positive GSBASE means it is a user value and a negative GSBASE
+ * means it is a kernel value.

So this has more explanation about the SWAPGS mode than about the
subtlities of FSGSBASE.

This stuff wants to be documented in great length for everyones sake
including yourself when you have to stare into that code a year from now. I
don't care about you're headache but I care about mine and that of people
who might end up debugging some subtle bug in that area.

Thanks,

	tglx







