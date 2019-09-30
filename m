Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E11BC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FFA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2qEyqRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfI3KjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:39:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42825 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfI3KjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:39:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so7263107qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XBde5jtGNQGf5FDnC74YETW24H484BN+1GZRFzjDJVg=;
        b=Q2qEyqRTLBbGm3kR40LUTPz2cJOyHmy6d12t+6VvxRon5SIPux+pqGDySLtS6RMUIP
         fLY21pPCjBYu8ytftpjq3JbFWOI+og7lG9j+j/HWfR5RKNlGmLeNnnFFqoM5lgnAFEyd
         l2UiAmlB8qXpSJ/goRDlGOQIC88RQdNlKrEDx5Z0KROT3t72U9gCbdlLmMOTV0e+CYVp
         2MlI/ZUHGE3isPxEUH523azBbB6e5+wTM9pOrSpSF5g6piXbRcSjY+Mvk9h+5TcYMiIm
         vDt83pJFO66XPuZWwTUGcFMHBJr8c706rLnYxm5KXT0CLvACmfo/vzGZSzxxuKApu8+I
         BFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBde5jtGNQGf5FDnC74YETW24H484BN+1GZRFzjDJVg=;
        b=Auwo43ooGB6jGzaTvpO39a6Y03/TQ3aMqYeHZpJ9IyoMCEGJNj36L6m8g1IYMyXVrJ
         CMsYfpnQln+GMOvnYXtlxzgPKjK9sdFYCwsGUOuV/7PODy+L5YvK2G8kSxB8n5MpMRNI
         SkcD7grf7+rXUwvOLn2TKPJR9kjGUNwrRhXZy8Ei14IfpEurKYgcluljEQrDl50wmJ52
         H20Yw8KcZnFmDnfuBAStqOlThj8cWgeUs/bdabqjvdnU7YLTkClDyM8iwtR+sbo/nwAs
         adI/sn6eyj+6kjHVQ9VxinyEAi1HvMLAUviJjsEm9yo23ECcut0z1NhmM3esyRpiupNs
         D8Gw==
X-Gm-Message-State: APjAAAXKwW2WfsK85WZCRsHmJkKnP5A4BzAAeuza+srNbAKNCqte6bMt
        BJZvYY4kfgYTmCw+6RaOif7atC8z
X-Google-Smtp-Source: APXvYqxqJNFmjeFZj3pa0wT9Rr5Ps3MWfX3ZrfXnW0CvcZZf01bU8wJakVK/k9Q3nybtg9IvohkjKA==
X-Received: by 2002:a37:a604:: with SMTP id p4mr17126922qke.58.1569839952995;
        Mon, 30 Sep 2019 03:39:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w2sm8064369qtc.59.2019.09.30.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:39:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A3E640396; Mon, 30 Sep 2019 07:39:09 -0300 (-03)
Date:   Mon, 30 Sep 2019 07:39:09 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20190930103909.GA9622@kernel.org>
References: <20190927211005.147176-1-irogers@google.com>
 <20190927214341.170683-1-irogers@google.com>
 <20190929210514.GC602@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929210514.GC602@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 29, 2019 at 11:05:14PM +0200, Jiri Olsa escreveu:
> On Fri, Sep 27, 2019 at 02:43:41PM -0700, Ian Rogers wrote:
> > Being const + weak breaks with some compilers that constant-propagate
> > from the weak symbol. This behavior is outside of the specification, but
> > in LLVM is chosen to match GCC's behavior.
> > 
> > LLVM's implementation was set in this patch:
> > https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> > A const + weak symbol is set to be weak_odr:
> > https://llvm.org/docs/LangRef.html
> > ODR is one definition rule, and given there is one constant definition
> > constant-propagation is possible. It is possible to get this code to
> > miscompile with LLVM when applying link time optimization. As compilers
> > become more aggressive, this is likely to break in more instances.
> > 
> > Move the definition of sample_reg_masks to the conditional part of
> > perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> > weak symbol.
> > 
> > Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
