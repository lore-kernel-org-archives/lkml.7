Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E911520859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOfdJFYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfDVQF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:05:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46549 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:05:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id w26so5858307qto.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqe5T/IHGzM/3+cSrJc7hY3YX15Dn1UASNLwG/n7aNU=;
        b=HOfdJFYTVowlR4tf9AJysITXeJFAozu9WQhBheF5lRuilQzhC9QlPlVNA12ORJ04H7
         ZHW8imyjJWNc6woE4cnUd6ohPAVODfaHztUWHBC+xAMRsgRuMYQ3DjCQKeGkRYUb1hYK
         JdGnUChhS1AJUO6trjkanJBiT+Z5gCQlDwKwZxlT2BOMfmcmGz17nfJ7bjj7HDY1UkY4
         v6Unyont4OS7r27Z+5oz9dsN7Bu4pLq+E91Xn8vW+LeK0/wWi5h2dIgV3J1PS3813st6
         iKa0L4jeDd7oK92MfwtzW9sHFVzK3pBnItK3hrWefZyKwh5EAjpYlQsBnE0GYDAloAKb
         hcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqe5T/IHGzM/3+cSrJc7hY3YX15Dn1UASNLwG/n7aNU=;
        b=Ukqtm6C3XOeZ9p0x4NM7bT5+b3NlHqIujVtokZbdzhxnHH+OCmE070lldFo5YJI5ju
         IZY5QNE7rZzj1bHStGrdgZA4sUXQmgtzvSffLFVJTmXSmgvJ8sKugxC9Z3JKuYrUJ/iM
         eTztTsbq3JIc0s0CmD46PpGxVd8U1dElJfgKFPP5K5oCMCr95p75aaiMA8QbFOytoe1y
         Ho3qFSg4gOkPDmhaQr6D6px0zvm+RAXdrHgneSXLkPnuOZa4SAlqDSJExzdGSioRyEqb
         TvIJ6liVBjrtn2ubQTquWFMvG8SHZZ56YFDDC7+EUnbVO5n2xmXe/bTBRCBsWeNlkS9H
         EdUQ==
X-Gm-Message-State: APjAAAUJ/tjmTCLLuEGbL0ofHlXY5j07T6on+vfJqs8BBz7QG1EBDGH7
        7unWaRvedXassK9Qy1cC+iE9xvml
X-Google-Smtp-Source: APXvYqwpVod+ytk0hi3EOaoqeoO3mu8KX9cQ+0DfnTbLNpG3OrRQ3PT2wH0uiDtZt6a0v/jRNX+2IQ==
X-Received: by 2002:ac8:1a6d:: with SMTP id q42mr16477686qtk.129.1555949127832;
        Mon, 22 Apr 2019 09:05:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-94-129-110.3g.claro.net.br. [189.94.129.110])
        by smtp.gmail.com with ESMTPSA id h27sm8247415qtc.1.2019.04.22.09.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 09:05:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76EE0403EB; Mon, 22 Apr 2019 13:05:23 -0300 (-03)
Date:   Mon, 22 Apr 2019 13:05:23 -0300
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bpf: Fix lock/unlock imbalance in
 perf_env__find_btf() info
Message-ID: <20190422160523.GC11750@kernel.org>
References: <20190422151056.GA24665@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422151056.GA24665@embeddedor>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 22, 2019 at 10:10:56AM -0500, Gustavo A. R. Silva escreveu:
> Fix lock/unlock imbalance by moving the call to up_read() just after
> the *out* label.
> 
> Addresses-Coverity-ID: 1444762 ("Missing unlock")
> Fixes: 2db7b1e0bd49 ("perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf()")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  tools/perf/util/env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 9494f9dc61ec..6a3eaf7d9353 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
>  	}
>  	node = NULL;
>  
> -	up_read(&env->bpf_progs.lock);
>  out:
> +	up_read(&env->bpf_progs.lock);
>  	return node;
>  }

too late, this was fixed already, also detected by coverity :-)

- Arnaldo
