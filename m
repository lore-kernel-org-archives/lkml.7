Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169EEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C2F20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 00:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSIlE6Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfIIAFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 20:05:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36571 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbfIIAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:05:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8039360pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x3ED2udYQj7z21wxhPjtTx0uq5M/bxOgQBiN+Fe7R7M=;
        b=KSIlE6Woq6KlLFCFP2rT2L2upPFlGWpGebR71QsbqavbP20EqFo2NcPrTMHxvzuHLS
         xj8pERDYQZVH+9OH9Qxg9eJFtHLipf2BHxPY3lmp11TBIXh5zq/pdstCxpk4SbC17hB2
         Wkhl/p4y6E0TJKxsHw0mdEL19juKCd92fzQpRBxrmZmjwgFRPwEy2yaZmHDO6yLtXYwd
         gckGNGJe+kKPzkMa75j0fQVFxXTRWvQqeSvyDpG8xts1OQQEReGKfNDwqrGtbJEdiFYr
         KRvB16nwJ1NskSdvkwc74xa2upKqwjdrAPAXY7mRsXmxJ4F3haLsdmiA+KCUoPXedDjH
         a+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x3ED2udYQj7z21wxhPjtTx0uq5M/bxOgQBiN+Fe7R7M=;
        b=ciySb3Ahq0O02PRniZI6gUOU6fxL/IjdTy60/ud6WFv9dmZwHdtg1yhyZxXuxfxlrN
         V+Rh3HO+cVqfB1r67vwVOH5um5WW6k5EvbmhNuLyqxfF2zO/x41fVhdBEgZaeafbLbBc
         Md2x2D4jqZTm3YQduDzwZBEWPUYTh8HPTyDwL6ILL7z4AAnZUl5fQXROyBYtQix+lB4S
         rMGzv4I/qt24avbiIqRBM2UKacsnQ/8h4wZgPSj6b3VVRHvGmHO4DabZuBhQp/kCdicX
         jVXD+asbXkhaXM+Urx/v/D3JqMHrSK53ttQ9dfwvI+9l9ma2DeSH0/WIza9fVECJUmsp
         r+rA==
X-Gm-Message-State: APjAAAVTJ5RrQ+No+maMiN+53WsXkAPWxFNgWvPJBErWM9+FPzsWYvOk
        d1m0fbQFiRvO8tL+UoOZJJPlIBn4FGO//g==
X-Google-Smtp-Source: APXvYqz+4NjTLpOaPBQV8rx9vKuh8FufFq3VpIFcqS+nrRcIBjNVvOsG1MPpIovGFWwnIOF2UeK6lg==
X-Received: by 2002:aa7:87ca:: with SMTP id i10mr3551591pfo.58.1567987511273;
        Sun, 08 Sep 2019 17:05:11 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id r27sm15024622pgn.25.2019.09.08.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 17:05:10 -0700 (PDT)
Date:   Mon, 9 Sep 2019 08:05:03 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: simplify ftrace hash lookup code
Message-ID: <20190909000501.mstkqzklma7pm76d@mail.google.com>
References: <20190908120545.11614-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908120545.11614-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:05:45PM +0800, Changbin Du wrote:
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 005f08629b8b..74162bc4024d 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -941,11 +941,6 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  
>  	preempt_disable_notrace();
>  
> -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> -		ret = 1;
> -		goto out;
> -	}
> -
Sorry, This remove is wrong. Will update change.

>  	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
>  
>  		/*
> @@ -967,7 +962,6 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  		ret = 1;
>  	}
>  
> -out:
>  	preempt_enable_notrace();
>  	return ret;
>  }
> -- 
> 2.20.1
> 

-- 
Cheers,
Changbin Du
