Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FDDC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4850D22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUJHCJXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGZTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:38:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37033 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZTiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:38:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so39883924qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LT0BvRmKgTqpBZlyz2D9/bFkGKnACByAIbcI+anu2SY=;
        b=NUJHCJXnjrykOXWMPW7kaKnUo7wMzCU3j5JuXWptJoXB9NKGfPRVprJrnzkldneFrH
         R86rk2jwv8UhUE5/+fT9/qJVmJ8GjZdvfya9gxlt0vbg/poT+B91PPP1qgwmRoqtMeP/
         YFdnph2aUt2D0XVYwtLBxlmp7Ey5nq07OtLvdP3qBp7eVQcFzthZISrPcUEcIqLJ72Nv
         M7xoKb26IlyMR60t/Q0tl6Cl7RMeOCm6z83RikbZt7ik4N96frVNoTPPYnmk8O1LRtrw
         TycKeO3B7eB+r0JixPf6n5EmrcMeV2S5t+6lrkOITesJH0+T8g8feJ2nhu+YICENDA1x
         GZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LT0BvRmKgTqpBZlyz2D9/bFkGKnACByAIbcI+anu2SY=;
        b=GSzKYLha705twIBILwG7etBjI98req0O824zME8om0AYt8AqbvvuKr7YHwiXUDaW4h
         JRHwjvx6vNdw+/mQFHWTdj/2ZocI7g5wgCZwc48jQLGyQmlvqmp/l/79jz+F/h4CjgrZ
         9DrgfPFYtmtYTwakRQgd2WPDQZQUGdbEQFL8Xpswq0t9eYotYEcYNrQlE57TGUz7QXbK
         rsEfFuEDAf/mG/ib/sDvu28rgVy6F4BTWitFtwz52XApjsTRJzS7V2gOLpFZeNyAu4PO
         AJPIW+kKKQMCKuvMMMdrgbtn5DbqvmbRB4WRRKnpKF8LjwAyyCCj0mRkX/BRZd/R7I6z
         hjsA==
X-Gm-Message-State: APjAAAXQWpKvWiJTX6thRcd8q0LgOAcow2J/v+cXjgr+WLeWrKWwiD0c
        wbi+JLGTorvIEU+UAioqw2k=
X-Google-Smtp-Source: APXvYqyVIG5e+cB1Hzaufmtx6YDY5dc3umrgp36L7dTvsOJcjfFgFTkV9vcBlxGgswFzamo6ZCyjOg==
X-Received: by 2002:a37:c247:: with SMTP id j7mr64521869qkm.94.1564169889588;
        Fri, 26 Jul 2019 12:38:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v84sm24360210qkb.0.2019.07.26.12.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:38:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E061240340; Fri, 26 Jul 2019 16:38:06 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:38:06 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com,
        linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com
Subject: Re: [PATCH 3/3] Fix insn.c misaligned address error
Message-ID: <20190726193806.GB24867@kernel.org>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724184512.162887-4-nums@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 11:45:12AM -0700, Numfor Mbiziwo-Tiapo escreveu:
> The ubsan (undefined behavior sanitizer) version of perf throws an
> error on the 'x86 instruction decoder - new instructions' function
> of perf test.
> 
> To reproduce this run:
> make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"
> 
> then run: tools/perf/perf test 62 -v
> 
> The error occurs in the __get_next macro (line 34) where an int is
> read from a potentially unaligned address. Using memcpy instead of
> assignment from an unaligned pointer.

Since this came from the kernel, don't we have to fix it there as well?
Masami, Adrian?

[acme@quaco perf]$ find . -name insn.c
./arch/x86/lib/insn.c
./arch/arm/kernel/insn.c
./arch/arm64/kernel/insn.c
./tools/objtool/arch/x86/lib/insn.c
./tools/perf/util/intel-pt-decoder/insn.c
[acme@quaco perf]$ diff -u ./tools/perf/util/intel-pt-decoder/insn.c ./arch/x86/lib/insn.c
--- ./tools/perf/util/intel-pt-decoder/insn.c	2019-07-06 16:59:05.734265998 -0300
+++ ./arch/x86/lib/insn.c	2019-07-06 16:59:01.369202998 -0300
@@ -10,8 +10,8 @@
 #else
 #include <string.h>
 #endif
-#include "inat.h"
-#include "insn.h"
+#include <asm/inat.h>
+#include <asm/insn.h>

 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
[acme@quaco perf]$


- Arnaldo
 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/util/intel-pt-decoder/insn.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/insn.c b/tools/perf/util/intel-pt-decoder/insn.c
> index ca983e2bea8b..de1944c60aa9 100644
> --- a/tools/perf/util/intel-pt-decoder/insn.c
> +++ b/tools/perf/util/intel-pt-decoder/insn.c
> @@ -31,7 +31,8 @@
>  	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
>  
>  #define __get_next(t, insn)	\
> -	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
> +	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); \
> +		insn->next_byte += sizeof(t); r; })
>  
>  #define __peek_nbyte_next(t, insn, n)	\
>  	({ t r = *(t*)((insn)->next_byte + n); r; })
> -- 
> 2.22.0.657.g960e92d24f-goog

-- 

- Arnaldo
