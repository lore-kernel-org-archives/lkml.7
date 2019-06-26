Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0CAC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F0B208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICD2T4nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFZUDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:03:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41856 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:03:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id p15so4814980eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJCEZwADJ64FudWRSvgjkrSHzdH+lNhY9Ai4SAjHt20=;
        b=ICD2T4ncTt+dn5KNQbyik0soYgrcmS149QLGqIOX44WHeH/X6yXUQcNbDXYo0SN7sj
         rbyiHnpqXOTseGcOtUMdC3+CDKGMFJZz2A5dAiArfbyREXQbYnRvd6h1iyGPgrSEhbia
         DEti/zsOXfDH2A8nJs+Js0oVFh/Pv1xjFLUYOx2BOH438KAhMnp6DLQHD8/H7u0s+xOH
         odb58LDyOjJoFLXydjw//wKLJXnBbq6UJWRgGgW8Ad/00y84frNHPdVkm9aaeGUYuLGQ
         ewyDqr2E0uVvOpAf4y1zrUKnSfGQp/1yd2RCjeiqKdAoLBHOJ/w7NqnWPperPADoIZb3
         sivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJCEZwADJ64FudWRSvgjkrSHzdH+lNhY9Ai4SAjHt20=;
        b=TpY5jPPL1LEpuOmPzlzCIRJs5wqRPv9osKXSw0WfiP0WXFJIsDLA1zpupQkzv/zg1R
         +ev2qdZkQ58u9OSE0wHiRBPgZI7/qVmzH1OunAo94u/53Isf2ubkWZwLQ3hgrW2OtnGC
         NWLcyTeEAEG5j3QShCtQtAf7BF+n/nIPBMW45tIKllSRArOJ7Af0h2BjHvwWkM3XSNFd
         aAUOOy/Q0PJgUBKsG2E3wG46fDNmC05E7NHPXtjuknrNREjZsM6+4Lz/l4bpIgH8pSO2
         cKHqPnXV4jROWDOuu4x1yYHKF7zGn1dSkejTtay9WtS8pPJXgKGGD+sDzf1XuYCUVfsA
         A7Og==
X-Gm-Message-State: APjAAAX2uRWp/xSA36XSfUOxuj2lz5NJrMf1cP7v2a5tCu3Jkrd3YHfk
        do3Xn1h7fYy7pjPyTknUZmk=
X-Google-Smtp-Source: APXvYqzh68Zi23Nhu/s1LMEfkz6cZUEgu/jXNTyljgTNTy7iZGouTKkNoVjXDeRH/q4GDJhYT8ds2Q==
X-Received: by 2002:a17:906:6550:: with SMTP id u16mr5886143ejn.7.1561579389182;
        Wed, 26 Jun 2019 13:03:09 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id x4sm6140660eda.22.2019.06.26.13.03.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:03:08 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:03:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626200306.GA72437@archlinux-epyc>
References: <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626051035.GA114229@archlinux-epyc>
 <alpine.DEB.2.21.1906261711540.32342@nanos.tec.linutronix.de>
 <20190626190028.GA14249@archlinux-epyc>
 <alpine.DEB.2.21.1906262140570.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906262140570.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:46:02PM +0200, Thomas Gleixner wrote:
> On Wed, 26 Jun 2019, Nathan Chancellor wrote:
> > On Wed, Jun 26, 2019 at 05:18:37PM +0200, Thomas Gleixner wrote:
> > > tarball with log and the preprocessed source and run scripts:
> > > 
> > >     https://tglx.de/~tglx/tc-crash.tar.bz2
> > > 
> > > The machine runs up to date debian stretch which has backports enabled and
> > > I just used the install command from the github project page you linked
> > > to. Getting started section.
> > > 
> > Great, thank you! It explodes during lowering, which is a backend issue
> > so that's fun :/
> > 
> > My guess is that this is a problem with -march=native on that version of
> > LLVM (since a newer one works). Could you try this patch that makes that
> > opt-in and see if that fixes it?
> > 
> > https://github.com/nathanchance/tc-build/commit/9f1ae41cd4246f9e4d011542f094aa0df2c069b4
> 
> clang --version
> clang version 3.8.1-24 (tags/RELEASE_381/final)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 
> ./build-llvm.py
> ...
> LLVM build duration: 0:03:14
> 
> Tested-by: Thomas Gleixner <tglx@linutronix.de>

Fantastic, thank you!

https://github.com/ClangBuiltLinux/tc-build/pull/19

Should be merged soon hopefully.

Cheers,
Nathan
