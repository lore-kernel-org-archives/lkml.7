Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C25C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8E72070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfDBQu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:50:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbfDBQu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:50:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A21B80D;
        Tue,  2 Apr 2019 09:50:58 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6D303F721;
        Tue,  2 Apr 2019 09:50:56 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:50:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     mingo@redhat.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH] perf: Change PMCR write to read-modify-write
Message-ID: <20190402165054.GB1442@fuggles.cambridge.arm.com>
References: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553134066-20272-1-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+MarkR]

On Wed, Mar 20, 2019 at 07:07:46PM -0700, Prasad Sodagudi wrote:
> Preserves the bitfields of PMCR_EL0(AArch64) during PMU reset.
> Reset routine should write a 1 to PMCR.C and PMCR.P fields only
> to reset the counters. Other fields should not be changed
> as they could be set before PMU initialization and their
> value must be preserved even after reset.
> 
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

No, I don't think this is right at all. Many of these bits are UNKNOWN
out of reset, so you're throwing away our means of getting the PMU into
a deterministic state.

Who is setting which bits that you want to preserve and why?

Will
