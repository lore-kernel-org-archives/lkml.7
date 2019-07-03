Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB567C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84AA218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDTwIkbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCTCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:02:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34762 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:02:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so3715554qkt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9j91QuzZiuA3k9yRtiEcwirJNujPfeZz+gfvWzqG4sM=;
        b=pDTwIkbqOcc+H1dxvW7x53x8X4xIJcfKzGjKxVWLntJnZBIte8mmdeX5JrFNjEgjnm
         70HbqMbI8zWsbL6++GGmF+JiKyC0De1UWoJqp0M4CdV5pRQGyIKcrd3AB12VNadldD0S
         k92iFBrPJF/WuYIHY1EqUDvrRRvrUc55TSdRIO7owyRzizI+3+kS7dEv9PaR3/vJjtUu
         aA3z9Eqe66YmavwDTE2vSJioAMBtZ/JzD2GBc+Zzb+rirhnEtqOMBaUxRs05SQ2Pi3dp
         LWrGWBJURqGiWKqxwUq5fvaRH0Q8KHhpeio3CrjKQ9yVUlKFUsvAzno3CQ95zAW7wERB
         wTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9j91QuzZiuA3k9yRtiEcwirJNujPfeZz+gfvWzqG4sM=;
        b=lBEugBG4DYBL3N76Q3RfB2v00sH+aM9Ldwb3365QXqPIb/jfQsNYuHhGMZWrUin1F0
         c3t2dOX+2JUK5fOKoI1SxwGVRfwKSmWRHgEUv8eYl11kCqXyauKnzyq5MTrKF0j7pUs8
         w3VTz3FWBbjB2gvdUHt0KZkOlbn74gd9aioA5y6X9BGI6OL0ah9mN7wmnE3DyKsHPu9o
         NQYQGt4GQFxnSjmuLXbEu6eaYJXanLPe02ZW3nQErEbieoSm5WPm9WpcABnpzx6PKEWP
         NyY2N1Zl/9Ue7J8qOkzY0EFc24YsQkvzd54nCtLfUg9V5FtC0coYcBxA8rhooOCFqekH
         SGmA==
X-Gm-Message-State: APjAAAXtj3m5MQETz22hhP0t3Fz9NEdD090ptI4JvpIxx96t0aNtyJ9d
        cgYjpj592ZACWwN32MQ3XGs=
X-Google-Smtp-Source: APXvYqwTSVQFT1OBkv74/wi6RpT6wpjYQH6SkQzuUDXz9ngGrO/LUCNP3A2jcrUaKH45Srfjgju1mQ==
X-Received: by 2002:a05:620a:522:: with SMTP id h2mr34041635qkh.329.1562180561228;
        Wed, 03 Jul 2019 12:02:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id p13sm1182260qkj.4.2019.07.03.12.02.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 12:02:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CFD341153; Wed,  3 Jul 2019 16:01:57 -0300 (-03)
Date:   Wed, 3 Jul 2019 16:01:57 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/11] perf session: Smatch: Fix potential NULL
 pointer dereference
Message-ID: <20190703190157.GG10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-9-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-9-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 06:34:17PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.
> 
>   tools/perf/util/session.c:1252
>   dump_read() error: we previously assumed 'evsel' could be null
>   (see line 1249)
> 
> tools/perf/util/session.c
> 1240 static void dump_read(struct perf_evsel *evsel, union perf_event *event)
> 1241 {
> 1242         struct read_event *read_event = &event->read;
> 1243         u64 read_format;
> 1244
> 1245         if (!dump_trace)
> 1246                 return;
> 1247
> 1248         printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
> 1249                evsel ? perf_evsel__name(evsel) : "FAIL",
> 1250                event->read.value);
> 1251
> 1252         read_format = evsel->attr.read_format;
>                            ^^^^^^^
> 
> 'evsel' could be NULL pointer, for this case this patch directly bails
> out without dumping read_event.

So this needs another hunk, adding it.

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8e0e06d3edfc..f4591a1438b4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -224,7 +224,7 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct perf_evsel *evsel,
 				     struct machine *machine)
 {
-	if (evsel->handler) {
+	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
 	}
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/session.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 54cf163347f7..2e61dd6a3574 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1249,6 +1249,9 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
>  	       evsel ? perf_evsel__name(evsel) : "FAIL",
>  	       event->read.value);
>  
> +	if (!evsel)
> +		return;
> +
>  	read_format = evsel->attr.read_format;
>  
>  	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
> -- 
> 2.17.1

-- 

- Arnaldo
