Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B655C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4921D2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 11:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzOYmSZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFLgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:36:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgAFLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578310581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNo9mQh01lbVS+94XbO5w3EBq7R26jK17HZQxPAGRck=;
        b=FzOYmSZ6Oj2ruUPC67FodJuH3wZDYAV1u8SWGJdfIS7ujON9uOJXlj5f93Vk7DxBYg7xHU
        uJSx3zmnsKr1n6Gp0sq3V3sMfEEBj/SGO50sRvXASABJWJiB/QzsrvTs9RpQGMfiZE3TST
        T/Egnbqn4R1RYOnEyXUa4rVfhRBazMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-0iscrV-INuqnGQoY1lxQPA-1; Mon, 06 Jan 2020 06:36:18 -0500
X-MC-Unique: 0iscrV-INuqnGQoY1lxQPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AF0D801E6C;
        Mon,  6 Jan 2020 11:36:16 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 692D45D9CA;
        Mon,  6 Jan 2020 11:36:13 +0000 (UTC)
Date:   Mon, 6 Jan 2020 12:36:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Copy string to perf_evsel_config_term
Message-ID: <20200106113610.GB207350@krava>
References: <20200102151326.31342-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102151326.31342-1-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:13:26PM +0800, Leo Yan wrote:
> perf with CoreSight fails to record trace data with command:
> 
>   perf record -e cs_etm/@tmc_etr0/u --per-thread ls
>   failed to set sink "" on event cs_etm/@tmc_etr0/u with 21 (Is a
>   directory)/perf/
> 
> This failure is root caused with the commit 1dc925568f01 ("perf
> parse: Add a deep delete for parse event terms").
> 
> The log shows, cs_etm fails to parse the sink attribution; cs_etm event
> relies on the event configuration to pass sink name, but the event
> specific configuration data cannot be passed properly with flow:
> 
>   get_config_terms()
>     ADD_CONFIG_TERM(DRV_CFG, drv_cfg, term->val.str);
>       __t->val.drv_cfg = term->val.str;
>         `> __t->val.drv_cfg is assigned to term->val.str;
> 
>   parse_events_terms__purge()
>     parse_events_term__delete()
>       zfree(&term->val.str);
>         `> term->val.str is freed and assigned to NULL pointer;
> 
>   cs_etm_set_sink_attr()
>     sink = __t->val.drv_cfg;
>       `> sink string has been freed.

so your problem is that the data is freed before you use it?

> 
> To fix this issue, in the function get_config_terms(), this patch
> changes from directly assignment pointer value for the strings to
> use strdup() for allocation a new duplicate string for the cases:
> 
>   perf_evsel_config_term::val.callgraph
>   perf_evsel_config_term::val.branch
>   perf_evsel_config_term::val.drv_cfg.
> 
> Fixes: 1dc925568f01 ("perf parse: Add a deep delete for parse event terms")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/parse-events.c | 49 ++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ed7c008b9c8b..5972acdd40d6 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1220,7 +1220,6 @@ static int get_config_terms(struct list_head *head_config,
>  			    struct list_head *head_terms __maybe_unused)
>  {
>  #define ADD_CONFIG_TERM(__type, __name, __val)			\
> -do {								\
>  	struct perf_evsel_config_term *__t;			\
>  								\
>  	__t = zalloc(sizeof(*__t));				\
> @@ -1229,9 +1228,19 @@ do {								\
>  								\
>  	INIT_LIST_HEAD(&__t->list);				\
>  	__t->type       = PERF_EVSEL__CONFIG_TERM_ ## __type;	\
> -	__t->val.__name = __val;				\
>  	__t->weak	= term->weak;				\
> -	list_add_tail(&__t->list, head_terms);			\
> +	list_add_tail(&__t->list, head_terms)
> +
> +#define ADD_CONFIG_TERM_VAL(__type, __name, __val)		\
> +do {								\
> +	ADD_CONFIG_TERM(__type, __name, __val);			\
> +	__t->val.__name = __val;				\
> +} while (0)
> +
> +#define ADD_CONFIG_TERM_STR(__type, __name, __val)		\
> +do {								\
> +	ADD_CONFIG_TERM(__type, __name, __val);			\
> +	__t->val.__name = strdup(__val);			\
>  } while (0)

the term->val.str is supposed to be already strdup-ed,
so this seems wrong and leaking mem

jirka

