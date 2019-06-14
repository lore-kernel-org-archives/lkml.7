Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CBC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4531E21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx/VKBos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfFNOvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:51:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33383 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfFNOvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:51:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so1853279qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmJUE3dhWkz/P+PCqhphikVZqaLKlhLHcEJt36Jl4nM=;
        b=Bx/VKBosFcvggB2cnpkvOwjZCKVW1XfnaXAp0N8I0n1vgbRSavU/K7VCiCO5qJheDP
         CAR60XEKGCYf6tW8P71zddp9uMxKDD6XqwNAwTQdQ1GF6bEoUzALjnzNPSl2izTlQqS0
         E4gzrMaRANlA2/D0QzDSIWPzQ3kecLWQvjXQEAwfOX/snUwcIl2nLp5+qlYZ5uuqGtVV
         EaoRxL5Nf3kGF/k7c7nR+54+tA5yRxSreiq/9dsXuqt+6QsqIK8suUd9AeJdaNjU02a5
         FNdfGu2K3SuFl2TWic0RyL5UJSoYjOnKTHdFGxJXlLRoycsEHWLerGDxLoFDqbcBq8no
         4Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmJUE3dhWkz/P+PCqhphikVZqaLKlhLHcEJt36Jl4nM=;
        b=p2iUylHlvGw/+TToZfMLTpxBkfQR+Hl32DC8GA7ritA7PjXEAzL6ehUn35o2lUwV5i
         RYYkn9HgHXZEm+kqjC4JhfrhzR8EJHBjw+1GRLwewaRdHsoqqUf38DLxIcs5htAM32EH
         grDCSLRJKPMnSM69rGavFerUYqM19PSorZUWnT3jL2A6yrUwNnPxJI5FlFQ9LV25Sl0O
         WoD5mVUqSGE9LffKQ552vM6i5ZOyGMw//xHD5zGatIewu4XlsLjHrhcIuc0BOYrwyvSA
         lCjT6tYDxZocY8uPHjgx4xe4cgdQxIeQmw94neh+Zc6te6wcRr1NH7cpoT5S/aUOi/LE
         TnDA==
X-Gm-Message-State: APjAAAV+R0EhONQT4AMj7NUljJ+h83FM9EryHQO3o+zbStsFFYdpnGlg
        TKpt8HSCBPoIDKMpTMfJN5E=
X-Google-Smtp-Source: APXvYqx2GIlJLoQgYQjjZHhiY0OWAxILcGj9TmGWS72w9YclDSndu47LYz1u3p+NYzzDZUhxvStz/g==
X-Received: by 2002:a37:9a4d:: with SMTP id c74mr12294366qke.123.1560523863734;
        Fri, 14 Jun 2019 07:51:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-172-117.3g.claro.net.br. [179.240.172.117])
        by smtp.gmail.com with ESMTPSA id e4sm1826637qtc.3.2019.06.14.07.51.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:51:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F07C241149; Fri, 14 Jun 2019 11:50:57 -0300 (-03)
Date:   Fri, 14 Jun 2019 11:50:57 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
Message-ID: <20190614145057.GG1402@kernel.org>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560521283-73314-3-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 14, 2019 at 10:08:00PM +0800, John Garry escreveu:
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

Looks ok, but would be good to have some Reviewed-by attached as I'm not
super familiar with the PMU oddities, Jiri, can you please review this,
somebody else?

Thanks,

- Arnaldo
 
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
> +		res = false;
> +		goto out;
> +	}
> +
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

-- 

- Arnaldo
