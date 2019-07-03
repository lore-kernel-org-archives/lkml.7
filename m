Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0A52189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbrY7QMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGCSSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:18:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40324 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:18:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so4862268qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DCpM7nms5B5RUVgOYjG5X7MCBjiWqWHo1JgqvBcjmHM=;
        b=bbrY7QMYHPZ7Mia+OaTfFaWN872NDlMZ1Yer/JourHzxGBRBVeZPHmKWxabKdkyrQK
         zXUq301ZKbw/758fFD7bDkDuwkG+kdSrZEv+giT8QlXnS2zZhJ+0wRYdSzv/t2WrZbe2
         +IZjHlDbj+Hq//uVCWcP5z5B6BQHjJmUupFcJIo5hkRivjgMZhpmbSmkynC6bRcLlHZr
         iV51wzDklp56UMYL8wL47L6mkYu0I4RS9wfqnswVAvytvRByqFmMNufO7YjaXpXpi7k7
         VbszCQc1t/50jmWf/FS6TRLYcPRE8nvuBgzZntN38D2oTFSbszBs8xkOWS+0xX+Kcluv
         MoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DCpM7nms5B5RUVgOYjG5X7MCBjiWqWHo1JgqvBcjmHM=;
        b=DdT5SXurGTv9zoG6DLXtG7Fy9NllqOOAyyM/2cjVga76dSJ3TFH0DUG576v09ugLeq
         qpBWMV9SeJUtZGWkk43tW8IQZM9ugG5+814/vcft5fe9S623DcgddOKOMT1M1buRnyKW
         XE/mFqZmkFTfseg3nYZyLEQZGoDRiM84T1G2lVKF9YxOTZIq1qT5x1YBKtTYMWe33uWl
         07b2CUfhpmXAafcKZWtQqkpXyAc0WGuEnHTdQ9kzyC6/9+Y/phNpTBKm6fbFcxpnPK5w
         W9rg3rhPApZqIjRWCa93KSAEoD8Nxlwd44e2DhPjbjPSuxNZO/1cu3Cs6yi6DVKp94h+
         Pf0A==
X-Gm-Message-State: APjAAAVA6r2s3t8blpfxnc30xQMEqlVaiSej73nenOLOJPUVP6ta6fNB
        Kff0ycKYFSc/YuvoH5rESJ0=
X-Google-Smtp-Source: APXvYqxOeiiCSzHuoTUco8WGNs2rMZECWyqtER1ghOhlmsutfnoYPSwrcBupt92rztRKGBxk8LvIoQ==
X-Received: by 2002:a0c:b897:: with SMTP id y23mr33775143qvf.44.1562177930791;
        Wed, 03 Jul 2019 11:18:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id m5sm1234999qke.25.2019.07.03.11.18.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:18:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF8DF41153; Wed,  3 Jul 2019 15:18:41 -0300 (-03)
Date:   Wed, 3 Jul 2019 15:18:41 -0300
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
Subject: Re: [PATCH v1 02/11] perf stat: Smatch: Fix use-after-freed pointer
Message-ID: <20190703181841.GC10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-3-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 06:34:11PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the use-after-freed
> pointer.
> 
>   tools/perf/builtin-stat.c:1353
>   add_default_attributes() warn: passing freed memory 'str'.
> 
> The pointer 'str' has been freed but later it is still passed into the
> function parse_events_print_error().  This patch fixes this
> use-after-freed issue.

thanks, applied.
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 8a35fc5a7281..de0f6d0e96a2 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1349,8 +1349,8 @@ static int add_default_attributes(void)
>  				fprintf(stderr,
>  					"Cannot set up top down events %s: %d\n",
>  					str, err);
> -				free(str);
>  				parse_events_print_error(&errinfo, str);
> +				free(str);
>  				return -1;
>  			}
>  		} else {
> -- 
> 2.17.1

-- 

- Arnaldo
