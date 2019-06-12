Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8388020874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfFLDmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:42:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:47176 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFLDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:42:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 20:42:22 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2019 20:42:20 -0700
Date:   Tue, 11 Jun 2019 20:32:59 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190612033259.GE180343@romley-ivt3.sc.intel.com>
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
> 
> > 4. Do other necessary changes to match the new word 11 and word 12.
> 
> But split in two patches: first does steps 1+2, second patch adds the
> new leaf to word 12.

Currently KVM doesn't simulate scattered features (the ones in CPUID_LNX_*
in cpuid_leafs) as reverse_cpuid[] doesn't contain CPUID_LNX_*.

After the X86_FEATURES_CQM_* features are changed to scattered features,
they will not be simulated by KVM any more as CPUID_F_0_EDX and CPUID_F_1_EDX
are removed.

Should patch #1 simulate X86_FEATURE_CQM_* in KVM? Or let KVM guys handle
the scattered features?

Thanks.

-Fenghua
