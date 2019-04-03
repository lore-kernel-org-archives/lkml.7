Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DEFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049FC2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9LB6FVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDCSu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:50:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42964 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:50:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id b74so40885qkg.9;
        Wed, 03 Apr 2019 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eApUNoXtvgObAw8zyzZ47zfQoPFaBmGvTL8aNfVE7ow=;
        b=r9LB6FVOscPWgOqfzrnU1kQasFACxnDbfBhJX8MPNq8WZ7AlJJWlNhG73+mugqqv5x
         IKKhLpdMOsj2vSJLuq4H8lUPg9gPoWYtPu/Mlkwd/zXXyqAfgLqCFQc6NvpxXFvuTcQT
         VlFZqPFYYnj9TsQVHg0KrguEFG8flFtx+WAa4gohMXW95Q0AX1GwZ9y8L7/CsGAHg2VY
         EoWBADNlsi76ZLXf/9DfNz7DdAyWoU2kE/um/+Z1QfHL5wKXFyktXw2UmUHe/dd+iXjG
         S0JWBjeiWmkkkXL90XB8OA7n8jBRr7rbztH/DBrN6F00HtM1Et2pooNA/i8nMTRczePg
         fPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eApUNoXtvgObAw8zyzZ47zfQoPFaBmGvTL8aNfVE7ow=;
        b=rdPW3KFhM9+Zf7vAXmnbsQq15cv1dGvEf7JFVAAicGMzpug3Q6fWMZEY6ZlQ4f+5e2
         5l5fj9MpVYU5WV92NWY+h8d5eUIzoF5gkj6maXm9TizDNPROBKdFdwwCvpQ1zfo4yBYs
         yGBidyo1juxL3ax88oMaU3u98gVj/cW37+fHa3ms4587IFpL30dDJilMMN/UtN3RJWvH
         0O+a9qciHL4NhPPieTm2qYA3Iz/9mFVERML2vAsMIV2L2kwD1zcwW/pL/KpMw9GcD3T6
         vK0/mL0n4hbDUXq5wQLzCqNZ6Ca/AxhcvWaHEs8Wiiz/LShjmafgPeb5Uhn06vbkyY+t
         CSeQ==
X-Gm-Message-State: APjAAAURV4xxs6YPonFsk7qg+EzXa4tpsoq98/WAD8UBpN/6PW0uZCP7
        vxVYcSUvdoH1RDG5txKCHvU=
X-Google-Smtp-Source: APXvYqzNkjXwap4Ps6qaGuLooGFrKtK8SFUrjTjRfePaECv+BMDJiLHkdZ/DTyiYtm4nR1vMDx0PPw==
X-Received: by 2002:a05:620a:1334:: with SMTP id p20mr1509693qkj.244.1554317456393;
        Wed, 03 Apr 2019 11:50:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y13sm7251773qkj.30.2019.04.03.11.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:50:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27C484039C; Wed,  3 Apr 2019 15:50:53 -0300 (-03)
Date:   Wed, 3 Apr 2019 15:50:53 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190403185053.GH32553@kernel.org>
References: <20190403143738.GB32001@krava>
 <20190403145353.GE32553@kernel.org>
 <20190403151548.GF32553@kernel.org>
 <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B07CAAC3-D085-443D-BB0C-05E9A8F3AFB2@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 03, 2019 at 04:27:56PM +0000, Song Liu escreveu:
> 
> 
> > On Apr 3, 2019, at 8:15 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
> >>> hi,
> >>> perf script --call-trace stop working for me recently,
> >>> and displays only user space functions
> >>> 
> >>> I bisected that to:
> >>>  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> >>> 
> >>> data from following comands will display user space functions only:
> >>>  # perf-with-kcore record pt -e intel_pt// -- ls
> >>>  # perf-with-kcore script pt --call-trace
> >>> 
> >>> when I disable the bpf synthesizing (patch below), kernel functions are back
> >>> 
> >>> I guess the new events mess up with intel_pt decoder somehow
> >> 
> >> I.e. I'm adding the patch below to my perf/urgent branch.
> > 
> > Song, that is what I have, can I have your Acked-by and please consider
> > taking a look at the bug Jiri reported,
> > 
> > Thanks,
> > 
> > - Arnaldo
> 
> Current logic with --no-bpf-event is to generate PERF_RECORD_KSYMBOL, but not
> PERF_RECORD_BPF_EVENT:

I see... The opts is done later, after querying the kernel for existing
BPF programs so that at least the KSYMBOL ones can be generated. So I'll
keep it as is, no need for this patch.
 
> https://elixir.bootlin.com/linux/v5.1-rc3/source/tools/perf/util/bpf-event.c#L254
> 
> I will look into the intel_pt problem. 

Ok.
 
> In the meanwhile, let's fix it for now. 

I'll wait a bit.
 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Thanks, 
> Song
> 
> 
> > commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Wed Apr 3 12:05:15 2019 -0300
> > 
> >    perf record: Do not synthesize BPF records when --no-bpf-event is used
> > 
> >    By default we synthesize and ask the kernel for BPF events, having a
> >    --no-bpf-event option to disable that, which can be useful, for
> >    instance, if there are still bugs in that code, which seems to be the
> >    case as reported by Jiri Olsa in:
> > 
> >      "[BUG] perf: intel_pt won't display kernel function"
> >      https://lore.kernel.org/lkml/20190403143738.GB32001@krava
> > 
> >    So add the check for record_opts.no_bpf_event when considering
> >    synthesizing BPF events for pre-existing BPF programs in 'perf record'.
> > 
> >    The reported bug needs further analysis and is a separate matter.
> > 
> >    Cc: Adrian Hunter <adrian.hunter@intel.com>
> >    Cc: Alexei Starovoitov <ast@kernel.org>
> >    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >    Cc: Daniel Borkmann <daniel@iogearbox.net>
> >    Cc: Jiri Olsa <jolsa@kernel.org>
> >    Cc: Martin KaFai Lau <kafai@fb.com>
> >    Cc: Namhyung Kim <namhyung@kernel.org>
> >    Cc: Peter Zijlstra <peterz@infradead.org>
> >    Cc: Song Liu <songliubraving@fb.com>
> >    Cc: Yonghong Song <yhs@fb.com>
> >    Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> >    Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
> >    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 4e2d953d4bc5..17d772f192ad 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1114,10 +1114,11 @@ static int record__synthesize(struct record *rec, bool tail)
> > 		return err;
> > 	}
> > 
> > -	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
> > -						machine, opts);
> > -	if (err < 0)
> > -		pr_warning("Couldn't synthesize bpf events.\n");
> > +	if (!opts->no_bpf_event) {
> > +		err = perf_event__synthesize_bpf_events(session, process_synthesized_event, machine, opts);
> > +		if (err < 0)
> > +			pr_warning("Couldn't synthesize bpf events.\n");
> > +	}
> > 
> > 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
> > 					    process_synthesized_event, opts->sample_address,

-- 

- Arnaldo
