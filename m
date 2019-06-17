Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FAC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E8121E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFQISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:18:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:23328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfFQISj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:18:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 01:18:39 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2019 01:18:39 -0700
Date:   Mon, 17 Jun 2019 01:09:09 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190617080909.GC214090@romley-ivt3.sc.intel.com>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
 <20190617031808.GA214090@romley-ivt3.sc.intel.com>
 <20190617075214.GB27127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617075214.GB27127@zn.tnic>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:52:14AM +0200, Borislav Petkov wrote:
> On Sun, Jun 16, 2019 at 08:18:09PM -0700, Fenghua Yu wrote:
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 2c57fffebf9b..f080be35da41 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -801,6 +801,31 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
> >  	}
> >  }
> >  
> > +static void get_cqm_info(struct cpuinfo_x86 *c)
> > +{
> > +	if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
> > +		u32 eax, ebx, ecx, edx;
> > +
> > +		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
> > +		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
> > +		/* will be overridden if occupancy monitoring exists */
> > +		c->x86_cache_max_rmid = ebx;
> > +
> > +		if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
> > +		    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
> > +		    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
> > +			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> > +			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
> > +
> > +			c->x86_cache_max_rmid = ecx;
> > +			c->x86_cache_occ_scale = ebx;
> > +		}
> > +	} else {
> > +		c->x86_cache_max_rmid = -1;
> > +		c->x86_cache_occ_scale = -1;
> > +	}
> > +}
> > +
> >  void get_cpu_cap(struct cpuinfo_x86 *c)
> >  {
> >  	u32 eax, ebx, ecx, edx;
> > @@ -832,33 +857,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
> >  		c->x86_capability[CPUID_D_1_EAX] = eax;
> >  	}
> >  
> > -	/* Additional Intel-defined flags: level 0x0000000F */
> > -	if (c->cpuid_level >= 0x0000000F) {
> > -
> > -		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
> > -		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
> > -		c->x86_capability[CPUID_F_0_EDX] = edx;
> > -
> > -		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
> > -			/* will be overridden if occupancy monitoring exists */
> > -			c->x86_cache_max_rmid = ebx;
> > -
> > -			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> > -			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
> > -			c->x86_capability[CPUID_F_1_EDX] = edx;
> > -
> > -			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
> > -			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
> > -			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
> > -				c->x86_cache_max_rmid = ecx;
> > -				c->x86_cache_occ_scale = ebx;
> > -			}
> > -		} else {
> > -			c->x86_cache_max_rmid = -1;
> > -			c->x86_cache_occ_scale = -1;
> > -		}
> > -	}
> 
> Why are you doing this carving out into a separate function since you're
> keeping the cpuinfo_x86 members?

I just keep the code a bit uniform around the calling area where
a few functions are called. So get_cqm_info() makes the code a bit more
readable.

        init_scattered_cpuid_features(c);
        init_speculation_control(c);
+       get_cqm_info(c);

        /*
         * Clear/Set all flags overridden by options, after probe.
         * This needs to happen each time we re-probe, which may happen
         * several times during CPU initialization.
         */
        apply_forced_caps(c);
}

Maybe not? If the function is not good, I can directly put the code here?

Thanks.

-Fenghua
