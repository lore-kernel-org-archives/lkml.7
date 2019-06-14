Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D3C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A92133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFNOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:39:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:41477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfFNOjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:39:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 07:39:12 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 07:39:12 -0700
Date:   Fri, 14 Jun 2019 07:39:12 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614143912.GB12191@linux.intel.com>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
 <20190614122749.GE2586@zn.tnic>
 <20190614131701.GA198207@romley-ivt3.sc.intel.com>
 <20190614134123.GF2586@zn.tnic>
 <20190614141424.GA12191@linux.intel.com>
 <20190614142139.GH2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614142139.GH2586@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:21:39PM +0200, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 07:14:24AM -0700, Sean Christopherson wrote:
> > This is wrong.  KVM isn't complaining about shuffling the order of feature
> > words, it's complaining that code is trying to do a reverse CPUID lookup
> > to a feature that isn't in the reverse_cpuid table.   Filtering out
> > checks dynamically is just hiding bugs.
> 
> No no, reverse_cpuid is hardcoding our feature leafs. This is wrong as
> we want to be able to change those. And reverse_cpuid[] should be able
> to handle that.
> 
> KVM is complaining because he removed one leaf. He adds it later in
> patch 3 as a Linux-defined leaf.

Yes, because removing that leaf breaks 'enum cpuid_leafs'.  Patch 3/3
"fixes" it by re-inserting a leaf, which causes 'enum cpuid_leafs' to
align with the CPU features.

For example, this assertion also fails:

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5b0e9d869ce5..c273b99702d0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -823,6 +823,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
                c->x86_capability[CPUID_7_0_EBX] = ebx;
                c->x86_capability[CPUID_7_ECX] = ecx;
                c->x86_capability[CPUID_7_EDX] = edx;
+               BUILD_BUG_ON(CPUID_7_EDX != X86_FEATURE_ARCH_CAPABILITIES/32);
        }
 
        /* Extended state features: level 0x0000000d */

In function ‘x86_feature_cpuid’,
    inlined from ‘guest_cpuid_get_register’ at arch/x86/kvm/cpuid.h:71:25,
    inlined from ‘guest_cpuid_has’ at arch/x86/kvm/cpuid.h:100:6,
    inlined from ‘kvm_get_msr_common’ at arch/x86/kvm/x86.c:2824:8:
include/linux/compiler.h:345:38: error: call to ‘__compiletime_assert_62’ declared with attribute error: BUILD_BUG_ON failed: x86_leaf >= ARRAY_SIZE(reverse_cpuid)
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)


But this assertion passes because its word is 10, i.e. below the 11/12
words that are getting mucked with.

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5b0e9d869ce5..aada9d2fa4df 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -830,6 +830,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
                cpuid_count(0x0000000d, 1, &eax, &ebx, &ecx, &edx);
 
                c->x86_capability[CPUID_D_1_EAX] = eax;
+               BUILD_BUG_ON(CPUID_D_1_EAX != X86_FEATURE_XSAVES/32);
        }
 
        /* AMD-defined flags: level 0x80000001 */


> All that doesn't matter for KVM - if KVM wants to do reverse lookup,
> then it should handle Linux-defined leafs just fine.

KVM can't handle Linux-defined leafs without extra tricks, which is why
I removed get_scattered_cpuid_leaf() or whatever it was called.
