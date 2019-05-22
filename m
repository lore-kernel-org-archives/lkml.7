Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC452089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iPw42ijW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfEVXdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 19:33:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfEVXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 19:33:04 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F04901EC0965;
        Thu, 23 May 2019 01:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558567982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xl5Yc0QXOfFQYSPjQOxIlwd2ATOS39P3nxW2Xi+N7i0=;
        b=iPw42ijWTXdkgxFZ4NtX2F+VQB/+juBFLIREFHMjnIk9yilyRmuJK1wrQobqxH0ix5/5fj
        9YzWPFzmCdp31xL4rW/nVfki8yeU/TyauS2xD+oRn2OoJAwaivFltdWiPJqKZOUt4f/KYi
        dEHOZO2MAcvxwUHDTRdAU4GReZPe0f8=
Date:   Thu, 23 May 2019 01:33:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        jiaxun.yang@flygoat.com, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86/CPU/AMD: don't force the CPB cap when running under
 a hypervisor
Message-ID: <20190522233335.GA16408@cz.tnic>
References: <20190522221745.GA15789@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522221745.GA15789@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:17:45PM +0000, Frank van der Linden wrote:
> For F17h AMD CPUs, the CPB capability is forcibly set, because some
> versions of that chip incorrectly report that they do not have it.
> 
> However, a hypervisor may filter out the CPB capability, for good
> reasons. For example, KVM currently does not emulate setting the CPB
> bit in MSR_K7_HWCR, and unchecked MSR access errors will be thrown
> when trying to set it as a guest:
> 
> 	unchecked MSR access error: WRMSR to 0xc0010015 (tried to write
>         0x0000000001000011) at rIP: 0xffffffff890638f4
>         (native_write_msr+0x4/0x20)
> 
> 	Call Trace:
> 	boost_set_msr+0x50/0x80 [acpi_cpufreq]
> 	cpuhp_invoke_callback+0x86/0x560
> 	sort_range+0x20/0x20
> 	cpuhp_thread_fun+0xb0/0x110
> 	smpboot_thread_fn+0xef/0x160
> 	kthread+0x113/0x130
> 	kthread_create_worker_on_cpu+0x70/0x70
> 	ret_from_fork+0x35/0x40
> 
> To avoid this issue, don't forcibly set the CPB capability for a CPU
> when running under a hypervisor.
> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> Fixes: 0237199186e7 ("x86/CPU/AMD: Set the CPB bit unconditionally on F17h")
> ---
>  arch/x86/kernel/cpu/amd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index fb6a64bd765f..ee4d79fa1b19 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -823,8 +823,11 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
>  {
>  	set_cpu_cap(c, X86_FEATURE_ZEN);
>  
> -	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
> -	if (!cpu_has(c, X86_FEATURE_CPB))
> +	/*
> +	 * Fix erratum 1076: CPB feature bit not being set in CPUID.
> +	 * Always set it, except when running under a hypervisor.
> +	 */
> +	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_CPB))
>  		set_cpu_cap(c, X86_FEATURE_CPB);
>  }

I guess...

Acked-by: Borislav Petkov <bp@suse.de>

Btw, it has come up before whether it would be additionally prudent
to replace those *msr calls with their *msr_safe counterparts, in
boost_set_msr() and also check *msr_safe() retvals and exit early there.
Just in case and exactly because of virt.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
