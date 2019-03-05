Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7204C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCEM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C01881F19;
        Tue,  5 Mar 2019 12:26:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id D8FDB60C7F;
        Tue,  5 Mar 2019 12:25:58 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:25:57 +0100
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
Message-ID: <20190305122557.GF16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 05 Mar 2019 12:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:41:44PM +0300, Alexey Budankov wrote:

SNIP

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

hum, why does this need the initial value?

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

is there a point to set this back in case of sync == true?
we are going out at this point, right?

jirka
