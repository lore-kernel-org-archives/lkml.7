Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E0C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD432072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWhdykjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgAFWQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:16:03 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35500 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFWQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:16:03 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so19653936qvi.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZFmEkhCTphA2jcs6BM5crnTey6oTYkf7QCSnnJ3SOw=;
        b=XWhdykjFa/qkaeanWQQ6rLrc9TwA+fmEQ2ks3cstM9cCghj8fbJQ7r3reyOJD5mAYT
         lmQURUkJ6QzWE31cEGTmSSYp1I7Vqk9+IibmohBs53Q+eFY91wzwsJ01PFQAMaAyQ8qg
         98dUU3F+KptosOHAT0cSX4SRVnpD3cZ5vqRDz7i3Svmzi8HJVKDIIqtdHjfoN91agIL7
         6P4hCOozL/p4KpOyNNY9kCenJnJnQ6P6SHMh8AzX+HTFYx3GAQ2pAPCAkI6uURGfmxVg
         FdKsz8GY/zv35mJuYSF4NBC5ihhovU/WhKudAtiPWblFZkeJRhQxb32NjYcx0CunGScz
         i/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZFmEkhCTphA2jcs6BM5crnTey6oTYkf7QCSnnJ3SOw=;
        b=uUSbFaXvBdZ/eJzl1QSsGu9yUEmKln25/pr6R5x22LKvtjZCu+QTeEnciQN+GaqAAW
         O+jTCWP6b9hjgRDiePag22DAqF1j16Y6tcN5KLwKJ7/R9vTc9G6IZwW1qdGPGRUPYAvY
         oCDBxN4EqVah3I3lTChB4lb6w2e9EsOxHE/WNZxxlDIgyQ0gDzyHgMCBh0Rs8ooWq18k
         XqhT8laxt96v0viKaEFGkArG8qsPrT6wwBJqn/P8orzvWkMfp6e7Zn876LOmBbMuXAu+
         n/E5dFWE7QWAFMYd57qcalRjfq0I4I5yJIWa1Fr4nK2JXRz8pavxQcP6QEBPXJO0n8R+
         yu2g==
X-Gm-Message-State: APjAAAWREIYUghVTVYUZlSaGwYVZoFbZdP1SnQ02CvH/UJiMO5xDHlDC
        kv5TNKaZdWxrH5YxtDws1fU=
X-Google-Smtp-Source: APXvYqzMXPHHrAizLeFRJXf7VNi9cma3Ydc/DPnF4OBf5Q4CqRXqD/cArEJjVvneqFrKbs9idSbhZQ==
X-Received: by 2002:ad4:4d91:: with SMTP id cv17mr71977440qvb.101.1578348962288;
        Mon, 06 Jan 2020 14:16:02 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l4sm15904039qkb.37.2020.01.06.14.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:16:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DB4E040DFD; Mon,  6 Jan 2020 19:15:59 -0300 (-03)
Date:   Mon, 6 Jan 2020 19:15:59 -0300
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
Subject: Re: [PATCH] tools build: Fix test-clang.cpp with Clang 8+
Message-ID: <20200106221559.GF11285@kernel.org>
References: <20191228171314.946469-1-mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228171314.946469-1-mail@maciej.szmigiero.name>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 28, 2019 at 06:13:13PM +0100, Maciej S. Szmigiero escreveu:
> LLVM rL344140 (included in Clang 8+) moved VFS from Clang to LLVM, so paths
> to its include files have changed.
> This broke the Clang test in tools/build - let's fix it.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  tools/build/feature/test-clang.cpp | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
> index a2b3f092d2f0..7d87075cd1c5 100644
> --- a/tools/build/feature/test-clang.cpp
> +++ b/tools/build/feature/test-clang.cpp
> @@ -1,9 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include "clang/Basic/Version.h"
> +#if CLANG_VERSION_MAJOR < 8
>  #include "clang/Basic/VirtualFileSystem.h"
> +#endif
>  #include "clang/Driver/Driver.h"
>  #include "clang/Frontend/TextDiagnosticPrinter.h"
>  #include "llvm/ADT/IntrusiveRefCntPtr.h"
>  #include "llvm/Support/ManagedStatic.h"
> +#if CLANG_VERSION_MAJOR >= 8
> +#include "llvm/Support/VirtualFileSystem.h"
> +#endif
>  #include "llvm/Support/raw_ostream.h"
>  
>  using namespace clang;

-- 

- Arnaldo
