Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D99C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F191A21850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574164841;
	bh=bwF8tJSNCgGugotzFwiYlS8GtgXDJCaX9YcwUK4dU9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cMHob8wt0fN1h0VFV/N2WM7I4IFlLboOuw5MvAErTu5rGI6I/kl5FSoLtlM+QleCy
	 f+0wmnOxx1y/SO4ovEyyRg+jWs4MkjsvX8NUC61A/qae9U7Gmy5P7oCt9MFTDVYuPx
	 l5AinmCbmH+er76axcNw+2tIV6TFOtQaQ9QmV8W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfKSMAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:00:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKSMAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:00:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so23496732wrv.4;
        Tue, 19 Nov 2019 04:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gwo5bbL+meftkwOd1ihXthir89OCQ1iqb96C338NHqE=;
        b=h47+5ln/AG6r+7Wbkh0O5bMrYiD7HFTudRZqtO6NGUDyoveRSD3C2YNiTFNIswD2dz
         wfomlzcRidMFkbHLF8Evdex7b/4jmqGAMmQjoY++lahKGgwQz4Zew45xv/dki3wOgXuh
         6KZHgMemKYDKrCqok2aQ3CvrCf85mOpC16DzO0OC1fOUZry1f+EzJ4W0YyRDzvwYkoWV
         xNcmSQOo4a3os70KI7hByv1IJBnpoLb9WX7BWPU5oZmXs7M7KcroLl0XpcRgUVaGtf0a
         9ucOeqOpLa+UuzKNfEGo3ZXgN/GwQq5Jqn0gsxMIOjMaKXYUDF4ixX/QpYGuSPKXsR0Z
         8r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gwo5bbL+meftkwOd1ihXthir89OCQ1iqb96C338NHqE=;
        b=RP6YfQtSgjQkYWD9oWnMcLr8FI79evnYsIXHMKABB/eI5sAX4t9zd/E1Vv1NCxoghb
         cvaXQ9xXNaHvBzj8WiULkSwFXEkhFhW7IKR7a6UZ+IWVme6OHDO63/yxDHhHi98XPZt+
         Z8SrisLHikH80DOxobMxSWT9cF9cyLd1Vb+ZDfh9IOJqkAULZMWPm10N4IU1jObvt0tq
         rEp/RX4SuOnIHl8+h1m55bttHLrlJSnPuXT7ec+5icYEh+XWfdJTt6LUkLRasuIRu818
         u5YPTKWD7XnibkMGXuZ/z/FxgIoenN6QH9upy+kf/qHnXv8QhCDDFPfxlQrPfQuZw1yV
         EZ3w==
X-Gm-Message-State: APjAAAXwcm2APC/tgMdVOY6Oyngnb+XfJ5KA/VszXX4Ed6cjrSiCHWm1
        kJkZl+/UxGs2yRFgLwOQovk=
X-Google-Smtp-Source: APXvYqxg13mUOhNjrks21lekepc6pB5Aajvl+K+Nne/SarClwXI9DMS3HUbwvoSgfE9XAdFdpZq3FQ==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr39563224wrc.9.1574164837340;
        Tue, 19 Nov 2019 04:00:37 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g11sm2899250wmh.27.2019.11.19.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:00:36 -0800 (PST)
Date:   Tue, 19 Nov 2019 13:00:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20191119120034.GA124098@gmail.com>
References: <20191119113245.19593-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> 
> The following changes since commit e1e9b78d3957a267346a86c8f2c433f6a332af65:
> 
>   perf parse: Use YYABORT to clear stack after failure, plugging leaks (2019-11-12 08:34:16 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191119
> 
> for you to fetch changes up to a910e4666d61712840c78de33cc7f89de8affa78:
> 
>   perf parse: Report initial event parsing error (2019-11-18 19:14:29 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> x86/insn:
> 
>   Adrian Hunter:
> 
>   - Add some more Intel instructions to the opcode map:
> 
>         cldemote, encls, enclu, enclv, enqcmd, enqcmds, movdir64b,
>         movdiri, pconfig, tpause, umonitor, umwait, wbnoinvd.
> 
>   - The instruction decoding can be tested using the perf tools'
>     "x86 instruction decoder - new instructions" test as folllows:
> 
>     $ perf test -v "new " 2>&1 | grep -i cldemote
>     Decoded ok: 0f 1c 00                    cldemote (%eax)
>     Decoded ok: 0f 1c 05 78 56 34 12        cldemote 0x12345678
>     Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%eax,%ecx,8)
>     Decoded ok: 0f 1c 00                    cldemote (%rax)
>     Decoded ok: 41 0f 1c 00                 cldemote (%r8)
>     Decoded ok: 0f 1c 04 25 78 56 34 12     cldemote 0x12345678
>     Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%rax,%rcx,8)
>     Decoded ok: 41 0f 1c 84 c8 78 56 34 12  cldemote 0x12345678(%r8,%rcx,8)
>     $ perf test -v "new " 2>&1 | grep -i tpause
>     Decoded ok: 66 0f ae f3                 tpause %ebx
>     Decoded ok: 66 0f ae f3                 tpause %ebx
>     Decoded ok: 66 41 0f ae f0              tpause %r8d
> 
> callchains:
> 
>   Adrian Hunter:
> 
>   - Fix segfault in thread__resolve_callchain_sample().
> 
> perf probe:
> 
>   - Line fixes to show only lines where probes can be used with 'perf probe -L',
>     and when reporting them via 'perf probe -l'.
> 
>   - Support multiprobe events.
> 
> perf scripts python:
> 
>   Adrian Hunter:
> 
>   - Fix use of TRUE with SQLite < 3.23 in exported-sql-viewer.py.
> 
> perf maps:
> 
>   - Trim 'struct map' by removing the rb_node member for sorting
>     by map name, as that is only needed for processing kernel maps,
>     and only when classifying symbols by section at load time.
>     Sort them by name using qsort() and do lookups using bsearch()
>     when map_groups__find_by_name() is used.
> 
> perf parse:
> 
>   Ian Rogers:
> 
>   - Report initial event parsing error, providing a less cryptic message
>     to state that a PMU wasn't found in the system.
> 
> perf vendor events:
> 
>   James Clark:
> 
>   - Fix commas so that PMU event files for arm64, power8 and power nine
>     become valid JSON.
> 
> libtraceevent:
> 
>   Konstantin Khlebnikov:
> 
>   - Fix parsing of event %o and %X argument types.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------

>  66 files changed, 2888 insertions(+), 2366 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
