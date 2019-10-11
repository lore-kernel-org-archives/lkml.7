Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C298C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476DA2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570811848;
	bh=79w5edtxDt5Jq6Ree1a1StCOYuG6EBQwad9naKy16Nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I7+0hRsQ5Is5R+CH8XaBZOZZXa0gVdJp/DUK3HmviH/YDrkT/eXp4HThaCest01nR
	 5/xA++WAE1SvKx17Rhw4xWVu8NOO95qHFPM4bQbtb+znxvZj/ETXTfVKdsoZVRR8lB
	 72dk91yKjkeujE0i1Y8ZpW3m4y/GXiI0bhEB7ZfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfJKQh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:37:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45229 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:37:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so7483646lff.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMiHtB5ZlwenoYg0oyx0g7MXemkZFkoKB6mCSzMxar0=;
        b=WvTdQO3PPBIwZwj1t370syw4bWNuRNNu5X9kUBY4nmpGylmSdsm9EeaCjpU7Vnv8Yx
         RIBTnDZKFaNEeN2w5TKDtE/axPzbYs2ol1oaGAlHshlDH+Wbx81Cy8oDxPhDJcEJ+mEJ
         6/WqNX914YOM138DOaNAdg7ENVxoQn93vF7Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMiHtB5ZlwenoYg0oyx0g7MXemkZFkoKB6mCSzMxar0=;
        b=sJ0D1NSsWz+d8N+DlJgPCZ04dAuTRkA5TFSCXzfA4Rd/yhvxzR0SHrTFEqlePI4+m8
         5Cf08yRVMUKdeF9HkMX3A4Tt2azB/eXxrxm09m7CFkzTubIYmBNCk9cNk0jhAE/jMGRm
         daXvcO8DnPbNt96NFZpluTv8eWfC1hZZ2ShiOmi1pHcNlunld5+9iv/Cvg9WsidWSC5D
         81Ih9c/gD0EkhpGg/H3gHbRrXn1Y9mkijg5v/An+UIwdf0I8y0+8PFBW38dOOsgBzQ+t
         42ZylwMlWT/fjAhl89uO4eUau5JeEDBNWTNAzl1GcKtOFxJbknvgmj189lDnGtRtNA5s
         sAXA==
X-Gm-Message-State: APjAAAWQOUWo/2aUL49a6KiPOWAb4ZSofpq/eogBEYyssPPeyvqFBbUf
        mW5eOB33AQCE/O3a71eCWPdqU67j5z0=
X-Google-Smtp-Source: APXvYqyg1q17vJoHbDN99xiY9gfppbh415TZeqN5vGCaijzLWsMHFgyb046ogjnpRulXLbhli1Yeig==
X-Received: by 2002:ac2:4556:: with SMTP id j22mr9311569lfm.87.1570811844434;
        Fri, 11 Oct 2019 09:37:24 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 25sm2158865lje.58.2019.10.11.09.37.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:37:24 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t8so7451607lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:37:24 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr9294065lfi.29.1570811416172;
 Fri, 11 Oct 2019 09:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com>
In-Reply-To: <cover.1570292505.git.joe@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 09:29:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
Message-ID: <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
Subject: Re: [PATCH 0/4] treewide: Add 'fallthrough' pseudo-keyword
To:     Joe Perches <joe@perches.com>
Cc:     linux-sctp@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 9:46 AM Joe Perches <joe@perches.com> wrote:
>
> Add 'fallthrough' pseudo-keyword to enable the removal of comments
> like '/* fallthrough */'.

I applied patches 1-3 to my tree just to make it easier for people to
start doing this. Maybe some people want to do the conversion on their
own subsystem rather than with a global script, but even if not, this
looks better as a "prepare for the future" series and I feel that if
we're doing the "fallthrough" thing eventually, the sooner we do the
prepwork the better.

I'm a tiny bit worried that the actual conversion is just going to
cause lots of pain for the stable people, but I'll not worry about it
_too_ much. If the stable people decide that it's too painful for them
to deal with the comment vs keyword model, they may want to backport
these three patches too.

            Linus
