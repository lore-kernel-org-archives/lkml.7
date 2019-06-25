Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E311C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDD1208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNcnUZtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfFYSFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:05:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37049 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfFYSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:05:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so28459685eds.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y0z5BxDxKG6mK/2TjsyaVPnCqxPuFcpMaFT0ffP2suQ=;
        b=aNcnUZtEYD7BtlT4ufo2DokTdV5JtlOc88TyNpRjxOMgQv6/1AwJPgqoYCiaQhubYp
         WjdX2RIXMbrBXKtT7ULOz7TZAFZDrz8hDqTtTgwLHMzvgc3A71mZpC/3bOp6MhJluhgs
         wRg00iX97g0qoEsjW7wtEYp80KFJ6I/G+StHq+nw5ZDChHVl3rNEGSbzDruZbRqJWDFt
         Qx6E/QlsIBO3Bgg9QqKkaovwRysf8VHxyHmAmlxy/pdEjJ1eN4AOrHrA5izofUFwyDFA
         2KfRPIbt8X0U/Rw/LcnHCtx/d5CYmm4AN/blU+z/xnoCHKba8efv+GIptfUbaYYKHv1p
         n2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0z5BxDxKG6mK/2TjsyaVPnCqxPuFcpMaFT0ffP2suQ=;
        b=Lw7xy4mD21GyyVY/Z6EyZO2+2gUj0UuXHbpMp1RODuditUIodm2tCe1Zl8R18uQoUM
         XJMFgZpcZvQIyEgauIYA66/AE7ILPtVFkYDZE0YmI5vNew+4uo2Gc0XMBgjqya7ioaFD
         2mCXCu8mo2Hti/EbvrABXk7hUt7uQtEbGkYikRnNr6uRAP5j6fgqBuBptarQYNIlGpz/
         Yb0lr+Ioh/ksCAq5M8XzhAwH3q09n3/+dmQCxvegl771BMY+Hn3d3k2vprknT1B/Ettc
         ieaz71R/WSbtbpzlP3zhIGVP/HR2Co5vbsKDZ+9YnKb6iXQvc2s0Pd0NGaHWSyg+r5DY
         xHzQ==
X-Gm-Message-State: APjAAAVULjndxPa7nTJ66i7uDCRsEDoTBeQogEBVn9FU8V0oZOaQKVoP
        KFCdtLlqSv/EKOVan/YJf+A=
X-Google-Smtp-Source: APXvYqwK/4c6xC0XUaZohjb8X/oY4ixHMzj1ndM08hF3f/kDkJlcRAXmVMV5XSn/iyZeVMMhnskSPA==
X-Received: by 2002:a50:b3d0:: with SMTP id t16mr104313495edd.158.1561485928085;
        Tue, 25 Jun 2019 11:05:28 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id j13sm677928ejt.13.2019.06.25.11.05.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 11:05:27 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:05:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <20190625180525.GA119831@archlinux-epyc>
References: <20190624161913.GA32270@embeddedor>
 <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906251009.BCB7438@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > Can it build a kernel without patches yet? That is, why should I care
> > what LLVM does?
> 
> Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> appear in the following release.
> 
> -- 
> Kees Cook

I don't think that's right. LLVM 9 hasn't been branched yet so it should
make it in.

http://lists.llvm.org/pipermail/llvm-dev/2019-June/133155.html

If anyone wants to play around with it before then, we wrote a
self-contained script that will build an LLVM toolchain suitable for
kernel development:

https://github.com/ClangBuiltLinux/tc-build

Cheers,
Nathan
