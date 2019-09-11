Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252DAECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98B621D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568181386;
	bh=1we/bF+BvFmcZn7S7gWaOrvGmVm/sYNSI7uyhzOKDv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RAcnnOglqc91b20rUNnvNt6AgACOhYJZja9xowyTbZtltmfmAGrK33add8DPvcIB2
	 fP4R93aPL9BRC1wU1La6DwlUplsTZEb3m4LXtQlg9hoNalXsjBr6MigMjcrIwlbxZk
	 VPwD6groh8g/Z+go+MUOdzPtz2fwo5U+2/SOU6wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfIKF4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:56:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfIKF4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:56:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so1909204wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEyEdgeX1g5OenAFJnbC/h1ZHD2LucUgJ4uwQyK8UPw=;
        b=RspCF2eZdIRZpGJb/Bb3U2nZ5Ykiwaq2u4fT5bs7TQ7hkf+PKsjtqNIkTJcpAlIT6p
         aJjv9DbYXB9Qat6ucRicUiuuqVjXw/+c31TokSwaLqr0unfX5ND+WEKg2oHyhYha3JVz
         jeKC+46n3CDxWLxvrmYPvOwDPWvNLnjpEEjM/aNzQGt8f0kN1qT5pr1mweK+LPfiMdcq
         ub20opiPTjmretlmD2o1n6Z4wEH0bzadmXlH6FEwBK932/sVynBtSdjVcqZYehoVPg+8
         nI6A1CpkDyOIzfG6kblGsh/Ze5I0dnMfZN2s3ErsorXYPxtRgCwX6hO8hueYcDNTDts6
         KDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEyEdgeX1g5OenAFJnbC/h1ZHD2LucUgJ4uwQyK8UPw=;
        b=bbuxbMP0a6XzDV8HHmmYCjCoctvjucKkilaZI+7UHsnuzXOnyPhsawf2BGM3v7m1TG
         EHa0x5fa50MMXKZQWiSG59WEc0Ez6R74XRTRz2fFeGbwi9UctAaff4DqTOdvIRjvXnrP
         XPq8/oSDDp/9rn+WtdO5Us1Z6VV9AMqVQn+Z+AZW6AoJCOSCbuT2ogAKqudD2MkjBS5g
         njH7FC2Xhs+UuEMjd7jekHRzHs1cmOeXCT6uuvST2LU+YCC2ltoStM+2TCQt4+Dn0hOX
         7Bw+9E07pFx0kvyTet2FxNiXChmVoeC8Z4BBxvntVuwVyrT9dDnCtRcAikWckR5VB1TR
         3fdg==
X-Gm-Message-State: APjAAAWPwEDKuZ4mSBa8hpLiZ2N2kDxCyVlslSt+repy4+0IAfwLMR0M
        oafly/IL/GugVmeiP1RayHE=
X-Google-Smtp-Source: APXvYqyHfdI1gU9t8o5JD3NxLVx8gGCgl1pXGWlT794Dw5LYSyatOO1rdsBjVPwbkdtZ9z6jBAn/Cg==
X-Received: by 2002:a7b:c8c6:: with SMTP id f6mr2294977wml.75.1568181380702;
        Tue, 10 Sep 2019 22:56:20 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t25sm1917508wmj.29.2019.09.10.22.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:56:20 -0700 (PDT)
Date:   Wed, 11 Sep 2019 07:56:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV
 is active
Message-ID: <20190911055618.GA104115@gmail.com>
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910151341.14986-3-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kairui Song <kasong@redhat.com> wrote:

> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> SWIOTLB will be enabled even if there is less than 4G of memory when SME
> is active, to support DMA of devices that not support address with the
> encrypt bit.
> 
> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> 
> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> encryption") will always force SWIOTLB to be enabled when SEV is active
> in all cases.
> 
> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> and this is also true for kdump kernel. As a result kdump kernel will
> run out of already scarce pre-reserved memory easily.
> 
> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> is specified or any offset is used. As for the high reservation case, an
> extra low memory region will always be reserved and that is enough for
> SWIOTLB. Else if the offset format is used, user should be fully aware
> of any possible kdump kernel memory requirement and have to organize the
> memory usage carefully.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 71f20bb18cb0..ee6a2f1e2226 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>  					  unsigned long long *crash_size,
>  					  bool high)
>  {
> -	unsigned long long base, size;
> +	unsigned long long base, size, mem_enc_req = 0;
>  
>  	base = *crash_base;
>  	size = *crash_size;
> @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>  	if (high)
>  		goto high_reserve;
>  
> +	/*
> +	 * When SME/SEV is active and not using high reserve,
> +	 * it will always required an extra SWIOTLB region.
> +	 */
> +	if (mem_encrypt_active())
> +		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +
>  	base = memblock_find_in_range(CRASH_ALIGN,
> -				      CRASH_ADDR_LOW_MAX, size,
> +				      CRASH_ADDR_LOW_MAX,
> +				      size + mem_enc_req,
>  				      CRASH_ALIGN);

What sizes are we talking about here?

- What is the possible size range of swiotlb_size_or_default()

- What is the size of CRASH_ADDR_LOW_MAX (the old limit)?

- Why do we replace one fixed limit with another fixed limit instead of 
  accurately sizing the area, with each required feature adding its own 
  requirement to the reservation size?

I.e. please engineer this into a proper solution instead of just 
modifying it around the edges.

For example have you considered adding some sort of 
kdump_memory_reserve(size) facility, which increases the reservation size 
as something like SWIOTLB gets activated? That would avoid the ugly 
mem_encrypt_active() flag, it would just automagically work.

Thanks,

	Ingo
