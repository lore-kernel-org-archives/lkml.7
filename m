Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507020665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK0PBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:01:44 -0500
Received: from foss.arm.com ([217.140.110.172]:48684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfK0PBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:01:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53ED30E;
        Wed, 27 Nov 2019 07:01:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC373F68E;
        Wed, 27 Nov 2019 07:01:39 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:01:37 +0000
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
Subject: Re: [PATCH v2 2/3] arm64: remove uaccess_ttbr0 asm macros from cache
 functions
Message-ID: <20191127150137.GB51937@lakrids.cambridge.arm.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122022406.590141-3-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Thu, Nov 21, 2019 at 09:24:05PM -0500, Pavel Tatashin wrote:
> Replace the uaccess_ttbr0_disable/uaccess_ttbr0_enable via
> inline variants, and remove asm macros.

A commit message should provide rationale, rather than just a
description of the patch. Something like:

| We currently duplicate the logic to enable/disable uaccess via TTBR0,
| with C functions and assembly macros. This is a maintenenace burden
| and is liable to lead to subtle bugs, so let's get rid of the assembly
| macros, and always use the C functions. This requires refactoring
| some assembly functions to have a C wrapper.

[...]

> +static inline int invalidate_icache_range(unsigned long start,
> +					  unsigned long end)
> +{
> +	int rv;
> +#if ARM64_HAS_CACHE_DIC
> +	rv = arch_invalidate_icache_range(start, end);
> +#else
> +	uaccess_ttbr0_enable();
> +	rv = arch_invalidate_icache_range(start, end);
> +	uaccess_ttbr0_disable();
> +#endif
> +	return rv;
> +}

This ifdeffery is not the same as an alternative_if, and even if it were
the ARM64_HAS_CACHE_DIC behaviour is not the same as the existing
assembly.

This should be:

static inline int invalidate_icache_range(unsigned long start,
					  unsigned long end)
{
	int ret;

	if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC)) {
		isb();
		return 0;
	}
	
	uaccess_ttbr0_enable();
	ret = arch_invalidate_icache_range(start, end);
	uaccess_ttbr0_disable();

	return ret;
}

The 'arch_' prefix should probably be 'asm_' (or have an '_asm' suffix),
since this is entirely local to the arch code, and even then should only
be called from the C wrappers.

Thanks,
Mark.
