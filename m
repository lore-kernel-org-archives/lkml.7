Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E70C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35EF22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfGZMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:30:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfGZMaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:30:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5430D337;
        Fri, 26 Jul 2019 05:29:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E413F694;
        Fri, 26 Jul 2019 05:29:58 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:29:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] arm_pmu: Mark expected switch fall-through
Message-ID: <20190726122956.GC26088@lakrids.cambridge.arm.com>
References: <20190726112737.19309-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726112737.19309-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> When fall-through warnings was enabled by default the following warning
> was starting to show up:
> 
> ../drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
> ../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    cpu_pm_pmu_setup(armpmu, cmd);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/perf/arm_pmu.c:727:2: note: here
>   case CPU_PM_ENTER_FAILED:
>   ^~~~
> 
> Rework so that the compiler doesn't warn about fall-through.
> 
> Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> I'm not convinced that this is the correct patch to fix this issue.
> However, I can't see why we do 'armpmu->start(armpmu);' only in 'case
> CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setup()
> there also, since in cpu_pm_pmu_setup() has a case prepared for
> CPU_PM_ENTER_FAILED.

I agree, think that should be:

	case CPU_PM_EXIT:
	case CPU_PM_ENTER_FAILED:
		cpu_pm_pmu_setup(armpmu, cmd);
		armpmu->start(armpmu);
		break;

... so that we re-start the events before we start the PMU.

That would be a fix for commit:

  da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM notifier")
 
Thanks,
Mark.

> 
>  drivers/perf/arm_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 2d06b8095a19..465a15705bab 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -724,6 +724,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
>  		break;
>  	case CPU_PM_EXIT:
>  		cpu_pm_pmu_setup(armpmu, cmd);
> +		/* Fall through */
>  	case CPU_PM_ENTER_FAILED:
>  		armpmu->start(armpmu);
>  		break;
> -- 
> 2.20.1
> 
