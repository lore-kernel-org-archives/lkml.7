Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B10C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A3C20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLTSKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:10:04 -0500
Received: from foss.arm.com ([217.140.110.172]:53916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfLTSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:10:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45D61FB;
        Fri, 20 Dec 2019 10:10:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A1F73F67D;
        Fri, 20 Dec 2019 10:10:02 -0800 (PST)
Date:   Fri, 20 Dec 2019 18:10:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] perf: arm_spe: Handle guest/host exclusion flags
Message-ID: <20191220180959.GF25258@lakrids.cambridge.arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
 <20191220143025.33853-16-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220143025.33853-16-andrew.murray@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 02:30:22PM +0000, Andrew Murray wrote:
> A side effect of supporting the SPE in guests is that we prevent the
> host from collecting data whilst inside a guest thus creating a black-out
> window. This occurs because instead of emulating the SPE, we share it
> with our guests.

We used to permit this; do we know if anyone is using it?

Thanks,
Mark.

> Let's accurately describe our capabilities by using the perf exclude
> flags to prevent !exclude_guest and exclude_host flags from being used.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 2d24af4cfcab..3703dbf459de 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -679,6 +679,9 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	if (attr->exclude_idle)
>  		return -EOPNOTSUPP;
>  
> +	if (!attr->exclude_guest || attr->exclude_host)
> +		return -EOPNOTSUPP;
> +
>  	/*
>  	 * Feedback-directed frequency throttling doesn't work when we
>  	 * have a buffer of samples. We'd need to manually count the
> -- 
> 2.21.0
> 
