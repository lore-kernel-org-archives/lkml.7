Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6952C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A0A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfDWJ4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:56:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52996 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWJ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49289374;
        Tue, 23 Apr 2019 02:56:11 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162DA3F557;
        Tue, 23 Apr 2019 02:56:09 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:56:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Ensure tail of unaligned initrd is reserved
Message-ID: <20190423095605.GA28879@fuggles.cambridge.arm.com>
References: <20190418042929.20189-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418042929.20189-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:29:29PM -0700, Bjorn Andersson wrote:
> In the event that the start address of the initrd is not aligned, but
> has an aligned size, the base + size will not cover the entire initrd
> image and there is a chance that the kernel will corrupt the tail of the
> image.
> 
> By aligning the end of the initrd to a page boundary and then
> subtracting the adjusted start address the memblock reservation will
> cover all pages that contains the initrd.
> 
> Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 6bc135042f5e..7cae155e81a5 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -363,7 +363,7 @@ void __init arm64_memblock_init(void)
>  		 * Otherwise, this is a no-op
>  		 */
>  		u64 base = phys_initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(phys_initrd_size);
> +		u64 size = PAGE_ALIGN(phys_initrd_start + phys_initrd_size) - base;

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up as a fix for 5.1.

Will
