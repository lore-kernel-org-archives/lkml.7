Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E08C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C872071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNSyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:54:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:17663 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKNSyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:54:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203149189"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 10:54:20 -0800
Date:   Thu, 14 Nov 2019 10:54:20 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191114185420.GJ24045@linux.intel.com>
References: <20191112211002.128278-1-jannh@google.com>
 <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com>
 <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
 <20191114182043.GG24045@linux.intel.com>
 <CALCETrVOPT5Np9=4ypEipu5YtXyTRZhiYBQ1XZoDd2=_Q4s=yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVOPT5Np9=4ypEipu5YtXyTRZhiYBQ1XZoDd2=_Q4s=yw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:41:06AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 14, 2019 at 10:20 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Thu, Nov 14, 2019 at 10:00:35AM -0800, Andy Lutomirski wrote:
> > > On Thu, Nov 14, 2019 at 9:46 AM Sean Christopherson
> > > <sean.j.christopherson@intel.com> wrote:
> > > > > +     /*
> > > > > +      * For the user half, check against TASK_SIZE_MAX; this way, if the
> > > > > +      * access crosses the canonical address boundary, we don't miss it.
> > > > > +      */
> > > > > +     if (addr_ref <= TASK_SIZE_MAX)
> > > >
> > > > Any objection to open coding the upper bound instead of using
> > > > TASK_SIZE_MASK to make the threshold more obvious?
> > > >
> > > > > +             return;
> > > > > +
> > > > > +     pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> > > >
> > > > Printing the raw address will confuse users in the case where the access
> > > > straddles the lower canonical boundary.  Maybe combine this with open
> > > > coding the straddle case?  With a rough heuristic to hedge a bit for
> > > > instructions whose operand size isn't accurately reflected in opnd_bytes.
> > > >
> > > >         if (addr_ref > __VIRTUAL_MASK)
> > > >                 pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> > > >         else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
> > > >                 pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> > > >                          addr_ref, addr_ref + insn->opnd_bytes - 1);
> > > >         else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
> > > >                 pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> > > >                          addr_ref, addr_ref + PAGE_SIZE - 1);
> > >
> > > This is unnecessarily complicated, and I suspect that Jann had the
> > > right idea but just didn't quite explain it enough.  The secret here
> > > is that TASK_SIZE_MAX is a full page below the canonical boundary
> > > (thanks, Intel, for screwing up SYSRET), so, if we get #GP for an
> > > address above TASK_SIZE_MAX,
> >
> > Ya, I followed all that.  My point is that if "addr_ref + insn->opnd_bytes"
> > straddles the boundary then it's extremely likely the #GP is due to a
> > non-canonical access, i.e. the pr_alert() doesn't have to hedge (as much).
> 
> I suppose.  But I don't think we have a real epidemic of failed
> accesses to user memory between TASK_SIZE_MAX and the actual boundary
> that get #GP instead of #PF but fail for a reason other than
> non-canonicality :)

No argument there.

> I think we should just go back in time and fix x86_64 to either give
> #PF or at least give some useful page fault for a non-canonical
> address. The only difficulties I'm aware of is that Intel CPUs would
> either need to be redesigned better or would have slightly odd
> semantics for jumps to non-canonical addresses -- #PF in Intel's model
> of "RIP literally *can't* have a non-canonical value" would be a bit
> strange.  Also, my time machine is out of commission.

If you happen to fix your time machine, just go back a bit further and
change protected mode to push the faulting address onto the stack.
