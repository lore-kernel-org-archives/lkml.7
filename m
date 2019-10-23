Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E76CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E7C21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405589AbfJWNJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:09:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:18589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405579AbfJWNJh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196772235"
Received: from shilongz-mobl.ccr.corp.intel.com (HELO [10.254.210.50]) ([10.254.210.50])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 06:09:34 -0700
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
 <20191023113649.GO22919@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <32cbd687-9089-91ba-a2de-d9784cc37a20@linux.intel.com>
Date:   Wed, 23 Oct 2019 21:09:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023113649.GO22919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 7:36 PM, Jiri Olsa wrote:
> On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index cdb436d6e11f..44aed40e9071 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -51,6 +51,7 @@
>>   #include "util/util.h" // perf_tip()
>>   #include "ui/ui.h"
>>   #include "ui/progress.h"
>> +#include "util/block-info.h"
>>   
>>   #include <dlfcn.h>
>>   #include <errno.h>
>> @@ -96,10 +97,64 @@ struct report {
>>   	float			min_percent;
>>   	u64			nr_entries;
>>   	u64			queue_size;
>> +	u64			cycles_count;
>> +	u64			block_cycles;
>>   	int			socket_filter;
>>   	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
>>   	struct branch_type_stat	brtype_stat;
>>   	bool			symbol_ipc;
>> +	bool			total_cycles;
>> +	struct block_hist	block_hist;
>> +};
> 
> as I said please move all below into util/block_info.c
> 
> thanks,
> jirka
> 

Hi Jiri,

Above fields are not suitable to be moved to struct block_info because 
they are not per-block info. For example, total_cycles are the sum of 
sampled cycles for all blocks.

Oh maybe you just suggest to create a new struct in util/block_info.c 
and move above info to the new struct? Is my understanding correct?

Thanks
Jin Yao

