Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FFB21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfIEKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:17:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbfIEKR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:17:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1121F1576;
        Thu,  5 Sep 2019 03:17:29 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CE9B3F718;
        Thu,  5 Sep 2019 03:17:27 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-4-subhra.mazumdar@oracle.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net,
        parth@linux.ibm.com
Subject: Re: [RFC PATCH 3/9] sched: add sched feature to disable idle core search
In-reply-to: <20190830174944.21741-4-subhra.mazumdar@oracle.com>
Date:   Thu, 05 Sep 2019 11:17:25 +0100
Message-ID: <87mufj2gju.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Aug 30, 2019 at 18:49:38 +0100, subhra mazumdar wrote...

> Add a new sched feature SIS_CORE to have an option to disable idle core
> search (select_idle_core).
>
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/features.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 858589b..de4d506 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -57,6 +57,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_AVG_CPU, false)
>  SCHED_FEAT(SIS_PROP, true)
> +SCHED_FEAT(SIS_CORE, true)

Why do we need a sched_feature? If you think there are systems in
which the usage of latency-nice does not make sense for in "Select Idle
Sibling", then we should probably better add a new Kconfig option.

If that's the case, you can probably use the init/Kconfig's
"Scheduler features" section, recently added by:

  commit 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")

>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
