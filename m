Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94A208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH+owc3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbfJJM3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:29:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40947 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbfJJM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:29:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id m61so8390327qte.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23//cENVQiVYoGQZus1cpePnZWSeYRa3XeMxkFD7WQg=;
        b=NH+owc3Bkdk66rd2oxnrLG1lU03Niv3N/GUBSt1/9dRSfQRuHfW4W1igS07q2DzsED
         fiQrQlVCnB6RH1zol5ooTAqAkk4Xsuck4130IKNNILzVnR6dN+APBVrTF3gt0uibSGgD
         REgXmU/yULmLNMrOnM+eAoYoNE5cZ/yj3rOWgPhBgTAsd1uDptCc1neDWiXY9TsuUizx
         bdjyqsenan6mAiId/xeorNg/BvGaBC7aZxP6eqKDfiV8jP3HVR62eHRnxnDBCTnQPotz
         /ChHSep613KsdqBbI6DYZASrvDT7F3+conY9cWnCzQAvoYhTBLOfZarBcIdBVrbFnPgR
         g5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23//cENVQiVYoGQZus1cpePnZWSeYRa3XeMxkFD7WQg=;
        b=Xz3uUUWUEz+DenY2WOyFiEmgokJgvJQyQ2+iYJEkXuRHC0nfQ0mde5vm+RXvpR3NmZ
         6EQz2bhSo4Yqeup9EMpNQ37750yojA1J7TRbptnuEBv7jBh67fLEW8dyBOracXcLcGO9
         V0vxz5iPell+duKUurrfC08JVq2XHufNa4GAZqoLnD3Ek3Fosd1g8Ujz5zKKGdRfaXKe
         FUCrSuMiJ5GeNCnd/LZloxtEOWHI0yXIJ3qBGdlR+B+bemJQhH0k9Y3kgbodtG2zLiuL
         gd9vHGBYcJ66WvqZD+IZbzPxWCeCRT//DwM/mAFQwTfLB0Yo5Kvs5P7tDaQ0DE2zz2NG
         t5Pg==
X-Gm-Message-State: APjAAAVt1LKnpENWzQ7gERY1NzPbTdSLaEXYFahFUs2lCD9QkArLDzuc
        ou20Pp7VC1DHSzTtt2DX/JE=
X-Google-Smtp-Source: APXvYqwQH5Jlb64oqJ1zXF4YJOVldcOTFNRXzDkOo7N4G+q3ydZkfiZFyUgO93pSNrWeN0FYBF31hw==
X-Received: by 2002:a0c:814d:: with SMTP id 71mr9689628qvc.220.1570710552657;
        Thu, 10 Oct 2019 05:29:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t64sm2491824qkc.70.2019.10.10.05.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 05:29:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 175E641199; Thu, 10 Oct 2019 09:29:08 -0300 (-03)
Date:   Thu, 10 Oct 2019 09:29:08 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Mao Han <han_mao@c-sky.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20191010122908.GA19434@kernel.org>
References: <20190927214341.170683-1-irogers@google.com>
 <20191001003623.255186-1-irogers@google.com>
 <20191008123104.GA16241@krava>
 <CAP-5=fUSgjyLkZJaHTvdFbzZijy6Gzmx5UZHK_brxVEhFpMG8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUSgjyLkZJaHTvdFbzZijy6Gzmx5UZHK_brxVEhFpMG8g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 09, 2019 at 04:07:37PM -0700, Ian Rogers escreveu:
> On Tue, Oct 8, 2019 at 5:31 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > On Mon, Sep 30, 2019 at 05:36:23PM -0700, Ian Rogers wrote:
> > > Being const + weak breaks with some compilers that constant-propagate
> > > from the weak symbol. This behavior is outside of the specification, but
> > > in LLVM is chosen to match GCC's behavior.
> > >
> > > LLVM's implementation was set in this patch:
> > > https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> > > A const + weak symbol is set to be weak_odr:
> > > https://llvm.org/docs/LangRef.html
> > > ODR is one definition rule, and given there is one constant definition
> > > constant-propagation is possible. It is possible to get this code to
> > > miscompile with LLVM when applying link time optimization. As compilers
> > > become more aggressive, this is likely to break in more instances.

> > is this just aprecaution or you actualy saw some breakage?
 
> We saw a breakage with clang with thinlto enabled for linking. Our
> compiler team had recently seen, and were surprised by, a similar
> issue and were able to dig out the weak ODR issue.

This is useful info, I'll add it to the commit log message.
 
> > > Move the definition of sample_reg_masks to the conditional part of
> > > perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> > > weak symbol.

> > > Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> > > In v3, add perf_regs.c for architectures that HAVE_PERF_REGS_SUPPORT but
> > > don't declare sample_regs_masks.

> > looks good to me (again ;-)), let's see if it passes Arnaldo's farm

It passed a few of the usual places where things like this break, I'll
submit it to a full set of build environments soon, together with what
is sitting in acme/perf/core.

Thanks,

- Arnaldo
