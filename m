Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1726C206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oO482uLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCEO0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:26:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40165 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:26:10 -0500
Received: by mail-it1-f193.google.com with SMTP id l139so4683147ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDS5cGbvimqByipqgym8LRQG2coW9/EpAfS9RoloVZw=;
        b=oO482uLCLvptkNe1aE0rBpZAkgHvsfj1TxoNFfW4bFX9kfmCDgK3ymfMvxNsBU22DW
         m0030yj2Mkz8Mx2z+SgLZKCV9wQObXPtYXUzh9Q7aHp9VsodzJs64Y9cv1u3I8f6Gdi2
         xlPDOPn5d6eXBJlD+SQGLFRq7epdvWPDP4Sidxb6l6aBp0RmfxJv010oDkqosy38b19c
         VtZIgM2RvzavRsWKrb0QJYQq+V1E9O3fmtEXX7DyEiIXNRCk2spnRD7Ia+T7eycssrUw
         /fC4O5u9+1IYNSEH3nSXvC4oWS19sVOZaQ5wjqC0f+6564QIUqYEkfLQWz5GcKjBeKHc
         7s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDS5cGbvimqByipqgym8LRQG2coW9/EpAfS9RoloVZw=;
        b=uQidiiIUhD0WCo3KsT3xtE6HJ/xuLCF/FVoVMzrq93sAURx381xE1P4li56z76ieio
         gznd3Nc739vDwVCrCL31ou8BAkg4paQdwESUif1DfZG+m2cUAtj/vpamtzSdCg+71uNV
         rRe/wdurknw102UypVmotR3Cy7qWqemshoARgEIfnZ8YHF87kqtHlw3HW/JYbLF9yVCt
         n9wSNifhqeYad+bFVmZXSLdmN5URVQReosAGTghI63lnFbap6KxiZzIGhmfMwVaQ0ZVG
         KbQWwyEr8sWsSkiuXOSYh6B77CdzgOXxK5mnBD+zoz7JCsl4OuvAL2/eQEk0ylelOpIi
         cXvQ==
X-Gm-Message-State: APjAAAVR1YffPJN6Ejr9L1F1KZWNw3HRcdiOeginH9SsbRo8UUkBmAGW
        hpUVATXCBxsQHdDsRhnmw8pENp9j1CeYSJpCDgKhTQ==
X-Google-Smtp-Source: APXvYqxMB99QboVllLr1U2tSs6uR3hQ1sdBtpZXMTYRMv8xNdrivK1FbQLay1V+X9CcKHRIqp1plvfIhUjq62/c6qQ8=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr2439912ita.144.1551795968921;
 Tue, 05 Mar 2019 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20190226213053.GC218103@gmail.com> <20190226220858.214438-1-ebiggers@kernel.org>
 <20190227231202.tycdbcqtk5ylwp4k@smtp.gmail.com> <CACT4Y+bXsD3FjOYMnpfPz3PtUpNNkpLtxqmZPmnQuk=r2OSpDw@mail.gmail.com>
 <20190304232312.qy6x2xmtueq22m3j@smtp.gmail.com>
In-Reply-To: <20190304232312.qy6x2xmtueq22m3j@smtp.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Mar 2019 15:25:57 +0100
Message-ID: <CACT4Y+bxmb6AEc3YOJ8knVjWWxNDjw7cO0YVYnpOHVE980Ymiw@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: fix use-after-free when drm_gem_handle_create() fails
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 12:23 AM Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
>
> On 02/28, Dmitry Vyukov wrote:
> > On Thu, Feb 28, 2019 at 12:12 AM Rodrigo Siqueira
> > <rodrigosiqueiramelo@gmail.com> wrote:
> > >
> > > On 02/26, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > >
> > > > If drm_gem_handle_create() fails in vkms_gem_create(), then the
> > > > vkms_gem_object is freed twice: once when the reference is dropped by
> > > > drm_gem_object_put_unlocked(), and again by the extra calls to
> > > > drm_gem_object_release() and kfree().
> > > >
> > > > Fix it by skipping the second release and free.
> > > >
> > > > This bug was originally found in the vgem driver by syzkaller using
> > > > fault injection, but I noticed it's also present in the vkms driver.
> > > >
> > > > Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
> > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > >  drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
> > > > index 138b0bb325cf9..69048e73377dc 100644
> > > > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > > > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > > > @@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> > > >
> > > >       ret = drm_gem_handle_create(file, &obj->gem, handle);
> > > >       drm_gem_object_put_unlocked(&obj->gem);
> > > > -     if (ret) {
> > > > -             drm_gem_object_release(&obj->gem);
> > > > -             kfree(obj);
> > > > +     if (ret)
> > > >               return ERR_PTR(ret);
> > > > -     }
> > > >
> > > >       return &obj->gem;
> > > >  }
> > > > --
> > > > 2.21.0.rc2.261.ga7da99ff1b-goog
> > > >
> > >
> > > Hi,
> > >
> > > Thanks for your patch! :)
> > >
> > > The patch looks good for me. I also tested it under the IGT tests on my
> > > local VM and everything was fine.
>
> Hi,
>
> Patch applied to drm-misc-fixes.
>
> > Hi Rodrigo,
> >
> > What are IGT tests? How can I run them?
>
> Hi Dmitry,
>
> IGT is a test suite focused on DRM drivers.
>
> You can clone the project using the link below:
>
>   https://gitlab.freedesktop.org/drm/igt-gpu-tools.git
>
> In the README, you will find the software dependencies. After you
> install all the required package, just use:
>
>  mkdir build && meson build && cd build && ninja

