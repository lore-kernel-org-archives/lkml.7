Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B907C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631902133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl564Nka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfB1Sr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:47:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39633 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfB1Sr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:47:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so24734895qtk.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tt6kAMg4DFGOQwaZs0E2ssxxVm9xqyADtQ6L2GzqsdA=;
        b=Gl564NkajcVZsQQ01ubn97ilKoLuSQgmkL1cBnOPq9MAQGnqiTbLFnzklqrza8l8aM
         AbXXeDBqZ3vsQvPLWNr2eCot+zxUL0BuFwQWcBbYK0ggtctXsm8lZ5X0x1oxOi2x12me
         GuMy9Ms3hMfi2uucyYcwiruuI0uR4jEzH8JuYHLJ4WfFb/w8eO0wgn50GRbmXoxWY7Ul
         eb52iLhZ2xSbmnMSOkd/3GXynVxHiG+mdZ9lB3//PoVLmwdZxvrfhYBdknCthDTn9ksW
         hSQj3edMQg4f3q6RFmfLUsiij3F71t2iYxI4lpa/cFfwtsRDLVebOvAVyfTZvfRx3Cym
         WZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tt6kAMg4DFGOQwaZs0E2ssxxVm9xqyADtQ6L2GzqsdA=;
        b=jY3d7Qdupn56fERHCWvNRdmxdKgQQWjcR10iUZXwok9ssVfviiZncM4REs4vU5urrC
         CyJgoZvQUmaxWtFrJLLiH0BiIsYepS7AuiLg6R9snj1jYnMmv7vnBm6EZl4EEhhAx56X
         oz5nka+Dsju966/zsx27uS35g9Tv1+g+4/mNX8UoEWwEcYKXfl8EkkfhvKVlabU2SQjM
         Ret7xiEOT+jO14o4lQiUMMyaNNJIKbHjUtIahWcWIIMmkd0156nMAu4h/t+CTewGyCSC
         lq24AVxto9qsjbglSjdauIc1zDbfRJHAj1XQMad4q6AHqIS1m5WmN7KJaAI2onDLhE+Q
         8tpQ==
X-Gm-Message-State: APjAAAVwPmUKpwEl2FRtsXdyCjSM3Jm+002GfLlw14imyLgC+cYu4gPX
        Jof/Q9vMtbmgagkELN8XXXQ=
X-Google-Smtp-Source: APXvYqzFBrvjjfWk71bDIBkAN/hNAtAxelqOVwvXI3kg3/dKk6RtefDIrAfWxJ4ZokrVcM5CdQgBdQ==
X-Received: by 2002:a0c:b05a:: with SMTP id l26mr538188qvc.40.1551379647150;
        Thu, 28 Feb 2019 10:47:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m42sm14161390qtb.63.2019.02.28.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:47:26 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 454344039C; Thu, 28 Feb 2019 15:47:24 -0300 (-03)
Date:   Thu, 28 Feb 2019 15:47:24 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] perf session: define bytes_transferred and
 bytes_compressed metrics
Message-ID: <20190228184724.GG9508@kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <914ab056-1488-2b05-8d2a-aa530c01d334@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <914ab056-1488-2b05-8d2a-aa530c01d334@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 12:02:09PM +0300, Alexey Budankov escreveu:
> 
> Define bytes_transferred and bytes_compressed metrics to calculate
> comp_ratio=transferred/compressed in the end of the data collection.
> 
> bytes_transferred accumulates the amount of bytes that was captured from
> the mmaped kernel buffers for compression. bytes_compressed accumulates
> the amount of bytes that was received after applying compression to
> move to a storage.

Where is the code that updates these metrics? Follow up patch?
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 8 ++++++++
>  tools/perf/util/env.h       | 1 +
>  tools/perf/util/session.h   | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 61818cbce443..6d78a7720698 100644
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
> +		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
> +			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
> +	}
> +
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

-- 

- Arnaldo
