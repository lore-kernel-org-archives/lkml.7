Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422942133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHXW1G8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCSPZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43860 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSPZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so7316239qkc.10;
        Tue, 19 Mar 2019 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OAi488nvi3+XNw8DsIxjpKEF0g+WAD11ZACPGU7TPTA=;
        b=bHXW1G8UAKi2XhuGqLl4pB9FGyAQxPSmrNDf6IQqH67zsRVsJPVQhvXh83mB25LMxt
         9izHB2Mf7lkFJ0aqwB12I/B5N/JN5Y5xhRYpHJcAJ4BJQmmgTqr0OOfgb8QhFHXBFbvz
         vlc3LEvrSp6NK0QvKgxI3nitBJHuYcvtIDZjKqvpTpsE3Tn+ast1r2ikJmjURiPd44fX
         n6ij0t2whHeEOiJwONKN3Le4Jcnx4RcKTV1IMJY+tIRThNEFfRGQvd+ZBmG7vdZFVMr1
         6TPwabQ/0XOP4OzMpU7H1pUHAAlPxICWQKnQyvjWp00gHQ4EmUxa53wkVQCkzTvJH+lb
         HNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OAi488nvi3+XNw8DsIxjpKEF0g+WAD11ZACPGU7TPTA=;
        b=FPYGfwrYvVE3sMLB8BUoCkwB1pMLaU2mrKCjrGwVz3so2F/zggHrS4KBgrdWlaFDXf
         DiJGsoc/J6dcgH4yZAgEs9+rhRe3AzJz3Gj8rEbSsnVzNSWqwKSUjqXa6RWBMVkwWlNB
         QHIXQbIWw5SzMliIKvngV/y3pItmg0mkMX5bAdbaAZzcT67mHa5O08sZeBckkrzXc5VT
         3+Exb1wX0VCRSf2yF5Ei2ry2uJjxnTN0KWF3YSuL0JmZM4pdfb/JJBaLG/6BO3uj3Ypn
         WMbB7boucZatwX+9tm+fX1CM2bQ9ZTKgErqTVk1+dLZHJqfvDMtV9IlyMF8JX5atn11i
         StAw==
X-Gm-Message-State: APjAAAW3Guj1+DkFQnTnPqSrjjRUoaX3JTm0JmTW3/NrMcFI7frAxVrv
        3PTwa+L7QaxtOSYgydamqL0=
X-Google-Smtp-Source: APXvYqzAqhL+z4RB4GC2Hw1lhuvJAbOQQoybMjOb8sgqsisGX8VuEoi9fl+6U9s7CeflM906ON4iow==
X-Received: by 2002:a37:a841:: with SMTP id r62mr2656115qke.16.1553009128942;
        Tue, 19 Mar 2019 08:25:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j17sm9863985qtj.61.2019.03.19.08.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 08:25:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 52F0B4039C; Tue, 19 Mar 2019 12:25:24 -0300 (-03)
Date:   Tue, 19 Mar 2019 12:25:24 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 15/15] perf, bpf: save bpf_prog_info and btf
 of short living bpf programs
Message-ID: <20190319152524.GG3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-16-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-16-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:51PM -0700, Song Liu escreveu:
> To fully annotate BPF programs with source code mapping, 4 different
> information are needed:
>     1) PERF_RECORD_KSYMBOL
>     2) PERF_RECORD_BPF_EVENT
>     3) bpf_prog_info
>     4) btf

The API for the sideband event, etc, needs reworking, I found it
convoluted, but testing shows that it works, so I left improving that
aspect for later.

Also this is not "for short living bpf programs", it is for any program
that starts after you started 'perf record' or 'perf top', so I've
changed in the cset comment log as well.

Now going thru the container build tests prior for upstreaming.

- Arnaldo
 
