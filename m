Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C80EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C5220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfKNSUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:57201 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfKNSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:20:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="208198401"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2019 10:20:43 -0800
Date:   Thu, 14 Nov 2019 10:20:43 -0800
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
Message-ID: <20191114182043.GG24045@linux.intel.com>
References: <20191112211002.128278-1-jannh@google.com>
 <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com>
 <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:00:35AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 14, 2019 at 9:46 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > > +     /*
> > > +      * For the user half, check against TASK_SIZE_MAX; this way, if the
> > > +      * access crosses the canonical address boundary, we don't miss it.
> > > +      */
> > > +     if (addr_ref <= TASK_SIZE_MAX)
> >
> > Any objection to open coding the upper bound instead of using
> > TASK_SIZE_MASK to make the threshold more obvious?
> >
> > > +             return;
> > > +
> > > +     pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> >
> > Printing the raw address will confuse users in the case where the access
> > straddles the lower canonical boundary.  Maybe combine this with open
> > coding the straddle case?  With a rough heuristic to hedge a bit for
> > instructions whose operand size isn't accurately reflected in opnd_bytes.
> >
> >         if (addr_ref > __VIRTUAL_MASK)
> >                 pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> >         else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
> >                 pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> >                          addr_ref, addr_ref + insn->opnd_bytes - 1);
> >         else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
> >                 pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> >                          addr_ref, addr_ref + PAGE_SIZE - 1);
> 
> This is unnecessarily complicated, and I suspect that Jann had the
> right idea but just didn't quite explain it enough.  The secret here
> is that TASK_SIZE_MAX is a full page below the canonical boundary
> (thanks, Intel, for screwing up SYSRET), so, if we get #GP for an
> address above TASK_SIZE_MAX,

Ya, I followed all that.  My point is that if "addr_ref + insn->opnd_bytes"
straddles the boundary then it's extremely likely the #GP is due to a
non-canonical access, i.e. the pr_alert() doesn't have to hedge (as much).

> then it's either a #GP for a different
> reason or it's a genuine non-canonical access.

Heh, "canonical || !canonical" would be the options :-D

> 
> So I think that just a comment about this would be enough.
> 
> *However*, the printout should at least hedge a bit and say something
> like "probably dereferencing non-canonical address", since there are
> plenty of ways to get #GP with an operand that is nominally
> non-canonical but where the actual cause of #GP is different.  And I
> think this code should be skipped entirely if error_code != 0.
> 
> --Andy
