Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90127C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657C720679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3YrzhH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfFRGrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:47:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39881 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfFRGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:47:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so9845579otq.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSGQkiA0RTI8/zzM/PYhJFV7uoveyRIL9DcSm94XU9M=;
        b=K3YrzhH9knSVg0opN5pMXGhkU64WtQRcrTBMXdiJN7CLHG6jerHxWRWu4ostAajrwu
         ikNE+RINxAVHNPRepCq10CAskzoDIrnQUTRxTN22rMOosA1Q1REL2vHwJppsWN1Fosts
         cVFoYxw/JO3JoGeWFX5Rh9E1CHYKcOcebw4IS2xIJ0kNlZZcSuJxbTuW9lN5poIWnTeW
         7UyXWNymgk6NIv1skfmyFT8P2TgsdCFhJ+j0uP1GyoAF4YIZ9jRF1Dv6CK2wI/gAWt3w
         IkzY1eIbGHFbigJcytrKhQ96VsJoWp0xFfS7XX4dWC1Y8vwbx5UG0k9dyuajDJKSCyVF
         +OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSGQkiA0RTI8/zzM/PYhJFV7uoveyRIL9DcSm94XU9M=;
        b=q8NJherHBjmaOLjl69uggWnXDtT2/m8XMzHdCCNgrvMmaUkpU25cdxAt7nD+j1oebd
         v/uwz5W/agJowBaAId+/Twwd+1X5eTR/c/a5+Sg6I7wF9HRIvl2fmlPC9zPxYkZBeNeA
         r6YxcvCiiNEG6remJquuc4JJW2R0ls42Tj85En9r6XgCPAbYpHv+a792HoSPYojScQiH
         KQ2dpcEDXM7aD541teARPO1NtQTqar+YLNh86sfMnt5Mi17pBCieRE7NyjtEZuoZfo6I
         xSYNA96W0UwQt6dWO58Mv02tKGfyauFG4NUX5U5QA/4bfCy54gBNMBN2locEBH+kg5Wa
         DO3Q==
X-Gm-Message-State: APjAAAW+Nmv3Dae+yDJyBYfIZWe7/X20AwYDfRs0q6fE8TezU4HqbyVM
        xG9VlhR8cq9sTjQQ6wqlAlCCPA==
X-Google-Smtp-Source: APXvYqz1110ewdb9NUAeSTkRxzg85X1SuQAXuN8x7GHnMUBwOu5l7oTLYjyfwq1iIOpaqYNvbf+HJg==
X-Received: by 2002:a9d:6f91:: with SMTP id h17mr13797401otq.67.1560839991255;
        Mon, 17 Jun 2019 23:39:51 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id n7sm5347496oih.18.2019.06.17.23.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 23:39:50 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:39:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf trace: Handle NULL pointer dereference in
 trace__syscall_info()
Message-ID: <20190618063937.GB24549@leoy-ThinkPad-X240s>
References: <20190617091140.24372-1-leo.yan@linaro.org>
 <20190617091140.24372-2-leo.yan@linaro.org>
 <20190617173203.GA23094@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617173203.GA23094@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:32:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 17, 2019 at 05:11:40PM +0800, Leo Yan escreveu:
> > trace__init_bpf_map_syscall_args() invokes trace__syscall_info() to
> > retrieve system calls information, it always passes NULL for 'evsel'
> > argument; when id is an invalid value then the logging will try to
> > output event name, this triggers NULL pointer dereference.
> > 
> > This patch directly uses string "unknown" for event name when 'evsel'
> > is NULL pointer.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/builtin-trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 5cd74651db4c..49dfb2fd393b 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1764,7 +1764,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
> >  		static u64 n;
> >  
> >  		pr_debug("Invalid syscall %d id, skipping (%s, %" PRIu64 ")\n",
> > -			 id, perf_evsel__name(evsel), ++n);
> > +			 id, evsel ? perf_evsel__name(evsel) : "unknown", ++n);
> >  		return NULL;
> 
> What do you think of this instead?

Yes, I agree the below change is right thing to do.  FWIW:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

BTW, my patch followed the code in [1], after apply below your change,
could consider to simplify code in [1] for without checking 'evsel' is
NULL pointer anymore.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-report.c?h=perf/core#n301

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 68beef8f47ff..1d6af95b9207 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -590,6 +590,9 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
>  {
>  	char bf[128];
>  
> +	if (!evsel)
> +		goto out_unknown;
> +
>  	if (evsel->name)
>  		return evsel->name;
>  
> @@ -629,7 +632,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
>  
>  	evsel->name = strdup(bf);
>  
> -	return evsel->name ?: "unknown";
> +	if (evsel->name)
> +		return evsel->name;
> +out_unknown:
> +	return "unknown";
>  }
>  
>  const char *perf_evsel__group_name(struct perf_evsel *evsel)
