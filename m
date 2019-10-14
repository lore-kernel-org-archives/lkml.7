Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D9DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D432083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqWE+kdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfJNOJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:09:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40610 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbfJNOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:09:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so25587864qte.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAcIvBMtUdPHiad0mmFNXbdJ5+29FjH6f8+sQBfeFbg=;
        b=XqWE+kdpccpCUNVtt97XV5xKVZBuFHgfWRjuCd53b4DtIfrCls6fdrtHlanBSg0Ra/
         xVHDM7gsRSKK9E7mPE5GWpKWutiXp0nC2YcL1adUCdvK0qxC69TN6/CMUEkgjqOxMZfA
         ZYyBhBfn4IxiAkiYRHnID3xpQGRD82xxo1sjQqkgPBXPZL8tAcLCXPewmDxJeMN9ovGD
         JiIcp9FP2z3pSOnbgwbRYyPkn0RUUyOInBvRXrgRNTHvJpBVXPVt2JOmy6vcUR/j9xPz
         HEWlvHFBdF3LX5NcTfliwSXkubMYng0POwpwNy4FBchYIvrW5EoAmCZ7kdNK4T0E/MUT
         2eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAcIvBMtUdPHiad0mmFNXbdJ5+29FjH6f8+sQBfeFbg=;
        b=GRGDZtvSPAjmuW2FV3SKGhfN1CrtxRrXthzefiL3O9RepJV4HGXmxNYtZ+P64f+tlE
         FNnrfReFyMnAXnagWj9AlyW1h55FIhPoxVdTKl44BSHUj0rNhD/7SQiCxg025Xb3zwIT
         by+Vt6dy5NEPKNbVM18f4rDS1Mkt1rFvyFqVkMKjxlb8z2IQ9ofUjq3fO70kQnZ1T0WM
         HKKiujQq3LwMXJ0mfVnp0307HTQi1vNKP+XjYlcuE0qEzJW/yJX2XbeOCyy27vpXdKdH
         StnRvodx9sTwN7ho29nJAyeNLJVnBgfxR3yy27q3advwGZmfSUY70nJI7QgXFVi2M/qo
         WAsA==
X-Gm-Message-State: APjAAAXBA2G7e365usYoxdcMqjX9EYzoU3u8mv77KMqDAD1K57YYzsCJ
        GKNLkmB4IzLWIU/jRyB8GQ4=
X-Google-Smtp-Source: APXvYqw3U9b7SX42wxgWbUJn0mOZBFeE+P8qcZJ//LpsTz0sgpE7gvLjd+lqwwIdL39hC9yhe2sPrQ==
X-Received: by 2002:ac8:17d9:: with SMTP id r25mr33053710qtk.9.1571062163593;
        Mon, 14 Oct 2019 07:09:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 44sm9682625qtu.45.2019.10.14.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:09:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 100A74DD66; Mon, 14 Oct 2019 11:09:21 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:09:21 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf test: Report failure for mmap events
Message-ID: <20191014140921.GC19627@kernel.org>
References: <20191011091942.29841-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011091942.29841-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 11, 2019 at 05:19:41PM +0800, Leo Yan escreveu:
> When fail to mmap events in task exit case, it misses to set 'err' to
> -1; thus the testing will not report failure for it.
> 
> This patch sets 'err' to -1 when fails to mmap events, thus Perf tool
> can report correct result.

Thanks, applied and added:

Fixes: d723a55096b8 ("perf test: Add test case for checking number of EXIT events")


 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/task-exit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index bce3a4cb4c89..ca0a6ca43b13 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -110,6 +110,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  	if (evlist__mmap(evlist, 128) < 0) {
>  		pr_debug("failed to mmap events: %d (%s)\n", errno,
>  			 str_error_r(errno, sbuf, sizeof(sbuf)));
> +		err = -1;
>  		goto out_delete_evlist;
>  	}
>  
> -- 
> 2.17.1

-- 

- Arnaldo
