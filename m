Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E97BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAFC2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az560Ko8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbfKGMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:45:43 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39817 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbfKGMpn (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:45:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id 15so1813631qkh.6
        for <Linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uiU6I1i2C7uz4f3ZyqDfcJztQpRux2aiyWfQWs/boAc=;
        b=Az560Ko8VvzcnhjDeQ1j54i6VAuV2Z3RdfrCjeShP5qo+p0cs5BNtWsm0eTm03VfLG
         2r0Fjokfh+rysrE2zxEu8RGJd9j3906Ia333fHfzxvOhXoUBnJcezBg/nr/vlmYndFeo
         kws+O9rK3FmaSq3uZ4aa9orosonhlzmW89YzV/oHmwPqKvurqKvc5Ir/nShXs0N9R5/R
         1b1Q8UTh8J+fnEdRdz+Irt0+KW5tf+gclHFccxK0P1oAf8ADAwGTCHNVXeVen43whH4L
         swDKRwyEf0z2UqUawXElC7ZbU4nNLX5KX4VJhdU68mQ2BQSCvJyzvuCpqB1OnjY5OENq
         wC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uiU6I1i2C7uz4f3ZyqDfcJztQpRux2aiyWfQWs/boAc=;
        b=Qxv1sIX2B7YpTt1XeMAwAecn5WdU3Ba0y+/S5uNSSGDq/ijiLcf1ErO2Al3H5S75dh
         w+bS1IxCKhpLvFvgaQ9eyrz4ug1zbEEGwuGHGeBI5QJKV7MR3CaX7MHoFhzz8fJC26br
         8XfoGeviCTaaMumXAYuPWspvCwbqRxhAa/e2BmtnRCkDcHlEK5CwpQrVqIqjl6xYYI4W
         YGqmeOtGhJ3eBh2m220tcjqham8bVp1KcYYwhzhHfbEDUgqPfUGam23iOdZ4saAJ6gX7
         IcwZG7AOb+5yTq/H2VgqsUc64A+V2hW/ZeZN3aIKBSTgqvZQ8QdgmGflMOx0v2JeR70o
         HxmA==
X-Gm-Message-State: APjAAAX3ElOrBt9CTbj4T7AL2jGZ19NqJbvYZrymlk0m/Ey/Vt9hQAwd
        sl3/fODa5oRd77W5obKf1Bs=
X-Google-Smtp-Source: APXvYqwe/+7O3I238ImQtastP8jiZom7+FEsyK0eZSSp+gUtL+GYOyON1H3XEAC/DBIrB6bTHNV5Ig==
X-Received: by 2002:a37:9cd2:: with SMTP id f201mr2382013qke.99.1573130741961;
        Thu, 07 Nov 2019 04:45:41 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i41sm1505530qti.42.2019.11.07.04.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:45:40 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E46D40B1D; Thu,  7 Nov 2019 09:45:38 -0300 (-03)
Date:   Thu, 7 Nov 2019 09:45:38 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 4/7] perf util: Support block formats with
 compare/sort/display
Message-ID: <20191107124538.GC11372@kernel.org>
References: <20191107074719.26139-1-yao.jin@linux.intel.com>
 <20191107074719.26139-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107074719.26139-5-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 07, 2019 at 03:47:16PM +0800, Jin Yao escreveu:
> This patch provides helper routines to support new
> columns for block info output.

This breaks bisection, some of my build containers complained about:

