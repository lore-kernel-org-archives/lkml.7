Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEE220833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC3iVs6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDIPBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:01:14 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36511 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDIPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:01:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so11781018qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Mm1Tgu7UCkhb5yunhqJAcrLQ95eZE4K9lMqhS46QCI=;
        b=hC3iVs6n/H2TTmAjzS20/QFI1UIH+zY6hNc+r7oqT3lY2Zmpi5Wolqj+TA99rqOlqn
         BLlJgEdbxbVqvHjKMEqjlfE5x4sBT5O2LhW2ysZD1K/iLVgTepQOOq/1A03KGkYhxtCv
         pxKcrgECmz38UDy1xAcNscDIMnh5mkrGwhoVPsuWkZGfNeBTkvrVqZn8rfa7mbUdE9qm
         hAaw09eqPGwur45O1yvquBLy2tqFrpihyG/8ZLcx4xV9d+jmw4/SXWrvQVY70KbTgovu
         Daxzz+uCxTY1s+pxbHVuvP2n0Ufc17IEpOj9hT+jsjPrR8SJWVQssxGnJoTO/1BgXsyY
         zg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Mm1Tgu7UCkhb5yunhqJAcrLQ95eZE4K9lMqhS46QCI=;
        b=JgUFpUxKr9prmUAReSFRb7xx7cxBzRuIrgEMFkXL3egkV7qe2/p+9/ZgxxQ2fDTFsZ
         S0XyyuwgZs3dAeurckgRmqpI7WuxIc8PuaqZ6l3aig7N+dVwE7r+TJd1RMuxnSmL4M5q
         Pt6eleD24efMWz14kSu+QRYS8iKVQtkcKm6kH7mSgk4p+qy0pXkPvdn/OmjT5EDc5wzB
         xG2WR32BIkK9GR/MTMQ2lZLcQLmiW6mCMWIaH2XpV3x+CLDyJNGW8uffx2SCTCN6yk5O
         xnbugRViNv4ww77pvwaV5ZPcY1T3+ixBsDFpsG/9BL0qFvWubHMM3EV1XOqzaGt6dYa3
         hvow==
X-Gm-Message-State: APjAAAVdpDLWcg9Yk0RtBAIPJTg6JOj7OiCgU5oD98UN2jsv/nkRjQEl
        IHS7mwEgnz7kQaMXdrLBzYHYmSwP
X-Google-Smtp-Source: APXvYqzyZKR1S6bd8FkAyWKkkWCXzNL9yNpVMiGWnfvMyeJ6RTAs/6qx9GFxT/HGLw7zwJN6jB++AQ==
X-Received: by 2002:ac8:21c7:: with SMTP id 7mr31199129qtz.66.1554822073101;
        Tue, 09 Apr 2019 08:01:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i24sm17872034qtm.3.2019.04.09.08.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:01:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CDFB24039C; Tue,  9 Apr 2019 12:01:09 -0300 (-03)
Date:   Tue, 9 Apr 2019 12:01:09 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf stat: Disable DIR_FORMAT feature for record
Message-ID: <20190409150109.GB31835@kernel.org>
References: <20190409100156.20303-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409100156.20303-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 09, 2019 at 12:01:56PM +0200, Jiri Olsa escreveu:
> Arnaldo reported assertion in perf stat record:
> 
>   assertion failed at util/header.c:875

Thanks, applied and added:

    Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")

- Arnaldo
> 
> There's no support for this in perf state record
> command, disabling the feature.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Link: http://lkml.kernel.org/n/tip-2uhyh815jfwikg5uhve8log6@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7f9c4b7f5d69..a3c060878faa 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1322,6 +1322,7 @@ static void init_features(struct perf_session *session)
>  	for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
>  		perf_header__set_feat(&session->header, feat);
>  
> +	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
>  	perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
>  	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
>  	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
> -- 
> 2.17.2

-- 

- Arnaldo
