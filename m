Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52019C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434982082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hp+EWvzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfIEQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:29:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732476AbfIEQ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:29:16 -0400
Received: from zn.tnic (p200300EC2F0A5F00ED1F85EF3FFCFB3D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5f00:ed1f:85ef:3ffc:fb3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1517D1EC067D;
        Thu,  5 Sep 2019 18:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567700955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5hqS2Tnt+MhJww+3RsaYT7pTPBcPNPDApzxd3gjYDLs=;
        b=Hp+EWvzEZWT9JITB7Z/lfDdAVLd/50JNp503vSkUFtg2WY8MtGXFtG3AKBFQbMRP8AF1dZ
        mGZM7TUdwlPWIpyWuovoYTlGhQlGvm+ja+hsjJ+y00qheLbDDpS8lb1VbmaoN+J7wBvZw3
        IkAg7GEBXtT+GLwzYLjPfxPm3Deb1QY=
Date:   Thu, 5 Sep 2019 18:29:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
Message-ID: <20190905162909.GF19246@zn.tnic>
References: <20190826044535.9646-1-kasong@redhat.com>
 <20190830164513.GE30413@zn.tnic>
 <e70f1e99-f696-51e2-f50c-148bcda5dfb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e70f1e99-f696-51e2-f50c-148bcda5dfb6@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:38:22PM +0800, Kairui Song wrote:
> Will it be good if the final code looks like this?
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 48115cf11e0f..754b25d6e785 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -526,6 +526,69 @@ static int __init reserve_crashkernel_low(void)
>  	return 0;
>  }
> +static int __init crashkernel_find_region(
> +		unsigned long long *base,
> +		unsigned long long *size,
> +		bool high)

Those should be aligned at the opening brace.

> +{
> +	unsigned long long start, mem_enc_req = 0;

Declare that mem_enc_req in the if (!high) branch below, where you need it only.

> +
> +	/*
> +	 * *base == 0 means: find the address automatically, else just
> +	 * verify the region is useable
> +	 */
> +	if (*base) {
> +		start = memblock_find_in_range(*base, *base + *size,
> +					       *size, 1 << 20);
> +		if (start != *base) {
> +			pr_info("crashkernel reservation failed - memory is in use.\n");
> +			return -EBUSY;

I don't like functions which change external variables passed as
pointers but then in the error case, change those unnecessarily. Write
into *base and *size only in the success case pls and use local vars for
the intermediate results.

Also, those retvals are not visible to userspace - just return negative for
error and 0 for success.

> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> +	 * crashkernel=x,high reserves memory over 4G, also allocates
> +	 * 256M extra low memory for DMA buffers and swiotlb.
> +	 * But the extra memory is not required for all machines.
> +	 * So try low memory first and fall back to high memory
> +	 * unless "crashkernel=size[KMG],high" is specified.
> +	 */
> +	if (!high) {

	if (high)
		goto high_reserve;

	< now save an indentation level >

> +		/*
> +		 * When SME/SEV is active and not using high reserve,
> +		 * it will always required an extra SWIOTLB region.
> +		 */
> +		if (mem_encrypt_active())
> +			mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +
> +		*base = memblock_find_in_range(CRASH_ALIGN,
> +					       CRASH_ADDR_LOW_MAX,
> +					       *size + mem_enc_req,
> +					       CRASH_ALIGN);
> +		if (*base) {
> +			if (mem_enc_req) {
> +				pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +					(unsigned long)(mem_enc_req >> 20));
> +				*size += mem_enc_req;
> +			}
> +			return 0;
> +		}
> +	}
> +

high_reserve:

> +	/* Try high reserve */
> +	*base = memblock_find_in_range(CRASH_ALIGN,
> +				       CRASH_ADDR_HIGH_MAX,
> +				       *size, CRASH_ALIGN);
> +	if (!*base) {
> +		pr_info("crashkernel reservation failed - No suitable area found.\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

...

> If you are OK with this, I will split it into two patch and send V3.

With that, yes, this looks a bit better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
