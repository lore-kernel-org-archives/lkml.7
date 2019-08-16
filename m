Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E0C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6B42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfHPJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfHPJFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C86BB81DE0;
        Fri, 16 Aug 2019 09:05:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F6405C1B2;
        Fri, 16 Aug 2019 09:05:14 +0000 (UTC)
Date:   Fri, 16 Aug 2019 11:05:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v2 1/6] perf: Refactor svg_build_topology_map
Message-ID: <20190816090514.GB20709@krava>
References: <20190814203824.204765-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814203824.204765-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 16 Aug 2019 09:05:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:38:24PM -0500, Kyle Meyer wrote:

SNIP

> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index ae6a534a7a80..1beeb7291361 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -751,38 +751,37 @@ static int str_to_bitmap(char *s, cpumask_t *b)
>  	return ret;
>  }
>  
> -int svg_build_topology_map(char *sib_core, int sib_core_nr,
> -			   char *sib_thr, int sib_thr_nr)
> +int svg_build_topology_map(struct perf_env *env)
>  {
>  	int i;
>  	struct topology t;
>  
> -	t.sib_core_nr = sib_core_nr;
> -	t.sib_thr_nr = sib_thr_nr;
> -	t.sib_core = calloc(sib_core_nr, sizeof(cpumask_t));
> -	t.sib_thr = calloc(sib_thr_nr, sizeof(cpumask_t));
> +	t.sib_core_nr = env->nr_sibling_cores;
> +	t.sib_thr_nr = env->nr_sibling_threads;
> +	t.sib_core = calloc(env->nr_sibling_cores, sizeof(cpumask_t));
> +	t.sib_thr = calloc(env->nr_sibling_threads, sizeof(cpumask_t));
>  
>  	if (!t.sib_core || !t.sib_thr) {
>  		fprintf(stderr, "topology: no memory\n");
>  		goto exit;
>  	}
>  
> -	for (i = 0; i < sib_core_nr; i++) {
> -		if (str_to_bitmap(sib_core, &t.sib_core[i])) {
> +	for (i = 0; i < env->nr_sibling_cores; i++) {
> +		if (str_to_bitmap(env->sibling_cores, &t.sib_core[i])) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
>  			goto exit;
>  		}
>  
> -		sib_core += strlen(sib_core) + 1;
> +		env->sibling_cores += strlen(env->sibling_cores) + 1;

so this will actualy change env->sibling_cores in the header,
I guess thats not a problem for timechart, but might cause some
confusion in future.. could you just use local pointer for that?

other than that the patchset looks good

thanks,
jirka

>  	}
>  
> -	for (i = 0; i < sib_thr_nr; i++) {
> -		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
> +	for (i = 0; i < env->nr_sibling_threads; i++) {
> +		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i])) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
>  			goto exit;
>  		}
>  
> -		sib_thr += strlen(sib_thr) + 1;
> +		env->sibling_threads += strlen(env->sibling_threads) + 1;
>  	}
>  

SNIP
