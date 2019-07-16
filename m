Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1EC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08EC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfGPJKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfGPJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23CD3307CDEA;
        Tue, 16 Jul 2019 09:10:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C4BD100164A;
        Tue, 16 Jul 2019 09:10:39 +0000 (UTC)
Date:   Tue, 16 Jul 2019 11:10:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        songliubraving@fb.com, mbd@fb.com, linux-kernel@vger.kernel.org,
        irogers@google.com, eranian@google.com
Subject: Re: [PATCH] Fix perf test data race for tsan build
Message-ID: <20190716091039.GE22317@krava>
References: <20190710221620.211059-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710221620.211059-1-nums@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 09:10:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 03:16:20PM -0700, Numfor Mbiziwo-Tiapo wrote:
> The tsan build of perf gives a data race warning in

hi,
what's 'tsan build of perf' ?

thanks,
jirka


> mmap-thread-lookup.c when perf test is run on our local machines.
> This is because there is no lock around the "go_away" variable in
> "mmap-thread-lookup.c".
> 
> The warning is difficult to reproduce from the tip branch and we
> suspect it has something to do with tsan working differently
> depending on the clang version.
> 
> The warning can be silenced by adding locks around the variable
> but it is better practice to make the variable atomic and use
> the atomic_set and atomic_read functions. This does not actually
> silence the warning because tsan doesn't recognize the atomic
> functions as thread safe, but in actuality it should prevent a
> data race.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/tests/mmap-thread-lookup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index 5ede9b561d32..f4cbb3d92a46 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -17,7 +17,7 @@
>  
>  #define THREADS 4
>  
> -static int go_away;
> +static atomic_t go_away;
>  
>  struct thread_data {
>  	pthread_t	pt;
> @@ -64,7 +64,7 @@ static void *thread_fn(void *arg)
>  		return NULL;
>  	}
>  
> -	while (!go_away) {
> +	while (!atomic_read(&go_away)) {
>  		/* Waiting for main thread to kill us. */
>  		usleep(100);
>  	}
> @@ -98,7 +98,7 @@ static int threads_create(void)
>  	struct thread_data *td0 = &threads[0];
>  	int i, err = 0;
>  
> -	go_away = 0;
> +	atomic_set(&go_away, 0);
>  
>  	/* 0 is main thread */
>  	if (thread_init(td0))
> @@ -118,7 +118,7 @@ static int threads_destroy(void)
>  	/* cleanup the main thread */
>  	munmap(td0->map, page_size);
>  
> -	go_away = 1;
> +	atomic_set(&go_away, 1);
>  
>  	for (i = 1; !err && i < THREADS; i++)
>  		err = pthread_join(threads[i].pt, NULL);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
