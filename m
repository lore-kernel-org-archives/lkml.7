Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18457C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D922CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0VKT3h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfGZTcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:32:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45929 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfGZTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:32:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so48810777qtp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jzVm99eEtizQN6p2EIQIgw3QNYuQc0g370x6MvZrtQI=;
        b=S0VKT3h/856Z2rc5kuch8uu2y3nzzOKS/LJUN5Ys54AOJpRGQS+VCwRuHZsaJ13hIc
         6qGaAIlbCVHo1M+LLmF9MiqTitRH3+f7E3u8jmfOoOmYm1DiSmxUbkyBueCZ/Tt6vW6Z
         YxFtIR4FSLemNOD4EvQySD7FwF2PEzxCehZv7LGtUsZMJtPf68TEhDAR/WR6iKmgKWCk
         DUG/LA2Vrij/4Y8aYg0iU6hYY2GYQJ8ORCU8aFwo+/JjTDPgRlbdvRrZvPt9gJc7/hZm
         oTLMSFAK3nOCgNcFSFUyMzqD0QQWm/2LoVdFrnxyMKJpASH+60WsCSS6SD+ThsA0f9TR
         r0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jzVm99eEtizQN6p2EIQIgw3QNYuQc0g370x6MvZrtQI=;
        b=RTQZNrk5GDYdl5tEIRaNwf50+48FpksCkeHn2Fl6irkIDi6nY55i7yRciVHzcjdIlS
         p/cMnNTYv5NMP02irGaJBzVUdrkc3yGtiP8ZZmvGVStOG09qm3g/FT44It/CI0zZmzZ1
         Us2M3HwNawyUEdgin53e6NrqqKq+HqU6Ty/HZKTpMDpCgooq9KzJ+2hTHDUwl0J64qQa
         499e4IDfGLSGWN9cES5+VTvatC94CfWRfVlgkjxu24IAOcFJ+eAa0npMkb9Un7EbF0Xy
         hx/eOPpOvPBbAsF8dr9M8DAFYi8JkhQhyJ0z+JMtVJx/iBgPbfJv/pglRuHyAyoO9I3A
         kJqQ==
X-Gm-Message-State: APjAAAUONuDUe8Z7aBZefGDHmoGm1iNa7vzPCJ1JiV9hUFDb1zGQhH8/
        upeT8R0rXqQ0AfzZuobhuZwN2PSO
X-Google-Smtp-Source: APXvYqzQ4nqqU7KemoIxOEToVwLIhnjwwQv1XXfZqEDv4GXQ734zp1exqRUhniAfBrGVqgJ+7Jqq9Q==
X-Received: by 2002:a0c:818f:: with SMTP id 15mr65788290qvd.162.1564169550222;
        Fri, 26 Jul 2019 12:32:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id s127sm23713157qkd.107.2019.07.26.12.32.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:32:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E5F840340; Fri, 26 Jul 2019 16:32:27 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:32:27 -0300
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 3/3] Fix sched-messaging.c use of uninitialized value
 errors
Message-ID: <20190726193227.GH20482@kernel.org>
References: <20190724234500.253358-1-nums@google.com>
 <20190724234500.253358-4-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724234500.253358-4-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 04:45:00PM -0700, Numfor Mbiziwo-Tiapo escreveu:
> Our local MSAN (Memory Sanitizer) build of perf throws use of
> uninitialized value warnings in "tools/perf/bench/sched-messaging.c"
> when running perf bench.
> 
> The first warning comes from the "ready" function where the "dummy" char
> is declared and then passed into "write" without being initialized.
> Initializing "dummy" to any character silences the warning.
> 
> The second warning comes from the "sender" function where a "write" call
> is made to write the contents from the "data" char array when it has not
> yet been initialized. Calling memset on "data" silences the warning.

So, this is just to silence MSAN, as it doesn't matter what is sent,
whatever values are in those variables is ok, as it will not be used,
right?

- Arnaldo
 
> To reproduce this warning, build perf by running:
> make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
>  -fsanitize-memory-track-origins"
> 
> (Additionally, llvm might have to be installed and clang might have to
> be specified as the compiler - export CC=/usr/bin/clang)
> 
> then running: tools/perf/perf bench sched all
> 
> Please see the cover letter for why false positive warnings may be
> generated.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/bench/sched-messaging.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index f9d7641ae833..d22d7b7b591d 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -69,7 +69,7 @@ static void fdpair(int fds[2])
>  /* Block until we're ready to go */
>  static void ready(int ready_out, int wakefd)
>  {
> -	char dummy;
> +	char dummy = 'N';
>  	struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };
>  
>  	/* Tell them we're ready. */
> @@ -87,6 +87,7 @@ static void *sender(struct sender_context *ctx)
>  	char data[DATASIZE];
>  	unsigned int i, j;
>  
> +	memset(data, 'N', DATASIZE);
>  	ready(ctx->ready_out, ctx->wakefd);
>  
>  	/* Now pump to every receiver. */
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
