Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA5C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D22173C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 09:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFPJ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 05:58:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfFPJ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 05:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39D303084034;
        Sun, 16 Jun 2019 09:58:53 +0000 (UTC)
Received: from krava (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6BD2C6AD2F;
        Sun, 16 Jun 2019 09:58:45 +0000 (UTC)
Date:   Sun, 16 Jun 2019 11:58:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        kan.liang@linux.intel.com, ben@decadent.org.uk,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
Message-ID: <20190616095844.GC2500@krava>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560521283-73314-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 16 Jun 2019 09:58:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 10:08:00PM +0800, John Garry wrote:
> The jevent "Unit" field is used for uncore PMU alias definition.
> 
> The form uncore_pmu_example_X is supported, where "X" is a wildcard,
> to support multiple instances of the same PMU in a system.
> 
> Unfortunately this format not suitable for all uncore PMUs; take the Hisi
> DDRC uncore PMU for example, where the name is in the form
> hisi_scclX_ddrcY.
> 
> For the current jevent parsing, we would be required to hardcode an uncore
> alias translation for each possible value of X. This is not scalable.
> 
> Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
> we can match by hisi_scclX and ddrcY. Tokens in Unit field are 
> delimited by ','.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/pmu.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 7e7299fee550..bc71c60589b5 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -700,6 +700,39 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
>  	return map;
>  }
>  
> +static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> +{
> +	char *tmp, *tok, *str;
> +	bool res;
> +
> +	str = strdup(pmu_name);
> +	if (!str)
> +		return false;
> +
> +	/*
> +	 * uncore alias may be from different PMU with common
> +	 * prefix or matching tokens.
> +	 */
> +	tok = strtok_r(str, ",", &tmp);
> +	if (strncmp(pmu_name, tok, strlen(tok))) {

if tok is NULL in here we crash

> +		res = false;
> +		goto out;
> +	}
> +
> +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {

why is name shifted in here?

jirka

> +		name = strstr(name, tok);
> +		if (!name) {
> +			res = false;
> +			goto out;
> +		}
> +	}
> +
> +	res = true;
> +out:
> +	free(str);
> +	return res;
> +}
> +
>  /*
>   * From the pmu_events_map, find the table of PMU events that corresponds
>   * to the current running CPU. Then, add all PMU events from that table
> @@ -730,12 +763,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  			break;
>  		}
>  
> -		/*
> -		 * uncore alias may be from different PMU
> -		 * with common prefix
> -		 */
>  		if (pmu_is_uncore(name) &&
> -		    !strncmp(pname, name, strlen(pname)))
> +		    pmu_uncore_alias_match(pname, name))
>  			goto new_alias;
>  
>  		if (strcmp(pname, name))
> -- 
> 2.17.1
> 
