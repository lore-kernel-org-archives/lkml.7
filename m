Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159EDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E416020644
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfFKS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:28:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:8293 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389490AbfFKS2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:28:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 11:28:41 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2019 11:28:41 -0700
Date:   Tue, 11 Jun 2019 11:19:20 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Enumerate new AVX512 bfloat16
 instructions
Message-ID: <20190611181920.GC180343@romley-ivt3.sc.intel.com>
References: <1560186158-174788-1-git-send-email-fenghua.yu@intel.com>
 <20190610192026.GI5488@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610192026.GI5488@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 09:20:26PM +0200, Borislav Petkov wrote:
> On Mon, Jun 10, 2019 at 10:02:38AM -0700, Fenghua Yu wrote:
> > AVX512 Vector Neural Network Instructions (VNNI) in Intel Deep Learning
> > Boost support bfloat16 format (BF16). BF16 is a short version of FP32 and
> > has several advantages over FP16. BF16 offers more than enough range for
> > deep learning training tasks and doesn't need to handle hardware exception
> > as this is a performance optimization. FP32 accumulation after the
> > multiply is essential to achieve sufficient numerical behavior on an
> > application level. 
> > 
> > AVX512 bfloat16 instructions can be enumerated by:
> > 	CPUID.(EAX=7,ECX=1):EAX[bit 5] AVX512_BF16
> >     
> > Detailed information of the CPUID bit and AVX512 bfloat16 instructions
> > can be found in the latest Intel Architecture Instruction Set Extensions
> > and Future Features Programming Reference.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> > 
> > Since split lock feature (to-be-upstreamed) occupies the last bit 
> > of word 7, need to create a new word 19 to host AVX512_BF16 and other
> > future features.
> 
> Is CPUID.(EAX=7,ECX=1):EAX going to contain only feature bits? If so,
> just make it a proper feature word instead of a linux-specific one.

AFAICT, there will be more features in the EAX register in the future.
Ok. I will use a feature word for CPUID.(EAX=7,ECX=1):EAX.

> 
> Also, while on the subject, you can recycle word 11
> 
> /* Intel-defined CPU QoS Sub-leaf, CPUID level 0x0000000F:0 (EDX), word 11 */
> #define X86_FEATURE_CQM_LLC             (11*32+ 1) /* LLC QoS if 1 */
> 
> and move it to scattered as it is a complete waste. Word 12 too, for
> that matter. But do that in separate patches.

So can I re-organize word 11 and 12 as follows?

1. Change word 11 to host scattered features.
2. Move the previos features in word 11 and word 12 to word 11:
/*
 * Extended auxiliary flags: Linux defined - For features scattered in various
 * CPUID levels and sub-leaves like CPUID level 7 and sub-leaf 1, etc, word 19.
 */
#define X86_FEATURE_CQM_LLC             (11*32+ 0) /* LLC QoS if 1 */
#define X86_FEATURE_CQM_OCCUP_LLC       (11*32+ 1) /* LLC occupancy monitoring */
#define X86_FEATURE_CQM_MBM_TOTAL       (11*32+ 2) /* LLC Total MBM monitoring */
#define X86_FEATURE_CQM_MBM_LOCAL       (11*32+ 3) /* LLC Local MBM monitoring */

3. Change word 12 to host CPUID.(EAX=7,ECX=1):EAX:
/* Intel-defined CPU features, CPUID level 0x7:1 (EAX), word 12 */
#define X86_FEATURE_AVX512_BF16         (12*32+ 0) /* BFLOAT16 instructions */

4. Do other necessary changes to match the new word 11 and word 12.

Thanks.

-Fenghua
