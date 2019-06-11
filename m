Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5932CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237FB20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405911AbfFKRNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:13:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:12980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405708AbfFKRNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:13:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 10:13:24 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 11 Jun 2019 10:13:24 -0700
Date:   Tue, 11 Jun 2019 10:04:02 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
Message-ID: <20190611170402.GA180343@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
 <20190611085036.GS3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611085036.GS3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:50:36AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 03:00:34PM -0700, Fenghua Yu wrote:
> > umwait or tpause allows processor to enter a light-weight
> > power/performance optimized state (C0.1 state) or an improved
> > power/performance optimized state (C0.2 state) for a period
> > specified by the instruction or until the system time limit or until
> > a store to the monitored address range in umwait.
> > 
> > IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> > on the processor and set maximum time the processor can reside in
> > C0.1 or C0.2.
> > 
> > By default C0.2 is enabled so the user wait instructions can enter the
> > C0.2 state to save more power with slower wakeup time.
> > 
> > Default maximum umwait time is 100000 cycles. A later patch provides
> > a sysfs interface to adjust this value.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> > Reviewed-by: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/include/asm/msr-index.h |  4 +++
> >  arch/x86/power/Makefile          |  1 +
> >  arch/x86/power/umwait.c          | 56 ++++++++++++++++++++++++++++++++
> 
> Why is this in power/, this isn't in the least related to
> suspend/hybernate. arch/x86/kernel/cpu/ might be a better place for
> instruction support.

Ok. I can move umwait.c to arch/x86/kernel/cpu/umwait.c.

Thanks.

-Fenghua
