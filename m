Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E372075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="itYrHCLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfC2Kj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:39:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbfC2Kj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:39:57 -0400
Received: from zn.tnic (p200300EC2F148A00A084EDD1F3CAD6FC.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:a084:edd1:f3ca:d6fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 434DA1EC082D;
        Fri, 29 Mar 2019 11:39:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553855996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uqyR0dwp809uKHGAQhJekWc/ky04xKAxHRHufvjw7HU=;
        b=itYrHCLc/2jLXbAyKdFVkj6jrkttnpS2QygK6P2hqNYD0VX35iet39WVMk6u/1rhL8LjVh
        U1uUo7pAFkufaVWfDmEOJddiJxmZRTI645+oX20xUxH6ScXRvaEIFr8pXumiXdhNuYNA8g
        FWWfidsrGGidtOzUelfc2sRJfGvZ39g=
Date:   Fri, 29 Mar 2019 11:39:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2 v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190329103958.GC21152@zn.tnic>
References: <20190329065649.12468-1-lijiang@redhat.com>
 <20190329065649.12468-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329065649.12468-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:56:48PM +0800, Lianbo Jiang wrote:
> When doing kexec_file_load(), the first kernel needs to pass the e820
> reserved ranges to the second kernel, because some devices may use it
> in kdump kernel, such as PCI devices.
> 
> But, the kernel can not exactly match the e820 reserved ranges when
> walking through the iomem resources via the 'IORES_DESC_NONE', because
> there are several types of e820 that are described as the 'IORES_DESC_NONE'
> type. Please refer to the e820_type_to_iores_desc().
> 
> Therefore, add a new I/O resource descriptor 'IORES_DESC_RESERVED' for
> the iomem resources search interfaces. It is helpful to exactly match
> the reserved resource ranges when walking through iomem resources.
> 
> In addition, since the new descriptor 'IORES_DESC_RESERVED' has been
> created for the reserved areas, the code originally related to the
> descriptor 'IORES_DESC_NONE' also need to be updated.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/e820.c |  2 +-
>  arch/x86/mm/ioremap.c  | 16 ++++++++++++++--
>  include/linux/ioport.h |  1 +
>  3 files changed, 16 insertions(+), 3 deletions(-)
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
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 0029604af8a4..5671ec24df49 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -81,9 +81,21 @@ static bool __ioremap_check_ram(struct resource *res)
>  	return false;
>  }
>  
> -static int __ioremap_check_desc_other(struct resource *res)

I can see this patch doesn't build even without applying and building
it.

How about you build-test your stuff before submitting?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
