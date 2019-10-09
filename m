Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E303C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5BE2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz/nfF+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfJIACE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 20:02:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJIACE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 20:02:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so262469wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yehEEcVd/f4xRiuRlKn78OHX+x36IDjBEHFJBns9Tpw=;
        b=Wz/nfF+OyxMhmw7+mH5tRbpSAyS3HngUQkqNfFOYOcIImgowqT1Y3L1m/AnpLyeYYJ
         G2ilvcmyVY/CTrsrwx/2U07AurJ94sp/y+a8WfC1mZrr4WQ7RTtKnNRhEmAZQMQbzuMk
         LINHHv+ZI1c1KFgnSDHCXj8Kr9AQpVWoRgZ2RbSFtCSFjg/Qrw0Zziz+qUkmJgFIJ6qR
         RVJxB+jwmwTay3Gr0K974ipHR3h5mKd3lzG/JAOdtVDl6p5naf9QrFDZY3Q5wP6OFxOk
         qae4JUMkjrG5bUYlCMppUufl3JjlrU7LTZmtfqKamUuhqEoH06XPfF45hdcCO2gHoNKT
         BQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yehEEcVd/f4xRiuRlKn78OHX+x36IDjBEHFJBns9Tpw=;
        b=NFvvwHyLGgNrim0vPySLLxa0Sa6kIZ70WJwVnmeT9aAkC7ZgQNPbgrgJojNizsXtcr
         yMJn6dJfxrFgtmxhx0wMXwBg7kjfAn9jiqMcLzp51hl2s0oQ8IzVgWMm2RvYvtvm68YE
         rQBk/9j22HlQ+gsTffKemaBPKfFSWoOrYuX5N97liZZN5dtEB3LvqaS47v1Negx8eRzA
         /2n8QBfUVDV+vmBNbKjIJq73Ll4nqOMUB0624gUgENVTSMlv4hymAxz025Ztp2/XVl1a
         bL9N9ipweyceiYiUeuvRFWxZravjpbiETx8Li4n3vkRInh/2RKMXnGe4SCRz/2K199wt
         82Yw==
X-Gm-Message-State: APjAAAVW9Aqls1S5aHxOHPOBO2MpAtokFSeTUDvzPYGBL7mdwesN6AWt
        4eY5iP8hmKJZa2qyGTCkHyU=
X-Google-Smtp-Source: APXvYqyagcPjtTrnCnvlKvfJLCLgYaYSN5e3If0TgegkwckEpCWlmuYFfijItVPdGlrHjTd3lRRAOg==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr378763wrx.162.1570579321624;
        Tue, 08 Oct 2019 17:02:01 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id g11sm300751wmh.45.2019.10.08.17.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 17:02:00 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:01:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
Message-ID: <20191009000159.GA531859@archlinux-threadripper>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <20191008212730.185532-1-samitolvanen@google.com>
 <20191008233137.GL42880@e119886-lin.cambridge.arm.com>
 <CABCJKufHzQamE5+JtH0J4TyS05kutkty_7GwJ6w8T-szdCwHvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufHzQamE5+JtH0J4TyS05kutkty_7GwJ6w8T-szdCwHvg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:59:25PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> On Tue, Oct 8, 2019 at 4:31 PM Andrew Murray <andrew.murray@arm.com> wrote:
> > This looks good to me. I can build and boot in a model with both Clang
> > (9.0.6) and GCC (7.3.1) and boot a guest without anything going bang.
> 
> Great, thank you for testing this!
> 
> > Though when I build with AS=clang, e.g.
> >
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang AS=clang Image
> 
> Note that this patch only fixes issues with inline assembly, which
> should at some point allow us to drop -no-integrated-as from clang
> builds. I believe there are still other fixes needed before AS=clang
> works.
> 
> > I get errors like this:
> >
> >   CC      init/main.o
> > In file included from init/main.c:17:
> > In file included from ./include/linux/module.h:9:
> > In file included from ./include/linux/list.h:9:
> > In file included from ./include/linux/kernel.h:12:
> > In file included from ./include/linux/bitops.h:26:
> > In file included from ./arch/arm64/include/asm/bitops.h:26:
> > In file included from ./include/asm-generic/bitops/atomic.h:5:
> > In file included from ./include/linux/atomic.h:7:
> > In file included from ./arch/arm64/include/asm/atomic.h:16:
> > In file included from ./arch/arm64/include/asm/cmpxchg.h:14:
> > In file included from ./arch/arm64/include/asm/lse.h:13:
> > In file included from ./include/linux/jump_label.h:117:
> > ./arch/arm64/include/asm/jump_label.h:24:20: error: expected a symbol reference in '.long' directive
> >                  "      .align          3                       \n\t"
> >                                                                   ^
> > <inline asm>:4:21: note: instantiated into assembly here
> >                 .long           1b - ., "" - .
> >                                            ^
> >
> > I'm assuming that I'm doing something wrong?
> 
> No, this particular issue will be fixed in clang 10:
> https://github.com/ClangBuiltLinux/linux/issues/500
> 
> Sami

I believe that it should be fixed with AOSP's Clang 9.0.8 or upstream
Clang 9.0.0.

Cheers,
Nathan
