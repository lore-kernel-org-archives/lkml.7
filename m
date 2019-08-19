Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F124C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF63D20673
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI3y7FmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfHSOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:30:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41433 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfHSOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:30:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so1549393qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HGVSfJgxGndqmKr3AeFrIE719FAYcg4+a2HDtPkh5O4=;
        b=RI3y7FmX2mzIIqhnSKh8oahmeHBusiOazihAsOl0C+1cz9UUSUz/CthmJd2KrWZPaE
         v/bHA3DbMV+q6SlUbJ6a7GxvMdpekmVb4mgvmTrllKvDI8zUFa+CIo7uB+x7WbAfDvqK
         c77/2NsrlI84wbS4FbiPww8S18hQ4mb8iGVgHQ517AzsotOUV24YT0XmKmURWe3FaaCe
         YiVpe2t12eE+EViJxWxUDVQdXUTH/4sAFcrySFUvSqtQxFlaYTy118pwoqskINuYKnyh
         CgQ24hvkmTMg/zIxCtmLy05syyQ79I3MRKH+imzUiNL2eNpz5fOncDz+AGoU/doAak+x
         ySeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGVSfJgxGndqmKr3AeFrIE719FAYcg4+a2HDtPkh5O4=;
        b=ttpkBfCMcPbkLysBkt7CJvkvT2GRX9QbjOTkSIgrDF6VQr8WNDA+oLqSoc55AWKO9g
         p2mrZrwiQpcQTtypb9XXURZSUjKLt3J6qbj6Ue8KZEJ6newsFnA1/qBJxvqJ6UA053nN
         GiooMjjEsGHTFOO5QS2W8AGUWvBpYb0rkrcDZr0ARRBOQraN3nLveJvwy6dQJ3iZPQ3U
         VbhWjbD1+rgThzwGO+MLAgsqtNUQsTjthXA1vIu1w9Ax8G2W/1qyOe/3cjqptzcDEfR+
         XR1IUJC5zumiqf8ZUkSkxpwPPhB16iGIkWvc+lUfm7oXVcaCIbMDli8/8o/BgjMsdzLM
         s4AA==
X-Gm-Message-State: APjAAAXdj19YWVkQ4MgjWlBec+AXCU0/veQ159NkXQtnXPLgqiF/bejz
        ImNFHWHMA0EfqOeieyH2rMY=
X-Google-Smtp-Source: APXvYqwVqQqccQGWKHL3klQLTXMSVCCqWbbCAeftBXBpPQJIVPq8xfZ1nLxOQ1M197T3f1OwAg3eaw==
X-Received: by 2002:a37:395:: with SMTP id 143mr21541956qkd.317.1566225038113;
        Mon, 19 Aug 2019 07:30:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v7sm7039528qte.86.2019.08.19.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:30:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E612140340; Mon, 19 Aug 2019 11:30:34 -0300 (-03)
Date:   Mon, 19 Aug 2019 11:30:34 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] perf_sample_id::idx
Message-ID: <20190819143034.GC29674@kernel.org>
References: <20190809092736.GA9377@krava>
 <363DA0ED52042842948283D2FC38E4649C5B1DB0@IRSMSX106.ger.corp.intel.com>
 <20190809160421.GB9280@kernel.org>
 <83ff264f-84c3-5372-8976-dd9293d20c6f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ff264f-84c3-5372-8976-dd9293d20c6f@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 12, 2019 at 12:09:35PM +0300, Adrian Hunter escreveu:
> On 9/08/19 7:04 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Aug 09, 2019 at 03:20:14PM +0000, Hunter, Adrian escreveu:
> > 
> >> It will be used for AUX area sampling.  A sample will have AUX area
> >> data that will be queued for decoding, where there are separate queues
> >> for each CPU (per-cpu tracing) or task (per-thread tracing).  The
> >> sample ID can be used to lookup 'idx' which is effectively the queue
> >> number.
> > 
> > Would be good to have this as a comment in the perf_sample_id struct
> > definition :-)

Thanks, applied to perf/core.
 
> 
> >From 45d57bd7b25c9864f21e25534274ea461ff83d9d Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Mon, 12 Aug 2019 12:06:31 +0300
> Subject: [PATCH] perf tools: Add comment for idx in struct perf_sample_id
> 
> 'idx' was added as preparation for AUX area sampling. Add a comment to
> describe why.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evsel.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cad54e8ba522..ba13eb771775 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -22,6 +22,13 @@ struct perf_sample_id {
>  	struct hlist_node 	node;
>  	u64		 	id;
>  	struct perf_evsel	*evsel;
> +	/*
> +	 * 'idx' will be used for AUX area sampling. A sample will have AUX area
> +	 * data that will be queued for decoding, where there are separate
> +	 * queues for each CPU (per-cpu tracing) or task (per-thread tracing).
> +	 * The sample ID can be used to lookup 'idx' which is effectively the
> +	 * queue number.
> +	 */
>  	int			idx;
>  	int			cpu;
>  	pid_t			tid;
> -- 
> 2.17.1

-- 

- Arnaldo
