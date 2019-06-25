Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CF9C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A220883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3SMLs+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfFYRMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:12:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46271 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfFYRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:12:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so9166014pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=evJZ611ieJocegJ3LQNW9Eg/UNskUaGIHgsK7ypKVgI=;
        b=a3SMLs+dWET/7V/UepBDzEvuFcGfzDN4wp15+eaj/zWii+KNOggB6WL1bG8BG9Ikxv
         bArAc5hMvi9DlkF9+F10Tj6n2UQrQ/wQkE7aKpZPZr3zidP+7DsZcmW/EUH0sCUlAN5x
         0+vu/8lI2jV7wnCfiIEWnBsL25pL670ITGdOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=evJZ611ieJocegJ3LQNW9Eg/UNskUaGIHgsK7ypKVgI=;
        b=lQVA9i8KSo/sUF8ydjd50YbV5EfBxa4iq/SpEswVY/WKcnl6LDOP34Vdxjzn4f2b8g
         i3GVwmyK/RxcXXe0UlX6tSNWXMR9yeXJsu5qLCMU5l9whOh9M69OEFWxcOqUyoNXq+eN
         Q6EbQ0uXIMnIK9V1bbxja1p8sKqhzyI9YhjMYbZ8jNhTNwG8MR/Hb3ZlcKfNVTc3zLjN
         dgaB+XSYUqKqDWARRiEp36elVvhexuR6m1H3PhEXV63WkcJvQ7Pf3dWqApsx9SW9Ei8M
         bGDl0EvJt3LVCgKw3kpD70GWrTgafhpFERiK0U8QOb3sEnsL6tYjmsITe0o7q5RddDDB
         axdA==
X-Gm-Message-State: APjAAAWpXJGZuhuiVWbaHnvelLchBJN+0ke7dGL9exnWpVt1mud+nezF
        NxSgftQNe4/Up03V+/QpRZ646Q==
X-Google-Smtp-Source: APXvYqwXQYcCcg4xky16h6RsWQUwWMNys8Mo6oo9mRuYdIHGyVw26Oun6x/a7fQXH5k8iQjfjEAP7g==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr143570404plz.132.1561482764938;
        Tue, 25 Jun 2019 10:12:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm2846752pjp.29.2019.06.25.10.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 10:12:43 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:12:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <201906251009.BCB7438@keescook>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625071846.GN3436@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> Can it build a kernel without patches yet? That is, why should I care
> what LLVM does?

Yes. LLVM trunk builds and boots x86 now. As for distro availability,
AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
appear in the following release.

-- 
Kees Cook
