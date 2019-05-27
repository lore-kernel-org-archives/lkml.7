Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931D2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FDB21726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAGRxWs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfE0OP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:15:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37030 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfE0OP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:15:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id d10so18084978qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsEihgLJMtxJwZkIIejHsogXtFVx03Q01juvEBgvS90=;
        b=MAGRxWs5+qeYxj5HDfE72VdgWIIf9+pq0yxcZn9Fh0gM8/hGpZIu3ua5rmIbHk2iuZ
         jPZJDKB0EsGG+1I7oRkLMRBqMKtq6DpeSCjX2zdNPJ77z2zFOh/3siHc3CbfRfCfcTSy
         7Q8RDyVfZjvh+6ctul++EEXcsxb16CCxpfxSpX9v1yZS86RTdpVp9INqVkXk93nbdIw4
         O463fRS8gXyOlnbya8Fy6DY5oF5dk89kIfSigUduJTjrxOsaR8rYF5PBhgrhN550Fwwo
         oYuae0DNWlvwm9xD7jMPIgWxfTM98ky7R+t7faHkhHBDvqh70V6SHSuzQgRjJIcKZYbl
         6APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsEihgLJMtxJwZkIIejHsogXtFVx03Q01juvEBgvS90=;
        b=Hdt2X0xQ+aCSa3OKEMN6O8VUd4Ro7Dl+WukvCV6eYm2znF6ogsdngn/ZZgkmUIBZY0
         WYeg7pu5k1zNbJC3H6VrhQXY7mIWxGvMnwtGBNLeLYeRD55OuUhOz7K2fttEyX260TKE
         +WjldqlDhTw+pPXdDjbRHHZs8N6Jinc0/j4BuNBCcv/gehBPyCwDIwMoIccp+dmBUEme
         hfWCQD8wj3zNScgQZv3uKH7ymN12sIUy6daMpoZppftcFwWSzbnouFov0Cnq3WoNsbiC
         gcOqCOj9a4ED/vMY3A3qdmMQL9qvDbU+8orhL447oFi3SmoY4E1IB5HLrfVKajIXae86
         TKJQ==
X-Gm-Message-State: APjAAAUx1jCQdVYmyMorAVQarT4Rzt5GL8Xgmsn0cgvoUePrWk3JINFz
        PoNKw+Pjhypb/jf8x83Uqdg=
X-Google-Smtp-Source: APXvYqxTePV+1rgUBbO5BO1nne+FgkElwQ/JiXt44HpVz/camwYPdN1eN8g7PHIQcs5OrSLn8Cwwxg==
X-Received: by 2002:a37:502:: with SMTP id 2mr2127568qkf.93.1558966557587;
        Mon, 27 May 2019 07:15:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id b12sm3024429qto.12.2019.05.27.07.15.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 07:15:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39F8B41149; Mon, 27 May 2019 11:15:41 -0300 (-03)
Date:   Mon, 27 May 2019 11:15:41 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/3] perf tools: Remove const from thread read accessors
Message-ID: <20190527141541.GA6417@kernel.org>
References: <20190523023636.GA196218@google.com>
 <20190527061149.168640-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527061149.168640-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 27, 2019 at 03:11:49PM +0900, Namhyung Kim escreveu:
> The namespaces and comm fields of a thread are protected by rwsem and
> require write access for it.  So it ended up using a cast to remove
> the const qualifier.  Let's get rid of the const then.

Thanks, applied 1/3 and 4/3.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/hist.c   |  2 +-
>  tools/perf/util/thread.c | 12 ++++++------
>  tools/perf/util/thread.h |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 7ace7a10054d..fb3271fd420c 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -2561,7 +2561,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
>  	char unit;
>  	int printed;
>  	const struct dso *dso = hists->dso_filter;
> -	const struct thread *thread = hists->thread_filter;
> +	struct thread *thread = hists->thread_filter;
>  	int socket_id = hists->socket_filter;
>  	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
>  	u64 nr_events = hists->stats.total_period;
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index b413ba5b9835..aab7807d445f 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -141,13 +141,13 @@ static struct namespaces *__thread__namespaces(const struct thread *thread)
>  	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
>  }
>  
> -struct namespaces *thread__namespaces(const struct thread *thread)
> +struct namespaces *thread__namespaces(struct thread *thread)
>  {
>  	struct namespaces *ns;
>  
> -	down_read((struct rw_semaphore *)&thread->namespaces_lock);
> +	down_read(&thread->namespaces_lock);
>  	ns = __thread__namespaces(thread);
> -	up_read((struct rw_semaphore *)&thread->namespaces_lock);
> +	up_read(&thread->namespaces_lock);
>  
>  	return ns;
>  }
> @@ -271,13 +271,13 @@ static const char *__thread__comm_str(const struct thread *thread)
>  	return comm__str(comm);
>  }
>  
> -const char *thread__comm_str(const struct thread *thread)
> +const char *thread__comm_str(struct thread *thread)
>  {
>  	const char *str;
>  
> -	down_read((struct rw_semaphore *)&thread->comm_lock);
> +	down_read(&thread->comm_lock);
>  	str = __thread__comm_str(thread);
> -	up_read((struct rw_semaphore *)&thread->comm_lock);
> +	up_read(&thread->comm_lock);
>  
>  	return str;
>  }
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index cf8375c017a0..e97ef6977eb9 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -76,7 +76,7 @@ static inline void thread__exited(struct thread *thread)
>  	thread->dead = true;
>  }
>  
> -struct namespaces *thread__namespaces(const struct thread *thread);
> +struct namespaces *thread__namespaces(struct thread *thread);
>  int thread__set_namespaces(struct thread *thread, u64 timestamp,
>  			   struct namespaces_event *event);
>  
> @@ -93,7 +93,7 @@ int thread__set_comm_from_proc(struct thread *thread);
>  int thread__comm_len(struct thread *thread);
>  struct comm *thread__comm(const struct thread *thread);
>  struct comm *thread__exec_comm(const struct thread *thread);
> -const char *thread__comm_str(const struct thread *thread);
> +const char *thread__comm_str(struct thread *thread);
>  int thread__insert_map(struct thread *thread, struct map *map);
>  int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone);
>  size_t thread__fprintf(struct thread *thread, FILE *fp);
> -- 
> 2.22.0.rc1.257.g3120a18244-goog

-- 

- Arnaldo
