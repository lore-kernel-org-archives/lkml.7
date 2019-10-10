Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D69C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5757205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfJJQnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:43:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJQnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:43:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C4C28;
        Thu, 10 Oct 2019 09:43:16 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A993F71A;
        Thu, 10 Oct 2019 09:43:14 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:43:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <justin.he@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20191010164312.GB40923@arrakis.emea.arm.com>
References: <20191009084246.123354-1-justin.he@arm.com>
 <20191009084246.123354-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009084246.123354-2-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:42:43PM +0800, Jia He wrote:
> We unconditionally set the HW_AFDBM capability and only enable it on
> CPUs which really have the feature. But sometimes we need to know
> whether this cpu has the capability of HW AF. So decouple AF from
> DBM by a new helper cpu_has_hw_af().
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I don't think I reviewed this version of the patch.

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9cde5d2e768f..1a95396ea5c8 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -659,6 +659,20 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
>  	default: return CONFIG_ARM64_PA_BITS;
>  	}
>  }
> +
> +/* Check whether hardware update of the Access flag is supported */
> +static inline bool cpu_has_hw_af(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM)) {

Please just return early here to avoid unnecessary indentation:

	if (!IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
		return false;

> +		u64 mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
> +
> +		return !!cpuid_feature_extract_unsigned_field(mmfr1,
> +						ID_AA64MMFR1_HADBS_SHIFT);

No need for !!, the return type is a bool already.

Anyway, apart from these nitpicks, the patch is fine you can keep my
reviewed-by.

If later we noticed a potential performance issue on this path, we can
turn it into a static label as with other CPU features.

-- 
Catalin
