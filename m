Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65101C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A4B20449
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sU0nWhBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFQHwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:52:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQHwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:52:23 -0400
Received: from zn.tnic (p200300EC2F0613003807E25F1A502EA7.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:3807:e25f:1a50:2ea7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5C421EC0982;
        Mon, 17 Jun 2019 09:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560757941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HcH95boZcfSkvl+SxA590ytBbM7pwxIJ7WZniKy8BDI=;
        b=sU0nWhBjI/K6gCRFnHZS1xeMySC4fOH1KBevvctucWSG80HIAYPeLh7gjQiP8deqd4kQhm
        BpzIYAW9ey7p9vzP5LgUwXStCtnLyka+LxwFMa5SY9vgvDRNzpqRPxkRqQ78E11T0/jVh1
        mTKoi4ja6rPhZwvc+Hzl4R3+j6l9wTs=
Date:   Mon, 17 Jun 2019 09:52:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
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
Message-ID: <20190617075214.GB27127@zn.tnic>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de>
 <20190617031808.GA214090@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190617031808.GA214090@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 08:18:09PM -0700, Fenghua Yu wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2c57fffebf9b..f080be35da41 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -801,6 +801,31 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +static void get_cqm_info(struct cpuinfo_x86 *c)
> +{
> +	if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
> +		u32 eax, ebx, ecx, edx;
> +
> +		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
> +		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
> +		/* will be overridden if occupancy monitoring exists */
> +		c->x86_cache_max_rmid = ebx;
> +
> +		if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
> +		    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
> +		    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
> +			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> +			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
> +
> +			c->x86_cache_max_rmid = ecx;
> +			c->x86_cache_occ_scale = ebx;
> +		}
> +	} else {
> +		c->x86_cache_max_rmid = -1;
> +		c->x86_cache_occ_scale = -1;
> +	}
> +}
> +
>  void get_cpu_cap(struct cpuinfo_x86 *c)
>  {
>  	u32 eax, ebx, ecx, edx;
> @@ -832,33 +857,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_capability[CPUID_D_1_EAX] = eax;
>  	}
>  
> -	/* Additional Intel-defined flags: level 0x0000000F */
> -	if (c->cpuid_level >= 0x0000000F) {
> -
> -		/* QoS sub-leaf, EAX=0Fh, ECX=0 */
> -		cpuid_count(0x0000000F, 0, &eax, &ebx, &ecx, &edx);
> -		c->x86_capability[CPUID_F_0_EDX] = edx;
> -
> -		if (cpu_has(c, X86_FEATURE_CQM_LLC)) {
> -			/* will be overridden if occupancy monitoring exists */
> -			c->x86_cache_max_rmid = ebx;
> -
> -			/* QoS sub-leaf, EAX=0Fh, ECX=1 */
> -			cpuid_count(0x0000000F, 1, &eax, &ebx, &ecx, &edx);
> -			c->x86_capability[CPUID_F_1_EDX] = edx;
> -
> -			if ((cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC)) ||
> -			      ((cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL)) ||
> -			       (cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)))) {
> -				c->x86_cache_max_rmid = ecx;
> -				c->x86_cache_occ_scale = ebx;
> -			}
> -		} else {
> -			c->x86_cache_max_rmid = -1;
> -			c->x86_cache_occ_scale = -1;
> -		}
> -	}

Why are you doing this carving out into a separate function since you're
keeping the cpuinfo_x86 members?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
