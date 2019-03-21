Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB0A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfCUNfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:35:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfCUNfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:35:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 214DE80D;
        Thu, 21 Mar 2019 06:35:03 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705A63F71A;
        Thu, 21 Mar 2019 06:34:57 -0700 (PDT)
Subject: Re: [PATCH] perf: Change PMCR write to read-modify-write
To:     Prasad Sodagudi <psodagud@codeaurora.org>, will.deacon@arm.com,
        mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <bb4ece56-ac42-05f2-8475-38c49539999d@arm.com>
Date:   Thu, 21 Mar 2019 13:34:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prasad,

On 21/03/2019 02:07, Prasad Sodagudi wrote:
> Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
> Reset routine should write a 1 to PMCR.C and PMCR.P fields only
> to reset the counters. Other fields should not be changed
> as they could be set before PMU initialization and their
> value must be preserved even after reset.
> 

Are there any particular bit you are concerned about? Apart from the RO
ones and the Res0 ones (to which we are already writing 0), I see:

DP -> irrelevant for non-secure
X -> This one is the only potentially interesting, however it resets to
an architecturally unknown value, so unless we know for a fact it was
set before hand, we probably want to clear it
D -> ignored when we have LC set (and we do)
E -> Since this is the function we use to reset the PMU on the current
CPU, we probably want to set this bit to 0 regardless of its previous value

So, is there any issue this patch is solving?

Thanks,

> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> ---
>  arch/arm64/kernel/perf_event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 4addb38..0c1afdd 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -868,8 +868,8 @@ static void armv8pmu_reset(void *info)
>  	 * Initialize & Reset PMNC. Request overflow interrupt for
>  	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
>  	 */
> -	armv8pmu_pmcr_write(ARMV8_PMU_PMCR_P | ARMV8_PMU_PMCR_C |
> -			    ARMV8_PMU_PMCR_LC);
> +	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_P |
> +			ARMV8_PMU_PMCR_C | ARMV8_PMU_PMCR_LC);
>  }
>  
>  static int __armv8_pmuv3_map_event(struct perf_event *event,
> 

-- 
Julien Thierry
