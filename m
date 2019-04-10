Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C56C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A55D2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojmyFk5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfDJNKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:10:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34599 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731494AbfDJNKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:10:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id k2so2755548qtm.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8t2aA2bixt06/o6dYNFeDs2oCONIn2Djf8k9eVzSfeE=;
        b=ojmyFk5eZDKRAjVysHwK0Pyc7q3FPuRpEwweuddgKrrLb76WL0EQHoXkF2iwnKjYkL
         rSuE1XAWaXp4zDly33a6HR1DEhgnIXHyDP7yYDAH4gfMlnOMxnLfLl5nV62YJkOIYSSl
         gM0UybhlfcPjcIuqisHJsTUwgwFXzuyFleiHgjpCILQQq+grFl5gi9QZutuX/iatpKBu
         DEUsWnr+kkU68QM/QNtXv7hUE1cF/edmdTUVI6wQmlPpWGLKAvr3O1RSbNZtLp2wJZzo
         OHK0h8T1P1fHKqMe4RBnK8ko9sREOWl+BeKycS3GLEA9gKdvZFtcovicqi55C4vF/mVB
         xDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8t2aA2bixt06/o6dYNFeDs2oCONIn2Djf8k9eVzSfeE=;
        b=mH3oZCNOKS101rxKa3VT2BGfAnnJudmmtgTi4mW3+464e1nKMQrBYISFVsn6UYMvwy
         /S7xo+aDXKg6j7nKyT7sHoWpRcbbnfoSaxPNPGpoVOoYR7UMUUw8hSKyMQCe9/sVZ+Jx
         eUscFwR2zFDZ0KNIwRVmcMQR0KV8YVC7nSI+WICdQ10TsLT/0mFENskfnij+CyD8gtwY
         aNT5oCdq1KMZxxIJJNTkXukT2CyIITAdDnj/kZG241e+Clim0ZKohplqKVFLl+nyc/Zh
         XEvcM8bm1RbfW6RtFG/ckYLD//Rw8d+D0vMD3+GiNIg6yoM/4En6F3K1bDulW9ERWIsq
         sQZw==
X-Gm-Message-State: APjAAAU4JNUXbmRADIgvLRdzlpYm2FebSj3QvWF7HggnDtbti2k0bVed
        ELC7upe8ypCTD36Ga6VU5VlesA2W
X-Google-Smtp-Source: APXvYqzu181Zf9PuD0tVvb/QLYet0+duRiy93t+Hi2BupceKi3UG1IriuTy+to/+Mw2zXrG5MDIAxA==
X-Received: by 2002:aed:2b87:: with SMTP id e7mr18557528qtd.190.1554901845491;
        Wed, 10 Apr 2019 06:10:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e4sm19488523qkg.6.2019.04.10.06.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:10:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2D8A84039C; Wed, 10 Apr 2019 10:10:42 -0300 (-03)
Date:   Wed, 10 Apr 2019 10:10:42 -0300
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 1/3] perf: use hweight64 instead of hweight_long
Message-ID: <20190410131042.GF13888@kernel.org>
References: <cover.1554883878.git.han_mao@c-sky.com>
 <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
 <20190410130841.GE13888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410130841.GE13888@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 10, 2019 at 10:08:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 10, 2019 at 04:16:43PM +0800, Mao Han escreveu:
> > On 32-bits platform with more than 32 registers, the 64 bits mask is
> > truncate to the lower 32 bits and the return value of hweight_long will
> > always smaller than 32. When kernel outputs more than 32 registers, but
> > the user perf program only counts 32, there will be a data mismatch
> > result to overflow check fail.
> > 
> > CC: Peter Zijlstra <peterz@infradead.org>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> > CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > CC: Jiri Olsa <jolsa@redhat.com>
> > CC: Namhyung Kim <namhyung@kernel.org>
> > 
> > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > ---
> >  tools/perf/util/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 7835e05..73c78be 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2322,7 +2322,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
> >  		if (data->user_regs.abi) {
> >  			u64 mask = evsel->attr.sample_regs_user;
> >  
> > -			sz = hweight_long(mask) * sizeof(u64);
> > +			sz = hweight64(mask) * sizeof(u64);
> >  			OVERFLOW_CHECK(array, sz, max_size);
> >  			data->user_regs.mask = mask;
> >  			data->user_regs.regs = (u64 *)array;
> 
> Later on, in the same function, perf_evsel__parse_sample() we have:
> 
>         data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
>         if (type & PERF_SAMPLE_REGS_INTR) {
>                 OVERFLOW_CHECK_u64(array);
>                 data->intr_regs.abi = *array;
>                 array++;
> 
>                 if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
>                         u64 mask = evsel->attr.sample_regs_intr;
> 
>                         sz = hweight_long(mask) * sizeof(u64);
>                         OVERFLOW_CHECK(array, sz, max_size);
>                         data->intr_regs.mask = mask;
>                         data->intr_regs.regs = (u64 *)array;
>                         array = (void *)array + sz;
>                 }
>         }
> 
> You forgot to convert that one, doing it for you,

Also in perf_event__sample_event_size() we need to do the same thing,
right?

- Arnaldo
