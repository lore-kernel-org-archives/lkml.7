Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA7C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D8206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 10:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yu5SR/gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAAKRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 05:17:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgAAKRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 05:17:18 -0500
Received: from zn.tnic (p200300EC2F00E7006D646DE0D0F19687.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:6d64:6de0:d0f1:9687])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 178471EC0BEA;
        Wed,  1 Jan 2020 11:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577873837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CexLLfP5wXDijeY6hIxv94YwZ310wApZ5/BW+991c/M=;
        b=Yu5SR/gVn2JiqI/gavibwlfu0AW1qFA+0v9BN/M+QA9S/GgaWSZq7tfsRJjMxEG2aEDPzH
        q4hXvfaSu8oOSYPGLsV6uNMAz5Z8clP+Ay4Yr9CzKfLDLu2Z3dspYbUIUJBDpokpMKZpUn
        VVYUBAqhyGDEv4PTbkxHrEyjst/ddWo=
Date:   Wed, 1 Jan 2020 11:17:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/resctrl: Fix potential memory leak
Message-ID: <20200101101708.GA14315@zn.tnic>
References: <20191220164358.177202-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220164358.177202-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 08:43:58AM -0800, Shakeel Butt wrote:
> The set_cache_qos_cfg() is leaking memory when the given level is not
> RDT_RESOURCE_L3 or RDT_RESOURCE_L2. However at the moment, this function
> is called with only valid levels but to make it more robust and future
> proof, we should be handling the error path gracefully.
> 
> Fixes: 99adde9b370de ("x86/intel_rdt: Enable L2 CDP in MSR IA32_L2_QOS_CFG")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Changes since v1:
> - Updated the commit message
> 
> 
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2e3b06d6bbc6..a0c279c7f4b9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1748,8 +1748,10 @@ static int set_cache_qos_cfg(int level, bool enable)
>  		update = l3_qos_cfg_update;
>  	else if (level == RDT_RESOURCE_L2)
>  		update = l2_qos_cfg_update;
> -	else
> +	else {
> +		free_cpumask_var(cpu_mask);
>  		return -EINVAL;
> +	}

And why can't the level check happen first and the allocation second,
thus needing to allocate the cpu mask only when the level is valid?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
