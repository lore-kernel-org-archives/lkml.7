Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0220863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjgu8vSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCRQQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:16:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38744 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfCRQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:16:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id s1so18575125qte.5;
        Mon, 18 Mar 2019 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q3ou9Dxhuvf5KRW1H+9oyeG4WWjqEolSQ1k7nE0+tyE=;
        b=Gjgu8vSrBe/LixfR2hHR22e+zgDVdNuyrYMR9cgkvOASYmg9LIElVQvwuOc7FGu2j8
         830hoHwmS5HPWlAcD5iJL1P/x+V4TKwvmo99UmWqP2dR7N3leTmoU2UWYqAwJwmPx7me
         TRoaq5swE8vSxm1f/mXaENONRJ7tcPbhiBjHZYKAAXr5/fl3hZ5Vjn180rO6JVFR5pz0
         9pAjTM3ujHoPlVaTO10PjcwEyQcb7AAjIhsWGpdUilLjKHQWEieda1ptnrfGIa7AyqaT
         2o9s54CZMqC6zgccEF77xNy5PR7yco9t2IFJN+aXbW2nH5U7qPJDl9O/USI3po5Qvget
         M+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3ou9Dxhuvf5KRW1H+9oyeG4WWjqEolSQ1k7nE0+tyE=;
        b=Xtz2fQBApTmgNsAYtmBDmLtshzV4T7jhYUdhMveKOWA9tBuAn27+Bo/Lfd33caseDt
         tSTZ3dko49GfKbCt68s4eyH24Pmcmxklx5dpMaYnlHavNWWlT84Q+V0myu4gl9/Sz21m
         zy/HIEM+PLgSnYbgbAyq/DKRL+rVCvKcV3FKyw09pljEmi8EtZHznxPMJWuGAwfAKBRc
         GKzLdRJO615L2BxSUSnjuBXn95qQRpbzJMK+4iuuzgu8kp+S898lPkaucwr8ZclK3N/V
         N5h6mxD543qFqyTrhwEUfFzXo2NpGxh56cYD509o0pSTHgHKKbEVy4rrxSIIMCTk4Ovu
         78Cw==
X-Gm-Message-State: APjAAAV3M4pG8su7LzUbsPBpmJPWNFCrR+3mWoSY5ob9U6l6YaHE6eai
        6lWLGFLuHRT5dKAWlPYwbCU=
X-Google-Smtp-Source: APXvYqy4k1gQ20W6D/FLG3xgTZnJMtiGCp4VSgU+f7tliz6INdriTsYAkqA9uNn7zioF4s1oEMtNLQ==
X-Received: by 2002:a0c:a424:: with SMTP id w33mr13710010qvw.5.1552925784633;
        Mon, 18 Mar 2019 09:16:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-164-38.3g.claro.net.br. [179.240.164.38])
        by smtp.gmail.com with ESMTPSA id p46sm3439639qtc.41.2019.03.18.09.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 09:16:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 833F44039C; Mon, 18 Mar 2019 13:16:19 -0300 (-03)
Date:   Mon, 18 Mar 2019 13:16:19 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/16] fix some perf issues detected by ASan
Message-ID: <20190318161619.GD22548@kernel.org>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190318100812.GC28556@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318100812.GC28556@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 18, 2019 at 11:08:12AM +0100, Jiri Olsa escreveu:
> On Sat, Mar 16, 2019 at 04:05:40PM +0800, Changbin Du wrote:
> > AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> > very useful tools to detect program bugs. This series fixed some issues
> > disclosed by ASan.
> > 
> > AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
> > such as buffer overflows or memory leaks.
> >   $ cd tools/perf
> >   $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
> >   $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
> > ASan outputs all detected issues into log file 'asan.log.<pid>'.
> > 
> > Note that this only fixes parts of the detected issues. There are many remaining
> > to be fixed[1].
> > 
> > [1] http://104.238.181.70:8080/asan.log.32555.txt
> > 
> > Changbin Du (16):
> >   perf: add doc for how to build perf with Asan and UBSan
> >   perf: list: fix memory leak in function is_event_supported
> >   perf: fix errors under optimization level '-Og'
> >   perf: fix an error in config template
> >   perf: fix a memory leak in collect_config
> >   perf: fix memory leak in print_sdt_events()
> >   perf: top: fix heap-use-after-free issue
> >   perf: top: fix error handing in cmd_top()
> >   perf: missed a map__put() in error case
> >   perf: remove map from names tree in __maps__remove
> >   perf: purge all maps from the names tree
> >   perf: top: fix global-buffer-overflow issue
> >   perf: free all counts in perf_evsel__exit
> >   perf: fix a memory leak of cpu_map object
> >   perf: fix memory leak by expr__find_other
> >   perf: fix a memory leak in test__perf_evsel__tp_sched_test
> 
> awesome.. thanks a lot
> 
> Reviewed-by: Jiri Olsa <jolsa@redhat.com>

Yeah, I'll go over all and apply, thanks a lot.

If you plan to work on the others, please first submit the ones that are
not related to the exit path, i.e. leave the ones that only take place
when exiting perf for a second batch, this way we'll get the more
important ones, that take place in normal operation, first.

- Arnaldo