Hi Rodrigo,

Thanks for the info, but this did not work for me.
I installed all recommended packages (including libdw-dev), but then got:

igt-gpu-tools$ mkdir -p build && meson build && cd build && ninja
The Meson build system
Version: 0.46.1
Source dir: /src/igt-gpu-tools
Build dir: /src/igt-gpu-tools/build
Build type: native build
Project name: igt-gpu-tools
Native C compiler: ccache cc (gcc 7.3.0 "cc (Debian 7.3.0-5) 7.3.0")
Build machine cpu family: x86_64
Build machine cpu: x86_64
Compiler for C supports arguments -Wbad-function-cast: YES
Compiler for C supports arguments -Wdeclaration-after-statement: YES
Compiler for C supports arguments -Wformat=2: YES
Compiler for C supports arguments -Wimplicit-fallthrough=0: YES
Compiler for C supports arguments -Wlogical-op: YES
Compiler for C supports arguments -Wmissing-declarations: YES
Compiler for C supports arguments -Wmissing-format-attribute: YES
Compiler for C supports arguments -Wmissing-noreturn: YES
Compiler for C supports arguments -Wmissing-prototypes: YES
Compiler for C supports arguments -Wnested-externs: YES
Compiler for C supports arguments -Wold-style-definition: YES
Compiler for C supports arguments -Wpointer-arith: YES
Compiler for C supports arguments -Wredundant-decls: YES
Compiler for C supports arguments -Wshadow: YES
Compiler for C supports arguments -Wstrict-prototypes: YES
Compiler for C supports arguments -Wuninitialized: YES
Compiler for C supports arguments -Wunused: YES
Compiler for C supports arguments -Wno-clobbered -Wclobbered: YES
Compiler for C supports arguments -Wno-maybe-uninitialized
-Wmaybe-uninitialized: YES
Compiler for C supports arguments -Wno-missing-field-initializers
-Wmissing-field-initializers: YES
Compiler for C supports arguments -Wno-pointer-arith -Wpointer-arith: YES
Compiler for C supports arguments -Wno-sign-compare -Wsign-compare: YES
Compiler for C supports arguments -Wno-type-limits -Wtype-limits: YES
Compiler for C supports arguments -Wno-unused-parameter -Wunused-parameter: YES
Compiler for C supports arguments -Wno-unused-result -Wunused-result: YES
Compiler for C supports arguments -Werror=address: YES
Compiler for C supports arguments -Werror=array-bounds: YES
Compiler for C supports arguments -Werror=implicit: YES
Compiler for C supports arguments -Werror=init-self: YES
Compiler for C supports arguments -Werror=int-to-pointer-cast: YES
Compiler for C supports arguments -Werror=main: YES
Compiler for C supports arguments -Werror=missing-braces: YES
Compiler for C supports arguments -Werror=nonnull: YES
Compiler for C supports arguments -Werror=pointer-to-int-cast: YES
Compiler for C supports arguments -Werror=return-type: YES
Compiler for C supports arguments -Werror=sequence-point: YES
Compiler for C supports arguments -Werror=trigraphs: YES
Compiler for C supports arguments -Werror=write-strings: YES
Found pkg-config: /usr/bin/pkg-config (0.29)
Native dependency libdrm found: YES 2.4.91
Native dependency libdrm_intel found: YES 2.4.91
Native dependency libdrm_nouveau found: YES 2.4.91
Native dependency libdrm_amdgpu found: YES 2.4.91
Native dependency pciaccess found: YES 0.13.4
Native dependency libkmod found: YES 24
Native dependency libprocps found: YES 3.3.15
Native dependency libunwind found: YES 1.21

meson.build:151:0: ERROR:  Could not generate cargs for libdw:

A full log can be found at /src/igt-gpu-tools/build/meson-logs/meson-log.txt


and meson-log.txt ends with:

Compiler for C supports arguments -Werror=write-strings: YES
Found pkg-config: /usr/bin/pkg-config (0.29)
Determining dependency 'libdrm' with pkg-config executable '/usr/bin/pkg-config'
Native dependency libdrm found: YES 2.4.91
Determining dependency 'libdrm_intel' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libdrm_intel found: YES 2.4.91
Determining dependency 'libdrm_nouveau' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libdrm_nouveau found: YES 2.4.91
Determining dependency 'libdrm_amdgpu' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libdrm_amdgpu found: YES 2.4.91
Determining dependency 'pciaccess' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency pciaccess found: YES 0.13.4
Determining dependency 'libkmod' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libkmod found: YES 24
Determining dependency 'libprocps' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libprocps found: YES 3.3.15
Determining dependency 'libunwind' with pkg-config executable
'/usr/bin/pkg-config'
Native dependency libunwind found: YES 1.21
Determining dependency 'libdw' with pkg-config executable '/usr/bin/pkg-config'

meson.build:151:0: ERROR:  Could not generate cargs for libdw:
