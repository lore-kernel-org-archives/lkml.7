Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C42C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1121670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLkW8KWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfGEQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:39:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35450 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfGEQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:39:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so11757266qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXutjVoC8jgVoKhUDiGmm73RHoDVVCoPv9Mt3G8FX8o=;
        b=PLkW8KWR10WrhUg94UuzGXGLdZrhlDZaiDslU0PaRMoWg5eWLrzkk9MwAoKVXwLjmN
         vJe/xvbwYctM1EpEu2KOUcS9BAHASi47dEvqV/K7eBquixqO5oBZvqxRh7zYi9NyxfjN
         RWXPRiJJFS6T9m5OZmCcZmTf+fsldbmPIkX1uINo2uvk9ZydxkPfDkeEkNhvEinyHnw1
         GZ5J8NMUaIsp4na8UBd00cNueQUTCGwYIOfDaRAYbV0na9Ue3fppy6AGoTMRC9LmZuYV
         WrT8/FVjQYPXBu7PLqMo1rVF2xoQAv3O0fpMKWhgG3EalWPgWOVHMmyHyRQtfGLlq4pa
         kHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXutjVoC8jgVoKhUDiGmm73RHoDVVCoPv9Mt3G8FX8o=;
        b=HfZunk08mMTGJrRwI2AkQ0sQT86x6kZYx6elNPGFSp/fbFAD/67+ECVI9bFKJOGIQT
         q4jo0DxUEDX1V/IkFgC55O0+uab0Iw+kWRujJf9A2AQCkyefgZzjXwa1JbC+8/GUFqfl
         62EfxMLcnq9h5MFHtl/3iNrN0YovAx07QvhZwFwCEcCblE6DZ9oqFKIWN/FL4BQUN/9w
         2S2umCZicNzkkz6mcytYAfEt21LD24+ZcBG8wtuGZym+5Qx9S/KZ9VxJGlN9XB6iZttj
         RJel+tdiAF3lP/m4aFjqrxIymlxsTRcjJgzQ37gTLsMi9bCNW3j2cQ/r3FNuhpg3KTgG
         p+CA==
X-Gm-Message-State: APjAAAXYkSVou8hJI1WudufDqJ089SfKlFwJsdCm7siyBQwCOKDw/8ML
        oQA3+QRMwauWsUYkGpVK6da6nEZM
X-Google-Smtp-Source: APXvYqz3w8JXHG93etW2rqCg9gNbmGx20rqPal8mvj1/IGyWRKwy2sdUG6pHa00Hy291Hq0reL1SdA==
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr4135311qvv.43.1562344767349;
        Fri, 05 Jul 2019 09:39:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id c5sm3933333qkb.41.2019.07.05.09.39.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:39:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BCEA640495; Fri,  5 Jul 2019 13:39:24 -0300 (-03)
Date:   Fri, 5 Jul 2019 13:39:24 -0300
To:     Luke Mujica <lukemujica@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com, eranian@google.com
Subject: Re: [PATCH] perf parse-events: Remove unused variable: error
Message-ID: <20190705163924.GA8600@kernel.org>
References: <20190703222509.109616-1-lukemujica@google.com>
 <20190703222509.109616-2-lukemujica@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703222509.109616-2-lukemujica@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 03, 2019 at 03:25:09PM -0700, Luke Mujica escreveu:
> Remove error variable because it is declared but not used in
> parse-events.y or in the generated parse-events.c.

Thanks, applied
 
> Signed-off-by: Luke Mujica <lukemujica@google.com>
> ---
>  tools/perf/util/parse-events.y | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 172dbb73941f..f1c36ed1cf36 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -480,7 +480,6 @@ event_bpf_file:
>  PE_BPF_OBJECT opt_event_config
>  {
>  	struct parse_events_state *parse_state = _parse_state;
> -	struct parse_events_error *error = parse_state->error;
>  	struct list_head *list;
>  
>  	ALLOC_LIST(list);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 

- Arnaldo
