Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51AD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCEM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8567307D764;
        Tue,  5 Mar 2019 12:26:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 205094129;
        Tue,  5 Mar 2019 12:26:04 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:26:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
Message-ID: <20190305122604.GG16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <cc16317a-87f0-7abe-69a6-31394d32dda7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc16317a-87f0-7abe-69a6-31394d32dda7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 05 Mar 2019 12:26:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:43:28PM +0300, Alexey Budankov wrote:
> 
> Define bytes_transferred and bytes_compressed metrics to calculate
> comp_ratio=transferred/compressed in the end of the data collection.
> 
> bytes_transferred accumulates the amount of bytes that was extracted from
> the mmaped kernel buffers for compression. bytes_compressed accumulates
> the amount of bytes that was received after applying compression to
> move to a storage.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 8 ++++++++
>  tools/perf/util/env.h       | 1 +
>  tools/perf/util/session.h   | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9b02a68e8c23..ab121bc27c6d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1449,6 +1449,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	record__mmap_read_all(rec, true);
>  	record__aio_mmap_read_sync(rec);
>  
> +	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
> +		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
> +
> +		session->header.env.comp_ratio = ratio + 0.5;

what's the + 0.5 for?

> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
> +	}
> +

could this be below together with the current:

	fprintf(stderr, "[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",

thanks,
jirka

>  	if (forks) {
>  		int exit_status;
>  
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d01b8355f4ca..fb39e9af128f 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -64,6 +64,7 @@ struct perf_env {
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
>  	u64                     clockid_res_ns;
> +	u32                     comp_ratio;
>  };
>  
>  extern struct perf_env perf_env;
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index d96eccd7d27f..0e14884f28b2 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -35,6 +35,8 @@ struct perf_session {
>  	struct ordered_events	ordered_events;
>  	struct perf_data	*data;
>  	struct perf_tool	*tool;
> +	u64			bytes_transferred;
> +	u64			bytes_compressed;
>  };
>  
>  struct perf_tool;
> -- 
> 2.20.1
> 
