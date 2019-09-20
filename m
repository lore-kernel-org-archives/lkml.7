Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A14D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk2ubI6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406484AbfITS1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:27:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44244 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405173AbfITS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:27:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so9720265qth.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0s2k/4dZqCb5QI1iJ0CGEoO0Kfqc7aEtMtJIxGJ6cS8=;
        b=Kk2ubI6p2w/efAM2cBxgHi2oeMJYX3fDqAXNPtOI3cNaXKhenttvaBT5Pdmr2Yg72o
         k6QQLdO7axXtYG1SxNwNrXyhSbeYoU9mp4zueIuuDZSX+bMQ1ioB3aIr11JSzAm+jyL3
         64XXHHzkaIaK8ZIhLDPVY9tthMJGei/fa5S9LfF0evcX5BPyZwKg/nOERPtdDtwrNOnS
         XS2Tsf/75t1LIBCUuc9lKd+bivtRMmSmyGq16hRflLu56YMeiZtlbx/Hheua6QkkAwM+
         lopirLy0NGQv+DKSSDDakMLXUSGKEZW2fbnnbzcK0EsIkboGTQRu1HL1fryMHsJA6gVY
         eOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0s2k/4dZqCb5QI1iJ0CGEoO0Kfqc7aEtMtJIxGJ6cS8=;
        b=Byq/Sd5V1uSoVEVtxWE08ixp+pYV4OQ8qsZsROBcDGxlWr6mM4AEmiyQwIzPsafstl
         cF6eEZLSld6z1oYLr0moYI4WGqVmj2qtX8apBjwL9sIVMMJjUja9gDHJrFGXVnZxWtNV
         1XH4/ID7FdWx7SBz/3vvyLu3OU6y2fizj4YBf6d/HS2zxSiNdXz8PdpDOpDmfY1gBGs8
         f7nCUQ/L8vhfRYSPhAoSxZ0pHXoS+iK+pJenBGOdGlQ6NB1Ai08Dr3XjdVhwCNrkb9Uq
         vBHovHTJWLHYxYmbWYSxjBOZB9k5N7I5VOHcnu3BZgHxel8CKjEv151xrApzcGlaeVAD
         7Jag==
X-Gm-Message-State: APjAAAVMuWiMm2mVqIUT5d6KzWd7aVIWjuw5yp+xwlHOk+cu4tAJ+hbL
        WH/zn6C89hNsz1lub+T6I5g5CAeE
X-Google-Smtp-Source: APXvYqziOCIr9ENh4537uw4vrecstUtfsTcDEXxIDapHDCvISkEKQaArw+XgIHptYEIAfE0Mslweiw==
X-Received: by 2002:a0c:fc4f:: with SMTP id w15mr13946172qvp.156.1569004025182;
        Fri, 20 Sep 2019 11:27:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.7.29])
        by smtp.gmail.com with ESMTPSA id j2sm1218220qki.15.2019.09.20.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:27:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FA6940340; Fri, 20 Sep 2019 15:26:46 -0300 (-03)
Date:   Fri, 20 Sep 2019 15:26:46 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/probe: Skip same probe address
Message-ID: <20190920182646.GC4865@kernel.org>
References: <156886447061.10772.4261569305869149178.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156886447061.10772.4261569305869149178.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 19, 2019 at 12:41:10PM +0900, Masami Hiramatsu escreveu:
> Fix to skip making a same probe address on given line.
> 
> Since dwarf line info contains several entries for one line
> with different column, perf probe will make a different
> probe on same address if user specifies a probe point by
> "function:line" or "file:line".
> 
> e.g.
>  $ perf probe -D kernel_read:8
>  p:probe/kernel_read_L8 kernel_read+39
>  p:probe/kernel_read_L8_1 kernel_read+39
> 
> This skips such duplicated probe address.

Thanks, applied to perf/urgent.

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 025fc4491993..02ca95deaf2c 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1244,6 +1244,17 @@ static int expand_probe_args(Dwarf_Die *sc_die, struct probe_finder *pf,
>  	return n;
>  }
>  
> +static bool trace_event_finder_overlap(struct trace_event_finder *tf)
> +{
> +	int i;
> +
> +	for (i = 0; i < tf->ntevs; i++) {
> +		if (tf->pf.addr == tf->tevs[i].point.address)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  /* Add a found probe point into trace event list */
>  static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
>  {
> @@ -1254,6 +1265,14 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
>  	struct perf_probe_arg *args = NULL;
>  	int ret, i;
>  
> +	/*
> +	 * For some reason (e.g. different column assigned to same address)
> +	 * This callback can be called with the address which already passed.
> +	 * Ignore it first.
> +	 */
> +	if (trace_event_finder_overlap(tf))
> +		return 0;
> +
>  	/* Check number of tevs */
>  	if (tf->ntevs == tf->max_tevs) {
>  		pr_warning("Too many( > %d) probe point found.\n",

-- 

- Arnaldo
