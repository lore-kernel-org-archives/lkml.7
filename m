Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46805C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2376C20717
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfLBSUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:20:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:49673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfLBSUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:20:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 10:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,270,1571727600"; 
   d="scan'208";a="208178708"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2019 10:20:32 -0800
Date:   Mon, 2 Dec 2019 10:20:32 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191202182032.GA22528@agluck-desk2.amr.corp.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125161348.GA12178@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 08:13:48AM -0800, Sean Christopherson wrote:
> On Fri, Nov 22, 2019 at 04:30:56PM -0800, Luck, Tony wrote:
> > Don't you have some horrible races between the two logical
> > processors on the same core as they both try to set/clear the
> > MSR that is shared at the core level?
> 
> Yes and no.  Yes, there will be races, but they won't be fatal in any way.
> 
>   - Only the split-lock bit is supported by the kernel, so there isn't a
>     risk of corrupting other bits as both threads will rewrite the current
>     hardware value.
> 
>   - Toggling of split-lock is only done in "warn" mode.  Worst case
>     scenario of a race is that a misbehaving task will generate multiple
>     #AC exceptions on the same instruction.  And this race will only occur
>     if both siblings are running tasks that generate split-lock #ACs, e.g.
>     a race where sibling threads are writing different values will only
>     occur if CPUx is disabling split-lock after an #AC and CPUy is
>     re-enabling split-lock after *its* previous task generated an #AC.
> 
>   - Transitioning between modes at runtime isn't supported and disabling
>     is tracked per task, so hardware will always reach a steady state that
>     matches the configured mode.  I.e. split-lock is guaranteed to be
>     enabled in hardware once all _TIF_SLD threads have been scheduled out.

We should probably include this analysis in the commit
comment. Maybe a comment or two in the code too to note
that the races are mostly harmless and guaranteed to end
quickly.

-Tony
