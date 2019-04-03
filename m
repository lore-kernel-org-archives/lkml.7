Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FAF20693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPbVxM2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDCOx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:53:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39152 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:53:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so19863143qte.6;
        Wed, 03 Apr 2019 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UjX2L1iL/QTwqjxFN1l59TUVB8PEEQ/nTiwcV0O1K+A=;
        b=VPbVxM2y7jA5aaDE4bouQD3pue7T+yUhRbknYOP179QarO2amC7fqCnukxaVDJVsZ+
         6QWLpofkay1231R9Ura4lslZBJ9mdLLk4vwBJNtKdrmDKAXx6Wp7E68gtpvI+khgOgXF
         ZEEQugJ+ll6/k8p84XyuM0AEthWHd3xA5jnbUGZGAFanH4zOP56/I5xudO+bHxbbfEL6
         feKJVbi+t0JoFKv1II25CVEt4BBKh6Kz5dH/cyuIxQXA+tq/hj22LGtTatXaKmm3XQGt
         aZjGctaS2tEv16VscydOwBP94JVoAp5EPNKDRfzGNCVg1nTSt9adcwyVVlzy4yh9hKKY
         8CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjX2L1iL/QTwqjxFN1l59TUVB8PEEQ/nTiwcV0O1K+A=;
        b=dGF2Ddabjp/V46GvfEB3mcSrmm7/PGyk9FPK8Bs8i4HbFLZBEpxH8kj0kn88obBvDS
         SeQi4efRZ9GbNZTcPJDYhu6lROE3/X4Z30jgMKxhlKPpy5numHtWJywd/bnjidmRQHcL
         R6fIobu87HmssITgt1vxTmkJY6u4bytLC6bTD8iqDbgo6MUIRRsMESyILLjvDXUTo6vl
         0kdoBW+l1PaVFwonBk8Z6k10WfG+w4hKUCZii35fenav7uT+NVKclUgb7fBn9zErjB8Q
         WeyCJyHeRlIzJx+HuQTBeaCRCcGRfDKuaPQ3YEgUqQTYhKpmc1R6fh+2IIpG57LfAaCH
         spWg==
X-Gm-Message-State: APjAAAVwIee808ByqlwmK1GK+cuvJ72W52Nk4QnLAi1giMPyD/YrGEnI
        +q8VoN2+wYh1PTvl912+/Lo=
X-Google-Smtp-Source: APXvYqzGTsTqXGnUr8ObFaoOhwPN1d0vTuln6BPZrcsbyLpUIljKiL19gOX+WotRMIJ3vGxaaX+r4Q==
X-Received: by 2002:ac8:2cb0:: with SMTP id 45mr330150qtw.92.1554303237075;
        Wed, 03 Apr 2019 07:53:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i33sm9289219qtb.64.2019.04.03.07.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:53:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DFCBF4039C; Wed,  3 Apr 2019 11:53:53 -0300 (-03)
Date:   Wed, 3 Apr 2019 11:53:53 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190403145353.GE32553@kernel.org>
References: <20190403143738.GB32001@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403143738.GB32001@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
> hi,
> perf script --call-trace stop working for me recently,
> and displays only user space functions
> 
> I bisected that to:
>   7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> 
> data from following comands will display user space functions only:
>   # perf-with-kcore record pt -e intel_pt// -- ls
>   # perf-with-kcore script pt --call-trace
> 
> when I disable the bpf synthesizing (patch below), kernel functions are back
> 
> I guess the new events mess up with intel_pt decoder somehow

And also that synthesizing should't take place when we use 

  perf record --no-bpf-event

I.e. I'm adding the patch below to my perf/urgent branch.

The --no-bpf-event option was put in place exactly for that for
explicitely disabling it if one thinks it is messing with something,
like seems to be the case here.

- Arnaldo

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4e2d953d4bc5..17d772f192ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
-						machine, opts);
-	if (err < 0)
-		pr_warning("Couldn't synthesize bpf events.\n");
+	if (!opts->no_bpf_event) {
+		err = perf_event__synthesize_bpf_events(session, process_synthesized_event, machine, opts);
+		if (err < 0)
+			pr_warning("Couldn't synthesize bpf events.\n");
+	}
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,

 
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4e2d953d4bc5..3daa78bc6549 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec, bool tail)
>  		return err;
>  	}
>  
> +#if 0
>  	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
>  						machine, opts);
>  	if (err < 0)
>  		pr_warning("Couldn't synthesize bpf events.\n");
> +#endif
>  
>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
>  					    process_synthesized_event, opts->sample_address,

-- 

- Arnaldo
