Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59508C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E30020856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNgZ8Xlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440335AbfIWSIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:08:10 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:46103 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438279AbfIWSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:08:09 -0400
Received: by mail-qk1-f174.google.com with SMTP id 201so16357901qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WaN44oA6b5/tAnNHC3BPVUq5YRUC75SWyO2ra2AcB2g=;
        b=VNgZ8Xlge6IGXUzXjlrG39OIERNp/l11spswrRWUICljsnNbu4wcZBe+bJwzk+w2w5
         +JgizpDi+hzzyycfjYiyFJGyHPSHgN+AyU1hK+iE4nINUVFP+svALT/x0+u3NhZ60DFH
         KgZV1JGJUP/ZLtoTWdOCOID+fRSKaw8xPkSYEiCiynTCdLUYrk05isuM5g6d0zlwgImL
         OV9cD8qZgncqC7au+nVYFhrfH7ySGfxdVJReFJkJ6vWnkcJ1EfHuEJOPnM2Ci+pq8pwv
         cpXDMYB9R9JthHrlsGTz3QkmnFiY0/hUImZVxkCVUOFPUWtC1n/EOzJHTLrPSJsE97cv
         fXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WaN44oA6b5/tAnNHC3BPVUq5YRUC75SWyO2ra2AcB2g=;
        b=R6AKjObMmj8GoLRPXqnZiyCeHOCc5rNhjGy2ap86k5R0aAnfdMUDcrN3mBlQqkIHz/
         hqxS6mbWlfcljk+gVgWvYBmuf6Eq458klijvQh4HyMgD9gxza5WWvmAqo9yYjvDO0Zsm
         wGrIgjjrtxw1vogtEhs/qPjilmnsDD8c1GXTDH39UuRe1SL9E3qGf4bnCTBGvbN86oxG
         377iOwSkJyUt7aYftdLszi3/mhDyGTH1esdMsmBIDoEPeKSDk2ykIymKA/ZNc1VcG5Ba
         l/0rfMInbnAv8BACOotQPOyVGM8d9PyreVLAZrhWaGi1xJOWnhk8K0q+MX2O+mpCpUFQ
         oFww==
X-Gm-Message-State: APjAAAV/yhtQ/3sAgJt9x6xLQdVyABr8SoKNCS1ud1r8ElOemaRS96yo
        VN6k1xiyMPfbclF+mPVP1fCbghrm
X-Google-Smtp-Source: APXvYqz83AGtJaZXT8SK+j0xU4qqrLPKxmRLGxVKl/r0yz1g99wYKYIFDSs0FjsPShXE9OGW/w4PbA==
X-Received: by 2002:a37:5cc1:: with SMTP id q184mr1256013qkb.212.1569262088921;
        Mon, 23 Sep 2019 11:08:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-94-129-1.3g.claro.net.br. [189.94.129.1])
        by smtp.gmail.com with ESMTPSA id m15sm5035819qka.104.2019.09.23.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 11:08:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99D3C41105; Mon, 23 Sep 2019 15:08:02 -0300 (-03)
Date:   Mon, 23 Sep 2019 15:08:02 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 19/73] libperf: Move system_wide from struct evsel to
 struct perf_evsel
Message-ID: <20190923180802.GA13508@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
 <20190913132355.21634-20-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913132355.21634-20-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 13, 2019 at 03:23:01PM +0200, Jiri Olsa escreveu:
> diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
> index 8b854d1c9b45..220cb2e2b54e 100644
> --- a/tools/perf/lib/include/internal/evsel.h
> +++ b/tools/perf/lib/include/internal/evsel.h
> @@ -18,6 +18,7 @@ struct perf_evsel {
>  
>  	/* parse modifier helper */
>  	int			 nr_members;
> +	bool			 system_wide;
>  };

Forgot to add:

#include <stdbool.h>

Added.

- Arnaldo
