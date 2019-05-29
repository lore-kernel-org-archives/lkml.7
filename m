Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0750C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DB122293
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="clma4lEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE2OtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:49:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfE2OtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:49:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id f10so1895770wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/di+Uq1BJj/mkx3thnH4knFOJUS1q/BsL8c4jSpHxow=;
        b=clma4lEFs8bcSe2LzeJxwAOiHfHQaPUY6W7C8ogQFe+7nXs8TX76LKLtV7cVu3n+kM
         P7KOV31F1uIyBDp1kIbDOIMTkGTC7M2l1pRlEFEFnM4x3PJpO+I51lafepNrhK1deNGd
         U9rmWrfVOjBLyl1dStRxFuaOHofcjpqwDzzAjBcd2r/EmT+QkdlRIHakLaalEJoYb4BU
         G5wHV/tSRq/05aOnlLVafm8BISCiwmz+o4Up2aab+nIaNKWozGknLYFTvJ5iZ27TFIA0
         Pc6OFCV2bbYlAiM5+gqNOEMT15Utd2k/SnkwJ16lLW+p0NC+PkV1o5BpPBglkNKdplwa
         /FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/di+Uq1BJj/mkx3thnH4knFOJUS1q/BsL8c4jSpHxow=;
        b=P0PN2sqHACA4I4m9K/HLSlk86sQrRgwd5uzkMOZ3HzZt3F5qiyBXxN9hNvTJQCRxtW
         IFaU2aX5FgPOWRppAo50omgtLWtqPYUhhzltRNZGtxabYmZxCBykzcAAZSIba639OUEM
         oawhFA2j3K7WoXqfXwl24WRQQkTpXcXI+EyFifKZXAuxrwjD/fGwgDaq44K66HwpZG0h
         moNQRxu2sTrHMj3KLQWiWgSg0L2D8SmzqTPDyg5fada0Emj8lQdCExe57OlDwnHB6vk5
         AOBvl5JC/LqUhfX7hOLLFueXiVnt5eR5nXBWSJreZ47hnwdnBAWYYfGqQi1tPsh/e67h
         fwjQ==
X-Gm-Message-State: APjAAAXDdlDVf7Sku7eRSn6zv1kht0A42c/7SB05fsaP4EZW/wkLYAIV
        uN4MlpPQy9GkAxxpFcxKLdAPVg==
X-Google-Smtp-Source: APXvYqzju/6W6sadyPhgz8yiqp8zfCn/tPkWqgfcjWSsndWLj+YOlIwJkLQt3fugCXoelXNiGpWuxw==
X-Received: by 2002:a05:600c:210c:: with SMTP id u12mr6863052wml.146.1559141358305;
        Wed, 29 May 2019 07:49:18 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z13sm13986343wrw.42.2019.05.29.07.49.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 07:49:17 -0700 (PDT)
Date:   Wed, 29 May 2019 16:49:16 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: Re: [PATCH 17/41] perf trace beauty clone: Handle CLONE_PIDFD
Message-ID: <20190529144915.xe5ug7r3u2efuzme@brauner.io>
References: <20190529133605.21118-1-acme@kernel.org>
 <20190529133605.21118-18-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529133605.21118-18-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:35:41AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> In addition to the older flags. This will allow something like this to
> be implemented in 'perf trace"
> 
>   perf trace -e clone/PIDFD in flags/
> 
> I.e. ask for strace like tracing, system wide, looking for 'clone'
> syscalls that have the CLONE_PIDFD bit set in the 'flags' arg.
> 
> For now we'll just see PIDFD if it is set in the 'flags' arg.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-drq9h7s8gcv8b87064fp6lb0@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Christian Brauner <christian@brauner.io>

> ---
>  tools/perf/trace/beauty/clone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
> index 6eb9a6636171..1a8d3be2030e 100644
> --- a/tools/perf/trace/beauty/clone.c
> +++ b/tools/perf/trace/beauty/clone.c
> @@ -25,6 +25,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
>  	P_FLAG(FS);
>  	P_FLAG(FILES);
>  	P_FLAG(SIGHAND);
> +	P_FLAG(PIDFD);
>  	P_FLAG(PTRACE);
>  	P_FLAG(VFORK);
>  	P_FLAG(PARENT);
> -- 
> 2.20.1
> 
