Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95340C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629BE206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB5uJfAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfI3Krc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:47:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33687 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfI3Krc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:47:32 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so16409332qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKSYeCUs2EWw/xdzgOFe3PhKw3PZZwmvMA9eANeKNY0=;
        b=jB5uJfAOU1tQSgqIl5pxjyV61xW1Inp4OMCMsYTh9ESmSAUkvv1U9qegIhPwA203/X
         PjhCpQTPU4S6uXwFaoufWnXjcElkcrmkU8oGZdDxS7zmoiNNKDuJHD00UjP0etTLIiSd
         alx4qTqMw2mL/wKEBGwR4peSwZTozzY51DtmSz9XoNX63ukyZkaCAXwGUN4yxcUWqYT/
         hWpP1gFJ4rlbK1sEs5w+gVS6x10yREsH9qgfYamnG6kXD1Vyjvyoj9bzAiiVngSQ207n
         HGRoTFUrZtFv3yVgF8tSRKNP6HsR4SH+IaqMlDaMmQOzzLyOFZ96RTKvx0Ev9Z/fpYLi
         W0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKSYeCUs2EWw/xdzgOFe3PhKw3PZZwmvMA9eANeKNY0=;
        b=CaI0FrsOFD1YGYCVDONiT7ikP7iSNd9/vb9V5cljrTm9mNpZIfQzIP1GWFs/Zv73Y2
         lom85IY2T1vnADPPtPNDOAWCd29fsKy8nn1oep0FL0aFaGZlqPgjHpbluNhAVEOLSORH
         aiN1whBAk07QQxTBwTY2GNDSHCG74mDicK7o6pO0qQolbYi13CQQl7VhkPEYskOq+jxi
         /Oozr55zr/xD0sVilyNKIXw/llTVVV+FzSRcShJbbS6kNtIwAdncu5gXzGKb/sLzZjE4
         puq5NX9iBHcvKW9M0UVHH7crGLeFiSp7h44VCvOlYvIUwD4nxXPWl+DI7WBzCyhKa5QT
         80lg==
X-Gm-Message-State: APjAAAUZuq98yII/yPy4r9qmucjeYxHfDm29qTXtLy+2fTuH84Ev2o76
        5gEOEbsEDf9/KiuIi7hoCyM=
X-Google-Smtp-Source: APXvYqwl0IKWpJyv2riKJ+8hpF6R30spKNugxjY1CSSzVFJuav5vX3HcpbfvWJApIkQoaPTucb7wLA==
X-Received: by 2002:ac8:2d08:: with SMTP id n8mr24950778qta.374.1569840451367;
        Mon, 30 Sep 2019 03:47:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e11sm4961382qkg.134.2019.09.30.03.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:47:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E0DD40396; Mon, 30 Sep 2019 07:47:28 -0300 (-03)
Date:   Mon, 30 Sep 2019 07:47:28 -0300
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/4] perf inject jit: Fix JIT_CODE_MOVE filename
Message-ID: <20190930104728.GB9622@kernel.org>
References: <BN8PR21MB1362FF8F127B31DBF4121528F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1362FF8F127B31DBF4121528F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 28, 2019 at 01:41:18AM +0000, Steve MacLean escreveu:
> During perf inject --jit, JIT_CODE_MOVE records were injecting MMAP records
> with an incorrect filename. Specifically it was missing the ".so" suffix.
> 
> Further the JIT_CODE_LOAD record were silently truncating the
> jr->load.code_index field to 32 bits before generating the filename.
> 
> Make both records emit the same filename based on the full 64 bit
> code_index field.

Thanks, applied and added:

[acme@quaco perf]$ git tag --contains 9b07e27f88b9 | grep ^v[[:digit:]] | sort --version-sort | head -5
v4.6
v4.6-rc1
v4.6-rc2
v4.6-rc3
v4.6-rc4
[acme@quaco perf]$

Cc: stable@vger.kernel.org # v4.6+
Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")

So that the stable folks get this backported.

- Arnaldo
 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
> ---
>  tools/perf/util/jitdump.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 1bdf4c6..e3ccb0c 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -395,7 +395,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  	size_t size;
>  	u16 idr_size;
>  	const char *sym;
> -	uint32_t count;
> +	uint64_t count;
>  	int ret, csize, usize;
>  	pid_t pid, tid;
>  	struct {
> @@ -418,7 +418,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  		return -1;
>  
>  	filename = event->mmap2.filename;
> -	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%u.so",
> +	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
>  			jd->dir,
>  			pid,
>  			count);
> @@ -529,7 +529,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
>  		return -1;
>  
>  	filename = event->mmap2.filename;
> -	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%"PRIu64,
> +	size = snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
>  	         jd->dir,
>  	         pid,
>  		 jr->move.code_index);
> -- 
> 2.7.4

-- 

- Arnaldo
