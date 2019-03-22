Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2D120850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W14/PrvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfCVRYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:24:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37548 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbfCVRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:23:59 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22F7B1EC045C;
        Fri, 22 Mar 2019 18:23:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553275438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GTDWcmNacIy9rS8aSJs54hTINOUYh53N9C4gaIJJ0dM=;
        b=W14/PrvVQVWcwGi8lRVHtUH5CZcwjaibauwTJSOrjfY2CycHVVjHEe8Hlkmd83IP8/zENk
        89caSqoQyjalMW07Ud1BgzZoq9dmyN+t34OC8WheCy8f+pq/PN/iGdiXEgK0Fpt9kySUlU
        9bK3wQAMriqchOWVng8qXxKNfZz8+oE=
Date:   Fri, 22 Mar 2019 18:24:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Message-ID: <20190322172405.GJ12472@zn.tnic>
References: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321202505.5553-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:25:17PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Some systems may report spurious MCA errors. In general, spurious MCA
> errors may be disabled by clearing a particular bit in MCA_CTL. However,
> clearing a bit in MCA_CTL may not be recommended for some errors, so the
> only option is to ignore them.
> 
> An MCA error is printed and handled after it has been added to the MCE
> event pool. So an MCA error can be ignored by not adding it to the pool.
> 
> Create a function pointer to filter MCA errors and use this when adding
> an error to the MCE event pool.
> 
> Install a default function that does not filter any errors.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190307212552.8865-1-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * This is a new patch replacing V1 Patch 1 which is no longer needed.
> 
>  arch/x86/include/asm/mce.h        | 3 +++
>  arch/x86/kernel/cpu/mce/core.c    | 6 ++++++
>  arch/x86/kernel/cpu/mce/genpool.c | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 22d05e3835f0..0b0b797a959c 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -253,6 +253,9 @@ extern void mce_disable_bank(int bank);
>  extern void (*machine_check_vector)(struct pt_regs *, long error_code);
>  void do_machine_check(struct pt_regs *, long);
>  
> +/* Filter MCEs from the decoder chain. */

That should be something like:

/* Decides whether to add MCE records to the decoder chain or filter them out. */

> +extern bool (*filter_mce)(struct mce *m);
> +
>  /*
>   * Threshold handler
>   */
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index b7fb541a4873..effb40581f08 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1771,6 +1771,12 @@ static void __mcheck_cpu_init_timer(void)
>  	mce_start_timer(t);
>  }
>  
> +/*
> + * Don't filter MCEs by default. Install a system-specific function, if needed.
> + */

That comment is kinda obvious.

> +static bool default_filter_mce(struct mce *m) { return false; }
> +bool (*filter_mce)(struct mce *) = default_filter_mce;
> +
>  /* Handle unconfigured int18 (should never happen) */
>  static void unexpected_machine_check(struct pt_regs *regs, long error_code)
>  {
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index 3395549c51d3..64d1d5a00f39 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -99,6 +99,9 @@ int mce_gen_pool_add(struct mce *mce)
>  {
>  	struct mce_evt_llist *node;
>  
> +	if (filter_mce(mce))
> +		return -EINVAL;
> +
>  	if (!mce_evt_pool)
>  		return -EINVAL;
>  
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
