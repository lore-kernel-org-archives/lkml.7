Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960EEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC602176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1Ov5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:51:57 -0500
Received: from foss.arm.com ([217.140.110.172]:36416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfK1Ov5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:51:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 670C430E;
        Thu, 28 Nov 2019 06:51:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D2C3F68E;
        Thu, 28 Nov 2019 06:51:53 -0800 (PST)
Date:   Thu, 28 Nov 2019 14:51:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, allison@lohutok.net, info@metux.net,
        alexios.zavras@intel.com, sstabellini@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, stefan@agner.ch,
        yamada.masahiro@socionext.com, xen-devel@lists.xenproject.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH 2/3] arm64: remove uaccess_ttbr0 asm macros from cache
 functions
Message-ID: <20191128145151.GB22314@lakrids.cambridge.arm.com>
References: <20191127184453.229321-1-pasha.tatashin@soleen.com>
 <20191127184453.229321-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127184453.229321-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:44:52PM -0500, Pavel Tatashin wrote:
> We currently duplicate the logic to enable/disable uaccess via TTBR0,
> with C functions and assembly macros. This is a maintenenace burden
> and is liable to lead to subtle bugs, so let's get rid of the assembly
> macros, and always use the C functions. This requires refactoring
> some assembly functions to have a C wrapper.

[...]

> +static inline int invalidate_icache_range(unsigned long start,
> +					  unsigned long end)
> +{
> +	int rv;

Please make this 'ret', for consistency with other arm64 code. We only
use 'rv' in one place where it's short for "Revision and Variant", and
'ret' is our usual name for a temporary variable used to hold a return
value.

> +
> +	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
> +		isb();
> +		return 0;
> +	}
> +	uaccess_ttbr0_enable();

Please place a newline between these two, for consistency with other
arm64 code.

> +	rv = asm_invalidate_icache_range(start, end);
> +	uaccess_ttbr0_disable();
> +
> +	return rv;
> +}
> +
>  static inline void flush_icache_range(unsigned long start, unsigned long end)
>  {
>  	__flush_icache_range(start, end);
> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
> index db767b072601..a48b6dba304e 100644
> --- a/arch/arm64/mm/cache.S
> +++ b/arch/arm64/mm/cache.S
> @@ -15,7 +15,7 @@
>  #include <asm/asm-uaccess.h>
>  
>  /*
> - *	flush_icache_range(start,end)
> + *	__asm_flush_icache_range(start,end)
>   *
>   *	Ensure that the I and D caches are coherent within specified region.
>   *	This is typically used when code has been written to a memory region,
> @@ -24,11 +24,11 @@
>   *	- start   - virtual start address of region
>   *	- end     - virtual end address of region
>   */
> -ENTRY(__flush_icache_range)
> +ENTRY(__asm_flush_icache_range)
>  	/* FALLTHROUGH */
>  
>  /*
> - *	__flush_cache_user_range(start,end)
> + *	__asm_flush_cache_user_range(start,end)
>   *
>   *	Ensure that the I and D caches are coherent within specified region.
>   *	This is typically used when code has been written to a memory region,
> @@ -37,8 +37,7 @@ ENTRY(__flush_icache_range)
>   *	- start   - virtual start address of region
>   *	- end     - virtual end address of region
>   */
> -ENTRY(__flush_cache_user_range)
> -	uaccess_ttbr0_enable x2, x3, x4
> +ENTRY(__asm_flush_cache_user_range)
>  alternative_if ARM64_HAS_CACHE_IDC

It's unfortunate that we pulled the IDC alternative out for
invalidate_icache_range(), but not here.

If we want to pull out that, then I reckon what we might want to do is
have two asm primitives:

* __asm_clean_dcache_range
* __asm_invalidate_icache_range

... which just do the by_line op, with a fixup that can return -EFAULT.

Then we can give each a C wrapper that just does the IDC/DIC check, e.g.

static int __clean_dcache_range(unsigned long start, unsigned long end)
{
	if (cpus_have_const_cap(ARM64_HAS_CACHE_IDC)) {
		dsb(ishst);
		return 0;
	}

	return __asm_clean_dcache_range(start, end);
}

Then we can build all the more complicated variants atop of those, e.g.

static int __flush_cache_user_range(unsigned long start, unsigned long end)
{
	int ret;

	uaccess_ttbr0_enable();

	ret = __clean_dcache_range(start, end);
	if (ret)
		goto out;
	
	ret = __invalidate_icache_range(start, end);

out:
	uaccess_ttbr0_disable();
	return ret;
}

Thanks,
Mark.
