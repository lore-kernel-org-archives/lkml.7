Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F403C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DBA223F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBMr/XS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfDPOUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46896 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfDPOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so23386097qts.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=obJaqUR8b3vMryj19dPA7um10nXOdV9Kj8upydZbIhc=;
        b=nBMr/XS+yjytyzSw9E21ipX6De3CXfVp60RvT7s/GsNCQQunV9bpbjXMgBbT9q7SVd
         aT6V42w3yak0kW1zQVtvfVbTeyfp18nGZJaQhaxpPMqXb2VypRa3ehlfdEqxTrLgqWPW
         VZfFMwLD3YyzVkC9ZiQPo/xWNHXTlJkroydeKB+3/C/vFb50/udG8Vb1uUjbUEhiKwBR
         /dUPT3qO9dRoHtIFwctYclTnSPUSofxvbnpQSDSAyDqBzKX5ha9qGmMuPWM3g3OdSxjq
         Pz7NpBoYyPmJqtugmnuGP3AxpgcI+tyqbOO25UDGSvPguYOprv42foxh5sn3LnyIvKpZ
         dF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=obJaqUR8b3vMryj19dPA7um10nXOdV9Kj8upydZbIhc=;
        b=NO8lXWSfvWJnIF6vxPu3Dnw29DNdd7zXOTIPr37Kx8qF5s/n8oD3ZbisUeQfZaK94l
         Q9b6/W8ZWiMestusXNteJ6hrtJ8J08sznqMzBvpIOJwZFr/5DUgMYJuBOqjJCaUSBtPQ
         4pF3MygRJcoJLcTLQvEkFc+iDsESY6LBLn1GOQivnmjmvtSqauXQ175WZhngrxW/X0Of
         3FuS4ahJ7PLe/AK0WL1CRN4V1YWQg66Fa7L2Djfi/xxogKVY4FKAMLOJN4s1l/YiPr+0
         XRjHLsljH152h54wQGTgtGXRGRQWVob9S7zqUxg0x3sBNSysTvLw95U09rlY71gWc5/G
         juFA==
X-Gm-Message-State: APjAAAUTrC9fbn4Tum/LrEtV1EEKVaLR1oEFCm+jRkyCSB1Vg7NkRQYS
        5Rw5I2yNR5qatgNDbufseoePkmly
X-Google-Smtp-Source: APXvYqzMKtQDvbIEpJlmlBt8mJD53u4QGode5WOo98DuGyZ3BOxDcMXjoS35v/wooTlKAAdSZV+tKQ==
X-Received: by 2002:ac8:37ce:: with SMTP id e14mr61844087qtc.146.1555424434941;
        Tue, 16 Apr 2019 07:20:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id e18sm13240487qki.82.2019.04.16.07.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 07:20:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA6344039C; Tue, 16 Apr 2019 11:20:28 -0300 (-03)
Date:   Tue, 16 Apr 2019 11:20:28 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix perf_env__find_bpf_prog_info rb tree
 lookup
Message-ID: <20190416142028.GH11294@kernel.org>
References: <20190416134151.15282-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416134151.15282-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 16, 2019 at 03:41:51PM +0200, Jiri Olsa escreveu:
> We currently don't return NULL in case we don't find
> the bpf_prog_info_node, fixing that.

Can you please try to figure out what was the changeset that introduced
this problem so that we can have a Fixes: tag that helps me determine if
this should go to perf/urgent (likely) or (perf/core) and to help the
stable guys as well?

Thanks,

- Arnaldo
 
> Cc: Song Liu <songliubraving@fb.com>
> Link: http://lkml.kernel.org/n/tip-bp07cla6dy6ifydl1sfoiorw@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/env.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index c6351b557bb0..34a363f2e71b 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -57,9 +57,11 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
>  		else if (prog_id > node->info_linear->info.id)
>  			n = n->rb_right;
>  		else
> -			break;
> +			goto out;
>  	}
> +	node = NULL;
>  
> +out:
>  	up_read(&env->bpf_progs.lock);
>  	return node;
>  }
> -- 
> 2.17.2

-- 

- Arnaldo
