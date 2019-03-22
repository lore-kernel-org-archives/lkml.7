Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD007218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kKOmFmZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCVT2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:28:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56174 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfCVT2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:28:00 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D9951EC0AE4;
        Fri, 22 Mar 2019 20:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553282878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VXB1QtfQ8DP+EAPzTwLd8hyJJhkavAjxwDzDrGjElso=;
        b=kKOmFmZWAYCBZ4BR+URKR0AwATvHoPRVjZ7X4l6Zkom6oKp/XWT3H+6rWhXDL9LpqM3Xqo
        o7yoSmajI2lxxx1gMdSYRQ3Cml1DxKr760QsbkruXiHJrJ7Gq1Q8bSalrBcMIYDX09y3k7
        HB5cPrbQCjsz8O5HTvZyZrkebDtvjRc=
Date:   Fri, 22 Mar 2019 20:28:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
Message-ID: <20190322192800.GM12472@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190321103309.27883-3-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:33:08PM +0800, Lianbo Jiang wrote:
> When doing kexec_file_load, the first kernel needs to pass the e820

Please end function names with parentheses.

> reserved ranges to the second kernel.

... because... ?

> But kernel can not exactly match the e820 reserved ranges
     ^
     the

> when walking through the iomem resources with the descriptor
> 'IORES_DESC_NONE', because several e820 types( e.g.
> E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'.
> It may pass these four types to the kdump kernel, that is not desired result.

Rewrite that sentence.

> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> for the iomem resources search interfaces. It is helpful to exactly
> match the reserved resource ranges when walking through iomem resources.
> 
> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
> these code originally related to the descriptor 'IORES_DESC_NONE' need to

"the code"

> be updated.

> Otherwise, it will be easily confused and also cause some errors.

What errors?

> Because the 'E820_TYPE_RESERVED' type is converted to the new
> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
> changed.

That sentence I cannot parse.

> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/e820.c | 2 +-
>  include/linux/ioport.h | 1 +
>  kernel/resource.c      | 6 +++---
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 2879e234e193..16fcde196243 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1050,10 +1050,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
> +	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>  	case E820_TYPE_RAM:		/* Fall-through: */
>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
> -	case E820_TYPE_RESERVED:	/* Fall-through: */
>  	default:			return IORES_DESC_NONE;
>  	}
>  }
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..6ed59de48bd5 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -133,6 +133,7 @@ enum {
>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
> +	IORES_DESC_RESERVED			= 8,
>  };
>  
>  /* helpers to define resources */

IORES_DESC_RESERVED is supposed to represent E820_TYPE_RESERVED. And if
that is the case, then all three hunks below look wrong to me. If you
want to pass E820_TYPE_RESERVED ranges, then do that explicitly.

> diff --git a/kernel/resource.c b/kernel/resource.c
> index e81b17b53fa5..ee7348761858 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -990,7 +990,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>  	res->start = start;
>  	res->end = end;
>  	res->flags = type | IORESOURCE_BUSY;
> -	res->desc = IORES_DESC_NONE;
> +	res->desc = IORES_DESC_RESERVED;
>  
>  	while (1) {
>  
> @@ -1025,7 +1025,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>  				next_res->start = conflict->end + 1;
>  				next_res->end = end;
>  				next_res->flags = type | IORESOURCE_BUSY;
> -				next_res->desc = IORES_DESC_NONE;
> +				next_res->desc = IORES_DESC_RESERVED;
>  			}
>  		} else {
>  			res->start = conflict->end + 1;
> @@ -1488,7 +1488,7 @@ static int __init reserve_setup(char *str)
>  			res->start = io_start;
>  			res->end = io_start + io_num - 1;
>  			res->flags |= IORESOURCE_BUSY;
> -			res->desc = IORES_DESC_NONE;
> +			res->desc = IORES_DESC_RESERVED;
>  			res->child = NULL;
>  			if (request_resource(parent, res) == 0)
>  				reserved = x+1;
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
