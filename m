Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C48C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0672077C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8oztfYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfGSHDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:03:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39125 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfGSHDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:03:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so31090698wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U80UZn01Ob0xepIcFiQIOV3+KsHca5AWbfBENdSAxxE=;
        b=V8oztfYx20N5r14aDZP0xCgnJ77x55VyTpEv8spC+oq8l7hW2VUABg3nBgPGXdLk/J
         mC09J0sJSo2dlktObL+jQWhWShMoo+xoBE4TZHjGJsOc8u+7LGhrHHCDxNsqLfJLSb/B
         v9XdgKZc02Dhah7ysjB08seYCHt+mI6qwv/NewabVYMu/8Rg/r86OvwpKsaRP97k253G
         WzRYDrs/EdfGBEiJE7JIo83cxuxBdzHSRFlZKyBOiZwAkfF3eeAyCqzloahTEO165pFO
         fyuvNEKVQSuxr6x40Z9dgUk/i2ZwAP4QAx8Xg1lmOZkdabju9CJ1KDzEO9kdi5l1Mzn7
         aQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U80UZn01Ob0xepIcFiQIOV3+KsHca5AWbfBENdSAxxE=;
        b=BMW+G4EGTg+KVftTJP6JnAJCo7qcIQ2WY1vghNXrB9Qb5ZrG+bbC3wclYylkzWhlgz
         xNGnS9n1hWZ5N7gRCCdeSwzj/P/CQkZO8atirmRFpis/4qmuWCcwtCl343fSiq1UnS0q
         qtA8ZJatdqhy4e85cnU35y42CqaJ/B+Ca5ZIGo0TMi91OoTwJboh2d4Tv5in27FIY/hH
         KBv2I+/+jPn5GyBOg+KA3dUwHgUJTpr9UbEbPX5FVPrCK3k4OPlQMZNGSfCoxgEVlng2
         TYSwY9qGbySnpl1pzGjALZ2PyyFrUM8V+srLvaAnSYPYTnyouLEazkXFaqHgIbRiBB1/
         Dz8A==
X-Gm-Message-State: APjAAAWTe3lvAUEcfmcCAEQEQB7/iEYUeoLIny75iJsGLk99k4s5fK0k
        3dPPDZPr4sru0Zd1hlXqHf4=
X-Google-Smtp-Source: APXvYqw0dMCO4f1TI2paUGO/sy95boxxoGvoUGmpmyZE/neDWr/obiDIbfT3IDkCuqP/hofGdslGyg==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr4012915wrw.131.1563519807754;
        Fri, 19 Jul 2019 00:03:27 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t6sm29535091wmb.29.2019.07.19.00.03.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:03:27 -0700 (PDT)
Date:   Fri, 19 Jul 2019 00:03:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: x86 - clang / objtool status
Message-ID: <20190719070325.GA29883@archlinux-threadripper>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190718205839.GA40219@archlinux-threadripper>
 <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:39:00AM +0200, Thomas Gleixner wrote:
> On Thu, 18 Jul 2019, Nathan Chancellor wrote:
> 
> > Hi Thomas,
> > 
> > I can't comment on the objtool stuff as it is a bit outside of my area
> > of expertise (probably going to be my next major learning project) but I
> > can comment on the other errors.
> > 
> > On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> > >  Build fails with:
> > > 
> > >   clang-10: error: unknown argument: '-mpreferred-stack-boundary=4'
> > >   make[5]: *** [linux/scripts/Makefile.build:279: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1
> > 
> > Arnd sent a patch for this which has been picked up:
> > https://lore.kernel.org/lkml/CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com/
> 
> Which I applied and now I get:
> 
> ERROR: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__eqdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__ledf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__subdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__gedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__ltdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__gtdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: "__floatdidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[2]: *** [/home/tglx/work/kernel/linus/linux/scripts/Makefile.modpost:91: __modpost] Error 1
> 

Ah right, allmodconfig...

https://github.com/ClangBuiltLinux/linux/issues/327

https://github.com/samitolvanen/linux/commit/2fd53310b7d7e9234c4018c45aefe056a0784e2b

This needs to find its way upstream again, I am not sure what's holding
it back at this point (probably real world testing), maybe Sami or Nick
will know.
