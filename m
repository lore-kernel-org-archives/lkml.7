Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAAFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618E2207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFEUHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:07:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:63734 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfFEUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:07:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 13:07:04 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2019 13:07:04 -0700
Date:   Wed, 5 Jun 2019 13:07:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cacheinfo: fix a -Wtype-limits warning
Message-ID: <20190605200703.GD26328@linux.intel.com>
References: <1559763654-5155-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559763654-5155-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:40:54PM -0400, Qian Cai wrote:
> cpuinfo_x86.x86_model is an unsigned type, so compares it against zero
> will generate a compilation warning,
> 
> arch/x86/kernel/cpu/cacheinfo.c: In function
> 'cacheinfo_amd_init_llc_id':
> arch/x86/kernel/cpu/cacheinfo.c:662:19: warning: comparison is always
> true due to limited range of data type [-Wtype-limits]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 395d46f78582..c7503be92f35 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -658,8 +658,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
>  	if (c->x86 < 0x17) {
>  		/* LLC is at the node level. */
>  		per_cpu(cpu_llc_id, cpu) = node_id;
> -	} else if (c->x86 == 0x17 &&
> -		   c->x86_model >= 0 && c->x86_model <= 0x1F) {
> +	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {

Might be worth calling out in the changelog that 'c->x86 == 0x17' is true
if and only if c->x86_model was explicitly set by cpu_detect(), i.e. the
patch is correct even if the original intent was a misguided attempt to
check that x86_model has been set.

Fixes: 68091ee7ac3c ("x86/CPU/AMD: Calculate last level cache ID from number of sharing threads")
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  		/*
>  		 * LLC is at the core complex level.
>  		 * Core complex ID is ApicId[3] for these processors.
> -- 
> 1.8.3.1
> 
