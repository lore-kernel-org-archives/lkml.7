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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C667C2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdkYkMqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDCPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:15:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36707 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:15:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so19995756qtn.3;
        Wed, 03 Apr 2019 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdW4eGaudh6Yjb1CdfmnpUhSxJHoKQ7SGC6G1i25TKU=;
        b=RdkYkMqRwX7QhzmkRil+Q3PPTM4Y9sEhQvRXjBZ1FitI0hZZ6IT9PoxSx2ke0k+nfR
         /cWJxCPWYTX1ij92IKqVvtY8DMdAO1elgDFIk7FlPVf9o7IfHJusVG8hCryXzVBJ5STK
         9HozigWoPjrpFkptrQQ8gpbnvCNiIVKA2GOZQUU44lOhcGR+rKJfatfRatgzMtUoUSnh
         xwdyluYLIzicCK1Equi0RXtxAJMxPTUuM4dy+jnMKKllcMrtLJkTcxjbi6Mno54i/eMT
         PDlF2o+HnvYJyBAclulzE+JeR7rOfASp/nkRDsIWE005JHcZut5ea3QKS2eQMRizLjlu
         NHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdW4eGaudh6Yjb1CdfmnpUhSxJHoKQ7SGC6G1i25TKU=;
        b=sLGHSzZKX43cEStiG9QtnQd4Bw5EESFQUN7miKAFK5xV/WdcWVuIizkOQ4APIS5qCe
         zsXMEnLf8JJ+bhjn6Rznbt1zkoO6sI377hUx9beCBxuOKVPGrG5IW4oUeo32yIr6TkMI
         FlrVYBP7byaTHVuPAXkGAjTTHuVWaEBRjyVwWtkcOeZvRjjdKjUx1yZcbIwxJaw5Th/Q
         06b240B4LDuNQ/MHk1M8juum4AzSiGWKNSDpokt+VYZV3iMvbc7dOcS5YLKoc1aqBfoS
         2Y4ajLLk+VVOzcS4qydyECFWhPaogPQe0MOvESslIVN+j4bCLB8Cm0+bk5azilnQW1qF
         ZKEg==
X-Gm-Message-State: APjAAAWGYSicBuvacZWm0B2dwNcntXy2iQAQClEyKCs9eEy3SqxZ3GIm
        y1wPMXlURo586XVNZnJ9P2c=
X-Google-Smtp-Source: APXvYqwiKc1KiUO8fCFoVhp5SZv5e6ZxYuGvBJVT9RqA15vohYovv0o1qtioeE0cubewBWxP806QSw==
X-Received: by 2002:ac8:28f4:: with SMTP id j49mr413299qtj.310.1554304552013;
        Wed, 03 Apr 2019 08:15:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m46sm10706966qtk.95.2019.04.03.08.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:15:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42CEE4039C; Wed,  3 Apr 2019 12:15:48 -0300 (-03)
Date:   Wed, 3 Apr 2019 12:15:48 -0300
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190403151548.GF32553@kernel.org>
References: <20190403143738.GB32001@krava>
 <20190403145353.GE32553@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403145353.GE32553@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 03, 2019 at 11:53:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 03, 2019 at 04:37:38PM +0200, Jiri Olsa escreveu:
> > hi,
> > perf script --call-trace stop working for me recently,
> > and displays only user space functions
> > 
> > I bisected that to:
> >   7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> > 
> > data from following comands will display user space functions only:
> >   # perf-with-kcore record pt -e intel_pt// -- ls
> >   # perf-with-kcore script pt --call-trace
> > 
> > when I disable the bpf synthesizing (patch below), kernel functions are back
> > 
> > I guess the new events mess up with intel_pt decoder somehow
> 
> I.e. I'm adding the patch below to my perf/urgent branch.

Song, that is what I have, can I have your Acked-by and please consider
taking a look at the bug Jiri reported,

Thanks,

- Arnaldo

commit 011318ccc2024ba03e96c32a06f74ca5d6ab5503
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Apr 3 12:05:15 2019 -0300

    perf record: Do not synthesize BPF records when --no-bpf-event is used
    
    By default we synthesize and ask the kernel for BPF events, having a
    --no-bpf-event option to disable that, which can be useful, for
    instance, if there are still bugs in that code, which seems to be the
    case as reported by Jiri Olsa in:
    
      "[BUG] perf: intel_pt won't display kernel function"
      https://lore.kernel.org/lkml/20190403143738.GB32001@krava
    
    So add the check for record_opts.no_bpf_event when considering
    synthesizing BPF events for pre-existing BPF programs in 'perf record'.
    
    The reported bug needs further analysis and is a separate matter.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Martin KaFai Lau <kafai@fb.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Yonghong Song <yhs@fb.com>
    Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
    Link: https://lore.kernel.org/lkml/20190403145353.GE32553@kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

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
