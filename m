Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B800D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsg7DpNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfEVNYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:24:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37293 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfEVNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:24:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so2278414qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQsPAOWexv5QAHQZ2BjwRe5FZ3NgQCn6l6Sy8+t0ltE=;
        b=Qsg7DpNkZh+8aiaKUIeW9MYDxn0Yk3Mk0+ssk9smN0aKW73F1ajzpl/d56oayesK+I
         4T9ls7o/CEDMW8bU9cr2788sgxoti632tsv1bokTnAXd3F8rNIKzsPjxd2j+OB6NkLQU
         CQVOanzTVG801tyec5OlyM63dCAPNvxwwWIYcPatD6Izwyb+qLrU6dEHrZlUvZfXFKq6
         jQdFBAkNMvPGtXVmryOELImcDRjSw+6xrDtllbSWQ27I5lfa/Wkp8TILVMd9VWuJmGtx
         hSGu/LcHf5ILwnkVAu/hECbkNqHwcg9vumczx+muDMK900/DbHyO9z7hb3/skRafdSEk
         toTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQsPAOWexv5QAHQZ2BjwRe5FZ3NgQCn6l6Sy8+t0ltE=;
        b=eQ8tnVcF6NYCm/OgyPAzO0rkkIed1HX9fu5BnajIu/aDQCrvi/8z0cH/6cyz3cPMGf
         57QXen1aWrvht/tJL1V3dsQe7y1Af6HH5TQn1Vk8PcnlxfjFTwrgGW/rjaomhAGNHEq9
         Ev/OFvMSd9pat1iawcmea9G5KPjiCpiCLbR9m1LQUPojGej6itBq/lRlXRuQ0ev0g0yB
         m837arMp9YZ9GdZ+Exor2x1C4o+AYEHwMSUibaZiHhbv4RaG6iZ30PNY7K2RNy+Ex6k7
         1Yqpfj22WCwxtPP/1THt8QqyMYiNF+FUeYxXvtlEtdDi0iY+LJCG734suJ3fG3JNetlJ
         9f9Q==
X-Gm-Message-State: APjAAAV8GQYGNfGYFiG52YX/6nc2VeNXsRZ3JgsvZ04JkCL46hgMXHNm
        qzJY7nWW1DAGNX8qjNlqyZs=
X-Google-Smtp-Source: APXvYqwY46I/zsgKFA8hoX6Qs6fOkBvlvqk4nz43+cV1Nhsiso27qIR1PO4zYc2faJIFJ284pOHWGA==
X-Received: by 2002:ac8:38d1:: with SMTP id g17mr4720752qtc.281.1558531456378;
        Wed, 22 May 2019 06:24:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id c18sm10453523qkl.78.2019.05.22.06.24.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 06:24:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D660404A1; Wed, 22 May 2019 10:23:43 -0300 (-03)
Date:   Wed, 22 May 2019 10:23:43 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] perf tools: Add missing swap ops for namespace events
Message-ID: <20190522132343.GC30271@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
 <20190522053250.207156-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522053250.207156-3-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 02:32:49PM +0900, Namhyung Kim escreveu:
> In case it's recorded from other arch.

Applied and added:

Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")

So that the stable guys can pick it.

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 2310a1752983..54cf163347f7 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -647,6 +647,26 @@ static void perf_event__throttle_swap(union perf_event *event,
>  		swap_sample_id_all(event, &event->throttle + 1);
>  }
>  
> +static void perf_event__namespaces_swap(union perf_event *event,
> +					bool sample_id_all)
> +{
> +	u64 i;
> +
> +	event->namespaces.pid		= bswap_32(event->namespaces.pid);
> +	event->namespaces.tid		= bswap_32(event->namespaces.tid);
> +	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
> +
> +	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
> +		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
> +
> +		ns->dev = bswap_64(ns->dev);
> +		ns->ino = bswap_64(ns->ino);
> +	}
> +
> +	if (sample_id_all)
> +		swap_sample_id_all(event, &event->namespaces.link_info[i]);
> +}
> +
>  static u8 revbyte(u8 b)
>  {
>  	int rev = (b >> 4) | ((b & 0xf) << 4);
> @@ -887,6 +907,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_LOST_SAMPLES]	  = perf_event__all64_swap,
>  	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
>  	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
> +	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
>  	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
>  	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
>  	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
> -- 
> 2.21.0.1020.gf2820cf01a-goog

-- 

- Arnaldo
