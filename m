Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8C7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQuNRotN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJJOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:47:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40841 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJJOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:47:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so5837770qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjEO2f+TwZXk8EzwR/o+3Q0E3Qg7K5djZv0L4SRg7OA=;
        b=PQuNRotN02blprv0iNrTRbz3rPaEVS7eCk2iRgADK0kejHNSbwNhheEGp+osyu4oV4
         cH+kilLN6Mtl5JV5+y5J4G993/GRnkSKtMpbqz3tz9vXiTSuUhqQavlyIpRLkwdXe450
         TMrCPMlbIaHQPok1W6d0+rkh2JnKlNJWdm8vP9BvgZ9otxX/TmsD5ubso6esBap1ZOnB
         ODmZs5vySYs7S7i4bAnVxXPmb2pT2NJkljbsXOeykLxEu1n8sa2Hm3+4dJwkDCDFbaSa
         /9bvU/T3mdF/LM5f9COoChuaOoa6M0p7YAU7CqsQ4IM8G67CftQEVH/JVHEX+UjVhUTs
         4Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjEO2f+TwZXk8EzwR/o+3Q0E3Qg7K5djZv0L4SRg7OA=;
        b=Ra+eyZpBvul6PgxXy4GAVHOBaHIQaLBNvqQEcRvZxGbzzbqNUzVE2mkaADaxAf6J26
         Gx0jdtRgmiw5yZpLLfZKemf9NRAhczkMwi7mfo1jNkTosvxy9xJ0CNu8kUujSVJG0e/h
         Wmgm4zJZJALKRZPbxxzsaSqtt9vbw5mv8P1YVP+DTA2pHf8VBGD2YOBVpN0k5hFYIrZV
         sJutLJBfBVHQVOaDbM2OuktEBqOl3KCZ2bdwOq+SkVDKqRj3dyqoz+wbPo63jBBl4owV
         wK2saCB19i881oga/UqgdrKqiOgaVqItfxqE2eF6LWqRO3L1ZwaRr38egpifGSlmtpJ5
         O3Jw==
X-Gm-Message-State: APjAAAVA6TGWtsMSHwjpYHyBezPXjPdvdoRzw8MrYSAuSjsnSex8fR0e
        QM3jFKn95Rjjvq2C13xCFv8=
X-Google-Smtp-Source: APXvYqzJ8nS2AIfJygs7xyoAlWgBPLTU70e5fQMllPvexuF2EZTjoBcrhVuoSpLzfAJa80nID9FwPw==
X-Received: by 2002:a37:7904:: with SMTP id u4mr10023165qkc.267.1570718825724;
        Thu, 10 Oct 2019 07:47:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e4sm2468197qkl.135.2019.10.10.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 07:47:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75DDF4DD66; Thu, 10 Oct 2019 11:47:00 -0300 (-03)
Date:   Thu, 10 Oct 2019 11:47:00 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 12/36] libperf: Add perf_mmap__read_event() function
Message-ID: <20191010144700.GB11638@kernel.org>
References: <20191007125344.14268-1-jolsa@kernel.org>
 <20191007125344.14268-13-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007125344.14268-13-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2019 at 02:53:20PM +0200, Jiri Olsa escreveu:
