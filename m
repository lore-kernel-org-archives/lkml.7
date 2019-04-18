Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E00C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2E420693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVOgWmVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbfDRT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:29:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34841 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:29:19 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so5088804itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M10GJuf4bipDB7K/vKvod02Yi+/17RyTpQPwsi+BPMs=;
        b=oVOgWmVsFvQV9dP/Okb70pmQ/tbSTCa6wtlhVGuIzdwAwCFAbXLrjc8fD9xeIOimph
         zVGZx2qfgg2M/G1es8cNY/hdP53V0s5TJPI+oXI52HneVMAlHKhNyJ2CrdhWIX31oIMz
         p8bf79CQpXkTtKL65Z5oipT3YAdWnjupa6B1mb4Cdu6V8pg6GJuGZgeDlUf1lvKGly48
         HZhaWNnKOBeP3Lf3nmM3gQX4YKKrrGEvKFToJMzYfejecCW2SDqDLy9FpvXglzM+TV74
         Y1Cz2WrQY6fvgwcp1eo98S+3n/bMiWOEQkANjn6pFHd23rViEeKF0c03tQNFjdNYVKSo
         bSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M10GJuf4bipDB7K/vKvod02Yi+/17RyTpQPwsi+BPMs=;
        b=n794iMhWacq14HcLHR9jeSM2POeNdRX8NhMgv2K9HTpiZBqiPILt4ILtEBbExGJBKr
         lVcrsMIHw+5etMV/SbHqVsqX+IVygnTIitfgFxzWJ3Y1HCX0qOL04DJmdKWbuINRTaKH
         apdI5qfnFJ8Y3BLAwwumWFGSHCOa9xW7bcRTtmxsNtp0MCy8VAH7nx6DbU/HkLezoI2B
         cjeLi0jVPuh05XgrvhaTSzueY1hSFTER2d0D0Jg4HSRKgZNBpq643mTKhs1kBOEALJ8B
         AlBZgmBEImzPFZjDFTYiKL0bWCO/AoX9Mposdg/soJ4qbi15TlMMgmbrACgGVH008/Ce
         pTSQ==
X-Gm-Message-State: APjAAAXvMhmxF75vUTS1TyHqEqzhXsss0xq6vPAwFvCA/r2RI9ypm+/F
        zUl0EkIziHSSwdNV0PxtU8RN5w==
X-Google-Smtp-Source: APXvYqyRIW4zkX0gfv1TfDMTl27yGtcYpE3cDgnWPR+SL0p8h1LWqPICbepxtJiLI/tqYtxP2+kgmA==
X-Received: by 2002:a24:2fcb:: with SMTP id j194mr5048562itj.14.1555615758044;
        Thu, 18 Apr 2019 12:29:18 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id h133sm1406984itb.34.2019.04.18.12.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 12:29:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:29:16 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 05/93] perf data: Dont store auxtrace index for
 directory data file
Message-ID: <20190418192916.4v7bfjukc3ovei7o@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160437.573320142@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418160437.573320142@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:56:43PM +0200, Greg Kroah-Hartman wrote:
> [ Upstream commit cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810 ]
> 
> We can't store the auxtrace index when we store into multiple files,
> because we keep only offset for it, not the file.
> 
> The auxtrace data will be processed correctly in the 'pipe' mode.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 882285fb9f64..3fd154f1701b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -386,7 +386,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
>  	size_t padding;
>  	u8 pad[8] = {0};
>  
> -	if (!perf_data__is_pipe(data)) {
> +	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {

This causes the following build error on 5.0:

    builtin-top.c: In function ‘__cmd_top’:
    builtin-top.c:1241:3: error: label ‘out_delete’ used but not defined
       goto out_delete;
       ^~~~
    builtin-record.c: In function ‘record__process_auxtrace’:
    builtin-record.c:389:36: error: implicit declaration of function ‘perf_data__is_dir’; did you mean ‘perf_data__is_pipe’? [-Werror=implicit-function-declaration]
      if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
                                        ^~~~~~~~~~~~~~~~~
                                        perf_data__is_pipe
    builtin-record.c:389:36: error: nested extern declaration of ‘perf_data__is_dir’ [-Werror=nested-externs]

Dropping the patch solves this error, though there is a second perf
related build error in this RC caused by 2c0bd03b5d20 ("perf top: Delete
the evlist before perf_session, fixing heap-use-after-free issue").


>  		off_t file_offset;
>  		int fd = perf_data__fd(data);
>  		int err;
> -- 
> 2.19.1
> 
> 
> 

-- 
Linaro - Kernel Validation
