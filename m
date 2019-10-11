Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51783C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9F62064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK82TZve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfJKNzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:55:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38187 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:55:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so13965486qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fu5Q0Oyp6tKh2lPmfGQugA9lYbtWy5skEb6Qa4y6e/E=;
        b=gK82TZveoLHQ58TwOBN79mw3P2zXsUn56BocsTqZsfV7GoqaDo6KDg6QINFgq5uU7l
         eQQZZWTfi6mbz+bIs417/8r7c3UlpioGxaRSb04EoU0p4HSlc41Au+24ybgkUJq3cOuq
         9pmsV2wg8F3gCZzf9coHpid8Jh9HnQJa6oATgTJhqrETHYRNJgoQr4Yh8UvbIyYLP/u/
         M3+H1wPMD/z3tZbOAuXGVmAuSGDueudMF8T2ikPypAvarA0NP76H1/nANgmlyDke47vi
         HZ0QeWR6FBwNsIEO+abyKODps1lA2TyIcPVVsKRDVhUV8rL/KGy5QGi64gOtaoFW92sq
         nIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fu5Q0Oyp6tKh2lPmfGQugA9lYbtWy5skEb6Qa4y6e/E=;
        b=A/cCEpRr9GQ2DxoHdMtjhmSDmAlsnCqPAd2mz12R2IL+/P+2oUyo49J7WRNYQFpWfp
         RhEUZQaE0bEA1H9IV0Raffs6cvHjVINqMwXbhXemv+6y2Eu9wBQO8gRM0roqPmktlUv8
         WtG1sWmaDMmB24+mnQh0yfgBpDVG+dwIdKOIvcVXBQz818F2TCE+ci5Mj5Gri/TqRoJe
         KtZHuVgeqyURziFxq0/GBy3VNrWwIY/yojOiHha46jh6q8tEngqPtP6fB7YsmQ9VUbvE
         QgfMgWgBvGSlOCLv/YZVPNDxpwdOhz0N7wsrUoLemKQXzC+UbXD4jlT/ZAqc6Wqd3cDv
         AWyA==
X-Gm-Message-State: APjAAAW8Ik0EJWDDTi9HDiymH9PhmkgviBJzy8PfUPzHeeq14/t4N9A5
        AbbU7XBV5ESbZ3arWTW8Emo=
X-Google-Smtp-Source: APXvYqz2lQS2U5OIkbKO3fQGwn4Do/DWWIv2YWkaH3C3hQ+HDl632TSMtHSeF3mnzxF/eosVu85ZBA==
X-Received: by 2002:ac8:2e61:: with SMTP id s30mr16072652qta.334.1570802145572;
        Fri, 11 Oct 2019 06:55:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 77sm4627631qke.78.2019.10.11.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:55:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 395E64DD66; Fri, 11 Oct 2019 10:55:42 -0300 (-03)
Date:   Fri, 11 Oct 2019 10:55:42 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Propagate CFLAGS to libperf
Message-ID: <20191011135542.GA32176@kernel.org>
References: <20191011122155.15738-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011122155.15738-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 11, 2019 at 02:21:55PM +0200, Jiri Olsa escreveu:
> Andi reported that 'make DEBUG=1' does not propagate
> to the libbperf code. It's true also for the other
> flags. Changing the code to propagate the global
> build flags to libperf compilation.

Thanks, applied.

- Arnaldo
 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Link: http://lkml.kernel.org/n/tip-sgq5yeyvitp655s2iq3e75ls@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.config | 28 +++++++++++++++-------------
>  tools/perf/Makefile.perf   |  2 +-
>  tools/perf/lib/core.c      |  3 ++-
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 46f7fba2306c..063202c53b64 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -188,7 +188,7 @@ endif
>  
>  # Treat warnings as errors unless directed not to
>  ifneq ($(WERROR),0)
> -  CFLAGS += -Werror
> +  CORE_CFLAGS += -Werror
>    CXXFLAGS += -Werror
>  endif
>  
> @@ -198,9 +198,9 @@ endif
>  
>  ifeq ($(DEBUG),0)
>  ifeq ($(CC_NO_CLANG), 0)
> -  CFLAGS += -O3
> +  CORE_CFLAGS += -O3
>  else
> -  CFLAGS += -O6
> +  CORE_CFLAGS += -O6
>  endif
>  endif
>  
> @@ -245,12 +245,12 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
>  
>  FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
>  
> -CFLAGS += -fno-omit-frame-pointer
> -CFLAGS += -ggdb3
> -CFLAGS += -funwind-tables
> -CFLAGS += -Wall
> -CFLAGS += -Wextra
> -CFLAGS += -std=gnu99
> +CORE_CFLAGS += -fno-omit-frame-pointer
> +CORE_CFLAGS += -ggdb3
> +CORE_CFLAGS += -funwind-tables
> +CORE_CFLAGS += -Wall
> +CORE_CFLAGS += -Wextra
> +CORE_CFLAGS += -std=gnu99
>  
>  CXXFLAGS += -std=gnu++11 -fno-exceptions -fno-rtti
>  CXXFLAGS += -Wall
> @@ -272,12 +272,12 @@ include $(FEATURES_DUMP)
>  endif
>  
>  ifeq ($(feature-stackprotector-all), 1)
> -  CFLAGS += -fstack-protector-all
> +  CORE_CFLAGS += -fstack-protector-all
>  endif
>  
>  ifeq ($(DEBUG),0)
>    ifeq ($(feature-fortify-source), 1)
> -    CFLAGS += -D_FORTIFY_SOURCE=2
> +    CORE_CFLAGS += -D_FORTIFY_SOURCE=2
>    endif
>  endif
>  
> @@ -301,10 +301,12 @@ INC_FLAGS += -I$(src-perf)/util
>  INC_FLAGS += -I$(src-perf)
>  INC_FLAGS += -I$(srctree)/tools/lib/
>  
> -CFLAGS   += $(INC_FLAGS)
> +CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> +
> +CFLAGS   += $(CORE_CFLAGS) $(INC_FLAGS)
>  CXXFLAGS += $(INC_FLAGS)
>  
> -CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> +LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
>  
>  ifeq ($(feature-sync-compare-and-swap), 1)
>    CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 45c14dc24f4b..a099a8a89447 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -769,7 +769,7 @@ $(LIBBPF)-clean:
>  	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) clean >/dev/null
>  
>  $(LIBPERF): FORCE
> -	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) $(OUTPUT)libperf.a
> +	$(Q)$(MAKE) -C $(LIBPERF_DIR) EXTRA_CFLAGS="$(LIBPERF_CFLAGS)" O=$(OUTPUT) $(OUTPUT)libperf.a
>  
>  $(LIBPERF)-clean:
>  	$(call QUIET_CLEAN, libperf)
> diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
> index d0b9ae422b9f..58fc894b76c5 100644
> --- a/tools/perf/lib/core.c
> +++ b/tools/perf/lib/core.c
> @@ -5,11 +5,12 @@
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <unistd.h>
> +#include <linux/compiler.h>
>  #include <perf/core.h>
>  #include <internal/lib.h>
>  #include "internal.h"
>  
> -static int __base_pr(enum libperf_print_level level, const char *format,
> +static int __base_pr(enum libperf_print_level level __maybe_unused, const char *format,
>  		     va_list args)
>  {
>  	return vfprintf(stderr, format, args);
> -- 
> 2.21.0

-- 

- Arnaldo
