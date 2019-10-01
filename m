Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5417ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6A821A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569934239;
	bh=/gPSJI6zO7uojDFJ0+HevJuNlGn4NzxfqGO+ldy/Pn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1nwwoZ8za3SH9Gk3qa4R9nUwsy+sLZg4vG5I/zjUx1tUs/e4UCzAFQR9ImTEh5YXk
	 KAkVxeB+QiunNt4MiuZO+3OuISp3m/2EPv+Ht/79X+sGKvJ1fIolbOLNJJns4EcpCi
	 AuH67J1hPfTyrg4cGpYn+YRdTh0Oy6NhSnTy07+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfJAMuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:50:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5197E21872;
        Tue,  1 Oct 2019 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569934237;
        bh=/gPSJI6zO7uojDFJ0+HevJuNlGn4NzxfqGO+ldy/Pn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFqF2QRXYBnbbTCXivGapO2pDUlAUngoCGoIkS3oh9r2HpKbLT3eU+AP+VjIjEGOP
         e0YoAtuKKCTtzfQqfIIEfGceqRKTf6Shy79nxMHUx3NY9Geoci6VSH2Zt3rzLCmPVM
         6yvRfrdXfiDaiQgqPTt64jLelAubqy/Uw24e8b/I=
Date:   Tue, 1 Oct 2019 13:50:32 +0100
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
Subject: Re: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Message-ID: <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
References: <20190930015740.84362-1-justin.he@arm.com>
 <20190930015740.84362-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930015740.84362-3-justin.he@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:57:39AM +0800, Jia He wrote:
> On arm64 without hardware Access Flag, copying fromuser will fail because
> the pte is old and cannot be marked young. So we always end up with zeroed
> page after fork() + CoW for pfn mappings. we don't always have a
> hardware-managed access flag on arm64.
> 
> Hence implement arch_faults_on_old_pte on arm64 to indicate that it might
> cause page fault when accessing old pte.
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7576df00eb50..e96fb82f62de 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -885,6 +885,20 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  #define phys_to_ttbr(addr)	(addr)
>  #endif
>  
> +/*
> + * On arm64 without hardware Access Flag, copying from user will fail because
> + * the pte is old and cannot be marked young. So we always end up with zeroed
> + * page after fork() + CoW for pfn mappings. We don't always have a
> + * hardware-managed access flag on arm64.
> + */
> +static inline bool arch_faults_on_old_pte(void)
> +{
> +	WARN_ON(preemptible());
> +
> +	return !cpu_has_hw_af();
> +}

Does this work correctly in a KVM guest? (i.e. is the MMFR sanitised in that
case, despite not being the case on the host?)

Will
