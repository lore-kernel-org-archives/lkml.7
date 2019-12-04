Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C3C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A8120675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFKFxuIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfLDNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:48:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46597 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfLDNsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:48:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id f5so7102112qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kjtKZQgAJfat4nV98ffIVr09JJKAt0JciPj76qkRygI=;
        b=XFKFxuIo/3r2okVn4VRckypd5Xj1FM40gNcjly+L3J+v08sH5ihWzpmww7VLOw/C2l
         q6XbKx4vxxo3VS8nIqw6iROMGlX8cSiqJ7tCowWUOMlQzXCGs8kx/DQ7Htr6rx5vhzmy
         /rc7Dd6EPvm78K3dxyNWlmp1v+ZQR1RUIU2z1dmJTfQL9AIjmKbfk/Rs+lbiUDrgaTn3
         W8/dMwIPyq66HHivmDrZk90DfxV9vEz5bV8pofHqzhlV/JK9BTQpbwmm1dk8AxymxNWO
         ruNX72M+ehyeOZ23olIWcY9SrAeS7sbi6YfYucbsLJhwqwTTmp4ZVRxzFSdug2pyRiyv
         9sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kjtKZQgAJfat4nV98ffIVr09JJKAt0JciPj76qkRygI=;
        b=cPpWx62zBOm9xmkho7tROrxY4qVZ1fZPA3mMXJwpjaEdFxKXu4FjK3pxAIWRyheB9u
         x1tynAzKe/alvJcdvogJGbJqNTmYe1hVv2LbHw27MYaqEhZUrU+zKyYEUVSnDOYnh0yy
         ieWZLm70YqfupEpFj2d9U08flge1AA9lpznPiV77RlTG6EZvi+s638t8T+ghtNJ2DZfp
         3KIgvS1srAcj/hCVn7cG6friX4aaD/TmZfsKtl6mKenw2meLfp0huq5Ks71sVloTlC/1
         T0/Bzl8nGIO6r92l1ZI3nr57+BHPDmXg98VcPJT0aFitLZ+tqp3rtEsonXoBOKeQIw7m
         BykA==
X-Gm-Message-State: APjAAAVkBfEjYX8/pRPQjpwNunp2J6RJVuHzYdwqDb064Y0TrNJuYtep
        W/kFSTjNpvGRJL3ziwr2enw=
X-Google-Smtp-Source: APXvYqw7cx0tldR19GNFpsQEo5p2LaTIklKafAx1hbJVFKwcgq63Ng/ykKiJlEnqx0H3pCPUhlJ05w==
X-Received: by 2002:a37:b4c6:: with SMTP id d189mr2969324qkf.33.1575467320335;
        Wed, 04 Dec 2019 05:48:40 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y28sm3761003qtk.65.2019.12.04.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 05:48:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 635EA4121E; Wed,  4 Dec 2019 10:48:36 -0300 (-03)
Date:   Wed, 4 Dec 2019 10:48:36 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] perf record: adapt affinity to machines with
 #CPUs > 1K
Message-ID: <20191204134836.GA31283@kernel.org>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
 <96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d7e2ff-ce8b-c1e0-d52c-aa59ea96f0ea@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 03, 2019 at 02:45:27PM +0300, Alexey Budankov escreveu:
> 
> Use struct mmap_cpu_mask type for tool's thread and mmap data
> buffers to overcome current 1024 CPUs mask size limitation of
> cpu_set_t type.
> 
> Currently glibc cpu_set_t type has internal mask size limit
> of 1024 CPUs. Moving to struct mmap_cpu_mask type allows
> overcoming that limit. tools bitmap API is used to manipulate
> objects of struct mmap_cpu_mask type.

Had to apply this to fix the build in some toolchains/arches:

[acme@quaco perf]$ git diff
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7bc83755ef8c..4c301466101b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2508,10 +2508,10 @@ int cmd_record(int argc, const char **argv)
                rec->affinity_mask.nbits = cpu__max_cpu();
                rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
                if (!rec->affinity_mask.bits) {
-                       pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affinity_mask.nbits);
+                       pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
                        return -ENOMEM;
                }
-               pr_debug2("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);
+               pr_debug2("thread mask[%zd]: empty\n", rec->affinity_mask.nbits);
        }

        err = record__auxtrace_init(rec);


 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 28 ++++++++++++++++++++++------
