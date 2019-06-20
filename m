Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85169C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FFF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfFTOPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:15:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:30414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfFTOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:15:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 07:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="168523082"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2019 07:15:49 -0700
Date:   Thu, 20 Jun 2019 07:06:15 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/cpufeatures: Enumerate new AVX512 BFLOAT16
 instructions
Message-ID: <20190620140614.GA238683@romley-ivt3.sc.intel.com>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
 <20190619173140.GH9574@zn.tnic>
 <20190619213404.GB234387@romley-ivt3.sc.intel.com>
 <20190620103720.GB28032@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620103720.GB28032@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:37:20PM +0200, Borislav Petkov wrote:
> On Wed, Jun 19, 2019 at 02:34:04PM -0700, Fenghua Yu wrote:
> You need to test the sub-leaf index validity here before accessing
> subleaf 1:
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 4910cb421b82..dad20bc891d5 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -848,8 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_capability[CPUID_7_ECX] = ecx;
>  		c->x86_capability[CPUID_7_EDX] = edx;
>  
> -		cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
> -		c->x86_capability[CPUID_7_1_EAX] = eax;
> +		/* Check valid sub-leaf index before accessing it */
> +		if (eax >= 1) {
> +			cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
> +			c->x86_capability[CPUID_7_1_EAX] = eax;
> +		}

You are right.

I tested the three patches in tip tree and they work as expected.

Thank you very much!

-Fenghua
