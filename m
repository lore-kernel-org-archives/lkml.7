Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD203C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E3E2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PViz45aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfKFOAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:00:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46222 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfKFOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:00:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so14914007qka.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e8GY1rXwBKcb+Lwe+YcPDTUeq1DMxubTmclRXFMT0T0=;
        b=PViz45aMNMK1rfF9SBa7813o21Y/gwutBw9tMmMdUictdChdtRWKU8Gh7/XnW/bxkD
         bMJX3fIxJF41b50XbbdtINkEKbPPZjHUD2GunYz10ORPVF4bvnZjf0bhA8+C5WTyxsAg
         c4nywx/Q4cdxqvkNJmP6DuRZwd7qxO7yaaa7q85bpJ8ZlXSrbDrX+UT5b5K2NRij8JIn
         I26Fz3nPNtR83xiSd7bP9YbvXT1XI0D/sSxMRoxC3CiwjczD7bK5IqFFrej6zszY5/Vi
         L3nJSi/wg5sZg6DkRbTnObEJkotJX/weMSBKdbiY6XqOwt+qc8V4hv/RsVul62TIJ/Om
         Q+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8GY1rXwBKcb+Lwe+YcPDTUeq1DMxubTmclRXFMT0T0=;
        b=XVPZ0J8bPDCf9cC9Fsh+RAsnmVkC+iZlm0xJzko7WGIjsGwbEacDiHCbTtSf8F36II
         tIX5oe+Wx0ejZsBsGu32RAbXRI4tT+yvLblXyAgJVbsTan0MaukraZ3/Kv4lJBJ64C9r
         Og9iHTqQZsfIe3cvEme9WFid4ZTXuiwGnETuzHz3IdbU/kPTQD4seH3tQqjFvCMoq7P3
         MoafxesRnf5tI/g0mUwNasVy3ab5fJy6UFYwTkf/5b2riM3qQIY9s3QYCmY0GUngHKvS
         WF3ZDUODM8dwD5L22FAtFCoB5pd0s0vd0c4tI5Lk8aPKVffzhT8ZZLJREIsAoPeWkBHo
         /ZCw==
X-Gm-Message-State: APjAAAXiK+cVkRRvA95YkzqJjlkVRW33eiWDXPHXhkXcTavfB/IV5aId
        26XHGrnNHkbX3JBI7wnziuY=
X-Google-Smtp-Source: APXvYqxHj2ckfpE0/WV/i5Zvo58qVZsKnwiS9WmeBMrPNo2oR7fqb9LJE46M3nZMzHWWXmuI5JM9Ow==
X-Received: by 2002:ae9:f012:: with SMTP id l18mr2010858qkg.291.1573048838971;
        Wed, 06 Nov 2019 06:00:38 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o2sm12444965qte.79.2019.11.06.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:00:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A5F140B1D; Wed,  6 Nov 2019 11:00:36 -0300 (-03)
Date:   Wed, 6 Nov 2019 11:00:36 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] perf tools: Fix cross compile for ARM64
Message-ID: <20191106140036.GA6259@kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 06, 2019 at 09:00:54PM +0800, John Garry escreveu:
> Currently when cross compiling perf tool for ARM64 on my x86 machine I get
> this error:
> arch/arm64/util/sym-handling.c:9:10: fatal error: gelf.h: No such file or directory
>  #include <gelf.h>
> 
> For the build, libelf is reported off:
> Auto-detecting system features:
> ...
> ...                        libelf: [ OFF ]

Thanks, applied.

- Arnaldo
 
> Indeed, test-libelf is not built successfully:
> more ./build/feature/test-libelf.make.output
> test-libelf.c:2:10: fatal error: libelf.h: No such file or directory
>  #include <libelf.h>
>           ^~~~~~~~~~
> compilation terminated.
> 
> I have no such problems natively compiling on ARM64, and I did not
> previously have this issue for cross compiling. Fix by relocating
> the gelf.h include.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> 
> I marked this as RFC as I am suspicious that I have seen no other
> reports, and whether fixing up the libelf.h include issue is the proper
> approach.
> 
> diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
> index 5df788985130..8dfa3e5229f1 100644
> --- a/tools/perf/arch/arm64/util/sym-handling.c
> +++ b/tools/perf/arch/arm64/util/sym-handling.c
> @@ -6,9 +6,10 @@
>  
>  #include "symbol.h" // for the elf__needs_adjust_symbols() prototype
>  #include <stdbool.h>
> -#include <gelf.h>
>  
>  #ifdef HAVE_LIBELF_SUPPORT
> +#include <gelf.h>
> +
>  bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>  {
>  	return ehdr.e_type == ET_EXEC ||
> -- 
> 2.17.1

-- 

- Arnaldo
