Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8CF24672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJJMbzW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAFWPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:15:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38916 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:15:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so40931262qko.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtL/MNOJtUrGbjT5VpkANRdtrGSGAxkiN6V9TVgQwzU=;
        b=JJJMbzW9YBmeuNv/3k9/eErSieAjRSfdvRjJEcElYQYLDa7ojirc3dsMJxLFep0Aet
         NP3tByCfMxH8sP4smFgb0viCTPe/X7ZfSaI93oBz4GO7jOLj/RL+XE5WVWQ7Li0QxSAJ
         JspE96EtZCd6rvAP3pyQLXHoGxEAXljWqU+KAWtWuOjrJNUji4wsSzMGyde0ixERME9M
         0mdFjCr8ICmi7B12ggLFgtqQ9FjgNZYb5SxvWENxpMrq/kXSv8YtTS1i6zX1E+Zwdh6L
         iFttQaxnnvr+OkAhF4ypkk3yVE49Ujl8XQJv9z8a2ubCjMukw5Uqdd6XlK+qx2ixdyVV
         pyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtL/MNOJtUrGbjT5VpkANRdtrGSGAxkiN6V9TVgQwzU=;
        b=klIqWgaIfLApxsEGQ9ubP0WjWjsOW4GCUzxsvl4V+PYSPK/6yIWNjPFmgTVAXk1noT
         phbvEzj0/26oYRRZZ3NPNALmFDLXIlocuC0O85yHLUSLco8pdD4shDZAAnERduuAnKvT
         dNhPPkC+ztMfO5MoVgZgpP8p8yz/6GOa7E3XfdTyH2y3XTORLZ6l1nwPbH88Ee7ukvzB
         QkbSKNWSq0rlb8LXfr/IlRDvKtFAY69qIFtBBni8uxNmLcBAsiQ8Q2t7UpqvyR+QLxw1
         ZWRCv98halY3y5A9BfjU1r4rttG/jidtnOz3fYKkRbmNGe9kDcXyN4qAFSr2HLLq6pUn
         GpJQ==
X-Gm-Message-State: APjAAAWWuodXULDn2fpzy/5kPhg9TZQBL99HZWk2dNZGU05hJBSn/5wz
        RSzbmfCq/LqP7rktAs0IHsY=
X-Google-Smtp-Source: APXvYqzbpJ4PlYrZVF2o1+fcR054zr79L8qe0MHRagkl+rm71lYrB4spyxa+3XkhT3KXd9jY2m++ww==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr85333165qkh.192.1578348918372;
        Mon, 06 Jan 2020 14:15:18 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a24sm21452630qkl.82.2020.01.06.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:15:17 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B26B540DFD; Mon,  6 Jan 2020 19:15:15 -0300 (-03)
Date:   Mon, 6 Jan 2020 19:15:15 -0300
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dennis Schridde <devurandom@gmx.net>,
        Denis Pronin <dannftk@yandex.ru>,
        Naohiro Aota <naota@elisp.net>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf clang: Fix build with Clang 9
Message-ID: <20200106221515.GE11285@kernel.org>
References: <20191228171314.946469-2-mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228171314.946469-2-mail@maciej.szmigiero.name>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 28, 2019 at 06:13:14PM +0100, Maciej S. Szmigiero escreveu:
> LLVM D59377 (included in Clang 9) refactored Clang VFS construction a bit,
> which broke perf clang build.
> Let's fix it.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Reviewed-by: Dennis Schridde <devurandom@gmx.net>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/util/c++/clang.cpp | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index fc361c3f8570..c8885dfa3667 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -71,7 +71,11 @@ getModuleFromSource(llvm::opt::ArgStringList CFlags,
>  	CompilerInstance Clang;
>  	Clang.createDiagnostics();
>  
> +#if CLANG_VERSION_MAJOR < 9
>  	Clang.setVirtualFileSystem(&*VFS);
> +#else
> +	Clang.createFileManager(&*VFS);
> +#endif
>  
>  #if CLANG_VERSION_MAJOR < 4
>  	IntrusiveRefCntPtr<CompilerInvocation> CI =

-- 

- Arnaldo
