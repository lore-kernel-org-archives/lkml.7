Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12887C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BE22083B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzQdyurT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfJNONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:13:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36467 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfJNONI (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:13:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so25644638qtf.3
        for <Linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZ3rccVGeVrHUmhs//jjhK2tJO3MmAegA7SZwWj1JLA=;
        b=JzQdyurTT+jZso8Ya3oQzG6fNUhLKT88o2XbbgoTludE61y7CbFwXHXAV6Gm7jJdrW
         hxkOW8Ftsg9YNjbGV5uuIVvx5fdtdWIrcurUg+He1SODu+oU5TmYkqxTm9EzHSrIOXtn
         70Unrd+Is/kjQFJkxmWM7Q0oyx/EhzshORHtED9LdFtqzLySYX9qDQQQkhsS2/+JpyhZ
         9LFGhZpOCV1JLvEbFZ/RgP/q8H6J9eIGJ1WDvhB1aWSn27lYA5ko/eEaLXWyDVAgCtpF
         IJ1V+RxsfeXMvSwtZVLP5V+wQtQ9ytWqxsI6RGzmgg+wRXMkyjmWeTg276HF8oqen44f
         sBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZ3rccVGeVrHUmhs//jjhK2tJO3MmAegA7SZwWj1JLA=;
        b=J+BbO6/XzsTQEz2tP/FgGZUVvWTrDZ7Bnwi79jNDRYryf4Ey8G0Jctl/E/cyOrKnFN
         8n4jNJ3+X1bmrnMqUp4e+CCJtFfmt0AnjZMIIGlU1FeZTAmvvCW/BCmNX+fwubdKlZgu
         aew40xeI9tOfh7/L7tbqBFWwYBy/1P5ThCdQgquk9AysbJOWyQ9YJQNFw2ZytFlz0TG6
         4clCha+koBjAD8RpTIFrlry1AvTkHn4/S2O1W5Zv2YtCCF6j7r9Ol3nhoGcX4AmDZos5
         tzPgt5aWbBl+qB8ibTMd56jWE0z61Fjh4aY7aAthlYdMcOnTG/7csrf6BHUrINSGea01
         PD3g==
X-Gm-Message-State: APjAAAV4OC2FE3IRGBw5i5sm7FbAQvtrTx0O14B3hOCN0SXis0Zsjjsi
        X1tvcxzpqhJy2bDJfLFaPiM=
X-Google-Smtp-Source: APXvYqwHYkcFv8Sz4pXwmWx133Ovs3sMgkaR5mL3MylODfsvDnudBLdr02caE61kUk/RXxFUUZVvOg==
X-Received: by 2002:ac8:35ba:: with SMTP id k55mr33191056qtb.110.1571062386882;
        Mon, 14 Oct 2019 07:13:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e4sm7969376qkl.135.2019.10.14.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:13:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E8C34DD66; Mon, 14 Oct 2019 11:13:04 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:13:04 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Add warning when libunwind not compiled in
Message-ID: <20191014141304.GE19627@kernel.org>
References: <20191011022122.26369-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011022122.26369-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 11, 2019 at 10:21:22AM +0800, Jin Yao escreveu:
> We received a user report that call-graph dwarf mode was enabled in perf
> record but perf report didn't unwind the callstack correctly. The reason was,
> libunwind was not compiled in.
> 
> We can use 'perf -vv' to check the compiled libraries but it would be valuable
> to report a warning to user directly (especially valuable for perf newbie).
> 
> The warning is,
> 
> Warning:
> Please install libunwind development packages during the perf build.
> 
> Both tui and stdio are supported.

Thanks, applied.
 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index aae0e57c60fb..7accaf8ef689 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -399,6 +399,13 @@ static int report__setup_sample_type(struct report *rep)
>  				PERF_SAMPLE_BRANCH_ANY))
>  		rep->nonany_branch_mode = true;
>  
> +#ifndef HAVE_LIBUNWIND_SUPPORT
> +	if (dwarf_callchain_users) {
> +		ui__warning("Please install libunwind development packages "
> +			    "during the perf build.\n");
> +	}
> +#endif
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1

-- 

- Arnaldo
