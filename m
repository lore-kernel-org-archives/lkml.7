Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B5BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8714A222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnAsK8+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505623AbfJRR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:57:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37353 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505601AbfJRR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:57:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so6102479qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJ2aFB6nVgWsoMS8qT6A8NRFs/E7OehjCvE9nzqVpn0=;
        b=KnAsK8+LQL8CZjLc5R3KZZTsYexKm3LyXuyrgL2GqbwBRHUoOY6CfuL8TFrxV7eg01
         u6K+KTxvJ7jNLQXxXDcyHKcUUsRAaLK/mODY5Tr1fZae1Jb9m3qVF+y/XazGbWzDathb
         vS8ZlVm2JuMOxqL2wqnhvpmify/9ct3piH45dMTUwcxSybklOL+NdzRKwveLpNcYB60S
         s/G4LAWmIDd8V8dGVKQovot5aM/GKLv/PY8XvY2jrOwmQv7x9hEvvMAK9KISXPI/K8kR
         KTlsme/nTsOsyupcZ1G/+KW0Vg8XqZ9CuAOKws3j9s+n3bQXwwgooTA4Z0ATX1/rF8Iw
         xvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJ2aFB6nVgWsoMS8qT6A8NRFs/E7OehjCvE9nzqVpn0=;
        b=KPBAo4MYLSOkFvxjK3PNHxDK8GhpvoL4FDwlBfnUwdqJgO8UjeVioL1dvmTWYMrl+/
         1lSo532UMSpmyPpoE4q+bm+2+CdG8YP3dw8kR5yQPupRT0YxnMPgLxCm6ZRAr7HxLE++
         G0iuHYOkTfcZppiAMmwpYF98V+940xLpZsorW685KS4WnfUY0HvMX6d9hVWT9Tg62xzN
         r7jXWzm2aDhtYUXs3up1PAzYKyfjLAllY9cA+VyfXEM/4of1pYPkOhNd73EbuejTk571
         nF/qkfZkCduXwS+Pk1CtDjPUpcKPE3Oj1wUbph6fsVxLP3omcR2p9K0b9e/OvcERr/23
         FufA==
X-Gm-Message-State: APjAAAVUndyfzkzEgzBn0DP9oEBcAd6z28ZThzCrins6MeM7jn3B4aBJ
        22htLFNZYmah1Byx+j+vphg=
X-Google-Smtp-Source: APXvYqz9HZ1sJ+p+UOH1Ymiy3rry3oUF7lIh5JfbCxrkzC+Uc1LFnVp1l8f/5WngevV+1l/cGNOlWA==
X-Received: by 2002:a05:620a:6cb:: with SMTP id 11mr1040134qky.123.1571421449486;
        Fri, 18 Oct 2019 10:57:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id x9sm2840888qkl.75.2019.10.18.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:57:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1E8E4DD66; Fri, 18 Oct 2019 14:57:21 -0300 (-03)
Date:   Fri, 18 Oct 2019 14:57:21 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf tests bp_account: Add dedicated checking
 helper is_supported()
Message-ID: <20191018175721.GB1797@kernel.org>
References: <20191018085531.6348-1-leo.yan@linaro.org>
 <20191018085531.6348-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018085531.6348-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 18, 2019 at 04:55:30PM +0800, Leo Yan escreveu:
> Arm architecture supports the breakpoint accounting but it doesn't
> support breakpoint overflow signal handling.  The current code uses the
> same checking helper, thus it disables both testings (bp_account and
> bp_signal) for arm platform.
> 
> For handling two testings separately, this patch adds a dedicated
> checking helper is_supported() for breakpoint accounting testing, thus
> it allows supporting breakpoint accounting testing on arm platform; the
> old helper test__bp_signal_is_supported() is only used to checking for
> breakpoint overflow signal testing.

Looks sensible,

Applied, thanks.

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/bp_account.c   | 16 ++++++++++++++++
>  tools/perf/tests/builtin-test.c |  2 +-
>  tools/perf/tests/tests.h        |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
> index 52ff7a462670..d0b935356274 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -188,3 +188,19 @@ int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_un
>  
>  	return bp_accounting(wp_cnt, share);
>  }
> +
> +bool test__bp_account_is_supported(void)
> +{
> +	/*
> +	 * PowerPC and S390 do not support creation of instruction
> +	 * breakpoints using the perf_event interface.
> +	 *
> +	 * Just disable the test for these architectures until these
> +	 * issues are resolved.
> +	 */
> +#if defined(__powerpc__) || defined(__s390x__)
> +	return false;
> +#else
> +	return true;
> +#endif
> +}
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 55774baffc2a..8b286e9b7549 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -121,7 +121,7 @@ static struct test generic_tests[] = {
>  	{
>  		.desc = "Breakpoint accounting",
>  		.func = test__bp_accounting,
> -		.is_supported = test__bp_signal_is_supported,
> +		.is_supported = test__bp_account_is_supported,
>  	},
>  	{
>  		.desc = "Watchpoint",
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 72912eb473cb..9837b6e93023 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -111,6 +111,7 @@ int test__map_groups__merge_in(struct test *t, int subtest);
>  int test__time_utils(struct test *t, int subtest);
>  
>  bool test__bp_signal_is_supported(void);
> +bool test__bp_account_is_supported(void);
>  bool test__wp_is_supported(void);
>  
>  #if defined(__arm__) || defined(__aarch64__)
> -- 
> 2.17.1

-- 

- Arnaldo
