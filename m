Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FBBC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FC5208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SQtRugiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfFPRwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:52:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35436 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFPRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:52:45 -0400
Received: from zn.tnic (p200300EC2F2EEF0075C5C90506498E88.dip0.t-ipconnect.de [IPv6:2003:ec:2f2e:ef00:75c5:c905:649:8e88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0F271EC0235;
        Sun, 16 Jun 2019 19:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560707563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8Yp2DHygoAGTOj7d8F++x0JZrHnRc1iI3fFZ7CTcrDo=;
        b=SQtRugiUMKQo+gPvHFlTg0jEiUpUCUmDxjmNMwlk6j/+3LGLHtVbMCow+VJjkCMekf7E2u
        9d2DiFUOsVMnsb11uPWNPIGtAeraptQ35+aoXsA+t9brAjJmEpNRzjUsA9UjZCmFc0ED85
        Aljy6Nf0x/8RScF+SMNkllieJACDYtc=
Date:   Sun, 16 Jun 2019 19:52:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Get max rmid and occupancy scale
 directly from CPUID instead of cpuinfo_x86
Message-ID: <20190616175233.GA10821@zn.tnic>
References: <1560705250-211820-1-git-send-email-fenghua.yu@intel.com>
 <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560705250-211820-2-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 10:14:08AM -0700, Fenghua Yu wrote:
> @@ -617,13 +617,20 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>  }
>  
> -int rdt_get_mon_l3_config(struct rdt_resource *r)
> +int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int cl_size = boot_cpu_data.x86_cache_size;
> +	u32 eax, ebx, ecx, edx;
>  	int ret;
>  
> -	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> +	/*
> +	 * At this point, CQM LLC and one of L3 occupancy, MBM total, and
> +	 * MBM local monitoring features must be supported. So sub-leaf
> +	 * (EAX=0xf, ECX=1) contains needed information for this resource.
> +	 */
> +	cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
> +	r->num_rmid = ecx + 1;
> +	r->mon_scale = ebx;
>  
>  	/*
>  	 * A reasonable upper limit on the max threshold is the number

This is simpler than that:

https://lkml.kernel.org/r/20190614174959.GF198207@romley-ivt3.sc.intel.com

Why?


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
