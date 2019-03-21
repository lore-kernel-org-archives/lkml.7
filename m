Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA22C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3478A21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfCURDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:03:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60146 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCURDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:03:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C10374;
        Thu, 21 Mar 2019 10:03:12 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8FE13F614;
        Thu, 21 Mar 2019 10:03:09 -0700 (PDT)
Subject: Re: [PATCH RFC 01/14] arm64/mm: Introduce asid_info structure and
 move asid_generation/asid_map to it
To:     julien.grall@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     christoffer.dall@arm.com, james.morse@arm.com,
        marc.zyngier@arm.com, julien.thierry@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-2-julien.grall@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ad32ff02-a88f-ee8a-3296-f859638d66b9@arm.com>
Date:   Thu, 21 Mar 2019 17:03:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321163623.20219-2-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 21/03/2019 16:36, Julien Grall wrote:
> In an attempt to make the ASID allocator generic, create a new structure
> asid_info to store all the information necessary for the allocator.
> 
> For now, move the variables asid_generation and asid_map to the new structure
> asid_info. Follow-up patches will move more variables.
> 
> Note to avoid more renaming aftwards, a local variable 'info' has been
> created and is a pointer to the ASID allocator structure.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>   arch/arm64/mm/context.c | 46 ++++++++++++++++++++++++++--------------------
>   1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 1f0ea2facf24..34db54f1a39a 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -30,8 +30,11 @@
>   static u32 asid_bits;
>   static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
>   
> -static atomic64_t asid_generation;
> -static unsigned long *asid_map;
> +struct asid_info
> +{
> +	atomic64_t	generation;
> +	unsigned long	*map;
> +} asid_info;

Shouldn't this be static ? Rest looks fine.

Cheers
Suzuki
