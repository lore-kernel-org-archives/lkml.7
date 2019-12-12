Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C4CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC042253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PjvCNeQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfLLUTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:19:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLUTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:19:18 -0500
Received: from zn.tnic (p200300EC2F0A5A00BC9FD9E905C0F14B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:bc9f:d9e9:5c0:f14b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2D5A1EC0B73;
        Thu, 12 Dec 2019 21:19:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576181957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oatlnVsZthR9KXlPmJ8zR/1CkHrsrTm6Ha2l+vUm12M=;
        b=PjvCNeQbKtPMoji85bIhmfr/3z5GpoGkkMD5MdHRGrOT2F6Xgz3nCuyrn3J0YDB0M2nx97
        I1rGJfIIAA8Lw1yJuWwIjX5i0AArBElPUZ65L7o7m41mdbYVw+7+mGyI0tCAOw6TZxW7CM
        i150REomX6xXWp8gLI+Gb9j4T8b9/GI=
Date:   Thu, 12 Dec 2019 21:19:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct mapping.
Message-ID: <20191212201916.GL4991@zn.tnic>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
 <20191115144917.28469-5-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115144917.28469-5-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:49:17AM -0500, Masayoshi Mizuma wrote:
> +/*
> + * Even though a huge virtual address space is reserved for the direct
> + * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
> + * rare system can own enough physical memory to use it up, most are
> + * even less than 1TB.

This sentence is unparseable.

> So with KASLR enabled, we adapt the size of

Who's "we"?

> + * direct mapping area to the size of actual physical memory plus the
> + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> + * The left part will be taken out to join memory randomization.
> + */
> +static inline unsigned long calc_direct_mapping_size(void)

What direct mapping?!

The code is computing the physical memory regions base address and
sizes.

> +{
> +	unsigned long size_tb, memory_tb;
> +
> +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	if (boot_params.max_addr) {
> +		unsigned long maximum_tb;
> +
> +		maximum_tb = DIV_ROUND_UP(boot_params.max_addr,
> +				1UL << TB_SHIFT);

All that jumping through hoops and adding a member to boot_params which
is useless on !hot-add systems - basically the majority out there - just
so that you can use that max address here?!

Did you not find acpi_table_parse_srat()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
