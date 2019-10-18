Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30121835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQjd0ez7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505588AbfJRRzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:55:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33196 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502168AbfJRRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:55:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so10365614qtd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v3/vLt+EKWeioKc4tQmvCoMElLXCr/itRZz1QkYPGMs=;
        b=CQjd0ez7ZIKksXNcfJCbd/BV6+q60FHKiEhFCnfNIAmnGQ4CaB28vz6agnn55L7RNb
         OF/yjE9oqgSoP0UE8uXYwPZEMt+cUppi2exiZAT5SsSFKDemICmP2CsJHDPPBtZ9E6KX
         gsKYMHNn3C16hfs3sqrKV28vA95P/wVEdnY+lnd/9r3CxIMKuozyHQdj2lXckSBzvqfG
         +mekiEKMdQWyhKrLBtQFRXa6nX+OrsdHgnty+fzIt5t46pNtaRpGMTbiUjhyIPZHoRL+
         PvVtBDJFGO/nPeJaLBj13rWaH6gixGOK/7PHQIhMOQQxQ9m9qu87EdlGD9/TdnXnh6MS
         IesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3/vLt+EKWeioKc4tQmvCoMElLXCr/itRZz1QkYPGMs=;
        b=mtDHQqk2Qe9U3wd5hHfyck0B0ujv/AgaN05B4iqE7HN1QwOpQFouT9uaOsZ5d9mofz
         s8y2MJhKym496EGOgivAYSv1heiXG7ckcQgj0seIB/jrUN5aQH+ryCsABvYauyZ+9qYu
         uecKkURp+pdT3cI30zsMGtSkfJOBvHziVsWcBAIDaOzeif8xhbSg0uiYMBi3dGTmdi5V
         AsAkvXoLMDOptGf5DrEHvytvhiPl68nJY6p98alw6JXNFUHJdpTxSiCXQMiebxA4p3zm
         HokHPhQPQpAJpR0KEWc7pV8M2jz7DW5WlJMgdFMMNJ0tS5q+hJsgAeJnbeWruFoaeitV
         J1eA==
X-Gm-Message-State: APjAAAVT3v6OH7Z7BApwMFy8Tb1u8hkGoEiinglTVj6XyD+/dtVzlUaG
        DAfDyufzpPZedP67pu5yIBo=
X-Google-Smtp-Source: APXvYqwnyiTvQk/p8Geuba9pxGmWxDiCiVvefnbXVy2Gi/Sajdhi3bSP6ghlzKPtoSxFYXgiEJhBdA==
X-Received: by 2002:a05:6214:801:: with SMTP id df1mr7170086qvb.54.1571421347113;
        Fri, 18 Oct 2019 10:55:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id d23sm3341360qkc.127.2019.10.18.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:55:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3EE894DD66; Fri, 18 Oct 2019 14:55:42 -0300 (-03)
Date:   Fri, 18 Oct 2019 14:55:42 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf tests: Remove needless headers for bp_account
Message-ID: <20191018175542.GA1797@kernel.org>
References: <20191018085531.6348-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018085531.6348-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 18, 2019 at 04:55:29PM +0800, Leo Yan escreveu:
> A few headers are not needed and were introduced by copying from other
> test file.  This patch removes the needless headers for the breakpoint
> accounting testing.

Thanks, applied.
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/bp_account.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
> index 016bba2c142d..52ff7a462670 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -10,11 +10,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> -#include <time.h>
>  #include <fcntl.h>
> -#include <signal.h>
> -#include <sys/mman.h>
> -#include <linux/compiler.h>
>  #include <linux/hw_breakpoint.h>
>  
>  #include "tests.h"
> -- 
> 2.17.1

-- 

- Arnaldo
