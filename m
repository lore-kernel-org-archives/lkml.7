Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724AC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA81F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnAwrnQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJKOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:38:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38632 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfJKOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:38:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so14177969qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kC6tRrQSq+U5wVR80DlQ4qp9ZXmbi64kvO32OghQf7A=;
        b=qnAwrnQgcmLQ+Fk2BGmhAB4jF/lr9XuLxBbmiAg+o+3IrZnIBzJDWoZXEPD69eWYue
         XjEoU2s6KzprJUWFnNiJh9IPBKiW9iyMFrAnqgMHT7QTQ1zOnezSwKU7tjn8Yv9aT8CR
         3rA3qcy7Gm94hNqzWPFL5zU+TSYoioG0329Jw8V6jS5W8SSQCmiCuSGSHF9BoVKFok0O
         gaDN4ZFd2lgYm+tYeOSCvo01SsSOsNvaL7SNyybB4HS18sZ12xuJ3dwoEBb3Nus9QiKD
         scsxioexObiAewHmoi0H9wIb9Q0f9owbsSTjqf7S2RGLwoSP2uEY4e3d8pcGY4llqhsU
         svCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kC6tRrQSq+U5wVR80DlQ4qp9ZXmbi64kvO32OghQf7A=;
        b=f5VSDHhOxLl5sJMazTRdqoxZMX26YhI8MSHSdJScMusbFlm0WC4gps89Q2dog26s44
         OjMWLH5FzD+rVXrj3hcGBKH17rk7BLRbMmveiLYOtDUPzTSN5cbh80CwxxhfsMd0g9sC
         0Gl12xeQlPErKV0eMwvW8/Z2yuTfwzqfxFQCkVJoijVFAvl3frguzAnMXdDBLqIYn2Ip
         fRaO7AayqI+uOwhQLvY8W3ckteLG+/dIuOdADNx/3OZDobhnaBuXEl2UZsS0DrwEbZ9O
         hpns+OyuhA9lQfJdGVA+fwUwPaxHW6xGDdmuQsixbfXaj2X6AhGwKKIHUJyCbRmy3F5T
         CruA==
X-Gm-Message-State: APjAAAUZAatbdKhr2XRdLXOJvF4Or7yx7IYaO645ExB/k9g5w+zC1dU7
        F/cAIyrXPoL6yFv8C9Qz9xE=
X-Google-Smtp-Source: APXvYqyeGe5VIm8U6UK/rwgLW9tmWUNSy4P2MQBlBs3d22PbmkGcYAs5uQi9Fa3ndHHdeBKrsb1AMQ==
X-Received: by 2002:a05:6214:18f:: with SMTP id q15mr16177473qvr.129.1570804687085;
        Fri, 11 Oct 2019 07:38:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c14sm4690836qta.80.2019.10.11.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:38:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 83F1E4DD66; Fri, 11 Oct 2019 11:38:03 -0300 (-03)
Date:   Fri, 11 Oct 2019 11:38:03 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Avoid infinite loop for task exit case
Message-ID: <20191011143803.GB32176@kernel.org>
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

Thanks, I'll go over this after I finish the current pull request,

- Arnaldo
 
> Eventually, we need to work out formal solution to allow PMU events can
> be freely migrated from one CPU variant to another, but this is a
> difficult task and a different topic.  This patch tries to fix the Perf
> test case to avoid infinite loop, when the testing detects 1000 times
> retrying for reading empty events, it will directly bail out and return
> failure.  This allows the Perf tool can continue its other test cases.
> 
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
