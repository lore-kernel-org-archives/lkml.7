Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A852CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60A21BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565179173;
	bh=fE7YIYx8+y7MYU9u2RxYo4CVYhuKEipF0tinVVdo9Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B/hpQOFvD/ZTNWDFvLcu0mGypU0HC3BeYPf4UMF0V9tlj8DKt3iIFQfbMm31auoyO
	 bjFDR+apdQTKnod3r1NnX3EVf2IN3ZdBwNN+mv+AjxFrL2SQU2byKEPcCE9gZdZ4Tb
	 IBTkdp2HacS396vZJPQe9cMda/gzmLwcERhqbj4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfHGL7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfHGL7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:59:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23123219BE;
        Wed,  7 Aug 2019 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565179171;
        bh=fE7YIYx8+y7MYU9u2RxYo4CVYhuKEipF0tinVVdo9Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqIoWwnfxBbJUXf2BBa9wQdIyLyOhszNRhLtFcfUHw3NhQ4TmBvZyabOT6UVP27B9
         ASkT5VvHTL+BACFrKajkYhPYPMaWw4LeiIWDNFMMdjZoj3r3C40mbgXXWCY+/JpS4S
         mbeGy4GZOgpyBKGaBOoHZj8FeY5+lrEWDT1JjlwY=
Date:   Wed, 7 Aug 2019 12:59:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190807115926.np7izmaq36kgxzdg@willie-the-truck>
References: <20190806193434.965-1-cai@lca.pw>
 <20190807105652.cyi3fou2rfsxhxrk@willie-the-truck>
 <D11F0810-A6D0-4835-B71A-9DDDC120423B@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D11F0810-A6D0-4835-B71A-9DDDC120423B@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:50:43AM -0400, Qian Cai wrote:
> 
> 
> > On Aug 7, 2019, at 6:56 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, Aug 06, 2019 at 03:34:34PM -0400, Qian Cai wrote:
> >> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >> index 876055e37352..a0c495a3f4fd 100644
> >> --- a/arch/arm64/kernel/cpuinfo.c
> >> +++ b/arch/arm64/kernel/cpuinfo.c
> >> @@ -34,10 +34,7 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
> >> static struct cpuinfo_arm64 boot_cpu_data;
> >> 
> >> static char *icache_policy_str[] = {
> >> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> >> -	[ICACHE_POLICY_VIPT]		= "VIPT",
> >> -	[ICACHE_POLICY_PIPT]		= "PIPT",
> >> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> >> +	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN"
> >> };
> >> 
> >> unsigned long __icache_flags;
> >> @@ -310,13 +307,16 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
> >> 
> >> 	switch (l1ip) {
> >> 	case ICACHE_POLICY_PIPT:
> >> +		icache_policy_str[ICACHE_POLICY_PIPT] = "PIPT";
> >> 		break;
> >> 	case ICACHE_POLICY_VPIPT:
> >> +		icache_policy_str[ICACHE_POLICY_VPIPT] = "VPIPT";
> >> 		set_bit(ICACHEF_VPIPT, &__icache_flags);
> >> 		break;
> >> 	default:
> >> 		/* Fallthrough */
> >> 	case ICACHE_POLICY_VIPT:
> >> +		icache_policy_str[ICACHE_POLICY_VIPT] = "VIPT";
> >> 		/* Assume aliasing */
> >> 		set_bit(ICACHEF_ALIASING, &__icache_flags);
> > 
> > I still think this is worse than the code in mainline. I don't think
> > -Woverride-init should warn when overriding a field from a GCC range
> > designated initialiser, since it makes them considerably less useful
> > imo.
> 
> Unfortunately, compiler people are moving into a different direction as
> Clang would warn those kind of usage too.
> 
> It actually prove that those warnings are useful to find real issues. See,
> 
> Fae5e033d65a (“mfd: rk808: Fix RK818_IRQ_DISCHG_ILIM initializer”)
> 32df34d875bb (“[media] rc: img-ir: jvc: Remove unused no-leader timings”)
> 
> Especially, to find redundant initializations in large structures. e.g.,
> 
> e6ea0b917875 (“[media] dvb_frontend: Don't declare values twice at a table”)

None of these appear to use the range initialisers I was referring to, so I
don't see why this is relevant to the discussion at hand.

Will