util/block-info.c:395:20: error: unused function 'set_fmt' [-Werror,-Wunused-function]
static inline void set_fmt(struct block_fmt *block_fmt,
                   ^
1 error generated.
mv: can't rename '/tmp/build/perf/util/.block-info.o.tmp': No such file or directory


Because you add a static inline function to a .c file and don't use it,
I'll try moving it to when it finally gets used.
 
> The new columns are:
> 
> Sampled Cycles%
> Sampled Cycles
> Avg Cycles%
> Avg Cycles
> [Program Block Range]
> Shared Object
> 
>  v5:
>  ---
>  1. Move more block related functions from builtin-report.c to
>     block-info.c
> 
>  2. Set ms (map+sym) in block hist_entry. Because this info
>     is needed for reporting the block range (i.e. source line)
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/block-info.c | 317 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/block-info.h |  33 +++-
>  tools/perf/util/hist.c       |   4 +
>  3 files changed, 352 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index b9954a32b8f4..1242c3a33509 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -6,6 +6,40 @@
>  #include "sort.h"
>  #include "annotate.h"
>  #include "symbol.h"
> +#include "dso.h"
> +#include "map.h"
> +#include "srcline.h"
> +#include "evlist.h"
> +
> +static struct block_header_column{
> +	const char *name;
> +	int width;
> +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
> +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT] = {
> +		.name = "Sampled Cycles%",
> +		.width = 15,
> +	},
> +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
> +		.name = "Sampled Cycles",
> +		.width = 14,
> +	},
> +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
> +		.name = "Avg Cycles%",
> +		.width = 11,
> +	},
> +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
> +		.name = "Avg Cycles",
> +		.width = 10,
> +	},
> +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
> +		.name = "[Program Block Range]",
> +		.width = 70,
> +	},
> +	[PERF_HPP_REPORT__BLOCK_DSO] = {
> +		.name = "Shared Object",
> +		.width = 20,
> +	}
> +};
>  
>  struct block_info *block_info__get(struct block_info *bi)
>  {
> @@ -127,3 +161,286 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>  
>  	return 0;
>  }
> +
> +static int block_column_header(struct perf_hpp_fmt *fmt,
> +			       struct perf_hpp *hpp,
> +			       struct hists *hists __maybe_unused,
> +			       int line __maybe_unused,
> +			       int *span __maybe_unused)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> +			 block_fmt->header);
> +}
> +
> +static int block_column_width(struct perf_hpp_fmt *fmt,
> +			      struct perf_hpp *hpp __maybe_unused,
> +			      struct hists *hists __maybe_unused)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +
> +	return block_fmt->width;
> +}
> +
> +static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
> +					struct perf_hpp *hpp,
> +					struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi = he->block_info;
> +	double ratio = 0.0;
> +	char buf[16];
> +
> +	if (block_fmt->total_cycles)
> +		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
> +
> +	sprintf(buf, "%.2f%%", 100.0 * ratio);
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
> +}
> +
> +static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
> +					   struct hist_entry *left,
> +					   struct hist_entry *right)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi_l = left->block_info;
> +	struct block_info *bi_r = right->block_info;
> +	double l, r;
> +
> +	if (block_fmt->total_cycles) {
> +		l = ((double)bi_l->cycles /
> +			(double)block_fmt->total_cycles) * 100000.0;
> +		r = ((double)bi_r->cycles /
> +			(double)block_fmt->total_cycles) * 100000.0;
> +		return (int64_t)l - (int64_t)r;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cycles_string(u64 cycles, char *buf, int size)
> +{
> +	if (cycles >= 1000000)
> +		scnprintf(buf, size, "%.1fM", (double)cycles / 1000000.0);
> +	else if (cycles >= 1000)
> +		scnprintf(buf, size, "%.1fK", (double)cycles / 1000.0);
> +	else
> +		scnprintf(buf, size, "%1d", cycles);
> +}
> +
> +static int block_cycles_lbr_entry(struct perf_hpp_fmt *fmt,
> +				  struct perf_hpp *hpp, struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi = he->block_info;
> +	char cycles_buf[16];
> +
> +	cycles_string(bi->cycles_aggr, cycles_buf, sizeof(cycles_buf));
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> +			 cycles_buf);
> +}
> +
> +static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
> +				  struct perf_hpp *hpp, struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi = he->block_info;
> +	double ratio = 0.0;
> +	u64 avg;
> +	char buf[16];
> +
> +	if (block_fmt->block_cycles && bi->num_aggr) {
> +		avg = bi->cycles_aggr / bi->num_aggr;
> +		ratio = (double)avg / (double)block_fmt->block_cycles;
> +	}
> +
> +	sprintf(buf, "%.2f%%", 100.0 * ratio);
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
> +}
> +
> +static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
> +				  struct perf_hpp *hpp,
> +				  struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi = he->block_info;
> +	char cycles_buf[16];
> +
> +	cycles_string(bi->cycles_aggr / bi->num_aggr, cycles_buf,
> +		      sizeof(cycles_buf));
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> +			 cycles_buf);
> +}
> +
> +static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +			     struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct block_info *bi = he->block_info;
> +	char buf[128];
> +	char *start_line, *end_line;
> +
> +	symbol_conf.disable_add2line_warn = true;
> +
> +	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
> +				  he->ms.sym);
> +
> +	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
> +				he->ms.sym);
> +
> +	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> +		scnprintf(buf, sizeof(buf), "[%s -> %s]",
> +			  start_line, end_line);
> +	} else {
> +		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx]",
> +			  bi->start, bi->end);
> +	}
> +
> +	free_srcline(start_line);
> +	free_srcline(end_line);
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
> +}
> +
> +static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +			   struct hist_entry *he)
> +{
> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
> +	struct map *map = he->ms.map;
> +
> +	if (map && map->dso) {
> +		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> +				 map->dso->short_name);
> +	}
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
> +			 "[unknown]");
> +}
> +
> +static void init_block_header(struct block_fmt *block_fmt)
> +{
> +	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
> +
> +	BUG_ON(block_fmt->idx >= PERF_HPP_REPORT__BLOCK_MAX_INDEX);
> +
> +	block_fmt->header = block_columns[block_fmt->idx].name;
> +	block_fmt->width = block_columns[block_fmt->idx].width;
> +
> +	fmt->header = block_column_header;
> +	fmt->width = block_column_width;
> +}
> +
> +static void hpp_register(struct block_fmt *block_fmt, int idx,
> +			 struct perf_hpp_list *hpp_list)
> +{
> +	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
> +
> +	block_fmt->idx = idx;
> +	INIT_LIST_HEAD(&fmt->list);
> +	INIT_LIST_HEAD(&fmt->sort_list);
> +
> +	switch (idx) {
> +	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
> +		fmt->entry = block_total_cycles_pct_entry;
> +		fmt->cmp = block_info__cmp;
> +		fmt->sort = block_total_cycles_pct_sort;
> +		break;
> +	case PERF_HPP_REPORT__BLOCK_LBR_CYCLES:
> +		fmt->entry = block_cycles_lbr_entry;
> +		break;
> +	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
> +		fmt->entry = block_cycles_pct_entry;
> +		break;
> +	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
> +		fmt->entry = block_avg_cycles_entry;
> +		break;
> +	case PERF_HPP_REPORT__BLOCK_RANGE:
> +		fmt->entry = block_range_entry;
> +		break;
> +	case PERF_HPP_REPORT__BLOCK_DSO:
> +		fmt->entry = block_dso_entry;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	init_block_header(block_fmt);
> +	perf_hpp_list__column_register(hpp_list, fmt);
> +}
> +
> +static void register_block_columns(struct perf_hpp_list *hpp_list,
> +				   struct block_fmt *block_fmts)
> +{
> +	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
> +		hpp_register(&block_fmts[i], i, hpp_list);
> +}
> +
> +static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts)
> +{
> +	__hists__init(&bh->block_hists, &bh->block_list);
> +	perf_hpp_list__init(&bh->block_list);
> +	bh->block_list.nr_header_lines = 1;
> +
> +	register_block_columns(&bh->block_list, block_fmts);
> +
> +	perf_hpp_list__register_sort_field(&bh->block_list,
> +		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
> +}
> +
> +static inline void set_fmt(struct block_fmt *block_fmt,
> +			   u64 total_cycles, u64 block_cycles)
> +{
> +	block_fmt->total_cycles = total_cycles;
> +	block_fmt->block_cycles = block_cycles;
> +}
> +
> +static void process_block_report(struct hists *hists,
> +				 struct block_report *block_report,
> +				 u64 total_cycles)
> +{
> +	struct rb_node *next = rb_first_cached(&hists->entries);
> +	struct block_hist *bh = &block_report->hist;
> +	struct hist_entry *he;
> +
> +	init_block_hist(bh, block_report->fmts);
> +
> +	while (next) {
> +		he = rb_entry(next, struct hist_entry, rb_node);
> +		block_info__process_sym(he, bh, &block_report->cycles,
> +					total_cycles);
> +		next = rb_next(&he->rb_node);
> +	}
> +
> +	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
> +		block_report->fmts[i].total_cycles = total_cycles;
> +		block_report->fmts[i].block_cycles = block_report->cycles;
> +	}
> +
> +	hists__output_resort(&bh->block_hists, NULL);
> +}
> +
> +struct block_report *block_info__create_report(struct evlist *evlist,
> +					       u64 total_cycles)
> +{
> +	struct block_report *block_reports;
> +	int nr_hists = evlist->core.nr_entries, i = 0;
> +	struct evsel *pos;
> +
> +	block_reports = calloc(nr_hists, sizeof(struct block_report));
> +	if (!block_reports)
> +		return NULL;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		struct hists *hists = evsel__hists(pos);
> +
> +		process_block_report(hists, &block_reports[i], total_cycles);
> +		i++;
> +	}
> +
> +	return block_reports;
> +}
> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
> index d55dfc2fda6f..b5266588d476 100644
> --- a/tools/perf/util/block-info.h
> +++ b/tools/perf/util/block-info.h
> @@ -4,8 +4,9 @@
>  
>  #include <linux/types.h>
>  #include <linux/refcount.h>
> -#include "util/hist.h"
> -#include "util/symbol.h"
> +#include "hist.h"
> +#include "symbol.h"
> +#include "sort.h"
>  
>  struct block_info {
>  	struct symbol		*sym;
> @@ -20,6 +21,31 @@ struct block_info {
>  	refcount_t		refcnt;
>  };
>  
> +struct block_fmt {
> +	struct perf_hpp_fmt	fmt;
> +	int			idx;
> +	int			width;
> +	const char		*header;
> +	u64			total_cycles;
> +	u64			block_cycles;
> +};
> +
> +enum {
> +	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
> +	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> +	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> +	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> +	PERF_HPP_REPORT__BLOCK_RANGE,
> +	PERF_HPP_REPORT__BLOCK_DSO,
> +	PERF_HPP_REPORT__BLOCK_MAX_INDEX
> +};
> +
> +struct block_report {
> +	struct block_hist	hist;
> +	u64			cycles;
> +	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
> +};
> +
>  struct block_hist;
>  
>  struct block_info *block_info__new(void);
> @@ -40,4 +66,7 @@ int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>  int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
>  			    u64 *block_cycles_aggr, u64 total_cycles);
>  
> +struct block_report *block_info__create_report(struct evlist *evlist,
> +					       u64 total_cycles);
> +
>  #endif /* __PERF_BLOCK_H */
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0e27d6830011..7cf137b0451b 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
>  	struct hist_entry entry = {
>  		.block_info = block_info,
>  		.hists = hists,
> +		.ms = {
> +			.map = al->map,
> +			.sym = al->sym,
> +		},
>  	}, *he = hists__findnew_entry(hists, &entry, al, false);
>  
>  	return he;
> -- 
> 2.17.1

-- 

- Arnaldo
