Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85FF233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTKmvoyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfHVPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:24:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35739 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730842AbfHVPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:24:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so5503284qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=odvCOXj3UumVA2n+f7aef7KNjmkmoOgl5FgEwfn9Tf8=;
        b=LTKmvoyDOtI8+cnmX5WagSmAPXowvfTqeoMk0yP1L1AXljbfsoeh7qtEV60ohWvajT
         Wf7oZWKKgaHellGhB/may3c3uBlyfQSF1WsvmyUe6pSGV/4iuUVrKMmEb7ZMZJhqWZes
         le8KG1nwaojukDQxYUIXbbG/s1D3tk6zWQy6OFuvFH1878Z3gVKob/ESeHL6tNXFaCp9
         mR0pvKn+G3QXmfQOrzXrMnITu/4PO1LUBH2sAezrIWn07g/3EbX+ATp9uYW5tPavG/OA
         IBcOBDYX5WluiIF1V669MinYYojV3Fj7bBKwKpuN0EAH7+ge8KNE2nAckv7hpYLWZXxU
         bzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=odvCOXj3UumVA2n+f7aef7KNjmkmoOgl5FgEwfn9Tf8=;
        b=rC1IEdnaYXl1JEI8U44EALe258vcIFFkxWuAEDkKJ26hFs2dnGqz2TVrinmx1wvILQ
         VPqBiebrgMYp2kSU2tlAkoTvhgv3FxMbc0WErRZ7EPYs2xyIH5bD093ybGMUi9Apjo3o
         gglvSz50HuPAB3YGVYAu82UpvuhhbMGy9LLO9snUIfj2PxSb/z8a7P7nCsHrfuaIn0WH
         KMG2E8eTM6ICnOZQKQOY4QaHMTDJYUDk4vncNJh5KdlwNd/MqQDAsYQTJk3xxsDKFh/O
         4RbTNUBJPJGWSb5vhd1rkf5vuB/GgCn722DAm2PshudTh0l2l30jW+tGAiIg/zVhVnyp
         zg6Q==
X-Gm-Message-State: APjAAAXI43xRT7UYua7veISczlZfYnVEYMXWhz0LKQOeymzwDXljqstS
        v6FpnJ4MJIx955vL9PbM4t8=
X-Google-Smtp-Source: APXvYqxrfZYf1LQJpL83KkMXacTD6/xp3AlHaGqxOc940hRUvJRm3oo4e05QdGjNT2UQqBmyd6cQTA==
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr36365876qkg.478.1566487478538;
        Thu, 22 Aug 2019 08:24:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r4sm13878895qta.93.2019.08.22.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 08:24:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A955A40340; Thu, 22 Aug 2019 12:24:35 -0300 (-03)
Date:   Thu, 22 Aug 2019 12:24:35 -0300
To:     Gerald BAEZA <gerald.baeza@st.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] libperf: fix alignment trap in perf stat
Message-ID: <20190822152435.GD29569@kernel.org>
References: <1566464769-16374-1-git-send-email-gerald.baeza@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566464769-16374-1-git-send-email-gerald.baeza@st.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 09:07:01AM +0000, Gerald BAEZA escreveu:
> Following the patch 'perf stat: Fix --no-scale', an
> alignment trap happens in process_counter_values()
> on ARMv7 platforms due to the attempt to copy non
> 64 bits aligned double words (pointed by 'count')
> via a NEON vectored instruction ('vld1' with 64
> bits alignment constraint).
> 
> This patch sets a 64 bits alignment constraint on
> 'contents[]' field in 'struct xyarray' since the
> 'count' pointer used above points to such a
> structure.

You forgot to add Mathieu and Andi, which I just did.

I think this is ok and I'm applying, please holler anyone if think this
isn't the case,

- Arnaldo
 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>  tools/perf/lib/include/internal/xyarray.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/lib/include/internal/xyarray.h b/tools/perf/lib/include/internal/xyarray.h
> index 3bf70e4..51e35d6 100644
> --- a/tools/perf/lib/include/internal/xyarray.h
> +++ b/tools/perf/lib/include/internal/xyarray.h
> @@ -2,6 +2,7 @@
>  #ifndef __LIBPERF_INTERNAL_XYARRAY_H
>  #define __LIBPERF_INTERNAL_XYARRAY_H
>  
> +#include <linux/compiler.h>
>  #include <sys/types.h>
>  
>  struct xyarray {
> @@ -10,7 +11,7 @@ struct xyarray {
>  	size_t entries;
>  	size_t max_x;
>  	size_t max_y;
> -	char contents[];
> +	char contents[] __aligned(8);
>  };
>  
>  struct xyarray *xyarray__new(int xlen, int ylen, size_t entry_size);
> -- 
> 2.7.4

-- 

- Arnaldo
