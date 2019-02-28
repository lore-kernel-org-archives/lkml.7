Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EE12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6nL2Z/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbfB1Sov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:44:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42388 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfB1Sov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:44:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id u7so15531169qtg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Jt/T78BDNGtCgNoODlW5ya5uTMxlBbxQFM8CrTjJKw=;
        b=B6nL2Z/e6lRLNR1JFCPMmsLBSZdCRmY1ebKZuDCNs1CETfKgRBPXHM744vn0hNk61W
         dGxnlmvJStt15IeiXA6/4DgYg9hE/i3OnbG+sk7/nkxAow1Vlt2ubu5/PclF35pIavAl
         xaT0G09oIqVcwfjNDPl/dIUZsoStoG/4lABCgkb32Ti/HuYEM99Vw783CWAEhC+pl498
         QBlOUi4wofUmSlZKQEY8nNfXHCy3dzGo/4cp+p7k+sLn7+1l0b4dA/Oe3w63unK9PBwg
         DllTtnsiiIUK88q7CWfxX2pdwsOzoaVgGR1stbLS+IpQn5IFraODBARykqy+tjGGUlou
         rEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Jt/T78BDNGtCgNoODlW5ya5uTMxlBbxQFM8CrTjJKw=;
        b=qtBK0yRj6VSkjb6FOC8sDq0MH/dyVJGuBD31AhOuLuM+a7CYdjxn+zEXqULjctFAPB
         MFqEPrS+m6xcLRTZ54OL+Gq3vmddoaqmUFAXfuc1qBJuP3kUpx7+cnPWhsbQ4/ipGq0s
         47dnqKYv6X67edi9li7VSiA/Q9xLP1o3VZvulgIE2A2YrCAGNiNnGgXF7A/p5xFYhFg5
         Z57k0gFQoCLcFByMHp+PsUG1b+9LZEceJZj2GIPBDrdbzjWgre6nQmEPnKY8VeZLSD6W
         LmaohXNnmvPzqYlbdz7iGDgW4E3ff8FgqqB4D+5iAkgDc7MXxuQWXV6GXyV+LW4GLgLr
         SLIQ==
X-Gm-Message-State: APjAAAXO7LtacrcLcFddY+y2Z3+iAMxEG2nruMwIVKhyzHc2lz5qrdui
        VgpAhKS13misMa5WxGYSCF8=
X-Google-Smtp-Source: APXvYqwG/DPY/GJZc3v/9HepCvRSJhrOFvhzefNyyDvUyc3OETueWoUTuh5KHVpsQxDVSH5/OmqjUA==
X-Received: by 2002:a0c:bb98:: with SMTP id i24mr492819qvg.129.1551379489662;
        Thu, 28 Feb 2019 10:44:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id p18sm12894550qkl.48.2019.02.28.10.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:44:47 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9CA954039C; Thu, 28 Feb 2019 15:44:45 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:44:45 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
Message-ID: <20190228184445.GE9508@kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <4abe0a4f-a0a9-f8e2-d2d1-e24846de15c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4abe0a4f-a0a9-f8e2-d2d1-e24846de15c9@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 12:00:41PM +0300, Alexey Budankov escreveu:
> 
> Implemented -f,--mmap-flush option that specifies threshold to postpone
> and/or trigger the move of data from mmaped kernel buffers to a storage.
> The option can be used to avoid capturing every single byte of data into
> the stored trace. The default option value is 1.

Can you add something here explain more clearly what this means, and
also on the tools/perf/Documentation/perf-record.txt file? Something
like a paragraph explaining when is that there is a mmap flush normally,
or rephrase what you wrote if you think you said that.

