Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF1ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03462064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfJOIlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:41:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59925 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfJOIlF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:41:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4990230860CB;
        Tue, 15 Oct 2019 08:41:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56F3A5D9CD;
        Tue, 15 Oct 2019 08:41:03 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:41:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191015084102.GA10951@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015053350.13909-4-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 08:41:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:33:48PM +0800, Jin Yao wrote:

SNIP

> +enum {
> +	PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV,
> +	PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> +	PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> +	PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> +	PERF_HPP_REPORT__BLOCK_RANGE,
> +	PERF_HPP_REPORT__BLOCK_DSO,
> +	PERF_HPP_REPORT__BLOCK_MAX_INDEX
> +};
> +
> +static struct block_fmt block_fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
> +
> +static struct block_header_column{
> +	const char *name;
> +	int width;
> +} block_columns[PERF_HPP_REPORT__BLOCK_MAX_INDEX] = {
> +	[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_COV] = {
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
>  };

so we already have support for multiple columns,
why don't you add those as 'struct sort_entry' objects?

SNIP

> +{
> +	struct block_hist *bh = &rep->block_hist;
> +
> +	get_block_hists(hists, bh, rep);
> +	symbol_conf.report_individual_block = true;
> +	hists__fprintf(&bh->block_hists, true, 0, 0, 0,
> +		       stdout, true);
> +	hists__delete_entries(&bh->block_hists);
> +	return 0;
> +}
> +
>  static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  					 struct report *rep,
>  					 const char *help)
> @@ -500,6 +900,12 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  			continue;
>  
>  		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
> +
> +		if (rep->total_cycles) {
> +			hists__fprintf_all_blocks(hists, rep);

so this call kicks all the block info setup/count/print, right?

I thingk it shouldn't be in the output code, but in the code before..
from what I see you could count block_info counts during the sample
processing, no?

jirka
