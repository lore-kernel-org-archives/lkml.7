Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA081C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCF820748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLkwXSNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfKVNnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:43:02 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37914 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:43:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so6282390qkn.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Vu9sPmSwjlIIyxeVV+nIDoN2mrKh5oZBm3cUmXN2F0=;
        b=fLkwXSNnK6IqFCIvhPpSG8hJV9VK1nn31ZmxhWakpzkYlaXp/vvBL/UHC1MXmS5MnR
         OQrg2Tc+gcJKbevpsNYJap2BghrI7RYcPKwNBVVUez5rAKfgOB5U+DsgUPR3QCuMp83P
         rVlXjZF2gQmLUkEmkTyQfusq9vt9CNJ28WbtFb6i0Asmjt6lbgtf5RGs5W078sWnfOpW
         ed8jOEWWHMjIlJb1V9ui/YHX854SeNfrtYQbgkkGvWQkMAAXelHtv9blG5V8eZOfTEOr
         oZMXyDQz+GjzprGNrN02psX5/EV9as4xy3XI1ZVHbGlHxstGcnTbVT78a5QPc4c3kl4H
         fA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Vu9sPmSwjlIIyxeVV+nIDoN2mrKh5oZBm3cUmXN2F0=;
        b=r60am+6GxoMO7YI0n49AcsjDQy2LAbuxIQs4SAjlQXYS7pZHeS2zhfkWd3C8kVCN/r
         PwWUJ9ID3R8RDQN2Xg16s/zAufjfoquiKCO2jMYdnobxZCTB4w3I7SjjlDecTEGioA2X
         atkpqSRGSHQQijx/NfCiqeSd+/dG40UpEMp+fNloIKchUvHHnY+PcLnbth4DoZpJan3j
         3c9ZBdMmOTRfrSojX897G36uif8xf8RznXaPdZvU7XwXFIRq0GYLoq0JTNRBiVt6hgfV
         tn8oLiQJpZ7FV714E0bsU2M9lY7Wtv26GVMKJjVMzOb0d0uUTRzpydHV37XnBrIQoKEn
         zSfQ==
X-Gm-Message-State: APjAAAXUSETveKGK0xVBBwJy+laOdgnlw1fbMU8HVlrDVmmXW48jbfcj
        CJO2BpwFCNyITIq2If8reA8=
X-Google-Smtp-Source: APXvYqyh6li4nW4Avsh1BcO2Ek4I2DGHryoCsxGRZhSz2AuPYGxEXaVx/8MhNMTfL4nvtk69iItKvw==
X-Received: by 2002:a37:4841:: with SMTP id v62mr4116922qka.444.1574430180833;
        Fri, 22 Nov 2019 05:43:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p10sm1086046qte.63.2019.11.22.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:42:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8626940D3E; Fri, 22 Nov 2019 10:42:57 -0300 (-03)
Date:   Fri, 22 Nov 2019 10:42:57 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Fix perf_can_aux_sample_size()
Message-ID: <20191122134257.GA9996@kernel.org>
References: <20191122094856.10923-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122094856.10923-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 22, 2019 at 11:48:56AM +0200, Adrian Hunter escreveu:
> perf_can_aux_sample_size() always returned true because it did not pass
> the attribute size to sys_perf_event_open, nor correctly check the
> return value and errno.
> 
> Before:
> 
>   # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
>   Error:
>   The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses:u).
>   /bin/dmesg | grep -i perf may provide additional information.
> 
> After:
> 
>   # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
>   AUX area sampling is not supported by kernel

Since this hasn't been sent to Ingo, I combined it with the patch that
introduced the problem, this one:

c31d79e7a052 perf record: Add a function to test for kernel support for AUX area sampling

Thanks for the quick fix,

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/record.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index e2321edcdd8f..7def66168503 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -143,6 +143,7 @@ bool perf_can_record_cpu_wide(void)
>  bool perf_can_aux_sample(void)
>  {
>  	struct perf_event_attr attr = {
> +		.size = sizeof(struct perf_event_attr),
>  		.exclude_kernel = 1,
>  		/*
>  		 * Non-zero value causes the kernel to calculate the effective
> @@ -158,7 +159,7 @@ bool perf_can_aux_sample(void)
>  	 * then we assume that it is supported. We are relying on the kernel to
>  	 * validate the attribute size before anything else that could be wrong.
>  	 */
> -	if (fd == -E2BIG)
> +	if (fd < 0 && errno == E2BIG)
>  		return false;
>  	if (fd >= 0)
>  		close(fd);
> -- 
> 2.17.1

-- 

- Arnaldo
