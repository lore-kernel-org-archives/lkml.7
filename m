Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717F52054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLmh1foF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392005AbfETOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:45:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34886 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfETOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:45:26 -0400
Received: by mail-qk1-f195.google.com with SMTP id c15so8987216qkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ofhQyIB4A6nPtsb92V5jWkKdzSPrIJPk9vscD80guhs=;
        b=jLmh1foF7cO2ohu56/whRWSjywwPOrhi2n+ahtk/pJoCtBSi/dQta0Mgte1/iI3qQC
         3V7A4Bscy7mq+gZL9/QmWdjzaHyIzt1O+xfksDfD0sv31+5Lctln9WnnskAiLaTwLxvW
         bCez9u/VpKL+JqoxiTffd2JOoK1NL6djm8zyz3t+FqpJgLhaz2QhEIx6pSmfSV5gWGfS
         IIAqF62P12L8wEOJR5Ehg17Ihac8uTlOLGiRrXG13wvRFppLE43BPLV7rCue9E/O6crR
         RmIxOR2BlEicT0Nswj0LsDCDzUg/4oj47QQxOIFTnTBMe/E9cV8F7/R++CUBRciwb+gk
         DgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ofhQyIB4A6nPtsb92V5jWkKdzSPrIJPk9vscD80guhs=;
        b=mrD0ruNQnPc6/iUASsjmpx8da1DkQVB82WCmJElHiJQ8ytDazHz2xkdUWx72MqvXgY
         1knzbGbknvim3iVNEiGmj1jX/0Fq1y2FkdLYaFjdsxmZgqOabyG53e1ysZAtCPMam0JF
         Xe8kAumkp/HQK6wFGfPtkoP9HbQG5LP5UxKEx83X7Xm7T7cMY1D3fz2+1emTuNAPOgkq
         ObvShLkfJodtYU7sfIs1/ygMnBgrmlW901AmVmcUu+IWpmnmQ1iu39LgAYW3sZlPObK5
         VEChKULOvDlpKeHng6bXJ/qTYmcksKQJCQEVfSQfglQy4D6g8NElMD2pwIq9pQBK2RHG
         45qA==
X-Gm-Message-State: APjAAAV1yxvyGmsHaMDsvrdHwAN8YyFisVYEwn76N6F6mOSRF638l0+o
        AQNssBCFXU73suUevoeI9ZIrxGbX
X-Google-Smtp-Source: APXvYqzs+wNYdFqbO/HIsthOJLfyyuyyLxqFsc/a8AICoeW0+i1IbJ04h+9KjQMvXQwAFLjdlc0wqg==
X-Received: by 2002:ae9:ec10:: with SMTP id h16mr21624321qkg.215.1558363525335;
        Mon, 20 May 2019 07:45:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.215.206])
        by smtp.gmail.com with ESMTPSA id a139sm7215956qkb.48.2019.05.20.07.45.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 07:45:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE758404A1; Mon, 20 May 2019 11:45:16 -0300 (-03)
Date:   Mon, 20 May 2019 11:45:16 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] perf intel-pt: Fix itrace defaults for perf script
Message-ID: <20190520144516.GL8945@kernel.org>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520113728.14389-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 20, 2019 at 02:37:07PM +0300, Adrian Hunter escreveu:
> Commit 4eb068157121 ("perf script: Make itrace script default to all
> calls") does not work because 'use_browser' is being used to determine
> whether to default to periodic sampling (i.e. better for perf report).
> The result is that nothing but CBR events display for perf script
> when no --itrace option is specified.
> 
> Fix by using 'default_no_sample' and 'inject' instead.

Applied 1-3 for now, concentrating on fixes, will process 4-22 later.

- Arnaldo
 
> Example:
> 
>  Before:
> 
>   $ perf record -e intel_pt/cyc/u ls
>   $ perf script > cmp1.txt
>   $ perf script --itrace=cepwx > cmp2.txt
>   $ diff -sq cmp1.txt cmp2.txt
>   Files cmp1.txt and cmp2.txt differ
> 
>  After:
> 
>   $ perf script > cmp1.txt
>   $ perf script --itrace=cepwx > cmp2.txt
>   $ diff -sq cmp1.txt cmp2.txt
>   Files cmp1.txt and cmp2.txt are identical
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
> Cc: stable@vger.kernel.org # v4.20+
> ---
>  tools/perf/util/intel-pt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 551ae10d1c7b..7a70693c1b91 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2626,7 +2626,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	} else {
>  		itrace_synth_opts__set_default(&pt->synth_opts,
>  				session->itrace_synth_opts->default_no_sample);
> -		if (use_browser != -1) {
> +		if (!session->itrace_synth_opts->default_no_sample &&
> +		    !session->itrace_synth_opts->inject) {
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
>  		}
> -- 
> 2.17.1

-- 

- Arnaldo
