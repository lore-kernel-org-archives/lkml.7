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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B5BC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A000A21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/I+IGB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfGEQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:39:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45114 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfGEQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:39:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so8278796qkj.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43/HQXiFm33FbsKjqjQm6rQKQJQHNK3p6k+7yHXMhWE=;
        b=Q/I+IGB6MTPCcg1lHFOrlownk+3Hx8wygJXhjMmcPGhA4uayzXFpRkWsQ8OJ+JtWp6
         CfcO4xxF3uZbL9No8YVQxu4ge09oaw8QQMHi02EsWFKT7TbE/ft7AbubWOSs+oIpQKBY
         KJkVgaFq+AvBb8sJRtPyjHW6I12UtD5w+2hUnpj13qcqrNDbV8mwLLWjF4fWIhAIoM8X
         6a99EFWfh6rtXnP/S8AlRkir1z0Xs7uWrtisZ9PYzX4m+VyzPchkTc9lYSOZuwpaZgbX
         CLtBktMHOtIlHCgWKXG+cBfS2UyyNF2azkXQWA3dtjUBVwkUPfb3bomowrLEnfy7aNjx
         yi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43/HQXiFm33FbsKjqjQm6rQKQJQHNK3p6k+7yHXMhWE=;
        b=PgAhvavJHBqv9HsyLTRnkkdI9lQX86WzaccVeYqIEi0qxh9ZfKgecCJjUwrs58bMR1
         2iHcC/dbIcZLYcp2VVvC5EVQ6CliTqXoE/ofFqzNvwCxZk4dDaQt187HdWjoricXF35l
         IU/73cmrnjtJSYaSyta++ZKHsAGNJ3G/NHuhxDUwFtrbgasQjF/7hYM6E8Dg8sSe/xCr
         Nze6RI6HF8UanC6XPgaaaq8LXbcdaHakQC8TylYI+1F2Mu8Qz8zdzE5J1XIBLyoe92i3
         QyYVrQBplL03tmi5+IGmC7vjpP3eFhsxBM46neKSZtkdH1rFZZmLvDkni3MtTexINEaY
         vXCA==
X-Gm-Message-State: APjAAAVZAd/eSQPFltROaU7sf0clSGzJtPb0MzeB7DSEtMsFg+UMpl7v
        JAz9dlEsGsz3+jpIkBjLmpw=
X-Google-Smtp-Source: APXvYqyRLT3f7pcUiRmRsTfdN9ZRTWIA1pjixaRlioaYtsf9J/uO4Iv9DctUbeM2t7xWHtOSZbeohQ==
X-Received: by 2002:a37:a6cf:: with SMTP id p198mr3831562qke.259.1562344752294;
        Fri, 05 Jul 2019 09:39:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f26sm4723248qtf.44.2019.07.05.09.39.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:39:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 332E740495; Fri,  5 Jul 2019 13:39:09 -0300 (-03)
Date:   Fri, 5 Jul 2019 13:39:09 -0300
To:     Luke Mujica <lukemujica@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com, eranian@google.com
Subject: Re: [PATCH] perf parse-events: Remove unused variable i
Message-ID: <20190705163909.GA392@kernel.org>
References: <20190703222509.109616-1-lukemujica@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703222509.109616-1-lukemujica@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 03, 2019 at 03:25:08PM -0700, Luke Mujica escreveu:
> Remove int i because it is declared but not used in parse-events.y or in
> the generated parse-events.c.
> 
> Signed-off-by: Luke Mujica <lukemujica@google.com>
> ---
>  tools/perf/util/parse-events.y | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 6ad8d4914969..172dbb73941f 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -626,7 +626,6 @@ PE_TERM
>  PE_NAME array '=' PE_NAME
>  {
>  	struct parse_events_term *term;
> -	int i;
>  
>  	ABORT_ON(parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
>  					$1, $4, &@1, &@4));

Thanks, applied.
