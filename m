Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4647EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13081222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6jds7wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfIZPYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:24:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45966 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIZPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:24:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so3286268qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRMtahzZaS317ydZu6zP9hU9Uft5Q7Gg/uXverRsTDI=;
        b=L6jds7wjJ6rGQVFP/NMPnfMT6Qx8UympuyaEL0on40XNkxBuQZdycNp/n6yAZFqGbb
         Fdx95IQ5Gd/xNnut4GryuuX16Sc46t46Ccdzz3Kf6I1hdJsgJvSsQ9FgnKJ731uc4P8p
         0SidU4qVada1RM/mdwIVbMzdRhpLB2ZByTscHaPlasqtDwyXgXxTj8U/Oy/McRkANPyB
         sneS3MPRRLzSTsfHQJAehmjNNTLYJIi/bzrZWm8yPYcC1TE/o8v4QCOYpsUmE5nBQs00
         8KxW1dOTMTXSCio9/uSOosLewn5y/rBExrsSlYYHEM6igvFalpcsdUJi8LmaFQJDRigt
         g9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRMtahzZaS317ydZu6zP9hU9Uft5Q7Gg/uXverRsTDI=;
        b=gjnp/mSA4bhUbS7bOJD5ds2sxEi4WI8JjZeKPAywnFbWCBpdXfoKnlLQ4mKcoNL3bh
         ChvMtnBmpKKgFrK8I62LagNHMbqL/S6i83o1kBJkvggpr0sXI1HMGAxJLb3LzJW8URN5
         FtLr+yigiMmzTmWFihCPwElMZhx/r1mse+TWdeaRmP04IhoI+HQ9XMCpd1JeK7d0xXJV
         KAmrpZUGVxzy2r6eVJ+5sr/MpoqdQ5H0K4kqxHXs0c0FSjRS3bd1b+SII5fn884Dpy0P
         Cca6DBbGtumZxdsfb3ngBGTODugA75dh4UPWq16xui/cd//tuMrm9GCgcRJS7Tj9iAly
         pFkw==
X-Gm-Message-State: APjAAAXl2SWrHd5oA+q5HABeCEpKcz+2Om8UUCXZ+fl/eJYReJU+Ly1p
        oHtxQpBQYJki6t8rw8SagLk=
X-Google-Smtp-Source: APXvYqx7RyptnqymzB0HhHx3k0IoSqRWOdLV4TYDxrMHlQjw+ncN46PfKKuOhdCyKMXK38DL5V8gJg==
X-Received: by 2002:a0c:9638:: with SMTP id 53mr3202541qvx.13.1569511463902;
        Thu, 26 Sep 2019 08:24:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i25sm1081901qkk.30.2019.09.26.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 08:24:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE60240396; Thu, 26 Sep 2019 12:24:19 -0300 (-03)
Date:   Thu, 26 Sep 2019 12:24:19 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] Avoid raising segv using an obvious null dereference
Message-ID: <20190926152419.GD10129@kernel.org>
References: <20190925195924.152834-1-irogers@google.com>
 <20190925195924.152834-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925195924.152834-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 25, 2019 at 12:59:24PM -0700, Ian Rogers escreveu:
> An optimized build such as:
> make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-O3
> will turn the dereference operation into a ud2 instruction, raising a SIGILL
> rather than a SIGSEGV. Use raise(..) for correctness and clarity.
> 
> Similar issues were addressed in Numfor Mbiziwo-Tiapo's patch:
> https://lkml.org/lkml/2019/7/8/1234

Added:

Cc: Numfor Mbiziwo-Tiapo <nums@google.com>

And:

Cc: Wang Nan <wangnan0@huawei.com>
Fixes: a074865e60ed ("perf tools: Introduce perf hooks")

And:

Committer testing:

Before:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17092
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]# 

After:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17909
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]#


 ----------------------------------------------------------------------------

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/perf-hooks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
> index dbc27199c65e..dd865e0bea12 100644
> --- a/tools/perf/tests/perf-hooks.c
> +++ b/tools/perf/tests/perf-hooks.c
> @@ -19,12 +19,11 @@ static void sigsegv_handler(int sig __maybe_unused)
>  static void the_hook(void *_hook_flags)
>  {
>  	int *hook_flags = _hook_flags;
> -	int *p = NULL;
>  
>  	*hook_flags = 1234;
>  
>  	/* Generate a segfault, test perf_hooks__recover */
> -	*p = 0;
> +	raise(SIGSEGV);
>  }
>  
>  int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
> -- 
> 2.23.0.351.gc4317032e6-goog

-- 

- Arnaldo
