Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB621882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd52Fp9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfIBN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:57:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33235 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfIBN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so10432949qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Vai56wCT38arG0bdhrBZmoeSGAh3JX1kMMqznwuIqw=;
        b=Qd52Fp9b4ropwqmh7oip0W1m/V/IWuEn76hNId70SaBGEsr9rduL5Aw4LcM4LJ4Ggt
         JBjn7WhGgMdGveWKo025PnAYfps/Ol9jcAcUTx38fJYz5vhuM0Bnu/nguxjGXPraVLcT
         mRYYGN216HlNebcY8Ox4jVHgy0Uq2rzvt4kQI3vMjbsjXP+fI7/+eyFKhO9JXy++9LyL
         slhU2E1Bo7kgwKPnxC8h4v/nG9Qu8Xewd0hHUZpDoDbzS1fLb02X4b+4AjwWUI+E4aoj
         SewuOXmbP6oufBYwTCxp8XnQwdza1TBWcqKyhtoAk2dtuvCXQFCYLatKtipkyVX1A9Pe
         IBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Vai56wCT38arG0bdhrBZmoeSGAh3JX1kMMqznwuIqw=;
        b=Cmr8cNNOSECSWWF7IsBDXq7dU19DpCX8wUxJwT5Bf33Loh1BHrcybxV7nH1fL7CI6p
         Se2fxuthCfswBl9v9kOH1H6TDXZM2TioyI+BvAnmRvQ4Ul28aGKtSzaVEbFMx7jI4LRa
         sQDQ0x7owDczlr6S4mNOntTuEGPyUJg38KqMGDDoz941qEMyzK7a4Pyd/GPQUsokFLPR
         n0chTCzcGxze6SB6fHkM5Fwy9Sqg7GlTqPnM1Xl422OikKO5JBMM8fGFSvcicxBTyIEV
         CeeD4wzGudI+3/wEqQV8OU5fYQbQpLtpKtDGW8m838TaV1U1yUHXUcwL6R+9ofSbkvyf
         qIoQ==
X-Gm-Message-State: APjAAAVWa0iPkwta6ER6KFurni5+CocNg7H+YJ3Ts0FFOUKzlgcVYZWZ
        HPmA4SAKRXGAr2W05aWK6pg=
X-Google-Smtp-Source: APXvYqxKOFQc10CCQaLXnpUQkRFdUaAmgSdIugkBSg/eoDlHD2hXB1DQji6jXttmihV8+j4Tjzjt8w==
X-Received: by 2002:ac8:71cb:: with SMTP id i11mr9181051qtp.32.1567432634194;
        Mon, 02 Sep 2019 06:57:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id d9sm6482428qko.20.2019.09.02.06.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:57:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B82A241146; Mon,  2 Sep 2019 10:57:10 -0300 (-03)
Date:   Mon, 2 Sep 2019 10:57:10 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf tools: Add perf_env__numa_node function
Message-ID: <20190902135710.GB8396@kernel.org>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902121255.536-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 02, 2019 at 02:12:54PM +0200, Jiri Olsa escreveu:
> To speed up cpu to node lookup, adding perf_env__numa_node
> function, that creates cpu array on the first lookup, that
> holds numa nodes for each stored cpu.
> 
> Link: http://lkml.kernel.org/n/tip-qqwxklhissf3yjyuaszh6480@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/env.c | 35 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h |  6 ++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 3baca06786fb..6385961e45df 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -179,6 +179,7 @@ void perf_env__exit(struct perf_env *env)
>  	zfree(&env->sibling_threads);
>  	zfree(&env->pmu_mappings);
>  	zfree(&env->cpu);
> +	zfree(&env->numa_map);
>  
>  	for (i = 0; i < env->nr_numa_nodes; i++)
>  		perf_cpu_map__put(env->numa_nodes[i].map);
> @@ -338,3 +339,37 @@ const char *perf_env__arch(struct perf_env *env)
>  
>  	return normalize_arch(arch_name);
>  }
> +
> +
> +int perf_env__numa_node(struct perf_env *env, int cpu)
> +{
> +	if (!env->nr_numa_map) {
> +		struct numa_node *nn;
> +		int i, nr = 0;
> +
> +		for (i = 0; i < env->nr_numa_nodes; i++) {
> +			nn = &env->numa_nodes[i];
> +			nr = max(nr, perf_cpu_map__max(nn->map));
> +		}
> +
> +		nr++;
> +		env->numa_map = zalloc(nr * sizeof(int));

Why do you use zalloc()...

> +		if (!env->numa_map)
> +			return -1;

Only to right after allocating it set all entries to -1?

That zalloc() should be downgraded to a plain malloc(), right?

The setting to -1 is because we may have holes in the array, right? I
think this deserves a comment here as well.

> +		for (i = 0; i < nr; i++)
> +			env->numa_map[i] = -1;
> +
> +		env->nr_numa_map = nr;
> +
> +		for (i = 0; i < env->nr_numa_nodes; i++) {
> +			int tmp, j;
> +
> +			nn = &env->numa_nodes[i];
> +			perf_cpu_map__for_each_cpu(j, tmp, nn->map)
> +				env->numa_map[j] = i;
> +		}
> +	}
> +
> +	return cpu >= 0 && cpu < env->nr_numa_map ? env->numa_map[cpu] : -1;
> +}
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d8e083d42610..777008f8007a 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -86,6 +86,10 @@ struct perf_env {
>  		struct rb_root		btfs;
>  		u32			btfs_cnt;
>  	} bpf_progs;
> +
> +	/* For fast cpu to numa node lookup via perf_env__numa_node */
> +	int			*numa_map;
> +	int			 nr_numa_map;
>  };
>  
>  enum perf_compress_type {
> @@ -118,4 +122,6 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  							__u32 prog_id);
>  void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
>  struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
> +
> +int perf_env__numa_node(struct perf_env *env, int cpu);
>  #endif /* __PERF_ENV_H */
> -- 
> 2.21.0

-- 

- Arnaldo
