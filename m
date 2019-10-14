Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0136ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AF72083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSWuI0vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfJNOLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:11:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36178 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbfJNOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:11:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so25637485qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPqNisl9/8QhR/3iXJbzR+QEtNfA52rxWMvfvk5p5zc=;
        b=aSWuI0vRPOVGeRISG8BLLKfORFzmyEYzKkJMBuq7BCRTARwtZULQ8UbJ9yX0TvNxi/
         TMSJB/bPg9ODd9Im0S+l56qjZ5r6n4iQ+VhSG3HQRzpYrO2Xyi6Manupy+hEF2MJclNE
         slte3qL/nvtpdZUwmIU+3q/f0WKmgGPlePThjZ7ZAKyRwN4u8luWqNxFkkdM6wwpggSr
         pHMQrutyWjDmJW6BmMKmlXel6OsLOCPDbxTlLZDRDTdZVDLxED1u2xwIHS5/mTrdhGCQ
         fCsSuzSdWH/ndiomv3sW/rGi4jIyUQ52krIszORdr4+BVunABwCZVdgCQH8K+3zNZg4V
         AfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPqNisl9/8QhR/3iXJbzR+QEtNfA52rxWMvfvk5p5zc=;
        b=lA4+TaxyY9CW/rgdShjSXuZnqEzdTfHxsrUbIrpT2w11lGn+Rgf0yo5eCr0PLP8Occ
         zchJ8jwoZpRbv2FcGLIhhIHY1qwGPalkEnV0qKKoD7/VO6jrzatVXFx3qJ+Gt8Zg2x/U
         j5ecn0P/fLBDixpHofV4/d5OGlpwggC7+TN/4HZPv2enZn/l1HCst/FuKgdpXcuhBb9O
         TTbN87+eyow33hVnf4v8v/rQYdhHQvdWOzlwXR2QqWghVwJ8rPMEx0XM4LxXkg09YoBL
         TSAq/28AMo6D6gf9Q9sM4ToPGYJKPyyfnJ9DexRiEel6u+Lc3siRQu7aJ57xkA87Es7d
         /7iQ==
X-Gm-Message-State: APjAAAUuAMmfJIuYvkwwRDsZ45fTR2XocCLxJV32XQUV0LNZtBvU9h8Z
        a7c/GCnmCtug8i6ES6O9Jlw=
X-Google-Smtp-Source: APXvYqwbYzyiJbi1P52sPo+JYT0X6U0C5f4qZBL7L0+I2GaNY9kSzIfSOlHemPV8pCGZ3TZGVZUdtg==
X-Received: by 2002:ac8:5243:: with SMTP id y3mr13900733qtn.74.1571062299155;
        Mon, 14 Oct 2019 07:11:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w73sm8581241qkb.111.2019.10.14.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:11:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C8B14DD66; Mon, 14 Oct 2019 11:11:36 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:11:36 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Avoid infinite loop for task exit case
Message-ID: <20191014141136.GD19627@kernel.org>
References: <20191011091942.29841-1-leo.yan@linaro.org>
 <20191011091942.29841-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011091942.29841-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 11, 2019 at 05:19:42PM +0800, Leo Yan escreveu:
> When execute task exit testing case, Perf tool stucks in this case and
> doesn't return back on Arm64 Juno board.
> 
> After dig into this issue, since Juno board has Arm's big.LITTLE CPUs,
> thus the PMUs are not compatible between the big CPUs and little CPUs.
> This leads to PMU event cannot be enabled properly when the traced task
> is migrated from one variant's CPU to another variant.  Finally, the
> test case runs into infinite loop for cannot read out any event data
> after return from polling.
> 
> Eventually, we need to work out formal solution to allow PMU events can
> be freely migrated from one CPU variant to another, but this is a
> difficult task and a different topic.  This patch tries to fix the Perf
> test case to avoid infinite loop, when the testing detects 1000 times
> retrying for reading empty events, it will directly bail out and return
> failure.  This allows the Perf tool can continue its other test cases.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/task-exit.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index ca0a6ca43b13..d85c9f608564 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -53,6 +53,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  	struct perf_cpu_map *cpus;
>  	struct perf_thread_map *threads;
>  	struct mmap *md;
> +	int retry_count = 0;
>  
>  	signal(SIGCHLD, sig_handler);
>  
> @@ -132,6 +133,13 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  out_init:
>  	if (!exited || !nr_exit) {
>  		evlist__poll(evlist, -1);
> +
> +		if (retry_count++ > 1000) {
> +			pr_debug("Failed after retrying 1000 times\n");
> +			err = -1;
> +			goto out_free_maps;
> +		}
> +
>  		goto retry;
>  	}
>  
> -- 
> 2.17.1

-- 

- Arnaldo