- Arnaldo

 
>   $ tools/perf/perf record -f 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -f 1024 -e cycles -- matrix.gcc
> 
> Implemented sync param is the mean to force data move independently from
> the threshold value. Despite a user provides flush value from the command
> line, the tool needs capability to drain memory buffers, at least in the
> end of the collection.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  5 +++
>  tools/perf/builtin-record.c              | 53 +++++++++++++++++++++---
>  tools/perf/perf.h                        |  1 +
>  tools/perf/util/evlist.c                 |  6 +--
>  tools/perf/util/evlist.h                 |  3 +-
>  tools/perf/util/mmap.c                   |  4 +-
>  tools/perf/util/mmap.h                   |  3 +-
>  7 files changed, 63 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 8f0c2be34848..1727663382f1 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -459,6 +459,11 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
>    node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
>    cpu  - thread affinity mask is set to cpu of the processed mmap buffer
>  
> +-f::
> +--mmap-flush=n::
> +Minimal number of bytes accumulated in mmaped kernel buffer that is flushed to a storage (default: 1).
> +Maximal allowed value is a quarter of mmaped kernel buffer size.
> +
>  --all-kernel::
>  Configure all used events to run in kernel space.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f3f7f3100336..61818cbce443 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -334,6 +334,29 @@ static int record__aio_enabled(struct record *rec)
>  	return rec->opts.nr_cblocks > 0;
>  }
>  
> +#define MMAP_FLUSH_DEFAULT 1
> +static int record__mmap_flush_parse(const struct option *opt,
> +				    const char *str,
> +				    int unset)
> +{
> +	int mmap_len;
> +	struct record_opts *opts = (struct record_opts *)opt->value;
> +
> +	if (unset)
> +		return 0;
> +
> +	if (str)
> +		opts->mmap_flush = strtol(str, NULL, 0);
> +	if (!opts->mmap_flush)
> +		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
> +
> +	mmap_len = perf_evlist__mmap_size(opts->mmap_pages);
> +	if (opts->mmap_flush > mmap_len / 4)
> +		opts->mmap_flush = mmap_len / 4;
> +
> +	return 0;
> +}
> +
>  static int process_synthesized_event(struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample __maybe_unused,
> @@ -543,7 +566,8 @@ static int record__mmap_evlist(struct record *rec,
>  	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
>  				 opts->auxtrace_mmap_pages,
>  				 opts->auxtrace_snapshot_mode,
> -				 opts->nr_cblocks, opts->affinity) < 0) {
> +				 opts->nr_cblocks, opts->affinity,
> +				 opts->mmap_flush) < 0) {
>  		if (errno == EPERM) {
>  			pr_err("Permission error mapping pages.\n"
>  			       "Consider increasing "
> @@ -733,7 +757,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
>  }
>  
>  static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
> -				    bool overwrite)
> +				    bool overwrite, bool sync)
>  {
>  	u64 bytes_written = rec->bytes_written;
>  	int i;
> @@ -756,12 +780,19 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  		off = record__aio_get_pos(trace_fd);
>  
>  	for (i = 0; i < evlist->nr_mmaps; i++) {
> +		u64 flush = MMAP_FLUSH_DEFAULT;
>  		struct perf_mmap *map = &maps[i];
>  
>  		if (map->base) {
>  			record__adjust_affinity(rec, map);
> +			if (sync) {
> +				flush = map->flush;
> +				map->flush = MMAP_FLUSH_DEFAULT;
> +			}
>  			if (!record__aio_enabled(rec)) {
>  				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
> +					if (sync)
> +						map->flush = flush;
>  					rc = -1;
>  					goto out;
>  				}
> @@ -774,10 +805,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  				idx = record__aio_sync(map, false);
>  				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
>  					record__aio_set_pos(trace_fd, off);
> +					if (sync)
> +						map->flush = flush;
>  					rc = -1;
>  					goto out;
>  				}
>  			}
> +			if (sync)
> +				map->flush = flush;
>  		}
>  
>  		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
> @@ -803,15 +838,15 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
>  	return rc;
>  }
>  
> -static int record__mmap_read_all(struct record *rec)
> +static int record__mmap_read_all(struct record *rec, bool sync)
>  {
>  	int err;
>  
> -	err = record__mmap_read_evlist(rec, rec->evlist, false);
> +	err = record__mmap_read_evlist(rec, rec->evlist, false, sync);
>  	if (err)
>  		return err;
>  
> -	return record__mmap_read_evlist(rec, rec->evlist, true);
> +	return record__mmap_read_evlist(rec, rec->evlist, true, sync);
>  }
>  
>  static void record__init_features(struct record *rec)
> @@ -1310,7 +1345,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (trigger_is_hit(&switch_output_trigger) || done || draining)
>  			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
>  
> -		if (record__mmap_read_all(rec) < 0) {
> +		if (record__mmap_read_all(rec, false) < 0) {
>  			trigger_error(&auxtrace_snapshot_trigger);
>  			trigger_error(&switch_output_trigger);
>  			err = -1;
> @@ -1411,6 +1446,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		record__synthesize_workload(rec, true);
>  
>  out_child:
> +	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
>  
>  	if (forks) {
> @@ -1813,6 +1849,7 @@ static struct record record = {
>  			.uses_mmap   = true,
>  			.default_per_cpu = true,
>  		},
> +		.mmap_flush          = MMAP_FLUSH_DEFAULT,
>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -1879,6 +1916,9 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
>  		     "number of mmap data pages and AUX area tracing mmap pages",
>  		     record__parse_mmap_pages),
> +	OPT_CALLBACK('f', "mmap-flush", &record.opts, "bytes",
> +		     "Minimal number of bytes in mmap data pages that is written to a storage (default: 1)",
> +		     record__mmap_flush_parse),
>  	OPT_BOOLEAN(0, "group", &record.opts.group,
>  		    "put the counters into a counter group"),
>  	OPT_CALLBACK_NOOPT('g', NULL, &callchain_param,
> @@ -2182,6 +2222,7 @@ int cmd_record(int argc, const char **argv)
>  		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>  
>  	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
> +	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
>  
>  	err = __cmd_record(&record, argc, argv);
>  out:
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index b120e547ddc7..7886cc9771cf 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -85,6 +85,7 @@ struct record_opts {
>  	u64          clockid_res_ns;
>  	int	     nr_cblocks;
>  	int	     affinity;
> +	int	     mmap_flush;
>  };
>  
>  enum perf_affinity {
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 08cedb643ea6..937039faac59 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
>   */
>  int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  			 unsigned int auxtrace_pages,
> -			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
> +			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
>  {
>  	struct perf_evsel *evsel;
>  	const struct cpu_map *cpus = evlist->cpus;
> @@ -1032,7 +1032,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  	 * Its value is decided by evsel's write_backward.
>  	 * So &mp should not be passed through const pointer.
>  	 */
> -	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
> +	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
>  
>  	if (!evlist->mmap)
>  		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
> @@ -1064,7 +1064,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  
>  int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
>  {
> -	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
> +	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
>  }
>  
>  int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 744906dd4887..edf18811e39f 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -165,7 +165,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
>  
>  int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
>  			 unsigned int auxtrace_pages,
> -			 bool auxtrace_overwrite, int nr_cblocks, int affinity);
> +			 bool auxtrace_overwrite, int nr_cblocks,
> +			 int affinity, int flush);
>  int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
>  void perf_evlist__munmap(struct perf_evlist *evlist);
>  
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index cdc7740fc181..ef3d79b2c90b 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -440,6 +440,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
>  
>  	perf_mmap__setup_affinity_mask(map, mp);
>  
> +	map->flush = mp->flush;
> +
>  	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
>  				&mp->auxtrace_mp, map->base, fd))
>  		return -1;
> @@ -492,7 +494,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
>  	md->start = md->overwrite ? head : old;
>  	md->end = md->overwrite ? old : head;
>  
> -	if (md->start == md->end)
> +	if ((md->end - md->start) < md->flush)
>  		return -EAGAIN;
>  
>  	size = md->end - md->start;
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index e566c19b242b..b82f8c2d55c4 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -39,6 +39,7 @@ struct perf_mmap {
>  	} aio;
>  #endif
>  	cpu_set_t	affinity_mask;
> +	u64		flush;
>  };
>  
>  /*
> @@ -70,7 +71,7 @@ enum bkw_mmap_state {
>  };
>  
>  struct mmap_params {
> -	int			    prot, mask, nr_cblocks, affinity;
> +	int			    prot, mask, nr_cblocks, affinity, flush;
>  	struct auxtrace_mmap_params auxtrace_mp;
>  };

-- 

- Arnaldo
