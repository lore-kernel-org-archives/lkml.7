Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1063FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24202184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCNMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbfCNMEi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:04:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC3D0C057F4B;
        Thu, 14 Mar 2019 12:04:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EE171001DEA;
        Thu, 14 Mar 2019 12:04:35 +0000 (UTC)
Date:   Thu, 14 Mar 2019 13:04:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Remove hist__account_cycles from callback
Message-ID: <20190314120434.GD4406@krava>
References: <1552422174-27622-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552422174-27622-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Mar 2019 12:04:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:22:54AM +0800, Jin Yao wrote:
> The hist__account_cycles is executed when the hist_iter__branch_callback
> is called. But it looks it's not necessary. In hist__account_cycles, it
> already walks on all branch entries.
> 
> This patch moves the hist__account_cycles out of callback, now the data
> processing is much faster than before.
> 
> For example,
> perf record -b ...
> perf annotate
> 
> The before/after output should be no change.

so in the old code it was called multiple times per sample,
while after your change it's called just once per sample

it increases cycles stats for symbol, so it's strange
the behaviour is the same.. could you please exaplin this
in more detail?

> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-annotate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 67f9d9f..77deb3a 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>  	struct perf_evsel *evsel = iter->evsel;
>  	int err;
>  
> -	hist__account_cycles(sample->branch_stack, al, sample, false);
> -

there's similar code in perf report, could you please cover
that as well?

thanks,
jirka

>  	bi = he->branch_info;
>  	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
>  
> @@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
>  	if (a.map != NULL)
>  		a.map->dso->hit = 1;
>  
> +	hist__account_cycles(sample->branch_stack, al, sample, false);
> +
>  	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
>  	return ret;
>  }
> -- 
> 2.7.4
> 
