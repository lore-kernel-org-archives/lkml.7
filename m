Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB9E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtKdqd1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfLLRo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:44:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbfLLRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:44:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so1120591pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vAybGGxacChJwAejcpVjaSkmOSjuyOa7Vm0vQDf0ytg=;
        b=XtKdqd1uqEqin8HfnsY6la7gkuC/L5k7UGq5WAVvh5yLgp/O7bgr5j2xLaZPJpJSZY
         BkbEVDXJE8CedObjoydxulNAUnY3TJHHQNcPAZ/CoOJ+AT/xyDRa1yKCyjg1ofQCSrPc
         dmOUjyw+tazUcoYKBq1whPaLNbhoET6FUDY6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vAybGGxacChJwAejcpVjaSkmOSjuyOa7Vm0vQDf0ytg=;
        b=DN6Rs7F70lzxMetzDSfQY2/rknrUgsTZwULUS7NvdGBnPmsn9vtXZEqk1dlr35qjbb
         P6uslOoSUWVKKMM7+iEfY/EcoSw41Whsj4KYASFPRa32YVJq56g12bWerO4K4k3lftFf
         IbzLzNwdH3Pf+6qA0rJNx4CF9NGkRo0Z0hqPdwY9hZT3mSd9uJQK4RTypWrUlreRsnsx
         HZ7qFJsU+6e+hArk8CITmIfVFWHGYsk2RRdVEx9QpjD77MA54yIG0FD/YTMXPGFaxlOP
         Egb0gjz5qDZuHILFojvjIKeYwDqg4wiLsC9/BDRQopTlW1NOA9QWj8AQvffZICgSty7T
         Vyiw==
X-Gm-Message-State: APjAAAXL8rEB4qSLnS8XRCELcYsIdKeuSwnI/iMbBtx2BumcgFat0DV8
        3y3YT/uit+yQJm3hseZgEso8cg==
X-Google-Smtp-Source: APXvYqx2FdF/gi6uYV/9IkBPv0MXEhVzlJwwj3Cn0zKuTW8p0YuVLJmzJYaX5SE2C2iWT2vFodsZPQ==
X-Received: by 2002:aa7:9d0d:: with SMTP id k13mr11590528pfp.254.1576172668230;
        Thu, 12 Dec 2019 09:44:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o17sm6423863pjq.1.2019.12.12.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 09:44:27 -0800 (PST)
Date:   Thu, 12 Dec 2019 09:44:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
Message-ID: <201912120943.486E507@keescook>
References: <20191211133951.401933-1-arnd@arndb.de>
 <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
 <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:59:40AM +0100, Arnd Bergmann wrote:
> On Thu, Dec 12, 2019 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Dec 11, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > I noticed that randconfig builds with gcc no longer produce a lot of
> > > ccache hits, unlike with clang, and traced this back to plugins
> > > now being enabled unconditionally if they are supported.
> > >
> > > I am now working around this by adding
> > >
> > >    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
> > >
> > > to my top-level Makefile. This changes the heuristic that ccache uses
> > > to determine whether the plugins are the same after a 'make clean'.
> > >
> > > However, it also seems that being able to just turn off the plugins is
> > > generally useful, at least for build testing it adds noticeable overhead
> > > but does not find a lot of bugs additional bugs, and may be easier for
> > > ccache users than my workaround.
> > >
> > > Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> On Wed, Dec 11, 2019 at 2:59 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Thanks! Who would be the best person to pick up the patch?
> Should I send it to Andrew?

Acked-by: Kees Cook <keescook@chromium.org>

I can take it in my tree, or I'm happy to have Masahiro take it.

-- 
Kees Cook