>> +
>> +struct block_fmt {
>> +	struct perf_hpp_fmt	fmt;
>> +	int			idx;
>> +	int			width;
>> +	const char		*header;
>> +	struct report		*rep;
>> +};
>> +
>> +enum {
>> +	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
>> +	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
>> +	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
>> +	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
>> +	PERF_HPP_REPORT__BLOCK_RANGE,
>> +	PERF_HPP_REPORT__BLOCK_DSO,
>> +	PERF_HPP_REPORT__BLOCK_MAX_INDEX
>> +};
>> +
>> +static struct block_fmt block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
>> +
>> +static struct block_header_column{
>> +	const char *name;
>> +	int width;
>> +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
>> +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT] = {
>> +		.name = "Sampled Cycles%",
>> +		.width = 15,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_LBR_CYCLES] = {
>> +		.name = "Sampled Cycles",
>> +		.width = 14,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_CYCLES_PCT] = {
>> +		.name = "Avg Cycles%",
>> +		.width = 11,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_AVG_CYCLES] = {
>> +		.name = "Avg Cycles",
>> +		.width = 10,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_RANGE] = {
>> +		.name = "[Program Block Range]",
>> +		.width = 70,
>> +	},
>> +	[PERF_HPP_REPORT__BLOCK_DSO] = {
>> +		.name = "Shared Object",
>> +		.width = 20,
>> +	}
>>   };
>>   
>>   static int report__config(const char *var, const char *value, void *cb)
>> @@ -277,7 +332,8 @@ static int process_sample_event(struct perf_tool *tool,
>>   		if (!sample->branch_stack)
>>   			goto out_put;
>>   
>> -		iter.add_entry_cb = hist_iter__branch_callback;
>> +		if (!rep->total_cycles)
>> +			iter.add_entry_cb = hist_iter__branch_callback;
>>   		iter.ops = &hist_iter_branch;
>>   	} else if (rep->mem_mode) {
>>   		iter.ops = &hist_iter_mem;
>> @@ -290,9 +346,10 @@ static int process_sample_event(struct perf_tool *tool,
>>   	if (al.map != NULL)
>>   		al.map->dso->hit = 1;
>>   
>> -	if (ui__has_annotation() || rep->symbol_ipc) {
>> +	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles) {
>>   		hist__account_cycles(sample->branch_stack, &al, sample,
>> -				     rep->nonany_branch_mode, NULL);
>> +				     rep->nonany_branch_mode,
>> +				     &rep->cycles_count);
>>   	}
>>   
>>   	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
>> @@ -480,6 +537,269 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
>>   	return ret + fprintf(fp, "\n#\n");
>>   }
>>   
>> +static int block_column_header(struct perf_hpp_fmt *fmt __maybe_unused,
>> +			       struct perf_hpp *hpp __maybe_unused,
>> +			       struct hists *hists __maybe_unused,
>> +			       int line __maybe_unused,
>> +			       int *span __maybe_unused)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
>> +			 block_fmt->header);
>> +}
>> +
>> +static int block_column_width(struct perf_hpp_fmt *fmt __maybe_unused,
>> +			      struct perf_hpp *hpp __maybe_unused,
>> +			      struct hists *hists __maybe_unused)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +
>> +	return block_fmt->width;
>> +}
>> +
>> +static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
>> +					struct perf_hpp *hpp,
>> +					struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct report *rep = block_fmt->rep;
>> +	struct block_info *bi = he->block_info;
>> +	double ratio = 0.0;
>> +	char buf[16];
>> +
>> +	if (rep->cycles_count)
>> +		ratio = (double)bi->cycles / (double)rep->cycles_count;
>> +
>> +	sprintf(buf, "%.2f%%", 100.0 * ratio);
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
>> +}
>> +
>> +static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
>> +					   struct hist_entry *left,
>> +					   struct hist_entry *right)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct report *rep = block_fmt->rep;
>> +	struct block_info *bi_l = left->block_info;
>> +	struct block_info *bi_r = right->block_info;
>> +	double l, r;
>> +
>> +	if (rep->cycles_count) {
>> +		l = ((double)bi_l->cycles / (double)rep->cycles_count) * 1000.0;
>> +		r = ((double)bi_r->cycles / (double)rep->cycles_count) * 1000.0;
>> +		return (int64_t)l - (int64_t)r;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void cycles_string(u64 cycles, char *buf, int size)
>> +{
>> +	if (cycles >= 1000000)
>> +		scnprintf(buf, size, "%.1fM", (double)cycles / 1000000.0);
>> +	else if (cycles >= 1000)
>> +		scnprintf(buf, size, "%.1fK", (double)cycles / 1000.0);
>> +	else
>> +		scnprintf(buf, size, "%1d", cycles);
>> +}
>> +
>> +static int block_cycles_lbr_entry(struct perf_hpp_fmt *fmt,
>> +				  struct perf_hpp *hpp, struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct block_info *bi = he->block_info;
>> +	char cycles_buf[16];
>> +
>> +	cycles_string(bi->cycles_aggr, cycles_buf, sizeof(cycles_buf));
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
>> +			 cycles_buf);
>> +}
>> +
>> +static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
>> +				  struct perf_hpp *hpp, struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct report *rep = block_fmt->rep;
>> +	struct block_info *bi = he->block_info;
>> +	double ratio = 0.0;
>> +	u64 avg;
>> +	char buf[16];
>> +
>> +	if (rep->block_cycles && bi->num_aggr) {
>> +		avg = bi->cycles_aggr / bi->num_aggr;
>> +		ratio = (double)avg / (double)rep->block_cycles;
>> +	}
>> +
>> +	sprintf(buf, "%.2f%%", 100.0 * ratio);
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
>> +}
>> +
>> +static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
>> +				  struct perf_hpp *hpp,
>> +				  struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct block_info *bi = he->block_info;
>> +	char cycles_buf[16];
>> +
>> +	cycles_string(bi->cycles_aggr / bi->num_aggr, cycles_buf,
>> +		      sizeof(cycles_buf));
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
>> +			 cycles_buf);
>> +}
>> +
>> +static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>> +			     struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct block_info *bi = he->block_info;
>> +	char buf[128];
>> +	char *start_line, *end_line;
>> +
>> +	symbol_conf.disable_add2line_warn = true;
>> +
>> +	start_line = map__srcline(he->ms.map, bi->sym->start + bi->start,
>> +				  he->ms.sym);
>> +
>> +	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>> +				he->ms.sym);
>> +
>> +	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>> +		scnprintf(buf, sizeof(buf), "[%s -> %s]",
>> +			  start_line, end_line);
>> +	} else {
>> +		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx]",
>> +			  bi->start, bi->end);
>> +	}
>> +
>> +	free_srcline(start_line);
>> +	free_srcline(end_line);
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
>> +}
>> +
>> +static int block_dso_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>> +			   struct hist_entry *he)
>> +{
>> +	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>> +	struct map *map = he->ms.map;
>> +
>> +	if (map && map->dso) {
>> +		return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
>> +				 map->dso->short_name);
>> +	}
>> +
>> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width,
>> +			 "[unknown]");
>> +}
>> +
>> +static void init_block_header(struct block_fmt *block_fmt)
>> +{
>> +	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
>> +
>> +	BUG_ON(block_fmt->idx >= PERF_HPP_REPORT__BLOCK_MAX_INDEX);
>> +
>> +	block_fmt->header = block_columns[block_fmt->idx].name;
>> +	block_fmt->width = block_columns[block_fmt->idx].width;
>> +
>> +	fmt->header = block_column_header;
>> +	fmt->width = block_column_width;
>> +}
>> +
>> +static void block_hpp_register(struct block_fmt *block_fmt, int idx,
>> +			       struct perf_hpp_list *hpp_list,
>> +			       struct report *rep)
>> +{
>> +	struct perf_hpp_fmt *fmt = &block_fmt->fmt;
>> +
>> +	block_fmt->rep = rep;
>> +	block_fmt->idx = idx;
>> +	INIT_LIST_HEAD(&fmt->list);
>> +	INIT_LIST_HEAD(&fmt->sort_list);
>> +
>> +	switch (idx) {
>> +	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
>> +		fmt->entry = block_total_cycles_pct_entry;
>> +		fmt->cmp = block_info__cmp;
>> +		fmt->sort = block_total_cycles_pct_sort;
>> +		break;
>> +	case PERF_HPP_REPORT__BLOCK_LBR_CYCLES:
>> +		fmt->entry = block_cycles_lbr_entry;
>> +		break;
>> +	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
>> +		fmt->entry = block_cycles_pct_entry;
>> +		break;
>> +	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
>> +		fmt->entry = block_avg_cycles_entry;
>> +		break;
>> +	case PERF_HPP_REPORT__BLOCK_RANGE:
>> +		fmt->entry = block_range_entry;
>> +		break;
>> +	case PERF_HPP_REPORT__BLOCK_DSO:
>> +		fmt->entry = block_dso_entry;
>> +		break;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	init_block_header(block_fmt);
>> +	perf_hpp_list__column_register(hpp_list, fmt);
>> +}
>> +
>> +static void register_block_columns(struct perf_hpp_list *hpp_list,
>> +				   struct report *rep)
>> +{
>> +	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
>> +		block_hpp_register(&block_fmts[i], i, hpp_list, rep);
>> +}
>> +
>> +static void init_block_hist(struct block_hist *bh, struct report *rep)
>> +{
>> +	__hists__init(&bh->block_hists, &bh->block_list);
>> +	perf_hpp_list__init(&bh->block_list);
>> +	bh->block_list.nr_header_lines = 1;
>> +
>> +	register_block_columns(&bh->block_list, rep);
>> +
>> +	perf_hpp_list__register_sort_field(&bh->block_list,
>> +		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
>> +}
>> +
>> +static void get_block_hists(struct hists *hists, struct block_hist *bh,
>> +			    struct report *rep)
>> +{
>> +	struct rb_node *next = rb_first_cached(&hists->entries);
>> +	struct hist_entry *he;
>> +
>> +	init_block_hist(bh, rep);
>> +
>> +	while (next) {
>> +		he = rb_entry(next, struct hist_entry, rb_node);
>> +		block_info__process_sym(he, bh, &rep->block_cycles,
>> +					rep->cycles_count);
>> +		next = rb_next(&he->rb_node);
>> +	}
>> +
>> +	hists__output_resort(&bh->block_hists, NULL);
>> +}
>> +
>> +static int hists__fprintf_all_blocks(struct hists *hists, struct report *rep)
>> +{
>> +	struct block_hist *bh = &rep->block_hist;
>> +
>> +	get_block_hists(hists, bh, rep);
>> +	symbol_conf.report_individual_block = true;
>> +	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
>> +		       stdout, true);
>> +	hists__delete_entries(&bh->block_hists);
>> +	return 0;
>> +}
>> +
>>   static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   					 struct report *rep,
>>   					 const char *help)
>> @@ -500,6 +820,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>   			continue;
>>   
>>   		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>> +
>> +		if (rep->total_cycles) {
>> +			hists__fprintf_all_blocks(hists, rep);
>> +			continue;
>> +		}
>> +
>>   		hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
>>   			       !(symbol_conf.use_callchain ||
>>   			         symbol_conf.show_branchflag_count));
>> @@ -1373,6 +1699,15 @@ int cmd_report(int argc, const char **argv)
>>   		goto error;
>>   	}
>>   
>> +	if (sort_order && strstr(sort_order, "total_cycles") &&
>> +	    (sort__mode == SORT_MODE__BRANCH)) {
>> +		report.total_cycles = true;
>> +		if (!report.use_stdio) {
>> +			pr_err("Error: -s total_cycles can be only used together with --stdio\n");
>> +			goto error;
>> +		}
>> +	}
>> +
>>   	if (strcmp(input_name, "-") != 0)
>>   		setup_browser(true);
>>   	else
>> @@ -1423,7 +1758,7 @@ int cmd_report(int argc, const char **argv)
>>   	 * so don't allocate extra space that won't be used in the stdio
>>   	 * implementation.
>>   	 */
>> -	if (ui__has_annotation() || report.symbol_ipc) {
>> +	if (ui__has_annotation() || report.symbol_ipc || report.total_cycles) {
>>   		ret = symbol__annotation_init();
>>   		if (ret < 0)
>>   			goto error;
>> diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
>> index 5365606e9dad..655ef7708cd0 100644
>> --- a/tools/perf/ui/stdio/hist.c
>> +++ b/tools/perf/ui/stdio/hist.c
>> @@ -558,6 +558,25 @@ static int hist_entry__block_fprintf(struct hist_entry *he,
>>   	return ret;
>>   }
>>   
>> +static int hist_entry__individual_block_fprintf(struct hist_entry *he,
>> +						char *bf, size_t size,
>> +						FILE *fp)
>> +{
>> +	int ret = 0;
>> +
>> +	struct perf_hpp hpp = {
>> +		.buf		= bf,
>> +		.size		= size,
>> +		.skip		= false,
>> +	};
>> +
>> +	hist_entry__snprintf(he, &hpp);
>> +	if (!hpp.skip)
>> +		ret += fprintf(fp, "%s\n", bf);
>> +
>> +	return ret;
>> +}
>> +
>>   static int hist_entry__fprintf(struct hist_entry *he, size_t size,
>>   			       char *bf, size_t bfsz, FILE *fp,
>>   			       bool ignore_callchains)
>> @@ -580,6 +599,9 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
>>   	if (symbol_conf.report_block)
>>   		return hist_entry__block_fprintf(he, bf, size, fp);
>>   
>> +	if (symbol_conf.report_individual_block)
>> +		return hist_entry__individual_block_fprintf(he, bf, size, fp);
>> +
>>   	hist_entry__snprintf(he, &hpp);
>>   
>>   	ret = fprintf(fp, "%s\n", bf);
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 0e27d6830011..7cf137b0451b 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
>>   	struct hist_entry entry = {
>>   		.block_info = block_info,
>>   		.hists = hists,
>> +		.ms = {
>> +			.map = al->map,
>> +			.sym = al->sym,
>> +		},
>>   	}, *he = hists__findnew_entry(hists, &entry, al, false);
>>   
>>   	return he;
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index 43d1d410854a..eb286700a8a9 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -492,6 +492,10 @@ struct sort_entry sort_sym_ipc_null = {
>>   	.se_width_idx	= HISTC_SYMBOL_IPC,
>>   };
>>   
>> +struct sort_entry sort_block_cycles = {
>> +	.se_cmp		= sort__sym_cmp,
>> +};
>> +
>>   /* --sort srcfile */
>>   
>>   static char no_srcfile[1];
>> @@ -1695,6 +1699,7 @@ static struct sort_dimension bstack_sort_dimensions[] = {
>>   	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
>>   	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
>>   	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
>> +	DIM(SORT_BLOCK_CYCLES, "total_cycles", sort_block_cycles),
>>   };
>>   
>>   #undef DIM
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index 5aff9542d9b7..2ede6c70ad56 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -239,6 +239,7 @@ enum sort_type {
>>   	SORT_SRCLINE_FROM,
>>   	SORT_SRCLINE_TO,
>>   	SORT_SYM_IPC,
>> +	SORT_BLOCK_CYCLES,
>>   
>>   	/* memory mode specific sort keys */
>>   	__SORT_MEMORY_MODE,
>> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
>> index e6880789864c..10f1ec3e0349 100644
>> --- a/tools/perf/util/symbol_conf.h
>> +++ b/tools/perf/util/symbol_conf.h
>> @@ -40,6 +40,7 @@ struct symbol_conf {
>>   			raw_trace,
>>   			report_hierarchy,
>>   			report_block,
>> +			report_individual_block,
>>   			inline_name,
>>   			disable_add2line_warn;
>>   	const char	*vmlinux_name,
>> -- 
>> 2.17.1
>>
> 
