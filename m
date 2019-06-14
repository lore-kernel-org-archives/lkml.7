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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8959DC46477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DECC2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7jc810v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfFNOrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:47:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45883 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfFNOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:47:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so1793701qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eto68beFTMuFiXin5hRYooxdWER5uQTswdUxEzMWaWA=;
        b=f7jc810vzETNFtoXuRS8MZGA64WEjhN1C4sf8wmEdEWkwM4Dcr53aH+Hri7YujTW0x
         B9rRRD9XyZuOam3GWo9voiNVb3yGAfFIFCS4DFiXsLJGbGQLpiM9je5wMe3vOKMJ3/Ih
         uDag2RsWOXt1dIOQJabdX/+GtmFZ/7oFIU9fMhoP3nHJV01lPSBxsfeteyvJ0ecic+gO
         cRGJPw2z5xFrf104TKtMYS7EZx5w+cvYnlb8IIeqbhG6ocIJkOX6WbWbyeflV/U0gYJN
         A1DfpvP6XrieQohpZI5LjYZm6R7zjHJ6V0Ez/2z4fp0Zm4N+h8DmXT/qGbb3es1S3alz
         RqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eto68beFTMuFiXin5hRYooxdWER5uQTswdUxEzMWaWA=;
        b=XGszRwt2kBX4Y/GlR/OrvfHHk8sNVVOybYkz2cLGy7qDfyDmPW208B/3ECuUCNYVNh
         0vL3gZeroSMAlMshz911Tw1fz7p+gGsHuK9dsBJH45klO5bSCN09wlKz4idp7BvsroWJ
         2kV1Bsb5vKJvVPAw+WaotPVpbv+/n92MHQTtNZPjEZtEaryUgzGbvMD/mRhKsa0bc8SR
         9bCR/wM1OiO3gBaObxbabciE0SFXzYKQxRiIEneOZYMEBcQgFZAKB1sZ74aA70ByBVQd
         Tz3osp4DAF6WaWrHsiJDThPCAteWlfCSZRgOxzc3FxR2HvdcY2pn5OCULxB94Q6zbedZ
         tviQ==
X-Gm-Message-State: APjAAAVx51WrESf0NOB6FcMezysmB9dTexa4FO4JQqbsz0TSUfs9BcjY
        +qPChIN72vAO/Qdw3RmyEkc=
X-Google-Smtp-Source: APXvYqyhHcWq1P1FF+Xkd+IYAcISgd96Zi2ZTLPk8SBAh1/jiUvJyvpag+WdQb+wknmrFfZaHYjJYA==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr9707415qke.222.1560523622785;
        Fri, 14 Jun 2019 07:47:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-172-117.3g.claro.net.br. [179.240.172.117])
        by smtp.gmail.com with ESMTPSA id s134sm1857501qke.51.2019.06.14.07.47.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:47:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 262DC41149; Fri, 14 Jun 2019 11:46:56 -0300 (-03)
Date:   Fri, 14 Jun 2019 11:46:56 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 1/5] perf pmu: Fix uncore PMU alias list for ARM64
Message-ID: <20190614144656.GF1402@kernel.org>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560521283-73314-2-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 14, 2019 at 10:07:59PM +0800, John Garry escreveu:
> In commit 292c34c10249 ("perf pmu: Fix core PMU alias list for X86
> platform"), we fixed the issue of CPU events being aliased to uncore
> events.
> 
> Fix this same issue for ARM64, since the said commit left the (broken)
> behaviour untouched for ARM64.

So I added:

Cc: stable@vger.kernel.org
Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")

So that the stable trees get this fix and add it to the versions where
it should have been together with the x86 fix, ok?

- Arnaldo
 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/pmu.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f2eff272279b..7e7299fee550 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -709,9 +709,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  {
>  	int i;
>  	struct pmu_events_map *map;
> -	struct pmu_event *pe;
>  	const char *name = pmu->name;
> -	const char *pname;
>  
>  	map = perf_pmu__find_map(pmu);
>  	if (!map)
> @@ -722,28 +720,26 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>  	 */
>  	i = 0;
>  	while (1) {
> +		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
> +		struct pmu_event *pe = &map->table[i++];
> +		const char *pname = pe->pmu ? pe->pmu : cpu_name;
>  
> -		pe = &map->table[i++];
>  		if (!pe->name) {
>  			if (pe->metric_group || pe->metric_name)
>  				continue;
>  			break;
>  		}
>  
> -		if (!is_arm_pmu_core(name)) {
> -			pname = pe->pmu ? pe->pmu : "cpu";
> -
> -			/*
> -			 * uncore alias may be from different PMU
> -			 * with common prefix
> -			 */
> -			if (pmu_is_uncore(name) &&
> -			    !strncmp(pname, name, strlen(pname)))
> -				goto new_alias;
> +		/*
> +		 * uncore alias may be from different PMU
> +		 * with common prefix
> +		 */
> +		if (pmu_is_uncore(name) &&
> +		    !strncmp(pname, name, strlen(pname)))
> +			goto new_alias;
>  
> -			if (strcmp(pname, name))
> -				continue;
> -		}
> +		if (strcmp(pname, name))
> +			continue;
>  
>  new_alias:
>  		pr_err("%s new_alias name=%s pe->name=%s\n", __func__, name, pe->name);
> -- 
> 2.17.1

-- 

- Arnaldo
