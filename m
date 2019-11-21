Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5448C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39920692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKUQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:02:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:4801 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:02:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 08:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="216163671"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2019 08:01:59 -0800
Date:   Thu, 21 Nov 2019 08:14:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121161410.GA199273@romley-ivt3.sc.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121130153.GS4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:01:53PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 21, 2019 at 07:04:44AM +0100, Ingo Molnar wrote:
> > * Fenghua Yu <fenghua.yu@intel.com> wrote:
> 
> > > +	split_lock_detect
> > > +			[X86] Enable split lock detection
> > > +			This is a real time or debugging feature. When enabled
> > > +			(and if hardware support is present), atomic
> > > +			instructions that access data across cache line
> > > +			boundaries will result in an alignment check exception.
> > > +			When triggered in applications the kernel will send
> > > +			SIGBUS. The kernel will panic for a split lock in
> > > +			OS code.
> > 
> > It would be really nice to be able to enable/disable this runtime as 
> > well, has this been raised before, and what was the conclusion?
> 
> It has, previous versions had that. Somehow a lot of things went missing
> and we're back to a broken neutered useless mess.
> 
> The problem appears to be that due to hardware design the feature cannot
> be virtualized, and instead of then disabling it when a VM runs/exists
> they just threw in the towel and went back to useless mode.. :-(

It's a bit complex to virtualize the TEST_CTRL MSR because it's per core
instead of per thread. But it's still doable to virtualize it as
discussion:
https://lore.kernel.org/lkml/20191017233824.GA23654@linux.intel.com/

KVM code will be released later. Even if there is no KVM code for split
lock, the patch set will killl qemu/guest if split lock happens there.
The goal of this patch set is to have a basic enabling code.

> 
> This feature MUST be default enabled, otherwise everything will
> be/remain broken and we'll end up in the situation where you can't use
> it even if you wanted to.

The usage scope of this patch set is largely reduced to only real time.
The long split lock processing time (>1000 cycles) cannot be tolerated
by real time.

Real time customers do want to use this feature to detect the fatal
split lock error. They don't want any split lock issue from BIOS/EFI/
firmware/kerne/drivers/user apps.

Real time can enable the feature (set bit 29 in TEST_CTRL MSR) in BIOS and
don't need OS to enable it. But, #AC handler cannot handle split lock
in the kernel and will return to the faulting instruction and re-enter #AC. So
current #AC handler doesn't provide useful information for the customers.
That's why we add the new #AC handler in this patch set.

>
> Imagine the BIOS/EFI/firmware containing an #AC exception. At that point
> the feature becomes useless, because you cannot enable it without your
> machine dying.

I believe Intel real time team guarantees to deliever a split lock FREE
BIOS/EFI/firmware to their real time users.

From kernel point of view, we are working on a split lock free kernel.
Some blocking split lock issues have been fixed in TIP tree.

Only limited user apps can run on real time and should be split lock
free before they are allowed to run on the real time system.

So the feature is enabled only for real time that wants to have
a controlled split lock free environment.

The point is a split lock issue is a FATAL error on real time. Whenever
it happens, the long processing time (>1000 cycles) cannot meet hard real
time requirement any more and the system/user app has to die.

> 
> Now, from long and painful experience we all know that if a BIOS can be
> wrong, it will be. Therefore this feature will be/is useless as
> presented.
> 
> And I can't be arsed to look it up, but we've been making this very same
> argument since very early (possible the very first) version.
> 
> So this version goes straight into the bit bucket. Please try again.

In summary, the patch set only wants to enable the feature for real time
and disable it by default.

Thanks.

-Fenghua
