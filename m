Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F14C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D672083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCRIxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfCRIxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:53:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4DB98AE4D;
        Mon, 18 Mar 2019 08:53:23 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BAF65D707;
        Mon, 18 Mar 2019 08:53:22 +0000 (UTC)
Date:   Mon, 18 Mar 2019 09:53:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Thomas Richter <tmricht@linux.ibm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix parser error for uncore event alias
Message-ID: <20190318085322.GD5200@krava>
References: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 18 Mar 2019 08:53:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 11:00:14AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf fails to parse uncore event alias, for example:
> 
>   #perf stat -e unc_m_clockticks -a --no-merge sleep 1
>   event syntax error: 'unc_m_clockticks'
>                        \___ parser error
> 
> Current code assumes that the event alias is from one specific PMU.
> To find the PMU, perf strcmp the pmu name of event alias with the
> real pmu name on the system.
> However, the uncore event alias may be from multiple PMUs with common
> prefix. The pmu name of uncore event alias is the common prefix.
> For example, UNC_M_CLOCKTICKS is clock event for iMC, which include
> 6 PMUs with the same prefix "uncore_imc" on a skylake server.
> The real pmu names on the system for iMC are uncore_imc_0 ...
> uncore_imc_5.
> The strncmp is used to only check the common prefix for uncore
> event alias.
> 
> With the patch,
>   #perf stat -e unc_m_clockticks -a --no-merge sleep 1
>   Performance counter stats for 'system wide':
> 
>        723,594,722      unc_m_clockticks [uncore_imc_5]
>        724,001,954      unc_m_clockticks [uncore_imc_3]
>        724,042,655      unc_m_clockticks [uncore_imc_1]
>        724,161,001      unc_m_clockticks [uncore_imc_4]
>        724,293,713      unc_m_clockticks [uncore_imc_2]
>        724,340,901      unc_m_clockticks [uncore_imc_0]
> 
>        1.002090060 seconds time elapsed
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/pmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 51d437f..395308f 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -732,10 +732,20 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  
>  		if (!is_arm_pmu_core(name)) {
>  			pname = pe->pmu ? pe->pmu : "cpu";
> +
> +			/*
> +			 * uncore alias may be from different PMU
> +			 * with common prefix
> +			 */
> +			if (pmu_is_uncore(name) &&
> +			    !strncmp(pname, name, strlen(pname)))
> +				goto new_alias;
> +
>  			if (strcmp(pname, name))
>  				continue;
>  		}
>  
> +new_alias:
>  		/* need type casts to override 'const' */
>  		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
>  				(char *)pe->desc, (char *)pe->event,
> -- 
> 2.7.4
> 
