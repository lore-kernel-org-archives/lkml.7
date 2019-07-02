Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F4CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D2C2184C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 19:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JidW4dYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGBTHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 15:07:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46958 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 15:07:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so19788792qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wQ2eWjX8ogKBuOp00qcklecjDoXf2f54BF8WB0/TWII=;
        b=JidW4dYbE0QUxwzFXcMc939F1GeiSl4e29Kjjwnj2aeiUe6IK1U7BDRoGAV8NQJDKV
         phtHtav1J/2VH88H6UKTt2gA3G0RDqkzeXKle1ef4Yc7ZSuBBoUen/LPm0nzPLEC+iNQ
         6+GaheRF7e42NzWfkmYuwBBKK8svcphuuNpuegyfFhApLCub3L0U6P3C11+fpdNRFl4d
         psWX+6K/X1I9hcXsB+Ia8S4t7uoC60O0s7kpD/JZUy4QXb8cAUwUPZrro0aLhy3kCITa
         UrgdkqRBH3vvS5IrCyz0RL/uxl26qJnyDE9WLCUyQO7FyoAEhLq8+w/pz57X2er0aHjB
         PQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wQ2eWjX8ogKBuOp00qcklecjDoXf2f54BF8WB0/TWII=;
        b=lhD2ac2xT40Nzmf6zIlr6NToeh3lIYRVX7QufSONCveBwI8S+JBgGSF5cPH9JvZR0w
         z6ePUdHeBuTNkRw8QzGBjcqnHUFXb+Qq8IvN0TQ7Qm7lRx9cR3OdKreRJvSoNNPQNI6k
         kLLmcCuZOE6o97nwHJpF0TzKW6DuxM3emRXiSnlsnEk2WKTOaxdYw05S0zHVjMF9FcVX
         dGWD9XKozlvguj/vbm7vyt22zX1QSg1WcX6oEcR9Sa/NJqTYCKEZMJOIc6g+eZRREyGZ
         OYVFaXtct+R4bsjwp5dz76qX7L3nnlO5F7e1RE3waU8aOx7QB+76k2RbekwqHUhTZZxQ
         /UJQ==
X-Gm-Message-State: APjAAAVFvWMtWRhRuY2kkrblx5n2agIt6OzlPmpdlVLzeVzGATiS/TGz
        ElMDUCH2Tlj1FljShcFanHA=
X-Google-Smtp-Source: APXvYqxRqnveK4LS61gzxzKAUfw9a3vS/qQpkVFcSgqTTeVnfX3pBapPH+oWlUIM5GvOlQwetS6gFg==
X-Received: by 2002:a0c:9687:: with SMTP id a7mr28868074qvd.163.1562094448043;
        Tue, 02 Jul 2019 12:07:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 5sm7522929qkr.68.2019.07.02.12.07.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 12:07:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80F8741153; Tue,  2 Jul 2019 16:07:24 -0300 (-03)
Date:   Tue, 2 Jul 2019 16:07:24 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com,
        ak@linux.intel.com
Subject: Re: [PATCH v3 1/4] perf pmu: Support more complex PMU event aliasing
Message-ID: <20190702190724.GM15462@kernel.org>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
 <1561732552-143038-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561732552-143038-2-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 10:35:49PM +0800, John Garry escreveu:
> The jevent "Unit" field is used for uncore PMU alias definition.
> 
> The form uncore_pmu_example_X is supported, where "X" is a wildcard,
> to support multiple instances of the same PMU in a system.
> 
> Unfortunately this format not suitable for all uncore PMUs; take the Hisi
> DDRC uncore PMU for example, where the name is in the form
> hisi_scclX_ddrcY.
> 
> For for current jevent parsing, we would be required to hardcode an uncore
> alias translation for each possible value of X. This is not scalable.
> 
> Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
> we can match by hisi_scclX and ddrcY. Tokens  in Unit field
> are delimited by ','.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/pmu.c | 46 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 7e7299fee550..cfc916819c59 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -700,6 +700,46 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
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
> +	 * uncore alias may be from different PMU with common prefix
> +	 */
> +	tok = strtok_r(str, ",", &tmp);

In some places, e.g. gcc version 4.1.2:

  CC       /tmp/build/perf/util/pmu.o
cc1: warnings being treated as errors
util/pmu.c: In function ‘pmu_lookup’:
util/pmu.c:706: warning: ‘tmp’ may be used uninitialized in this function
mv: cannot stat `/tmp/build/perf/util/.pmu.o.tmp': No such file or directory

This silences it, adding.

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 913633ae0bf8..55f4de6442e3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -703,7 +703,7 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 
 static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 {
-	char *tmp, *tok, *str;
+	char *tmp = NULL, *tok, *str;
 	bool res;
 
 	str = strdup(pmu_name);


> +	if (strncmp(pmu_name, tok, strlen(tok))) {
> +		res = false;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Match more complex aliases where the alias name is a comma-delimited
> +	 * list of tokens, orderly contained in the matching PMU name.
> +	 *
> +	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
> +	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
> +	 *	    "pmunameY".
> +	 */
> +	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
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
> @@ -730,12 +770,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
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

-- 

- Arnaldo
