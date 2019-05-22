Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE19C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6721851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfEVOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3645 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfEVOEp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7616A30ADC83;
        Wed, 22 May 2019 14:04:34 +0000 (UTC)
Received: from krava (unknown [10.40.205.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 19D5278395;
        Wed, 22 May 2019 14:04:28 +0000 (UTC)
Date:   Wed, 22 May 2019 16:04:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 8/9] perf diff: Print the basic block cycles diff
Message-ID: <20190522140428.GD4757@krava>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
 <1558358876-32211-9-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558358876-32211-9-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 22 May 2019 14:04:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 09:27:55PM +0800, Jin Yao wrote:
> Currently we only support sorting by diff cycles.
> 
> For example,
> 
> perf record -b ./div
> perf record -b ./div
> perf diff --basic-block
> 
>  # Cycles diff  Basic block (start:end)
>  # ...........  .......................
>  #
>           -20   native_write_msr (7fff9a069900:7fff9a06990b)
>            -3   __indirect_thunk_start (7fff9ac02ca0:7fff9ac02ca0)
>             1   __indirect_thunk_start (7fff9ac02cac:7fff9ac02cb0)
>             0   rand@plt (490:490)
>             0   rand (3af60:3af64)
>             0   rand (3af69:3af6d)
>             0   main (4e8:4ea)
>             0   main (4ef:500)
>             0   main (4ef:535)
>             0   compute_flag (640:644)
>             0   compute_flag (649:659)
>             0   __random_r (3ac40:3ac76)
>             0   __random_r (3ac40:3ac88)
>             0   __random_r (3ac90:3ac9c)
>             0   __random (3aac0:3aad2)
>             0   __random (3aae0:3aae7)
>             0   __random (3ab03:3ab0f)
>             0   __random (3ab14:3ab1b)
>             0   __random (3ab28:3ab2e)
>             0   __random (3ab4a:3ab53)

really nice, could you keep the standard diff format
and display the 'Baseline' and Shared Object columns?

jirka

> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-diff.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/hist.c    |   2 +-
>  tools/perf/util/sort.h    |   1 +
>  3 files changed, 170 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 47e34a3..dbf242d 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -27,6 +27,12 @@
>  #include <stdlib.h>
>  #include <math.h>
>  
> +struct block_hpp_fmt {
> +	struct perf_hpp_fmt	fmt;
> +	struct data__file	*file;
> +	int			width;
> +};
> +
>  struct block_hists {
>  	struct hists		sym_hists;
>  	struct perf_hpp_list	sym_list;
> @@ -34,6 +40,8 @@ struct block_hists {
>  	struct hists		hists;
>  	struct perf_hpp_list	list;
>  	struct perf_hpp_fmt	fmt;
> +	struct block_hpp_fmt	block_fmt;
> +	struct perf_hpp_fmt	desc_fmt;
>  };
>  
>  struct perf_diff {
> @@ -1157,6 +1165,162 @@ static void compute_block_hists_diff(struct block_hists *block_hists,
>  	}
>  }
>  
> +static int64_t block_cycles_diff_cmp(struct perf_hpp_fmt *fmt,
> +				     struct hist_entry *left,
> +				     struct hist_entry *right)
> +{
> +	struct block_hpp_fmt *block_fmt = container_of(fmt,
> +						       struct block_hpp_fmt,
> +						       fmt);
> +	struct data__file *d = block_fmt->file;
> +	bool pairs_left  = hist_entry__has_pairs(left);
> +	bool pairs_right = hist_entry__has_pairs(right);
> +	struct hist_entry *p_right, *p_left;
> +	s64 l, r;
> +
> +	if (!pairs_left && !pairs_right)
> +		return 0;
> +
> +	if (!pairs_left || !pairs_right)
> +		return pairs_left ? -1 : 1;
> +
> +	p_left  = get_pair_data(left, d);
> +	p_right  = get_pair_data(right, d);
> +
> +	if (!p_left && !p_right)
> +		return 0;
> +
> +	if (!p_left || !p_right)
> +		return p_left ?  -1 : 1;
> +
> +	l = abs(p_left->diff.cycles_diff);
> +	r = abs(p_right->diff.cycles_diff);
> +
> +	return r - l;
> +}
> +
> +static int64_t block_diff_sort(struct perf_hpp_fmt *fmt,
> +			       struct hist_entry *left, struct hist_entry *right)
> +{
> +	return block_cycles_diff_cmp(fmt, right, left);
> +}
> +
> +static int block_diff_header(struct perf_hpp_fmt *fmt __maybe_unused,
> +			     struct perf_hpp *hpp,
> +			     struct hists *hists __maybe_unused,
> +			     int line __maybe_unused,
> +			     int *span __maybe_unused)
> +{
> +	return scnprintf(hpp->buf, hpp->size, "Cycles diff");
> +}
> +
> +static int block_diff_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> +			    struct hist_entry *he)
> +{
> +	struct block_hpp_fmt *block_fmt = container_of(fmt,
> +						       struct block_hpp_fmt,
> +						       fmt);
> +	struct data__file *d = block_fmt->file;
> +	struct hist_entry *pair = get_pair_data(he, d);
> +
> +	if (pair && pair->diff.computed) {
> +		return scnprintf(hpp->buf, hpp->size, "%*ld", block_fmt->width,
> +				 pair->diff.cycles_diff);
> +	}
> +
> +	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, " ");
> +}
> +
> +static int block_diff_width(struct perf_hpp_fmt *fmt,
> +			    struct perf_hpp *hpp __maybe_unused,
> +			    struct hists *hists __maybe_unused)
> +{
> +	struct block_hpp_fmt *block_fmt =
> +		container_of(fmt, struct block_hpp_fmt, fmt);
> +
> +	return block_fmt->width;
> +}
> +
> +static int block_sym_width(struct perf_hpp_fmt *fmt __maybe_unused,
> +			    struct perf_hpp *hpp __maybe_unused,
> +			    struct hists *hists __maybe_unused)
> +{
> +	return 23;
> +}
> +
> +static int block_sym_entry(struct perf_hpp_fmt *fmt __maybe_unused,
> +			   struct perf_hpp *hpp, struct hist_entry *he)
> +{
> +	struct block_info *bi = he->block_info;
> +
> +	return scnprintf(hpp->buf, hpp->size, "%s (%lx:%lx)",
> +			 bi->sym->name, bi->sym->start + bi->start,
> +			 bi->sym->start + bi->end);
> +}
> +
> +static int block_sym_header(struct perf_hpp_fmt *fmt __maybe_unused,
> +			    struct perf_hpp *hpp,
> +			    struct hists *hists __maybe_unused,
> +			    int line __maybe_unused,
> +			    int *span __maybe_unused)
> +{
> +	return scnprintf(hpp->buf, hpp->size, "Basic block (start:end)");
> +}
> +
> +static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
> +{
> +	he->not_collen = true;
> +
> +	return 0;
> +}
> +
> +static void hists_block_printf_sorted(struct hists *hists)
> +{
> +	hists__fprintf(hists, true, 0, 0, 0, stdout, true);
> +}
> +
> +static void init_block_hists_fmt(void)
> +{
> +	struct block_hists *hists_base = &data__files[0].block_hists;
> +	struct data__file *d;
> +	int i;
> +	struct perf_hpp_fmt *fmt;
> +
> +	perf_hpp__reset_output_field(&hists_base->list);
> +
> +	hists_base->list.nr_header_lines = 1;
> +
> +	data__for_each_file_new(i, d) {
> +		struct block_hpp_fmt *block_fmt = &d->block_hists.block_fmt;
> +
> +		fmt = &block_fmt->fmt;
> +		block_fmt->file = d;
> +		block_fmt->width = 11;
> +
> +		INIT_LIST_HEAD(&fmt->list);
> +		INIT_LIST_HEAD(&fmt->sort_list);
> +
> +		fmt->sort = block_diff_sort;
> +		fmt->header = block_diff_header;
> +		fmt->entry = block_diff_entry;
> +		fmt->width = block_diff_width;
> +
> +		perf_hpp_list__column_register(&hists_base->list, fmt);
> +		perf_hpp_list__register_sort_field(&hists_base->list, fmt);
> +	}
> +
> +	/* fmt for description */
> +	fmt = &hists_base->desc_fmt;
> +
> +	fmt->width = block_sym_width;
> +	fmt->entry = block_sym_entry;
> +	fmt->header = block_sym_header;
> +	fmt->sort = hist_entry__cmp_nop;
> +
> +	perf_hpp_list__column_register(&hists_base->list, fmt);
> +	perf_hpp_list__register_sort_field(&hists_base->list, fmt);
> +}
> +
>  static void basic_block_process(void)
>  {
>  	struct hists *hists_base = &data__files[0].block_hists.hists;
> @@ -1182,6 +1346,10 @@ static void basic_block_process(void)
>  		compute_block_hists_diff(&data__files[0].block_hists, d);
>  	}
>  
> +	init_block_hists_fmt();
> +	hists__output_resort_cb(hists_base, NULL, filter_cb);
> +	hists_block_printf_sorted(hists_base);
> +
>  	data__for_each_file(i, d) {
>  		hists__delete_entries(&d->block_hists.sym_hists);
>  		hists__delete_entries(&d->block_hists.hists);
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 3810460..ae95191 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1846,7 +1846,7 @@ static void output_resort(struct hists *hists, struct ui_progress *prog,
>  		__hists__insert_output_entry(&hists->entries, n, min_callchain_hits, use_callchain);
>  		hists__inc_stats(hists, n);
>  
> -		if (!n->filtered)
> +		if ((!n->filtered) && (!n->not_collen))
>  			hists__calc_col_len(hists, n);
>  
>  		if (prog)
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index de9e61a..1e921fe 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -121,6 +121,7 @@ struct hist_entry {
>  
>  	char			level;
>  	u8			filtered;
> +	bool			not_collen;
>  
>  	u16			callchain_size;
>  	union {
> -- 
> 2.7.4
> 
