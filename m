Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412C20651
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 06:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGSGjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 02:39:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59375 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfGSGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 02:39:05 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hoMXl-0006yq-Vq; Fri, 19 Jul 2019 08:39:02 +0200
Date:   Fri, 19 Jul 2019 08:39:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: x86 - clang / objtool status
In-Reply-To: <20190718205839.GA40219@archlinux-threadripper>
Message-ID: <alpine.DEB.2.21.1907190837350.1785@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de> <20190718205839.GA40219@archlinux-threadripper>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, Nathan Chancellor wrote:

> Hi Thomas,
> 
> I can't comment on the objtool stuff as it is a bit outside of my area
> of expertise (probably going to be my next major learning project) but I
> can comment on the other errors.
> 
> On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
> >  Build fails with:
> > 
> >   clang-10: error: unknown argument: '-mpreferred-stack-boundary=4'
> >   make[5]: *** [linux/scripts/Makefile.build:279: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1
> 
> Arnd sent a patch for this which has been picked up:
> https://lore.kernel.org/lkml/CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com/

Which I applied and now I get:

ERROR: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__eqdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__ledf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__subdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__gedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__ltdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__gtdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__floatdidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/home/tglx/work/kernel/linus/linux/scripts/Makefile.modpost:91: __modpost] Error 1

