Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B947020850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfCVRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:22:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:19997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfCVRWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:22:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 10:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="136555324"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2019 10:22:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5604E300E46; Fri, 22 Mar 2019 10:22:50 -0700 (PDT)
Date:   Fri, 22 Mar 2019 10:22:50 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V3 01/23] perf/x86: Support outputting XMM registers
Message-ID: <20190322172250.GF24002@tassilo.jf.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
 <20190322163718.2191-2-kan.liang@linux.intel.com>
 <20190322170841.GJ7905@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322170841.GJ7905@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> > index f3329cabce5c..b33995313d17 100644
> > --- a/arch/x86/include/uapi/asm/perf_regs.h
> > +++ b/arch/x86/include/uapi/asm/perf_regs.h
> > @@ -28,7 +28,29 @@ enum perf_event_x86_regs {
> >  	PERF_REG_X86_R14,
> >  	PERF_REG_X86_R15,
> >  
> > -	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
> > -	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> 
> So this changes UAPI visible symbols... did we think about that?

Should be fine. Old programs won't use the new bits,
and it just uses not yet used bits.

> 
> > +	/* These all need two bits set because they are 128bit */
> > +	PERF_REG_X86_XMM0  = 32,
> > +	PERF_REG_X86_XMM1  = 34,
> > +	PERF_REG_X86_XMM2  = 36,
> > +	PERF_REG_X86_XMM3  = 38,
> > +	PERF_REG_X86_XMM4  = 40,
> > +	PERF_REG_X86_XMM5  = 42,
> > +	PERF_REG_X86_XMM6  = 44,
> > +	PERF_REG_X86_XMM7  = 46,
> > +	PERF_REG_X86_XMM8  = 48,
> > +	PERF_REG_X86_XMM9  = 50,
> > +	PERF_REG_X86_XMM10 = 52,
> > +	PERF_REG_X86_XMM11 = 54,
> > +	PERF_REG_X86_XMM12 = 56,
> > +	PERF_REG_X86_XMM13 = 58,
> > +	PERF_REG_X86_XMM14 = 60,
> > +	PERF_REG_X86_XMM15 = 62,
> > +
> > +	/* This does not include the XMMX registers */
> > +	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
> > +	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
> > +
> > +	/* All registers include the XMMX registers */
> > +	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
> >  };
> >  #endif /* _ASM_X86_PERF_REGS_H */
> 
> Also, what happens if we run a 32bit kernel or 32bit compat task?
> 
> Then the register dump will report PERF_SAMPLE_REGS_ABI_32, should we
> then still interpret the XMM registers as 2x64bit?

Yes XMM registers are 128bit in 32bit mode too.

> 
> Are they still at the same offset?

Yes.

> 
> Do we need additional PERF_SAMPLE_REGS_ABI_* definitions for this?

I don't think so.

-Andi
