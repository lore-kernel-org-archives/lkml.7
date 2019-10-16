Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E294FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405183AbfJPOkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:40:11 -0400
Received: from foss.arm.com ([217.140.110.172]:41694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404529AbfJPOkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2E5E142F;
        Wed, 16 Oct 2019 07:40:09 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193FB3F68E;
        Wed, 16 Oct 2019 07:40:08 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:40:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] arm64: mm: Fix unused variable warning in
 zone_sizes_init
Message-ID: <20191016144006.GK49619@arrakis.emea.arm.com>
References: <20191015224304.20963-1-natechancellor@gmail.com>
 <20191016031107.30045-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016031107.30045-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:11:08PM -0700, Nathan Chancellor wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 44f07fdf7a59..359c3b08b968 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	struct memblock_region *reg;
>  	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
>  	unsigned long max_dma32 = min;
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
>  	unsigned long max_dma = min;
> +#endif

Nitpick: the coding style recommends __maybe_unused instead of #ifdef.

-- 
Catalin
