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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E810AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84522339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0W+y/PB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfIAPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:18:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38550 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:18:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id u190so10487324qkh.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsjVf8G0s3dVgmEdOE8Dx0us8DE7z4NJfbB1KbthVmg=;
        b=C0W+y/PBXjw0rAELJ20N+uFzbatYs1xSFZ817U+ZXNpPdIkFc53RC8u6A0khk4UYHo
         l3yUxbZs7z9netIwk/tTHfMvQterDuylRutg1uWqrJ0OEG4dnVrnuLrnP55SOzLUgEBS
         keoJzz9wDqetWyevSAHU7eRyoJjkZ/idmtd8deeB7ngkBRs38cHwDYhnao3fhubDrGr7
         RGDGDYb4h8dqxh+9B5X2WLgtjFTePfCnXkkMtAKsHVzs/KuLiGI38RNMVZ59hCVqkqku
         zA6HkGi128IIgdLp4cstOpbucxbC3DYePe3AC/m3C2QSQgc4g6litwIqCwxUWPteVxdr
         45/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsjVf8G0s3dVgmEdOE8Dx0us8DE7z4NJfbB1KbthVmg=;
        b=Q3PfylLo+dtOSroKDnwqbCol2W41wJ8G2OMicT5bl6L7T8aBYv6wYylLxVgyorlX6u
         pXN8J2VxKwlZouJ9yMSE52HwqpbT9Oas1eoMJ1GM0Bguy9d1UVX1G78JbgvxD3Hxagov
         aVUi5Ba13XhszB0RZoxLcudMSuwNBZK5lTEmxypmLJ7Rk02k/b1MJbfKN75na7QVa9dJ
         rhzhmRc72VYrnXeNlUy2vbqIhmCOTy4qFJUJkkfzxAz6EAgC4+G78+xHIgERLqkIQPZR
         AqHjuhAPDgNlYjJPX2mFi7LY+IxTilB8iKkZnxN37Hk/K7Uu4vsrrLnnRyVjoc/Hzrbt
         +yUg==
X-Gm-Message-State: APjAAAVBi9PozmWtthYt5PAntZq/1su6k73tjPIbmoZiH1opSB2JVX/b
        iLm0Z8LZxS3Mx8cdJj8PTz4=
X-Google-Smtp-Source: APXvYqy//9NRrFDr+ViD3Uval7M1pLVi3Cj6fFqKYtssPykSGJrsJSqh3XLyWFAQILazLeTAiReuNQ==
X-Received: by 2002:a05:620a:15b9:: with SMTP id f25mr1564398qkk.230.1567351123330;
        Sun, 01 Sep 2019 08:18:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i12sm5284588qki.122.2019.09.01.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 08:18:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9FE7B41146; Sun,  1 Sep 2019 12:18:40 -0300 (-03)
Date:   Sun, 1 Sep 2019 12:18:40 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 3/4] perf tests: Add libperf automated test
Message-ID: <20190901151840.GN28011@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
 <20190901124822.10132-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901124822.10132-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 01, 2019 at 02:48:21PM +0200, Jiri Olsa escreveu:
> Adding libperf build test.

Thanks, applied. And also added a note that this is used when one does
a:

  $ make -C tools/perf built-test
 
> Link: http://lkml.kernel.org/n/tip-r1be6tz02ay0bf2729a7xwjk@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/make | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 17ee3facfd4d..128a0d801ac1 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -327,6 +327,10 @@ make_kernelsrc_tools:
>  	(make -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
>  	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
>  
> +make_libperf:
> +	@echo "- make -C lib";
> +	make -C lib clean >$@ 2>&1; make -C lib >>$@ 2>&1 && rm $@
> +
>  FEATURES_DUMP_FILE := $(FULL_O)/BUILD_TEST_FEATURE_DUMP
>  FEATURES_DUMP_FILE_STATIC := $(FULL_O)/BUILD_TEST_FEATURE_DUMP_STATIC
>  
> @@ -365,5 +369,5 @@ $(foreach t,$(run),$(if $(findstring make_static,$(t)),\
>  			$(eval $(t) := $($(t)) FEATURES_DUMP=$(FEATURES_DUMP_FILE))))
>  endif
>  
> -.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools
> +.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools make_libperf
>  endif # ifndef MK
> -- 
> 2.21.0

-- 

- Arnaldo
