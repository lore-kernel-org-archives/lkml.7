Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC943C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882AD206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfHFIef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:34:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfHFIee (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E8F83091785;
        Tue,  6 Aug 2019 08:34:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id CD2DE166A5;
        Tue,  6 Aug 2019 08:34:29 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:34:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
Message-ID: <20190806083429.GI7695@krava>
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724221432.26297-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 06 Aug 2019 08:34:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:

SNIP

>  static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
> -			 struct perf_hpp *hpp, int width)
> +			 struct perf_hpp *hpp, int width __maybe_unused)
>  {
>  	struct block_hist *bh = container_of(he, struct block_hist, he);
>  	struct block_hist *bh_pair = container_of(pair, struct block_hist, he);
>  	struct hist_entry *block_he;
>  	struct block_info *bi;
> -	char buf[128];
> +	char buf[128], spark[32];
>  	char *start_line, *end_line;
> +	int ret = 0, pad;
> +	char pfmt[20] = " ";
> +	double d;
>  
>  	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
>  	if (!block_he) {
> @@ -1350,18 +1375,56 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>  	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>  				he->ms.sym);
>  
> -	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
> -		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
> -			  start_line, end_line, block_he->diff.cycles);
> +	if (show_noisy) {
> +		ret = print_stat_spark(spark, sizeof(spark),
> +				       &block_he->diff.stats);
> +		d = rel_stddev_stats(stddev_stats(&block_he->diff.stats),
> +				     avg_stats(&block_he->diff.stats));
> +
> +		if ((start_line != SRCLINE_UNKNOWN) &&
> +		    (end_line != SRCLINE_UNKNOWN)) {
> +			scnprintf(buf, sizeof(buf),
> +				  "[%s -> %s] %4ld  %s%5.1f%% %s",
> +				  start_line, end_line, block_he->diff.cycles,
> +				  "\u00B1", d, spark);
> +		} else {
> +			scnprintf(buf, sizeof(buf),
> +				  "[%7lx -> %7lx] %4ld  %s%5.1f%% %s",
> +				  bi->start, bi->end, block_he->diff.cycles,
> +				  "\u00B1", d, spark);
> +		}
> +
> +		if (ret > 0) {
> +			pad = 8 - ((ret - 1) / 3);
> +			scnprintf(pfmt, 20, "%%%ds",
> +				  81 + (2 * ((ret - 1) / 3)) - pad);
> +			ret = scnprintf(hpp->buf, hpp->size, pfmt, buf);
> +			if (pad > 0) {
> +				ret += scnprintf(hpp->buf + ret,
> +						 hpp->size - ret,
> +						 "%-*s", pad, " ");
> +			}
> +		} else {
> +			ret = scnprintf(hpp->buf, hpp->size, "%73s", buf);
> +			ret += scnprintf(hpp->buf + ret, hpp->size - ret,
> +					 "%-*s", 8, " ");
> +		}


hum, why isn't the histogram in the separate column? 
looks like there's lot of duplicated code in here 

thanks,
jirka

>  	} else {
> -		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
> -			  bi->start, bi->end, block_he->diff.cycles);
> +		if ((start_line != SRCLINE_UNKNOWN) &&
> +		    (end_line != SRCLINE_UNKNOWN)) {
> +			scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
> +				  start_line, end_line, block_he->diff.cycles);
> +		} else {
> +			scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
> +				  bi->start, bi->end, block_he->diff.cycles);
> +		}
> +
> +		ret = scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>  	}
>  
>  	free_srcline(start_line);
>  	free_srcline(end_line);
> -
> -	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
> +	return ret;
>  }

SNIP
