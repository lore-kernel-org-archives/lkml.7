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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDEAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6472342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkl0Ipvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfIAPS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:18:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37150 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:18:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so13104619qto.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLV1GEvowhQxcMk1RK/g6Egx7Q3ZRjMvVdb1THmpULw=;
        b=pkl0IpvbRJGuwLyqoqvdMHhN6cLvyvVR0WsRhMurWnHsH8oUZ+nvjYbVTr6Kla6VoY
         WuMz/qV1vUugFzu1TdcRLp52rJEm8h/AsMqOPywaC55ilRRtpOaT2z7oHitVeKj134b+
         grw4Rf0thm7FCT8neEbaVBMuIX0sXL7UC7/cragVUWl4iG48jEpAi9A8lzzIsdQosXCo
         RYWHAWFz/h3X0GRbLuRDoqmTjM79eQHW96dlVMhOUnvoic2AAwTKJ6ozKXdJX03Y3bpM
         OVF7pKoyNMlH2EME8hRCQKnm+2ok4EgvN700+Z8JGgpdNjRXutuY5KoxMiTBCtfOJSLX
         cUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLV1GEvowhQxcMk1RK/g6Egx7Q3ZRjMvVdb1THmpULw=;
        b=OoGi0l+IFtwrH2m3mDvS34BRgI7K36iN3o8u0JlpQd0cc6jeif4YeHYsO7a3zuOIm3
         Z3HsML1lZgX1BkWiLZ5X4ZADFlenVlT2DDozPdCHyw1GhzO/Gy7/mozdpsY85nzOfO8b
         S2vxpkSxUwA20JNZAcnbkFQCIRafm1vELVWEU7udkGArtJkzvL3yW/2N9hMqzaD8+gPn
         BO20c+yCX9RwxKpJIk/aOgIKT/KQvGbGhTWL6hBqugrvpOTemCuGFgZTVtiqkHa1AH9y
         EfIesc6J6xCU67ZET3Pk97jp1xibpjQygYxwfsMRjvKialspVaNm0kM22GXx3yAPP1w+
         SBnQ==
X-Gm-Message-State: APjAAAXyMtOf+Gs92G2lAZZUggDI8h5qg7u7um1PZ0+Ucwbt0YEViWee
        87D8MuVHP9BDaRgKtzW63aBWsVAE
X-Google-Smtp-Source: APXvYqzPblDg9KdI9oGpvtHen/WrqZBfvydxTS0c6EGOt/wWsPWMyu/0FjQZwXOJROPTfb85u41T5Q==
X-Received: by 2002:ad4:41c6:: with SMTP id a6mr16022762qvq.49.1567351135625;
        Sun, 01 Sep 2019 08:18:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b17sm1139496qtb.57.2019.09.01.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 08:18:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29D2141146; Sun,  1 Sep 2019 12:18:53 -0300 (-03)
Date:   Sun, 1 Sep 2019 12:18:53 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 4/4] libperf: Add missing event.h into install rule
Message-ID: <20190901151853.GO28011@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
 <20190901124822.10132-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901124822.10132-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 01, 2019 at 02:48:22PM +0200, Jiri Olsa escreveu:
> So it's properly installed.

Thanks, applied.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-7e989xk9ykmd60db9lym5uc6@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> index a67efb8d9d39..e325c0503dc6 100644
> --- a/tools/perf/lib/Makefile
> +++ b/tools/perf/lib/Makefile
> @@ -146,6 +146,7 @@ install_headers:
>  		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
>  		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
>  		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644);
> +		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644);
>  
>  install_pkgconfig: $(LIBPERF_PC)
>  	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
> -- 
> 2.21.0

-- 

- Arnaldo
