Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3727C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3732173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407197AbfFKWhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:37:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:32551 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405478AbfFKWho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:37:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 15:37:43 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2019 15:37:43 -0700
Date:   Tue, 11 Jun 2019 15:28:22 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>, g@romley-ivt3.sc.intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190611222822.GD180343@romley-ivt3.sc.intel.com>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
 <20190611181920.GC180343@romley-ivt3.sc.intel.com>
 <20190611194701.GJ31772@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611194701.GJ31772@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 09:47:02PM +0200, Borislav Petkov wrote:
> On Tue, Jun 11, 2019 at 11:19:20AM -0700, Fenghua Yu wrote:
> > So can I re-organize word 11 and 12 as follows?
> > 
> > 1. Change word 11 to host scattered features.
> > 2. Move the previos features in word 11 and word 12 to word 11:
> > /*
> >  * Extended auxiliary flags: Linux defined - For features scattered in various
> >  * CPUID levels and sub-leaves like CPUID level 7 and sub-leaf 1, etc, word 19.
> >  */
> > #define X86_FEATURE_CQM_LLC             (11*32+ 0) /* LLC QoS if 1 */
> > #define X86_FEATURE_CQM_OCCUP_LLC       (11*32+ 1) /* LLC occupancy monitoring */
> > #define X86_FEATURE_CQM_MBM_TOTAL       (11*32+ 2) /* LLC Total MBM monitoring */
> > #define X86_FEATURE_CQM_MBM_LOCAL       (11*32+ 3) /* LLC Local MBM monitoring */
> 
> Yap.
> 
> > 3. Change word 12 to host CPUID.(EAX=7,ECX=1):EAX:
> > /* Intel-defined CPU features, CPUID level 0x7:1 (EAX), word 12 */
> > #define X86_FEATURE_AVX512_BF16         (12*32+ 0) /* BFLOAT16 instructions */
> 
> This needs to be (12*32+ 5) if word 12 is going to map leaf
> CPUID.(EAX=7,ECX=1):EAX.
> 
> At least judging from the arch extensions doc which lists EAX as:
> 
> Bits 04-00: Reserved.
> Bit 05: AVX512_BF16. Vector Neural Network Instructions supporting BFLOAT16 inputs and conversion instructions from IEEE single precision.
> Bits 31-06: Reserved.

Yes, you are absolutely right. I'll defint it as (12*32+ 5).

> 
> > 4. Do other necessary changes to match the new word 11 and word 12.
> 
> But split in two patches: first does steps 1+2, second patch adds the
> new leaf to word 12.

There are two varialbes defined in cpuinfo_x86: x86_cache_max_rmid and
x86_cache_occ_scale. c->x86_cache_max_rmid is read from CPUID.0xf.1:ECX
and c->x86_cache_occ_scale is read from CPUID.0xf.1:EBX.

After getting X86_FEATURE_CQM_* from scattered, the two variables need
to be read from CPUID again. So the code of reading the two variables
need to be moved from before init_scattered_cpuid_features(c) to after
the function. This make the get_cpu_cap() code awkward.

And the two variables are ONLY used in resctrl monitoring configuration.
There is no need to store them in cpuinfo_x86 on each CPU.

I'm thinking to simplify and clean this part of code:

1. In patch #1:
- remove the definitions of x86_cache_max_rmid and x86_cache_occ_scale
from cpuinfo_x86
- remove assignment of c->x86_cache_max_rmid and c->x86_cache_occ_scale
from get_cpu_cap(c)
- get r->mon_scale and r->num_rmid in rdt_get_mon_l3_config(r) directly
from CPUID.0xf.1:EBX and CPUID.0xf.1:ECX.
2. In patch #2: do steps 1+2 to recycle word 11. After patch #1, I can
totally remove the code to get c->x86_cache_max_rmd and
c->x86_cache_occ_scale in get_cpu_cap(c). And patch #2 is cleaner.
3. In patch #3: add new word 12 to host CPUID.7.1:EAX

Do you think the patch #1 is necessary and this is a right patch set?

Thanks.

-Fenghua
