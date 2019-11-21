Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA38DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EF32068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKUVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:51:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:33229 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfKUVv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:51:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 13:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="210049893"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2019 13:51:26 -0800
Date:   Thu, 21 Nov 2019 13:51:26 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121131522.GX5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121131522.GX5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:15:22PM +0100, Peter Zijlstra wrote:
> Also, just to remind everyone why we really want this. Split lock is a
> potent, unprivileged, DoS vector.

So how much do we "really want this"?

It's been 543 days since the first version of this patch was
posted. We've made exactly zero progress.

Current cut down patch series is the foundation to move one
small step towards getting this done.

Almost all of what's in this set will be required in whatever
final solution we want to end up with. Out of this:

 Documentation/admin-guide/kernel-parameters.txt |   10 +++
 arch/x86/include/asm/cpu.h                      |    5 +
 arch/x86/include/asm/cpufeatures.h              |    2 
 arch/x86/include/asm/msr-index.h                |    8 ++
 arch/x86/include/asm/traps.h                    |    3 +
 arch/x86/kernel/cpu/common.c                    |    2 
 arch/x86/kernel/cpu/intel.c                     |   72 ++++++++++++++++++++++++
 arch/x86/kernel/traps.c                         |   22 +++++++
 8 files changed, 123 insertions(+), 1 deletion(-)

the only substantive thing that will *change* is to make the default
be "on" rather than "off".

Everything else we want to do is *additions* to this base. We could
wait until we have those done and maybe see if we can stall out this
series to an even thousand days. Or, we can take the imperfect base
and build incrementally on it.

You've expressed concern about firmware ... with a simple kernel command
line switch to flip, LUV (https://01.org/linux-uefi-validation) could begin
testing to make sure that firmware is ready for the big day when we throw
the switch from "off" to "on".

-Tony
