Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54391C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD9D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwDR1FXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:47:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37621 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:47:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so3001543qtk.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6R7y2QZXFFrk7CRLcrrpeFMHRpnzu2Damor0UJTfJo=;
        b=GwDR1FXVA1Sjn2AtU4PZQEEGR9bejpe+ebab3xc6k3EgoGJHTFtjs39IzrFq5/34Ip
         H9DtAvsvYLJDLuUkeTRKRS1OpitS6Jx/sEUx4Z+rmQk0hqbyX3iMSvkWX/0l1rd1sGXU
         zvWGlmhxtjrQ0jC75DKe07psf2kxkmqhZGnIfAiNmNc4UrvKs5rurwKs6nqKIdjK5/Mh
         sCuNCsya+CR+LeKmhgFdIzjR8rZIPVgSDK+FEWYqsJCpBSCvVqH//SlyZ7QMoPgcTGtZ
         V+0u2vYTUzjB+1lyf/zYJkAJ1PQwAfME4kqn9lwCHCExuUFhDUsGFNHW703QiFNEoSGu
         J64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6R7y2QZXFFrk7CRLcrrpeFMHRpnzu2Damor0UJTfJo=;
        b=bn+4edsgCiCYPI6MyjIfbCsK21kKABAguttjHI89MWqFF+pCaQ1YUin7w7tvrM51e5
         /jRqaf3lQFF/OS+aNpF2SOKw168K1uT+sPBgNDZ0Yz+Cu0PURLmRxdZRlwfiVicV7Te3
         F4Ru2AIYK6vvSkW1jMRz+OzPUhdUxHZ4z16qA6oMpW+H+4Z5bngNpLiczqrB9xqK2bMB
         5abh0RP8CAUkY8akx38kWRzUQFnTO6lXybNMqfhi4l4iyCK2WA9uJJg1SHD+0ykVKUzD
         PhH7VGc2ldr6vrr29erel2u8PBUm6xnwQIqLt67JoruKJ+f8lfGJIiqe4aH3c5xLfI3A
         H7uQ==
X-Gm-Message-State: APjAAAWxq8olmuWzzCj8hCj3WwvVPVZZ9t5RRlHZvTaCZLQcx9EDjtkb
        NDkTuKznfcyYkcFN/KysH+0=
X-Google-Smtp-Source: APXvYqzsBaaym0moS4V+AO4Kd5ODrNmpUYgYJ2YxtdUPya1tCGUKVJE/TXvR3DhG5mu1WbbiA9dqrg==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr45815485qtn.15.1560527269329;
        Fri, 14 Jun 2019 08:47:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-172-117.3g.claro.net.br. [179.240.172.117])
        by smtp.gmail.com with ESMTPSA id 34sm2046839qtq.59.2019.06.14.08.47.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:47:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37B2741149; Fri, 14 Jun 2019 12:47:44 -0300 (-03)
Date:   Fri, 14 Jun 2019 12:47:44 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v2 1/5] perf pmu: Fix uncore PMU alias list for ARM64
Message-ID: <20190614154744.GH1402@kernel.org>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
 <1560521283-73314-2-git-send-email-john.garry@huawei.com>
 <20190614144656.GF1402@kernel.org>
 <275d1699-23a3-f06b-3fad-750784318cc1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275d1699-23a3-f06b-3fad-750784318cc1@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 14, 2019 at 04:04:26PM +0100, John Garry escreveu:
> On 14/06/2019 15:46, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 14, 2019 at 10:07:59PM +0800, John Garry escreveu:
> > > In commit 292c34c10249 ("perf pmu: Fix core PMU alias list for X86
> > > platform"), we fixed the issue of CPU events being aliased to uncore
> > > events.
> > > 
> > > Fix this same issue for ARM64, since the said commit left the (broken)
> > > behaviour untouched for ARM64.
> > 
> > So I added:
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 292c34c10249 ("perf pmu: Fix core PMU alias list for X86 platform")
> > 
> > So that the stable trees get this fix and add it to the versions where
> > it should have been together with the x86 fix, ok?
> 
> Hi Arnaldo,
> 
> I have a slight hesitation about this qualifying for the stable.
> 
> It's fixing uncore pmu aliasing for arm64. But this series is also the first
> to introduce any actual arm64 uncore pmu aliases.

I'm not talking about the whole series, just the first patch, the one
you said should've been done together with the equivalent fix for x86.

- Arnaldo
 
> Thanks,
> John
> 
> > 
> > - Arnaldo
> > 
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > ---
> > >  tools/perf/util/pmu.c | 28 ++++++++++++----------------
> > >  1 file changed, 12 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index f2eff272279b..7e7299fee550 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -709,9 +709,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
> > >  {
> > >  	int i;
> > >  	struct pmu_events_map *map;
> > > -	struct pmu_event *pe;
> > >  	const char *name = pmu->name;
> > > -	const char *pname;
> > > 
> > >  	map = perf_pmu__find_map(pmu);
> > >  	if (!map)
> > > @@ -722,28 +720,26 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
> > >  	 */
> > >  	i = 0;
> > >  	while (1) {
> > > +		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
> > > +		struct pmu_event *pe = &map->table[i++];
> > > +		const char *pname = pe->pmu ? pe->pmu : cpu_name;
> > > 
> > > -		pe = &map->table[i++];
> > >  		if (!pe->name) {
> > >  			if (pe->metric_group || pe->metric_name)
> > >  				continue;
> > >  			break;
> > >  		}
> > > 
> > > -		if (!is_arm_pmu_core(name)) {
> > > -			pname = pe->pmu ? pe->pmu : "cpu";
> > > -
> > > -			/*
> > > -			 * uncore alias may be from different PMU
> > > -			 * with common prefix
> > > -			 */
> > > -			if (pmu_is_uncore(name) &&
> > > -			    !strncmp(pname, name, strlen(pname)))
> > > -				goto new_alias;
> > > +		/*
> > > +		 * uncore alias may be from different PMU
> > > +		 * with common prefix
> > > +		 */
> > > +		if (pmu_is_uncore(name) &&
> > > +		    !strncmp(pname, name, strlen(pname)))
> > > +			goto new_alias;
> > > 
> > > -			if (strcmp(pname, name))
> > > -				continue;
> > > -		}
> > > +		if (strcmp(pname, name))
> > > +			continue;
> > > 
> > >  new_alias:
> > >  		pr_err("%s new_alias name=%s pe->name=%s\n", __func__, name, pe->name);
> > > --
> > > 2.17.1
> > 
> 

-- 

- Arnaldo
