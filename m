Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A132082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfCEMZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:25:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfCEMZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:25:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6D4D59458;
        Tue,  5 Mar 2019 12:25:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 11EBC60A9A;
        Tue,  5 Mar 2019 12:25:41 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:25:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
Message-ID: <20190305122541.GC16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 05 Mar 2019 12:25:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:41:44PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f3f7f3100336..9b02a68e8c23 100644
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

if there's point in this config option, pelase make it
configurable as the other size options we have with
the B/K/M suffixes

jirka
