Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C1EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587A5233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tk0JajPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfIAPPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:15:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35656 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfIAPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:15:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id d26so2856861qkk.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70IsHT9M7wHC5sbEsMlcBOHr5LV3ctdi6TIiJAxnIsc=;
        b=tk0JajPcEgvD26gilbHdnhaaVrcVPAGP4+USKl7uvrugQIQ3kGSXiz9S1l9t79RCGW
         wSajhc7H5+TrWuV3AnhbuyL/4oQzFyyo6PkEfyeXrmaLsWn24xA7OsOqmmaDtoaGIfr8
         I/HOKvnfJqH5F7B5oO7ZN0BnA09jv/Gi1nDJKH0jZDky5fFa+qqRyDlYDTZ0S7WKdilJ
         TTdamtSOn2qagAqv8Oh2PVIIkl7a3o8hjvNxif5rdgcb6gfTDz2T7bvZqdk2ywynAunZ
         EP6q0r+D9yeRec9DAjpgzF9039ZrZJv2ke4aZHFXBvEleD9dva+w5+ieDYXM74D5q1rI
         nAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70IsHT9M7wHC5sbEsMlcBOHr5LV3ctdi6TIiJAxnIsc=;
        b=J9N19+AK0iLRpCxx5c7JUMol679Js9qZki+0nlEyGD1EtbbK8uyPxy14AJnaYC6OOR
         3uNRD+LUp8cW3g7SWVDOIP2Pz2MJgqaqj/4MbQr+e5Iyt/WQP67qLuA0L5fS50sMyJ57
         NDeu1XUfmbidPdcLY0ulgwD6Zykk+PUjz0rctvEVxE/tSBcajnTOjbJ77nvpXK42TUOS
         7J7MmJ5nIkMPPAoy9PD4+upBL+d3pq9Piaik5oNE0AfF99ozWwYEO7bQrpnfvp50REVx
         Jgst13VBzUCJ6DEciu8hr22skiAFbtFhnMTRCWKy3OiIqTYsw/qMOJW43oPvbdUWGTUH
         KWoQ==
X-Gm-Message-State: APjAAAVHDONAO8JqgbdkkuD43uQHlFnHyY/DINIXHLc1F9wmdzeesdst
        hbUrYnE4jfzmJaOeEam2cac=
X-Google-Smtp-Source: APXvYqyNQ29zmAzLyAokohJjcIsmZZDLjAAvNBpcmrGJVY6XGC6VhZOU0gwPZHt3veLO1ZY5mmvrRA==
X-Received: by 2002:a37:9c88:: with SMTP id f130mr24409751qke.494.1567350930991;
        Sun, 01 Sep 2019 08:15:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e2sm5379927qki.70.2019.09.01.08.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 08:15:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 638F941146; Sun,  1 Sep 2019 12:15:28 -0300 (-03)
Date:   Sun, 1 Sep 2019 12:15:28 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/4] perf tests: Fix static build test
Message-ID: <20190901151528.GM28011@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
 <20190901124822.10132-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901124822.10132-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 01, 2019 at 02:48:20PM +0200, Jiri Olsa escreveu:
> Link: http://lkml.kernel.org/n/tip-ibdgg163291sx5m5xkojx5sq@git.kernel.org


Can you explain why this is needed? Wat is the problem with building
statically with those features? What happens when one tries to do it
that way?

I.e. what is this fixing?

- Arnaldo

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/make | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 70c48475896d..17ee3facfd4d 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -100,7 +100,7 @@ make_install_info   := install-info
>  make_install_pdf    := install-pdf
>  make_install_prefix       := install prefix=/tmp/krava
>  make_install_prefix_slash := install prefix=/tmp/krava/
> -make_static         := LDFLAGS=-static
> +make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_JVMTI=1
>  
>  # all the NO_* variable combined
>  make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
> -- 
> 2.21.0

-- 

- Arnaldo
