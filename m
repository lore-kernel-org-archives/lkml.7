Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E0FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524A8217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwKiejIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfKGCEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:04:52 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43408 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:04:52 -0500
Received: by mail-yw1-f68.google.com with SMTP id g77so79887ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTT0dMOEqgZW1kV1sG/4ggHTaPX+X0/vvJoLumgE0QE=;
        b=nwKiejIONICC8a1e9UtTPzcvwk33OVhxyR+rHFggtmA7ta4wqFG7X0xpOIh3EMbknq
         pBuwvexBQSGPn0PK9n2GPanJdAApK6v07KUs6+B3T/iB8Mu6UePWuvaOZn/DzFEXVsA1
         ZQyXE4QbIVSjaiaAkZbJ3xwuh9LM+hOPXx1LxQ/O0TbBbhH9/FwgoytOgCuwOI0JaAHh
         tRIeodQncd1GOIHhwAQn/9v2S39MY6cgIErsyXqw2gYNPu0iQZz99NPClFl0U+c8TPpu
         NXFdv4O2zU25BBM/4/RaiK8bz8wxz3giHN50/eaMzT0tCOXaddlcrS1rEhF3beOeOaZl
         y6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTT0dMOEqgZW1kV1sG/4ggHTaPX+X0/vvJoLumgE0QE=;
        b=Zuda7/ebWoyWj+O1ywb8TH34yrp0SOw8HkTZn0Xzph3ins0ufCASTPWhrCLyvo7gW9
         haW55BdKDPIhdsBVMfXaASUQ9Ru5N5gv62h+WOQ9wqqfhyRb6nNjJm97wawUPcgndhFx
         8YcKOPB3k/qLpEP6akTyauf8w2xSs2KFGkafw/c80y7Y4xxMVfmvNOyqKQSaNW+TMC68
         av3tiEUYhWpD7MPnRRCcxjSFMq/G9s7K3hMdg6262AC3h6WVInNcN22Spq0ClSRmufZD
         xeDigdkqoBJpP6JqrMCYqQN7678ObPH/PL7c3YEoxWZetcygboY7hqndHCswt4hCjOOf
         ip/A==
X-Gm-Message-State: APjAAAW/C7bZgGKIIspwLnDC6DvQ02y3wuvPDj5C8cMY1HLN72bDGAy+
        ea5C8XxacO/PgDwxV51zXL2l7w==
X-Google-Smtp-Source: APXvYqys4FxqHT5i0B3nU82yxh98o0yA9kOe7QL961oJ6FlDBIoVownZx2JzOa8BV0xtygbcyKtOZg==
X-Received: by 2002:a81:8ac4:: with SMTP id a187mr525991ywg.87.1573092289701;
        Wed, 06 Nov 2019 18:04:49 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id z16sm172524ywj.93.2019.11.06.18.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 18:04:49 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:04:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] perf tests: Fix out of bounds memory access
Message-ID: <20191107020443.GC12850@leoy-ThinkPad-X240s>
References: <20191107014848.30008-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107014848.30008-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:48:48AM +0800, Leo Yan wrote:
> The test case 'Read backward ring buffer' failed on 32bit architectures
> which were found by LKFT pert testing.  The test failed on arm32 x15
                           ^^^^
                           s/pert/perf

Sorry for typo and spamming, I sent patch v2 for reviewing.

Thanks,
Leo Yan

> device, qemu_arm32, qemu_i386, and found intermittent failure on i386;
> the failure log is as below:
> 
>   50: Read backward ring buffer                  :
>   --- start ---
>   test child forked, pid 510
>   Using CPUID GenuineIntel-6-9E-9
>   mmap size 1052672B
>   mmap size 8192B
>   Finished reading overwrite ring buffer: rewind
>   free(): invalid next size (fast)
>   test child interrupted
>   ---- end ----
>   Read backward ring buffer: FAILED!
> 
> The log hints there have issues for memory usage, thus free() reports
> error 'invalid next size' and directly exit for the case.  Finally, this
> issue is root caused as out of bounds memory access for the data array
> 'evsel->id'.
> 
> The backward ring buffer test invokes do_test() twice.  'evsel->id' is
> allocated at the first call with the flow:
> 
>   test__backward_ring_buffer()
>     `-> do_test()
> 	  `-> evlist__mmap()
> 	        `-> evlist__mmap_ex()
> 	              `-> perf_evsel__alloc_id()
> 
> So 'evsel->id' is allocated with one item, and it will be used in
> function perf_evlist__id_add():
> 
>    evsel->id[0] = id
>    evsel->ids   = 1
> 
> At the second call for do_test(), it skips to initialize 'evsel->id'
> and reuses the array which is allocated in the first call.  But
> 'evsel->ids' contains the stale value.  Thus:
> 
>    evsel->id[1] = id    -> out of bound access
>    evsel->ids   = 2
> 
> To fix this issue, we will use evlist__open() and evlist__close() pair
> functions to prepare and cleanup context for evlist; so 'evsel->id' and
> 'evsel->ids' can be initialized properly when invoke do_test() and avoid
> the out of bounds memory access.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/backward-ring-buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
> index 338cd9faa835..5128f727c0ef 100644
> --- a/tools/perf/tests/backward-ring-buffer.c
> +++ b/tools/perf/tests/backward-ring-buffer.c
> @@ -147,6 +147,15 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
>  		goto out_delete_evlist;
>  	}
>  
> +	evlist__close(evlist);
> +
> +	err = evlist__open(evlist);
> +	if (err < 0) {
> +		pr_debug("perf_evlist__open: %s\n",
> +			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		goto out_delete_evlist;
> +	}
> +
>  	err = do_test(evlist, 1, &sample_count, &comm_count);
>  	if (err != TEST_OK)
>  		goto out_delete_evlist;
> -- 
> 2.17.1
> 
