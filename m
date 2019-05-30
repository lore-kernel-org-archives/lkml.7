Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524D923A1E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvF+ndgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE3MnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:43:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32927 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3MnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:43:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so6745803qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+V5SWVbmLB45AILz1KmTrjb2ygLvnb9c4k3DnNULQsQ=;
        b=hvF+ndgKPf10iLKA+j8CJoUZBFuD0CMjpSKl44suU4fTwKCdGADa7d/g0lqx1LAhJ4
         REUilKy4A1g0FOkW+bBCZ07fj6dD41V2Ha7FVHG6ddnClDCHCvTOqDWhCC998NyRvcNq
         tUcsTemobF/GOiTNfYDMTTDuX7J1nvMu9l+MZdXTm50PUO6pSVknMM9BfEuyhGaDQixb
         LyF1DhvE5aKgrY01LRgNhk2YcxCzftUvjx3zjkJsHYyC0iuzBJRy4uqsIOICX8JDFIuS
         dKjfqRkrRYF7/Al/Oo1Zd99PE/fJw2yzxLz0DjoBvdudALBDuo8g4bVvewtg+091icz7
         HdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+V5SWVbmLB45AILz1KmTrjb2ygLvnb9c4k3DnNULQsQ=;
        b=XOvWtdbzQTgfxif+7lWAk/yo9rk5Z6mGIldQ7gwc8Web2Pr3rvaRLKD4TNwT2RaMdn
         4pHDj8Fx9IBdM/7xvFJm8zKK0OqRx2eg8qJqONa7D1qgs/svRKHBzgLTWHoau1EaNHI0
         IGQkotMbAHyDiUGuwgPv+yeTzvGWYHKUfmzq2Z7qqB+HNc3l3WLJycbtJUrmyhM4zL9b
         R24j1azB5kuNw0cZeFNDZPd/fiDUeW5sA9POPunXlWoZQWsg3cDkLR/nekzPBl4vbMcd
         tuR2MdugNK/AO/iSHoH6h2enHGCgWD0qn6z+Og8CpNX6sgB3k1GpnwAOmpN3sggCe3Vs
         6fsA==
X-Gm-Message-State: APjAAAWLnRqONIyVvbIGCXoa90LOmE6pTRm592Cyf155yeAvOTLNtDZH
        8xoENlPidbPzvKHaD9NW6gY=
X-Google-Smtp-Source: APXvYqw3h8yZGzdcQmvgcDEYkNOmOJKUIyqJsFMpNQpI4ShRGE9TW0/DenOaobqeuguy7DZuNFiSWA==
X-Received: by 2002:ac8:183a:: with SMTP id q55mr3322768qtj.23.1559220185932;
        Thu, 30 May 2019 05:43:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id s35sm1417645qth.79.2019.05.30.05.43.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 05:43:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B7CB41149; Thu, 30 May 2019 09:43:02 -0300 (-03)
Date:   Thu, 30 May 2019 09:43:02 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Remove unused variable 'err'
Message-ID: <20190530124302.GA21962@kernel.org>
References: <20190530093801.20510-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530093801.20510-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 05:38:01PM +0800, Leo Yan escreveu:
> Variable 'err' is defined but never used in function symsrc__init(),
> remove it and directly return -1 at the end of the function.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/symbol-elf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 4ad106a5f2c0..fdc5bd7dbb90 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -699,7 +699,6 @@ bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>  int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>  		 enum dso_binary_type type)
>  {
> -	int err = -1;
>  	GElf_Ehdr ehdr;
>  	Elf *elf;
>  	int fd;
> @@ -793,7 +792,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>  	elf_end(elf);
>  out_close:
>  	close(fd);
> -	return err;
> +	return -1;
>  }
>  
>  /**
> -- 
> 2.17.1

-- 

- Arnaldo