> This patch handles 3) and 4) for short living BPF programs. For timely
> process of these information, a dedicated event is added to the side
> band evlist. When PERF_RECORD_BPF_EVENT is received via the side band
> event, the polling thread gathers 3) and 4) vis sys_bpf and store them
> in perf_env. These information are saved to perf.data at the end of
> perf-record.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/builtin-record.c |  2 +
>  tools/perf/builtin-top.c    |  2 +
>  tools/perf/util/bpf-event.c | 95 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/bpf-event.h | 15 ++++++
>  4 files changed, 114 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f792dd28d936..3c0596a68992 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1217,6 +1217,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> +	if (!opts->no_bpf_event)
> +		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
>  	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
>  
>  	err = record__synthesize(rec, false);
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 9577dba4996b..b7790d66cac2 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1641,6 +1641,8 @@ int cmd_top(int argc, const char **argv)
>  		signal(SIGWINCH, winch_sig);
>  	}
>  
> +	if (!top.record_opts.no_bpf_event)
> +		bpf_event__add_sb_event(&sb_evlist, &perf_env);
>  	perf_evlist__start_sb_thread(sb_evlist, target);
>  
>  	status = __cmd_top(&top);
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index af434de3a23e..77e0fdead6f4 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -13,6 +13,7 @@
>  #include "env.h"
>  #include "session.h"
>  #include "map.h"
> +#include "evlist.h"
>  
>  #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>  
> @@ -330,3 +331,97 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  	free(event);
>  	return err;
>  }
> +
> +static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info_node *info_node;
> +	struct btf *btf = NULL;
> +	u64 arrays;
> +	u32 btf_id;
> +	int fd;
> +
> +	fd = bpf_prog_get_fd_by_id(id);
> +	if (fd < 0)
> +		return;
> +
> +	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
> +	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
> +	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
> +
> +	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
> +	if (IS_ERR_OR_NULL(info_linear)) {
> +		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
> +		goto out;
> +	}
> +
> +	btf_id = info_linear->info.btf_id;
> +
> +	info_node = malloc(sizeof(struct bpf_prog_info_node));
> +	if (info_node) {
> +		info_node->info_linear = info_linear;
> +		perf_env__insert_bpf_prog_info(env, info_node);
> +	} else
> +		free(info_linear);
> +
> +	if (btf_id == 0)
> +		goto out;
> +
> +	if (btf__get_from_id(btf_id, &btf)) {
> +		pr_debug("%s: failed to get BTF of id %u, aborting\n",
> +			 __func__, btf_id);
> +		goto out;
> +	}
> +	perf_env__fetch_btf(env, btf_id, btf);
> +
> +out:
> +	free(btf);
> +	close(fd);
> +}
> +
> +static int bpf_event__sb_cb(union perf_event *event, void *data)
> +{
> +	struct perf_env *env = data;
> +
> +	if (event->header.type != PERF_RECORD_BPF_EVENT)
> +		return -1;
> +
> +	switch (event->bpf_event.type) {
> +	case PERF_BPF_EVENT_PROG_LOAD:
> +		perf_env__add_bpf_info(env, event->bpf_event.id);
> +
> +	case PERF_BPF_EVENT_PROG_UNLOAD:
> +		/*
> +		 * Do not free bpf_prog_info and btf of the program here,
> +		 * as annotation still need them. They will be freed at
> +		 * the end of the session.
> +		 */
> +		break;
> +	default:
> +		pr_debug("unexpected bpf_event type of %d\n",
> +			 event->bpf_event.type);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int bpf_event__add_sb_event(struct perf_evlist **evlist,
> +			    struct perf_env *env)
> +{
> +	struct perf_event_attr attr = {
> +		.type	          = PERF_TYPE_SOFTWARE,
> +		.config           = PERF_COUNT_SW_DUMMY,
> +		.sample_id_all    = 1,
> +		.watermark        = 1,
> +		.bpf_event        = 1,
> +		.wakeup_watermark = 1,
> +		.size	   = sizeof(attr), /* to capture ABI version */
> +	};
> +
> +	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
> +}
> diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
> index b9ec394dc7c7..249909c826e7 100644
> --- a/tools/perf/util/bpf-event.h
> +++ b/tools/perf/util/bpf-event.h
> @@ -4,12 +4,17 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/rbtree.h>
> +#include <pthread.h>
> +#include <api/fd/array.h>
>  #include "event.h"
>  
>  struct machine;
>  union perf_event;
> +struct perf_env;
>  struct perf_sample;
>  struct record_opts;
> +struct evlist;
> +struct target;
>  
>  struct bpf_prog_info_node {
>  	struct bpf_prog_info_linear	*info_linear;
> @@ -31,6 +36,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
>  				      perf_event__handler_t process,
>  				      struct machine *machine,
>  				      struct record_opts *opts);
> +int bpf_event__add_sb_event(struct perf_evlist **evlist,
> +				 struct perf_env *env);
> +
>  #else
>  static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  					     union perf_event *event __maybe_unused,
> @@ -46,5 +54,12 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
>  {
>  	return 0;
>  }
> +
> +static int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
> +				   struct perf_env *env __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  #endif // HAVE_LIBBPF_SUPPORT
>  #endif
> -- 
> 2.17.1

-- 

- Arnaldo