>  tools/perf/util/mmap.c      | 28 ++++++++++++++++++++++------
>  tools/perf/util/mmap.h      |  2 +-
>  3 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index fb19ef63cc35..7bc83755ef8c 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -62,6 +62,7 @@
>  #include <linux/string.h>
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
> +#include <linux/bitmap.h>
>  
>  struct switch_output {
>  	bool		 enabled;
> @@ -93,7 +94,7 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> -	cpu_set_t		affinity_mask;
> +	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
>  };
>  
> @@ -961,10 +962,15 @@ static struct perf_event_header finished_round_event = {
>  static void record__adjust_affinity(struct record *rec, struct mmap *map)
>  {
>  	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> -	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
> -		CPU_ZERO(&rec->affinity_mask);
> -		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
> -		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
> +	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
> +			  rec->affinity_mask.nbits)) {
> +		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
> +		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
> +			  map->affinity_mask.bits, rec->affinity_mask.nbits);
> +		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
> +				  (cpu_set_t *)rec->affinity_mask.bits);
> +		if (verbose == 2)
> +			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
>  	}
>  }
>  
> @@ -2433,7 +2439,6 @@ int cmd_record(int argc, const char **argv)
>  # undef REASON
>  #endif
>  
> -	CPU_ZERO(&rec->affinity_mask);
>  	rec->opts.affinity = PERF_AFFINITY_SYS;
>  
>  	rec->evlist = evlist__new();
> @@ -2499,6 +2504,16 @@ int cmd_record(int argc, const char **argv)
>  
>  	symbol__init(NULL);
>  
> +	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
> +		rec->affinity_mask.nbits = cpu__max_cpu();
> +		rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
> +		if (!rec->affinity_mask.bits) {
> +			pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affinity_mask.nbits);
> +			return -ENOMEM;
> +		}
> +		pr_debug2("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);
> +	}
> +
>  	err = record__auxtrace_init(rec);
>  	if (err)
>  		goto out;
> @@ -2613,6 +2628,7 @@ int cmd_record(int argc, const char **argv)
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> +	bitmap_free(rec->affinity_mask.bits);
>  	evlist__delete(rec->evlist);
>  	symbol__exit();
>  	auxtrace_record__free(rec->itr);
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 43c12b4a3e17..832d2cb94b2c 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -219,6 +219,8 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
>  
>  void mmap__munmap(struct mmap *map)
>  {
> +	bitmap_free(map->affinity_mask.bits);
> +
>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
>  		munmap(map->data, mmap__mmap_len(map));
> @@ -227,7 +229,7 @@ void mmap__munmap(struct mmap *map)
>  	auxtrace_mmap__munmap(&map->auxtrace_mmap);
>  }
>  
> -static void build_node_mask(int node, cpu_set_t *mask)
> +static void build_node_mask(int node, struct mmap_cpu_mask *mask)
>  {
>  	int c, cpu, nr_cpus;
>  	const struct perf_cpu_map *cpu_map = NULL;
> @@ -240,17 +242,23 @@ static void build_node_mask(int node, cpu_set_t *mask)
>  	for (c = 0; c < nr_cpus; c++) {
>  		cpu = cpu_map->map[c]; /* map c index to online cpu index */
>  		if (cpu__get_node(cpu) == node)
> -			CPU_SET(cpu, mask);
> +			set_bit(cpu, mask->bits);
>  	}
>  }
>  
> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>  {
> -	CPU_ZERO(&map->affinity_mask);
> +	map->affinity_mask.nbits = cpu__max_cpu();
> +	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
> +	if (!map->affinity_mask.bits)
> +		return -1;
> +
>  	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
>  		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
>  	else if (mp->affinity == PERF_AFFINITY_CPU)
> -		CPU_SET(map->core.cpu, &map->affinity_mask);
> +		set_bit(map->core.cpu, map->affinity_mask.bits);
> +
> +	return 0;
>  }
>  
>  int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
> @@ -261,7 +269,15 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  		return -1;
>  	}
>  
> -	perf_mmap__setup_affinity_mask(map, mp);
> +	if (mp->affinity != PERF_AFFINITY_SYS &&
> +		perf_mmap__setup_affinity_mask(map, mp)) {
> +		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
> +			  errno);
> +		return -1;
> +	}
> +
> +	if (verbose == 2)
> +		mmap_cpu_mask__scnprintf(&map->affinity_mask, "mmap");
>  
>  	map->core.flush = mp->flush;
>  
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index ef51667fabcb..9d5f589f02ae 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -40,7 +40,7 @@ struct mmap {
>  		int		 nr_cblocks;
>  	} aio;
>  #endif
> -	cpu_set_t	affinity_mask;
> +	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
>  };
> -- 
> 2.20.1
> 

-- 

- Arnaldo
