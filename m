Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA9A20828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCTAfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:35:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:44331 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCTAfX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:35:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 17:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="124100212"
Received: from unknown (HELO [10.239.196.108]) ([10.239.196.108])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 17:35:20 -0700
Subject: Re: [PATCH v3] perf annotate/report: Remove hist__account_cycles from
 callback
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9bf3bdff-1b7f-e471-5b35-9d788248eeb9@linux.intel.com>
Date:   Wed, 20 Mar 2019 08:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody like this patch? :)

In my test, for a 72MB perf.data (with LBR data), the perf annotate 
processing speed:

Before: 10.2s
After: 2.2s

Thanks
Jin Yao

On 3/16/2019 5:16 AM, Jin Yao wrote:
> The hist__account_cycles is executed when the hist_iter__branch_callback
> is called. But it looks it's not necessary. In hist__account_cycles, it
> already walks on all branch entries.
> 
> This patch moves the hist__account_cycles out of callback, now the data
> processing is much faster than before.
> 
> Previous code has an issue that the ch[offset].num++
> (in __symbol__account_cycles) is executed repeatedly since
> hist__account_cycles is called in each hist_iter__branch_callback,
> so the counting of ch[offset].num is not correct (too big).
> With this patch, the issue is fixed. And we don't need the code of
> "ch->reset >= ch->num / 2" to check if there are too many overlaps
> (in annotation__count_and_fill), otherwise some data would be
> hidden.
> 
> Now, we can try, for example:
> 
> perf record -b ...
> perf annotate or perf report -s symbol
> 
> The before/after output should be no change.
> 
>   v3:
>   ---
>   Fix the crash in stdio mode.
>   Like previous code, it needs the checking of ui__has_annotation()
>   before hist__account_cycles()
> 
>   v2:
>   ---
>   1. Cover the similar perf report
>   2. Remove the checking code "ch->reset >= ch->num / 2"
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>   tools/perf/builtin-annotate.c |  4 ++--
>   tools/perf/builtin-report.c   | 11 +++++------
>   tools/perf/util/annotate.c    |  2 +-
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 67f9d9f..77deb3a 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>   	struct perf_evsel *evsel = iter->evsel;
>   	int err;
>   
> -	hist__account_cycles(sample->branch_stack, al, sample, false);
> -
>   	bi = he->branch_info;
>   	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
>   
> @@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
>   	if (a.map != NULL)
>   		a.map->dso->hit = 1;
>   
> +	hist__account_cycles(sample->branch_stack, al, sample, false);
> +
>   	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
>   	return ret;
>   }
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1921aaa..493e115 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -136,9 +136,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
>   	if (!ui__has_annotation() && !rep->symbol_ipc)
>   		return 0;
>   
> -	hist__account_cycles(sample->branch_stack, al, sample,
> -			     rep->nonany_branch_mode);
> -
>   	if (sort__mode == SORT_MODE__BRANCH) {
>   		bi = he->branch_info;
>   		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
> @@ -181,9 +178,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>   	if (!ui__has_annotation() && !rep->symbol_ipc)
>   		return 0;
>   
> -	hist__account_cycles(sample->branch_stack, al, sample,
> -			     rep->nonany_branch_mode);
> -
>   	bi = he->branch_info;
>   	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
>   	if (err)
> @@ -282,6 +276,11 @@ static int process_sample_event(struct perf_tool *tool,
>   	if (al.map != NULL)
>   		al.map->dso->hit = 1;
>   
> +	if (ui__has_annotation() || rep->symbol_ipc) {
> +		hist__account_cycles(sample->branch_stack, &al, sample,
> +				     rep->nonany_branch_mode);
> +	}
> +
>   	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
>   	if (ret < 0)
>   		pr_debug("problem adding hist entry, skipping event\n");
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5f6dbbf..e8080c0 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1015,7 +1015,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
>   		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
>   
>   		/* Hide data when there are too many overlaps. */
> -		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
> +		if (ch->reset >= 0x7fff)
>   			return;
>   
>   		for (offset = start; offset <= end; offset++) {
> 
