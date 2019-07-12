Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC9C742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FF721019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562943441;
	bh=MEM3wLZlDJ4ekEKM4/6J5Ww9M6DT1KF+sb6hCC/78lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NOTQdmis0ZzKzTiKjv2emee1Zjj9P+yCpZOTjRl7rih2MOstR/zne9snPnZJMGDlf
	 /pJIVKdwq2weRIp92Q6NS6d9TpfG26GHWJNLkv9pBc6G5/7XW8JMbkFJ5Zu1rMq+I0
	 dB74VzJg3bDtlSQODMBPUPTHBThS7EzGADb1jM7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGLO5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfGLO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:57:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854402084B;
        Fri, 12 Jul 2019 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562943438;
        bh=MEM3wLZlDJ4ekEKM4/6J5Ww9M6DT1KF+sb6hCC/78lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvHVEWVjk8B3Pk1Ja75F/Em+VG7L/pR8IR53MZAgXjL21B3CV+Ol3dyYc0mtum7iG
         GrmRiEOIRHzFuee4G63LOuvX8pUoorMctEVAgBnW0ElrDceThp9cm5cqqNAa+aJLjK
         MaTs152R+W3BaCw3bxXUeTQKYkzZMBcVaQ6y5ARc=
Date:   Fri, 12 Jul 2019 15:57:12 +0100
From:   Will Deacon <will@kernel.org>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Message-ID: <20190712145711.mxmnuyn6kpv2dr7u@willie-the-truck>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:21:21AM +0200, KarimAllah Ahmed wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3645f29..cdc3e8e 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -78,7 +78,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> -	if (!pfn_valid(pfn))
> +	if (!memblock_is_memory(__pfn_to_phys(pfn)))

This looks broken to me, since it will end up returning 'true' for nomap
memory and we really don't want to map that using writeback attributes.

Will
