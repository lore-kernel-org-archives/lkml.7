Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05787C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3AC2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULcSYDYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgAGKGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:06:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726565AbgAGKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578391606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qzQU7dhwOvEyaAnJCUtjkpnmYEUK3rxKYOMsoAMpFpQ=;
        b=ULcSYDYeEtvzpBztr1WzZNJj7X7Id6hJo7lNiKalMdooQ+aiCN2jiVKpYGfcEi5WM2T1sA
        B2oQjRcrOuzAtdUimn8qxC99ioYtzZtii7xr2C7+DJV3nC6ay/ydrI/Wh5D4UrCxY2LO6A
        42zVD571YX5NyOnKTRS0BCW9fO5xDoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-P02HqLlCNmC1aBaNyVhL2g-1; Tue, 07 Jan 2020 05:06:43 -0500
X-MC-Unique: P02HqLlCNmC1aBaNyVhL2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81003477;
        Tue,  7 Jan 2020 10:06:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7606C272A1;
        Tue,  7 Jan 2020 10:06:39 +0000 (UTC)
Date:   Tue, 7 Jan 2020 11:06:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/3] perf util: Flexible to set block info output
 formats
Message-ID: <20200107100637.GE290055@krava>
References: <20200106194525.12228-1-yao.jin@linux.intel.com>
 <20200106194525.12228-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106194525.12228-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 03:45:24AM +0800, Jin Yao wrote:
> Currently we use a predefined array to set the
> block info output formats, it's fixed and inflexible.
> 
> This patch adds two parameters "block_hpps" and "nr_hpps"
> in block_info__create_report and other static functions,
> in order to let user decide which columns to report and
> with specified report ordering. It should be more flexible.
> 
> Buffers will be allocated to contain the new fmts, of course,
> we need to release them before perf exits.
> 
>  v2:
>  ---
>  New patch created in v2.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c  | 25 +++++++++++---
>  tools/perf/util/block-info.c | 64 ++++++++++++++++++++++++++----------
>  tools/perf/util/block-info.h | 12 +++++--
>  3 files changed, 76 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index de988589d99b..81ae1f862d11 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -104,6 +104,7 @@ struct report {
>  	bool			symbol_ipc;
>  	bool			total_cycles_mode;
>  	struct block_report	*block_reports;
> +	int			nr_block_reports;
>  };
>  
>  static int report__config(const char *var, const char *value, void *cb)
> @@ -503,7 +504,7 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>  		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
>  						 rep->min_percent, pos,
>  						 &rep->session->header.env,
> -						 &rep->annotation_opts);
> +						 &rep->annotation_opts, true);
>  		if (ret != 0)
>  			return ret;
>  	}
> @@ -536,7 +537,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>  		if (rep->total_cycles_mode) {
>  			report__browse_block_hists(&rep->block_reports[i++].hist,
>  						   rep->min_percent, pos,
> -						   NULL, NULL);
> +						   NULL, NULL, true);
>  			continue;
>  		}
>  
> @@ -966,8 +967,19 @@ static int __cmd_report(struct report *rep)
>  	report__output_resort(rep);
>  
>  	if (rep->total_cycles_mode) {
> +		int block_hpps[6] = {
> +			PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
> +			PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> +			PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> +			PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> +			PERF_HPP_REPORT__BLOCK_RANGE,
> +			PERF_HPP_REPORT__BLOCK_DSO,
> +		};

I'd understand this change if there was another place in the code using
this, but it's not part of this patchset.. is it comming later?

thanks,
jirka

