Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2CECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CDC21A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569934498;
	bh=4ZwqNMkLAQ6qVgwcsq/kPtYCFF46wZLCtAuZ+J9bA0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhsjBw5KqsjCQOsvxn6Rx/sTJxSpmknR58zJqeqzvCXZe9sL/A7JwoWZkjAYZSSpL
	 qmz/a9cN5319L54J6Ox4E2t6yoGLDUkAqzkucClJ2R6La9n+JgA3xjyAI2GmaBTNFb
	 JS/nVp3Ts2dw9tZTbClxw/WkoVxmimXZvfgJpKeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbfJAMy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbfJAMyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:54:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ADF21872;
        Tue,  1 Oct 2019 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934493;
        bh=4ZwqNMkLAQ6qVgwcsq/kPtYCFF46wZLCtAuZ+J9bA0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOXfnlLNBAeHH+AHjQ/kdaxE6JUJFThHEvZ5AnHpcIJhKyHJiF59b0Nb3ywQH8RE5
         78jm9cqaDGZLNS11Hdl09X2vIhhg0UGjXDBMZZPluuea7beLK4hgB694ALgyVuezxZ
         JS/+Y+lD4qfJINQObM0tYmWz7zzM3Gy1feo1XRN0=
Date:   Tue, 1 Oct 2019 13:54:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v10 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20191001125446.gknoofnm7az4wqf5@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930015740.84362-2-justin.he@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:57:38AM +0800, Jia He wrote:
> We unconditionally set the HW_AFDBM capability and only enable it on
> CPUs which really have the feature. But sometimes we need to know
> whether this cpu has the capability of HW AF. So decouple AF from
> DBM by new helper cpu_has_hw_af().
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Suggested-by: Suzuki Poulose <Suzuki.Poulose@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9cde5d2e768f..949bc7c85030 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -659,6 +659,16 @@ static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
>  	default: return CONFIG_ARM64_PA_BITS;
>  	}
>  }
> +
> +/* Check whether hardware update of the Access flag is supported */
> +static inline bool cpu_has_hw_af(void)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
> +		return read_cpuid(ID_AA64MMFR1_EL1) & 0xf;

0xf? I think we should have a mask in sysreg.h for this constant.

Will