> Move perf_mmap__read_event() from tools/perf to libperf and export it in
> the perf/mmap.h header.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Link: http://lore.kernel.org/lkml/20190913132355.21634-52-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
>  tools/perf/builtin-kvm.c                     |  2 +-
>  tools/perf/builtin-top.c                     |  2 +-
>  tools/perf/builtin-trace.c                   |  2 +-
>  tools/perf/lib/include/internal/mmap.h       |  1 +
>  tools/perf/lib/include/perf/mmap.h           |  1 +
>  tools/perf/lib/libperf.map                   |  1 +
>  tools/perf/lib/mmap.c                        | 79 ++++++++++++++++++++
>  tools/perf/tests/backward-ring-buffer.c      |  2 +-
>  tools/perf/tests/bpf.c                       |  2 +-
>  tools/perf/tests/code-reading.c              |  2 +-
>  tools/perf/tests/keep-tracking.c             |  2 +-
>  tools/perf/tests/mmap-basic.c                |  2 +-
>  tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
>  tools/perf/tests/perf-record.c               |  2 +-
>  tools/perf/tests/sw-clock.c                  |  2 +-
>  tools/perf/tests/switch-tracking.c           |  2 +-
>  tools/perf/tests/task-exit.c                 |  2 +-
>  tools/perf/util/evlist.c                     |  2 +-
>  tools/perf/util/mmap.c                       | 77 -------------------
>  tools/perf/util/mmap.h                       |  2 -
>  tools/perf/util/python.c                     |  2 +-
>  22 files changed, 98 insertions(+), 95 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> index c90d925f7ae6..909ead08a6f6 100644
> --- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> +++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> @@ -121,7 +121,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
>  
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			struct perf_sample sample;
>  
>  			if (event->header.type != PERF_RECORD_COMM ||
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 4c087a8c9fed..858da896b518 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -764,7 +764,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
>  	if (err < 0)
>  		return (err == -EAGAIN) ? 0 : -1;
>  
> -	while ((event = perf_mmap__read_event(md)) != NULL) {
> +	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
>  		if (err) {
>  			perf_mmap__consume(&md->core);
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1a54069ccd9c..d96f24c8770d 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -873,7 +873,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		return;
>  
> -	while ((event = perf_mmap__read_event(md)) != NULL) {
> +	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  		int ret;
>  
>  		ret = perf_evlist__parse_sample_timestamp(evlist, event, &last_timestamp);
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5fc3051a0938..2ae8298375a0 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3454,7 +3454,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
>  
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			++trace->nr_events;
>  
>  			err = trace__deliver_event(trace, event);
> diff --git a/tools/perf/lib/include/internal/mmap.h b/tools/perf/lib/include/internal/mmap.h
> index ee536c4441bb..b328332b6ccf 100644
> --- a/tools/perf/lib/include/internal/mmap.h
> +++ b/tools/perf/lib/include/internal/mmap.h
> @@ -11,6 +11,7 @@
>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>  
>  struct perf_mmap;
> +union perf_event;

Why are you adding this here?
  
>  typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);
>  
> diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
> index 4f946e7f724b..396c6543d95d 100644
> --- a/tools/perf/lib/include/perf/mmap.h
> +++ b/tools/perf/lib/include/perf/mmap.h
> @@ -9,5 +9,6 @@ struct perf_mmap;
>  LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
>  LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
>  LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
> +LIBPERF_API union perf_event *perf_mmap__read_event(struct perf_mmap *map);
>  
>  #endif /* __LIBPERF_MMAP_H */
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 7e3ea2e9c917..8bb0d73e0c6c 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -43,6 +43,7 @@ LIBPERF_0.0.1 {
>  		perf_mmap__consume;
>  		perf_mmap__read_init;
>  		perf_mmap__read_done;
> +		perf_mmap__read_event;
>  	local:
>  		*;
>  };
> diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
> index 7d39289a4a22..fe9e1b095fd7 100644
> --- a/tools/perf/lib/mmap.c
> +++ b/tools/perf/lib/mmap.c
> @@ -3,9 +3,11 @@
>  #include <inttypes.h>
>  #include <asm/bug.h>
>  #include <errno.h>
> +#include <string.h>
>  #include <linux/ring_buffer.h>
>  #include <linux/perf_event.h>
>  #include <perf/mmap.h>
> +#include <perf/event.h>
>  #include <internal/mmap.h>
>  #include <internal/lib.h>
>  #include "internal.h"
> @@ -191,3 +193,80 @@ void perf_mmap__read_done(struct perf_mmap *map)
>  
>  	map->prev = perf_mmap__read_head(map);
>  }
> +
> +/* When check_messup is true, 'end' must points to a good entry */
> +static union perf_event *perf_mmap__read(struct perf_mmap *map,
> +					 u64 *startp, u64 end)
> +{
> +	unsigned char *data = map->base + page_size;
> +	union perf_event *event = NULL;
> +	int diff = end - *startp;
> +
> +	if (diff >= (int)sizeof(event->header)) {
> +		size_t size;
> +
> +		event = (union perf_event *)&data[*startp & map->mask];
> +		size = event->header.size;
> +
> +		if (size < sizeof(event->header) || diff < (int)size)
> +			return NULL;
> +
> +		/*
> +		 * Event straddles the mmap boundary -- header should always
> +		 * be inside due to u64 alignment of output.
> +		 */
> +		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
> +			unsigned int offset = *startp;
> +			unsigned int len = min(sizeof(*event), size), cpy;
> +			void *dst = map->event_copy;
> +
> +			do {
> +				cpy = min(map->mask + 1 - (offset & map->mask), len);
> +				memcpy(dst, &data[offset & map->mask], cpy);
> +				offset += cpy;
> +				dst += cpy;
> +				len -= cpy;
> +			} while (len);
> +
> +			event = (union perf_event *)map->event_copy;
> +		}
> +
> +		*startp += size;
> +	}
> +
> +	return event;
> +}
> +
> +/*
> + * Read event from ring buffer one by one.
> + * Return one event for each call.
> + *
> + * Usage:
> + * perf_mmap__read_init()
> + * while(event = perf_mmap__read_event()) {
> + *	//process the event
> + *	perf_mmap__consume()
> + * }
> + * perf_mmap__read_done()
> + */
> +union perf_event *perf_mmap__read_event(struct perf_mmap *map)
> +{
> +	union perf_event *event;
> +
> +	/*
> +	 * Check if event was unmapped due to a POLLHUP/POLLERR.
> +	 */
> +	if (!refcount_read(&map->refcnt))
> +		return NULL;
> +
> +	/* non-overwirte doesn't pause the ringbuffer */
> +	if (!map->overwrite)
> +		map->end = perf_mmap__read_head(map);
> +
> +	event = perf_mmap__read(map, &map->start, map->end);
> +
> +	if (!map->overwrite)
> +		map->prev = map->start;
> +
> +	return event;
> +}
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
> index 13e67cd213bd..a4cd30c0beb3 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -39,7 +39,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
>  		union perf_event *event;
>  
>  		perf_mmap__read_init(&map->core);
> -		while ((event = perf_mmap__read_event(map)) != NULL) {
> +		while ((event = perf_mmap__read_event(&map->core)) != NULL) {
>  			const u32 type = event->header.type;
>  
>  			switch (type) {
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index fd45529e29c1..5d20bf8397f0 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -188,7 +188,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
>  
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			const u32 type = event->header.type;
>  
>  			if (type == PERF_RECORD_SAMPLE)
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 9947cda29bad..1f017e1b2a55 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -429,7 +429,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
>  
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			ret = process_event(machine, evlist, event, state);
>  			perf_mmap__consume(&md->core);
>  			if (ret < 0)
> diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> index e950907f6f57..50a0c9fcde7d 100644
> --- a/tools/perf/tests/keep-tracking.c
> +++ b/tools/perf/tests/keep-tracking.c
> @@ -41,7 +41,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
>  		md = &evlist->mmap[i];
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			if (event->header.type == PERF_RECORD_COMM &&
>  			    (pid_t)event->comm.pid == getpid() &&
>  			    (pid_t)event->comm.tid == getpid() &&
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index bb15d405a42c..5f4c0dbb4715 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -117,7 +117,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		goto out_init;
>  
> -	while ((event = perf_mmap__read_event(md)) != NULL) {
> +	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  		struct perf_sample sample;
>  
>  		if (event->header.type != PERF_RECORD_SAMPLE) {
> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> index c95eb1bbf396..c6b2d7aab608 100644
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> @@ -96,7 +96,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
>  			if (perf_mmap__read_init(&md->core) < 0)
>  				continue;
>  
> -			while ((event = perf_mmap__read_event(md)) != NULL) {
> +			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  				const u32 type = event->header.type;
>  				int tp_flags;
>  				struct perf_sample sample;
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 92a53be3b32b..2195fc205e72 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -174,7 +174,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  			if (perf_mmap__read_init(&md->core) < 0)
>  				continue;
>  
> -			while ((event = perf_mmap__read_event(md)) != NULL) {
> +			while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  				const u32 type = event->header.type;
>  				const char *name = perf_event__name(type);
>  
> diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
> index ace20921ad55..bfb9986093d8 100644
> --- a/tools/perf/tests/sw-clock.c
> +++ b/tools/perf/tests/sw-clock.c
> @@ -103,7 +103,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		goto out_init;
>  
> -	while ((event = perf_mmap__read_event(md)) != NULL) {
> +	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  		struct perf_sample sample;
>  
>  		if (event->header.type != PERF_RECORD_SAMPLE)
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 8400fb17c170..fcb0d03dba4e 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -273,7 +273,7 @@ static int process_events(struct evlist *evlist,
>  		if (perf_mmap__read_init(&md->core) < 0)
>  			continue;
>  
> -		while ((event = perf_mmap__read_event(md)) != NULL) {
> +		while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  			cnt += 1;
>  			ret = add_event(evlist, &events, event);
>  			 perf_mmap__consume(&md->core);
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index c6a13948821c..4965f8b9055b 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -121,7 +121,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		goto out_init;
>  
> -	while ((event = perf_mmap__read_event(md)) != NULL) {
> +	while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>  		if (event->header.type == PERF_RECORD_EXIT)
>  			nr_exit++;
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 830dc91994bc..09fe8fe9805d 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1742,7 +1742,7 @@ static void *perf_evlist__poll_thread(void *arg)
>  
>  			if (perf_mmap__read_init(&map->core))
>  				continue;
> -			while ((event = perf_mmap__read_event(map)) != NULL) {
> +			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
>  				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
>  
>  				if (evsel && evsel->side_band.cb)
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 2dedef9b06fd..2a8bf0ab861c 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -29,83 +29,6 @@ size_t mmap__mmap_len(struct mmap *map)
>  	return perf_mmap__mmap_len(&map->core);
>  }
>  
> -/* When check_messup is true, 'end' must points to a good entry */
> -static union perf_event *perf_mmap__read(struct mmap *map,
> -					 u64 *startp, u64 end)
> -{
> -	unsigned char *data = map->core.base + page_size;
> -	union perf_event *event = NULL;
> -	int diff = end - *startp;
> -
> -	if (diff >= (int)sizeof(event->header)) {
> -		size_t size;
> -
> -		event = (union perf_event *)&data[*startp & map->core.mask];
> -		size = event->header.size;
> -
> -		if (size < sizeof(event->header) || diff < (int)size)
> -			return NULL;
> -
> -		/*
> -		 * Event straddles the mmap boundary -- header should always
> -		 * be inside due to u64 alignment of output.
> -		 */
> -		if ((*startp & map->core.mask) + size != ((*startp + size) & map->core.mask)) {
> -			unsigned int offset = *startp;
> -			unsigned int len = min(sizeof(*event), size), cpy;
> -			void *dst = map->core.event_copy;
> -
> -			do {
> -				cpy = min(map->core.mask + 1 - (offset & map->core.mask), len);
> -				memcpy(dst, &data[offset & map->core.mask], cpy);
> -				offset += cpy;
> -				dst += cpy;
> -				len -= cpy;
> -			} while (len);
> -
> -			event = (union perf_event *)map->core.event_copy;
> -		}
> -
> -		*startp += size;
> -	}
> -
> -	return event;
> -}
> -
> -/*
> - * Read event from ring buffer one by one.
> - * Return one event for each call.
> - *
> - * Usage:
> - * perf_mmap__read_init()
> - * while(event = perf_mmap__read_event()) {
> - *	//process the event
> - *	perf_mmap__consume()
> - * }
> - * perf_mmap__read_done()
> - */
> -union perf_event *perf_mmap__read_event(struct mmap *map)
> -{
> -	union perf_event *event;
> -
> -	/*
> -	 * Check if event was unmapped due to a POLLHUP/POLLERR.
> -	 */
> -	if (!refcount_read(&map->core.refcnt))
> -		return NULL;
> -
> -	/* non-overwirte doesn't pause the ringbuffer */
> -	if (!map->core.overwrite)
> -		map->core.end = perf_mmap__read_head(&map->core);
> -
> -	event = perf_mmap__read(map, &map->core.start, map->core.end);
> -
> -	if (!map->core.overwrite)
> -		map->core.prev = map->core.start;
> -
> -	return event;
> -}
> -
>  int __weak auxtrace_mmap__mmap(struct auxtrace_mmap *mm __maybe_unused,
>  			       struct auxtrace_mmap_params *mp __maybe_unused,
>  			       void *userpg __maybe_unused,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 0b15702be1a5..bee4e83f7109 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -47,8 +47,6 @@ void mmap__munmap(struct mmap *map);
>  
>  union perf_event *perf_mmap__read_forward(struct mmap *map);
>  
> -union perf_event *perf_mmap__read_event(struct mmap *map);
> -
>  int perf_mmap__push(struct mmap *md, void *to,
>  		    int push(struct mmap *map, void *to, void *buf, size_t size));
>  
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7cb432899e7a..78345442cad9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1020,7 +1020,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  	if (perf_mmap__read_init(&md->core) < 0)
>  		goto end;
>  
> -	event = perf_mmap__read_event(md);
> +	event = perf_mmap__read_event(&md->core);
>  	if (event != NULL) {
>  		PyObject *pyevent = pyrf_event__new(event);
>  		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
> -- 
> 2.21.0

-- 

- Arnaldo
