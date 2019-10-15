Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12021848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s17SDYWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfJOLkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:40:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfJOLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:40:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so30011247qte.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02G6ILTaST1a8y3NRyfUEBPlsVYY6wbFdoki+Yg8QNs=;
        b=s17SDYWpQoCoedq/K8Fzedb24l8dH0aMWwsRIbjPJ1dxlyPtIkoho4EcRU7WStlaXu
         cOMe80AodKX5QHC5Hn/Z4ZmGEnpQTa+TzbH9SffYc51thRFB7SmpKYv1Hl1G+yrzOjjM
         MOA5+fElhe8wQ9IM+yA42AixeectyrbVf3DUmxbZfYr5R24xB8L50RU5gp9xnw7uUc/o
         OtUjb0FN6NpoW+APStq9uqA/YdSjfHniFFiKNUMptE5F2pdArt4TNek89O/znUoXUhIe
         abSAOUC/uYs7L228AiCBNx56WXx/LMfRxc7kdKEAHMl7umD0BBJ1qeK2C0zit3daGoDI
         Liew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02G6ILTaST1a8y3NRyfUEBPlsVYY6wbFdoki+Yg8QNs=;
        b=CNue+g6NmSkjANxWwTMV4irs+az3THvdvKZPnnbHzabbGAFFoQMt2QfaWxPlabYCKm
         x+4mNCgAgGbY5IER+H/1fkccW0amj8jSwb2cc6mOozG7Cxzsq13+ueN0v/82xxd04AEt
         e9BC24YcI4oe/JtIolEZBuFaiwH/7+OrlGa1lk6vI/x9dmmS7st26kIqIfsryyqE46cQ
         pFz75/ZK6MzIzjTWSb9HiNklgECbl8kG2lgtsXMmvXyg+FMOSBSh7luKSYPGaxv0SVQU
         FCPonNOIMHxFuiN9tNfDnPGgXnv2LUAD+FxOswyIMxyCyp7VMsoXHJoo6su9eSL0aGlS
         x6eA==
X-Gm-Message-State: APjAAAWWIOtQNDj89saa56l2rTz6EbHVgpu1R8YbqUDjvWmsg54Zwy+r
        QerxSzwmOp8Ngbd/OLov/Fk=
X-Google-Smtp-Source: APXvYqxnsTJcr0P9p+hdcRptpQaYzywIwPAV7Rstwo1k9VbavXS6wUq2i7aQTATDGAQae2ai1M+rsA==
X-Received: by 2002:a0c:9311:: with SMTP id d17mr37424440qvd.11.1571139621811;
        Tue, 15 Oct 2019 04:40:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.182.218.3])
        by smtp.gmail.com with ESMTPSA id q2sm9239325qkc.68.2019.10.15.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:40:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D02B64DD66; Tue, 15 Oct 2019 08:40:17 -0300 (-03)
Date:   Tue, 15 Oct 2019 08:40:17 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf annotate: ensure objdump argv is NULL terminated
Message-ID: <20191015114017.GB29967@kernel.org>
References: <20191015003418.62563-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015003418.62563-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 14, 2019 at 05:34:18PM -0700, Ian Rogers escreveu:
> Provide null termination.

Since this hasn't been pushed upstream yet I folded it into the patch
where it should've been, to keep bisection.

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/annotate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index f7c620e0099b..a9089e64046d 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1921,6 +1921,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		NULL, /* Will be the objdump command to run. */
>  		"--",
>  		NULL, /* Will be the symfs path. */
> +		NULL,
>  	};
>  	struct child_process objdump_process;
>  	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
> -- 
> 2.23.0.700.g56cf767bdb-goog

-- 

- Arnaldo
