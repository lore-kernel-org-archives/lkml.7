Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91199C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYWt7FRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfFXSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:51:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40596 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfFXSvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:51:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so15625546qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSmYyNc2fIIS+s0I43Zz8EjRCnMH8XLZNYH9NqLdr1s=;
        b=IYWt7FRDteXDPndd1Rq2+FIK86SgVPW0U79Fp+uWIeYGGk8dZ3NsbdPptk+DQ7RLMV
         vQc/fGlCHVRdOTD0piftuS4xEZQoLGQ6C6wrXbaOohKn77kruiyK23BVrjkp8TuY1mJ3
         xvugEf3qHT7vAdNx38PRtNhCeiOKTFZaEyClydmHQpGuNmIxo8I42BE/qtHl0EnHLoBN
         4GkMPxyB69TTOAVte3EHv8itoBCery39cu7U/zQImtRxyWF0mPNvh8IzTu4gOEU+ooDb
         wZ9eHfxo5+Nx/AzpAEqmUE1bWtDmL+MJazB1f8HNCX7W4DAQifyAK3OdeNv6so2g3+hk
         FLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSmYyNc2fIIS+s0I43Zz8EjRCnMH8XLZNYH9NqLdr1s=;
        b=nIPqC2SvshsTnbP2T5PSHiOUjJYihMx25XKaCGO6/ut4RzK/e5+X/LjT+HeO9Pr6T/
         1/BTBlA0KpQj3MTHv/cJFd9hu1kFgDp6Ri0bgUgzw1+bLHefi0TExiBoO7JSpLBK/Gs1
         SloMLqvjGI2SZQU19QteNZ+/HIpsubFp6yQoaXTtrjUn7Gyij7rndzwpGhuFs9vBtWOU
         L9uxkx9XOgySV87tEe5bpAV5VsAGaxTGZjLwz855NL+8hv//HS9rfrQo0sxJOtwvPMuV
         uxZ5JC0iUV1l0V12s2h4ZsyH0kxlEyQmcKYfLasEhpGacAyB4jZdCPa1uKtHWxnbXGW/
         mXgA==
X-Gm-Message-State: APjAAAXOPbzaWRaVyr0/F3+CiGOncLobSAccZVk58PQsirRM8On3oDxj
        C86X+SDxhrZJLoSVK1lX4qo=
X-Google-Smtp-Source: APXvYqzUZWgj2LbrQv0A2AaCyD+dAM0Fl3cZdEVyqS0/RI/DR0DxUG4PYPUxv0EnKQhGVUdaxjqCYA==
X-Received: by 2002:a0c:d24d:: with SMTP id o13mr60243666qvh.86.1561402273474;
        Mon, 24 Jun 2019 11:51:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o21sm5669537qtq.16.2019.06.24.11.51.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:51:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 564C841153; Mon, 24 Jun 2019 15:50:58 -0300 (-03)
Date:   Mon, 24 Jun 2019 15:50:58 -0300
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v1] Increase MAX_NR_CPUS and MAX_CACHES
Message-ID: <20190624185058.GC4181@kernel.org>
References: <20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 20, 2019 at 02:36:30PM -0500, Kyle Meyer escreveu:
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> Attempting to profile 1024 or more CPUs with perf causes two errors:
> 
> perf record -a
> [ perf record: Woken up X times to write data ]
> way too many cpu caches..
> [ perf record: Captured and wrote X MB perf.data (X samples) ]
> 
> perf report -C 1024
> Error: failed to set  cpu bitmap
> Requested CPU 1024 too large. Consider raising MAX_NR_CPUS
> 
> Increasing MAX_NR_CPUS from 1024 to 2048 and redefining MAX_CACHES as
> MAX_NR_CPUS * 4 returns normal functionality to perf:
> 
> perf record -a
> [ perf record: Woken up X times to write data ]
> [ perf record: Captured and wrote X MB perf.data (X samples) ]
> 
> perf report -C 1024

So, I'm applying the tools/perf/ part, leaving the rest for Daniel do
consider, ok?

- Arnaldo

> ...
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  samples/bpf/map_perf_test_kern.c | 2 +-
>  samples/bpf/map_perf_test_user.c | 2 +-
>  tools/perf/perf.h                | 2 +-
>  tools/perf/util/header.c         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_test_kern.c
> index 2b2ffb97018b..342738a1e386 100644
> --- a/samples/bpf/map_perf_test_kern.c
> +++ b/samples/bpf/map_perf_test_kern.c
> @@ -11,7 +11,7 @@
>  #include "bpf_helpers.h"
>  
>  #define MAX_ENTRIES 1000
> -#define MAX_NR_CPUS 1024
> +#define MAX_NR_CPUS 2048
>  
>  struct bpf_map_def SEC("maps") hash_map = {
>  	.type = BPF_MAP_TYPE_HASH,
> diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
> index fe5564bff39b..da3c101ca776 100644
> --- a/samples/bpf/map_perf_test_user.c
> +++ b/samples/bpf/map_perf_test_user.c
> @@ -22,7 +22,7 @@
>  #include "bpf_load.h"
>  
>  #define TEST_BIT(t) (1U << (t))
> -#define MAX_NR_CPUS 1024
> +#define MAX_NR_CPUS 2048
>  
>  static __u64 time_get_ns(void)
>  {
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 711e009381ec..74d0124d38f3 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
>  }
>  
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS			1024
> +#define MAX_NR_CPUS			2048
>  #endif
>  
>  extern const char *input_name;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 06ddb6618ef3..abc9c2145efe 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1121,7 +1121,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
>  	return 0;
>  }
>  
> -#define MAX_CACHES 2000
> +#define MAX_CACHES (MAX_NR_CPUS * 4)
>  
>  static int write_cache(struct feat_fd *ff,
>  		       struct perf_evlist *evlist __maybe_unused)
> -- 
> 2.12.3

-- 

- Arnaldo
