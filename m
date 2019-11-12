Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9693C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF1E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPJyv/zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLLEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:04:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38599 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:04:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id e2so14015765qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYz3gGTyFyQw31RJBI2t4RviUtjg6Hf/pGBgh/emmKw=;
        b=KPJyv/zsiaoU+mA1Lg5djNIgFODfhCkFtSTUMVPrrcV+TfGQDIrTL6yuYlRueGSR4v
         Ft8/NgiRtlXf7a/+nprTdY9m4X4pM1dcEE7HmkDzmvX776OPrKsPaenokcB6XY5xOI99
         XM+LPquNP0yTeuEHyGUr1bpemlaiVbNQ1asPdHPw/MuQK2IsfDd9bsjwV3qEho5/qYiz
         aUETBQgQ6xhMk3c9X5h2IF4I/xzRDYqHzfReGmYQ/TFzIRBBeaiE6NAVtSu8MfIfC0E4
         ZJAbr5viOEnZEIM3wKNYdi4CvCpZTgJRQnnVCpHyPMol0bzZgrv6IqDCkflXmJaMteSr
         f7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYz3gGTyFyQw31RJBI2t4RviUtjg6Hf/pGBgh/emmKw=;
        b=Mee08xgSi+OKi3mCEdEt6oU7UdhmW3gMyrZZbkZnkrHDWSISd6WuE9Dng5Vkg9LdWF
         3317yIyzpQIj7LdjsQK65lr3Xoynz2ZObH3euiOA7nrNbKWrMLslroKWlqEw8Bs/kA4e
         h9B7MsUwwWqQtLkn2t89+3YLEVEL+LBObaHshtKAKkHC0RXImYXJGVY/6rTRXHFoDBkZ
         xnJeYS9uS0am0cUSNBit9je+kHtmk/XuH8C2XEZwjoqZb0s5rQwBDow+g1OzpILv1Yyj
         pVPIbBMCK4fZfw+De+DWtua3MHqkNBY96Zm3Hj9u6KFMk8OX/pCRqki3bPT8evhvvfN5
         /whg==
X-Gm-Message-State: APjAAAWcWsITOywBB1Rauolsfm29d54eIkONn9oEs77jaxUZNZhJmmCD
        8CzbnHL/bR67oTfc0hVqbnc=
X-Google-Smtp-Source: APXvYqyVE2hb4RZ/ySAZHOt+KC6EHpG23XuRA/PiWgIybPxqStnKnMgq0ytT1Hp/obn9T2M3Adugcg==
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr2582599qkl.26.1573556660915;
        Tue, 12 Nov 2019 03:04:20 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.182.211.47])
        by smtp.gmail.com with ESMTPSA id 187sm9363128qkk.103.2019.11.12.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:04:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45FDA411B3; Tue, 12 Nov 2019 08:04:17 -0300 (-03)
Date:   Tue, 12 Nov 2019 08:04:17 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, kan.liang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Fix segfault with '-F phys_daddr'
Message-ID: <20191112110417.GH9365@kernel.org>
References: <20191112054946.5869-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112054946.5869-1-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 12, 2019 at 11:19:46AM +0530, Ravi Bangoria escreveu:
> If perf.data file is not recorded with mem-info, adding 'phys_daddr'
> to output field in perf report results in segfault. Fix that.
> 
> Before:
>   $ ./perf record ls
>   $ ./perf report -F +phys_daddr
>   Segmentation fault (core dumped)
> 
> After:
>   $ ./perf report -F +phys_daddr
>   Samples: 11  of event 'cycles:u', Event count (approx.): 1485821
>   Overhead  Data Physical Address  Command  Shared Object  Symbol
>     22.57%  [.] 0000000000000000   ls       libc-2.29.so   [.] __strcoll_l
>     21.87%  [.] 0000000000000000   ls       ld-2.29.so     [.] _dl_relocate_object
>     ...

Shouldn't we instead just bail out and state that this isn't possible
and leave the user wondering why what was asked isn't presented?

- Arnaldo
 
> Fixes: 8780fb25ab06 ("perf sort: Add sort option for physical address")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/sort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 43d1d410854a..c2430676e569 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1413,7 +1413,7 @@ static int hist_entry__phys_daddr_snprintf(struct hist_entry *he, char *bf,
>  	size_t ret = 0;
>  	size_t len = BITS_PER_LONG / 4;
>  
> -	addr = he->mem_info->daddr.phys_addr;
> +	addr = he->mem_info ? he->mem_info->daddr.phys_addr : 0;
>  
>  	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", he->level);
>  
> -- 
> 2.21.0

-- 

- Arnaldo
