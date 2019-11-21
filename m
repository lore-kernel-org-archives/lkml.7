Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D4CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5620672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUSkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:40:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:4638 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKUSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:40:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 10:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="216191810"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2019 10:40:52 -0800
Date:   Thu, 21 Nov 2019 10:53:03 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121185303.GB199273@romley-ivt3.sc.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 21, 2019 at 9:43 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Ingo Molnar
> > > Sent: 21 November 2019 17:12
> > > * Peter Zijlstra <peterz@infradead.org> wrote:
> > ...
> > > > This feature MUST be default enabled, otherwise everything will
> > > > be/remain broken and we'll end up in the situation where you can't use
> > > > it even if you wanted to.
> > >
> > > Agreed.
> >
> > Before it can be enabled by default someone needs to go through the
> > kernel and fix all the code that abuses the 'bit' functions by using them
> > on int[] instead of long[].
> >
> > I've only seen one fix go through for one use case of one piece of code
> > that repeatedly uses potentially misaligned int[] arrays for bitmasks.
> >
> 
> Can we really not just change the lock asm to use 32-bit accesses for
> set_bit(), etc?  Sure, it will fail if the bit index is greater than
> 2^32, but that seems nuts.
> 
> (Why the *hell* do the bitops use long anyway?  They're *bit masks*
> for crying out loud.  As in, users generally want to operate on fixed
> numbers of bits.)

We are working on a separate patch set to fix all split lock issues
in atomic bitops. Per Peter Anvin and Tony Luck suggestions:
1. Still keep the byte optimization if nr is constant. No split lock.
2. If type of *addr is unsigned long, do quadword atomic instruction
   on addr. No split lock.
3. If type of *addr is unsigned int, do word atomic instruction
   on addr. No split lock.
4. Otherwise, re-calculate addr to point the 32-bit address which contains
   the bit and operate on the bit. No split lock.

Only small percentage of atomic bitops calls are in case 4 (e.g. 3%
for set_bit()) which need a few extra instructions to re-calculate
address but can avoid big split lock overhead.

To get real type of *addr instead of type cast type "unsigned long",
the atomic bitops APIs are changed to macros from functions. This change
need to touch all architectures.

Thanks.

-Fenghua
