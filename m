Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DCD216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfHTJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:18:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CF931801D5A;
        Tue, 20 Aug 2019 09:18:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4567D50;
        Tue, 20 Aug 2019 09:18:53 +0000 (UTC)
Date:   Tue, 20 Aug 2019 11:18:52 +0200
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
Subject: Re: [PATCH v3 4/6] perf/util/session: Replace MAX_NR_CPUS with
 nr_cpus_online
Message-ID: <20190820091852.GC24105@krava>
References: <20190819202333.88032-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819202333.88032-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 20 Aug 2019 09:18:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:23:33PM -0500, Kyle Meyer wrote:
> nr_cpus_online, the number of CPUs online during a record session, can be
> used as a dynamic alternative for MAX_NR_CPUS in perf_session__cpu_bitmap.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  tools/perf/util/session.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: tip/tools/perf/util/session.c
> ===================================================================
> --- tip.orig/tools/perf/util/session.c
> +++ tip/tools/perf/util/session.c
> @@ -2284,6 +2284,7 @@ int perf_session__cpu_bitmap(struct perf
>  {
>  	int i, err = -1;
>  	struct perf_cpu_map *map;
> +	int nr_cpus_online = session->header.env.nr_cpus_online;

so all those bitmaps that use this function are initialized with
MAX_NR_CPUS length, are we sure that session->header.env.nr_cpus_online
is always smaller than MAX_NR_CPUS?

jirka

>  
>  	for (i = 0; i < PERF_TYPE_MAX; ++i) {
>  		struct evsel *evsel;
> @@ -2308,9 +2309,8 @@ int perf_session__cpu_bitmap(struct perf
>  	for (i = 0; i < map->nr; i++) {
>  		int cpu = map->map[i];
>  
> -		if (cpu >= MAX_NR_CPUS) {
> -			pr_err("Requested CPU %d too large. "
> -			       "Consider raising MAX_NR_CPUS\n", cpu);
> +		if (cpu >= nr_cpus_online) {
> +			pr_err("Requested CPU %d too large\n", cpu);
>  			goto out_delete_map;
>  		}
>  
