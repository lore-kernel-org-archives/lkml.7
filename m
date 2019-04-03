Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC2C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31020693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K6rBmoG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDCHtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:49:35 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39392 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:49:35 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x337nDD6021533;
        Wed, 3 Apr 2019 16:49:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x337nDD6021533
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554277754;
        bh=EptBD1gd7ssO6+JGNGPC9vyN05FofYqRlQlzWBRWTYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K6rBmoG99PzHBb8nCKSQysuQoFI2NtiVoKHCJsqbBVOn7O3ts3/lpo+qDtSRo7zcG
         nEmmmoS7xBqs5JGPVqZ6TZLa07SfWfsF1jtnYBA8VYKhc1GFSKyzCSgyIoZ3ZB6kt+
         ueaTxObHfBfIg9WBZYP1jgUGMV8A+XZjK+wHhHjrW4/YZiI/aPjyOEqEf7r3zh4rUR
         2790bPsv9YtsMCTha+LRZ02uLWcl9DmIH581JPhTLFuGFy5hXHgjHLgGu5yQ/qqYcg
         o+E/jWQjR2Sb3n7hp5DMoABfH7YswoeFBxpr+X4KYBL2Q47vz8poOMbnkgx5LVisAH
         yELxCh7GNLJqw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id w13so8371591vsc.4;
        Wed, 03 Apr 2019 00:49:14 -0700 (PDT)
X-Gm-Message-State: APjAAAWdyWZZaPeon64CbwPnZyyt7DFAYyWh2DP1Onrx7OG7v73sXH4b
        vuhFykLexwBI0oc9fD8m8Li1UW3Pk4oCEHLUJ/w=
X-Google-Smtp-Source: APXvYqysWW4RlGbpDydTURckS9nFxPEBXGqwCTFg4JpRh2/+Ru+cA+T1OaHmlC9KO0z+nQDEatTlyyOj06c9xqex+fg=
X-Received: by 2002:a67:818e:: with SMTP id c136mr39567305vsd.65.1554277753032;
 Wed, 03 Apr 2019 00:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <20190325134947.GA187133@google.com>
 <20190327173103.GA205980@google.com>
In-Reply-To: <20190327173103.GA205980@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 3 Apr 2019 16:48:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
Message-ID: <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:32 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Mon, Mar 25, 2019 at 09:49:47AM -0400, Joel Fernandes wrote:
> > On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> > > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > > Introduce in-kernel headers and other artifacts which are made available
> > > > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > > > it possible to build kernel modules, run eBPF programs, and other
> > > > tracing programs that need to extend the kernel for tracing purposes
> > > > without any dependency on the file system having headers and build
> > > > artifacts.
> > > >
> > > > On Android and embedded systems, it is common to switch kernels but not
> > > > have kernel headers available on the file system. Raw kernel headers
> > > > also cannot be copied into the filesystem like they can be on other
> > > > distros, due to licensing and other issues. There's no linux-headers
> > > > package on Android. Further once a different kernel is booted, any
> > > > headers stored on the file system will no longer be useful. By storing
> > > > the headers as a compressed archive within the kernel, we can avoid these
> > > > issues that have been a hindrance for a long time.
> > >
> > > The set looks good to me and since the main use case is building bpf progs
> > > I can route it via bpf-next tree if there are no objections.
> > > Masahiro, could you please ack it?
> >
> > FYI, Masahiro's comments were all address by v5:
> > https://lore.kernel.org/patchwork/project/lkml/list/?series=387311
> >
> > I believe aren't more outstanding concerns. Could we consider it for v5.2?
>
> Just to highlight the problem, today I booted v5.0 on an emulated Android
> device for some testing, that didn't have a set of prebuilt headers that we
> have been packaging on well known kernels, to get around this issue. This
> caused great pain and issues with what I was doing. I know me and many others
> really want this. With this I can boot an emulated Android device with
> IKCONFIG_PROC=y and run BCC with that that. Also I want to do the BCC side of
> the development, but first want to know if we can merge this upstream.
>
> Masahiro, I believe due diligence has been done in solidifying it as posted
> in the v5.  Anything else we need to do here? Are you with the patches?


As you said, these updates are "cosmetic".
Nobody is worried about (or interested in) them.
Even if we miss something, they are fixable later.

I accept embedding headers in the kernel,
but I do not like the part about external module build.
 - kernel embeds build artifacts that depend on a
   particular host-arch
 - users do not know which compiler to use

Perhaps, you may remember my concerns.
https://lore.kernel.org/patchwork/patch/1046307/#1239501

I reviewed this, and already expressed my opinion,
so I finished all job I can do.

Anyway, you believe this approach is solid.
All that is left is somebody makes a decision.
Already you are asking this to Andrew.
Good luck!



--
Best Regards
Masahiro Yamada
