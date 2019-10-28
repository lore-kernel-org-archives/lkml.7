Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA81CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B121721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H476hzYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfJ1PVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:21:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfJ1PVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYQJBoLlXMijB61UyPZNPGjwfcxayF05c36JKITFNco=; b=H476hzYTFEKh98cq8PNtPeKoR
        Ojuzom3FRoQ1ViHJD70YdoENeuLnlImHSvX3aHS12eCSmh5GZzVIWcIe0MGqPcV8xIAVw1sFifich
        x4mt23MPw1TxnjTGt32WIIdAc73cjcVHnJVJUDBodBDR6LqWiNIeSZsxoVgO7xRTcVCQwsohi+uYK
        iUjl2VuGOA3O0E4v/HZDWgpdXYcxh6qunLM4HdZO/nbN11WwDCCao1bKuZq0FFgRB8vWmH5atuzvS
        NKfpk9bQsDd9CUUjO1PkgxVTpx/oEToBUmT/kbv0FbUqKEe5bB10VSKGEaELZLAfYqDc3PA+Of3ur
        YpYFaPsqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP6pu-000472-5C; Mon, 28 Oct 2019 15:21:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DED44300E4D;
        Mon, 28 Oct 2019 16:20:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F4E12B4468C8; Mon, 28 Oct 2019 16:21:35 +0100 (CET)
Date:   Mon, 28 Oct 2019 16:21:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
Message-ID: <20191028152135.GC4097@hirez.programming.kicks-ass.net>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:34:21PM -0400, Thara Gopinath wrote:
> Add thermal.c and thermal.h files that provides interface
> APIs to initialize, update/average, track, accumulate and decay
> thermal pressure per cpu basis. A per cpu variable delta_capacity is
> introduced to keep track of instantaneous per cpu thermal pressure.
> Thermal pressure is the delta between maximum capacity and capped
> capacity due to a thermal event.

> API trigger_thermal_pressure_average is called for periodic accumulate
> and decay of the thermal pressure. It is to to be called from a
> periodic tick function. This API passes on the instantaneous delta
> capacity of a cpu to update_thermal_load_avg to do the necessary
> accumulate, decay and average.

> API update_thermal_pressure is for the system to update the thermal
> pressure by providing a capped frequency ratio.

> Considering, trigger_thermal_pressure_average reads delta_capacity and
> update_thermal_pressure writes into delta_capacity, one can argue for
> some sort of locking mechanism to avoid a stale value.

> But considering trigger_thermal_pressure_average can be called from a
> system critical path like scheduler tick function, a locking mechanism
> is not ideal. This means that it is possible the delta_capacity value
> used to calculate average thermal pressure for a cpu can be
> stale for upto 1 tick period.

Please use a blank line at the end of a paragraph.

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---

>  include/linux/sched.h  |  8 ++++++++
>  kernel/sched/Makefile  |  2 +-
>  kernel/sched/thermal.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/thermal.h | 13 +++++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/sched/thermal.c
>  create mode 100644 kernel/sched/thermal.h

These are some tiny files, do these functions really need their own
little files?


> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
> new file mode 100644
> index 0000000..0c84960
> --- /dev/null
> +++ b/kernel/sched/thermal.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Scheduler Thermal Interactions
> + *
> + *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
> + */
> +
> +#include <linux/sched.h>
> +#include "sched.h"
> +#include "pelt.h"
> +#include "thermal.h"
> +
> +static DEFINE_PER_CPU(unsigned long, delta_capacity);
> +
> +/**
> + * update_thermal_pressure: Update thermal pressure
> + * @cpu: the cpu for which thermal pressure is to be updated for
> + * @capped_freq_ratio: capped max frequency << SCHED_CAPACITY_SHIFT / max freq
> + *
> + * capped_freq_ratio is normalized into capped capacity and the delta between
> + * the arch_scale_cpu_capacity and capped capacity is stored in per cpu
> + * delta_capacity.
> + */
> +void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
> +{
> +	unsigned long __capacity, delta;
> +
> +	/* Normalize the capped freq ratio */
> +	__capacity = (capped_freq_ratio * arch_scale_cpu_capacity(cpu)) >>
> +							SCHED_CAPACITY_SHIFT;
> +	delta = arch_scale_cpu_capacity(cpu) -  __capacity;
> +	pr_debug("updating cpu%d thermal pressure to %lu\n", cpu, delta);

Surely we can do without the pr_debug() here?

> +	per_cpu(delta_capacity, cpu) = delta;
> +}
