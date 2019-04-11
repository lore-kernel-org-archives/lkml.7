Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DB9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3014220693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+MWK/nB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKRMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:12:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42240 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKRMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:12:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so3924152vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbVhfxmGF0URsGvyR2UkMeD56y0+dvwTkthYL3Uleek=;
        b=X+MWK/nBnYRuHCbAkw7FFJUhs/b+TfhegS9ar0HHGiRvNTE24iJdfV77fs7sYwIhTZ
         7AHrBpobPL1qYM+8x2quOZno9dt9UpqI2l8hmRsmDhe1fOBt6/7WS57SQLr7A8czn+6I
         DKvlexZH15Z1OSRBWpQ565uNRY1P8uBJ+lh2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbVhfxmGF0URsGvyR2UkMeD56y0+dvwTkthYL3Uleek=;
        b=d4bi3FZcGnNYcztihtA3fnCZNdQvPhDCezDBMKEshKvugIb8IO7YUohLPy/WmArj3y
         at0nD7b+LxBXRCqkuG2xnom0wM8bx4ev/qbFU7Akib4bELOE3p39GvWvm2UqtGFUW+kx
         k3tmupaEcOnOL++nVwg9JU7VvL4weKUcrjiYXu12Ip8aJVi85Spd3IwUk784A1C7ieoQ
         qa2OOdogdHWDeGxoDZzOOKwi8Yy4AgCiJrj3luWY1+4lunuf11RT4iWU9+fsdwMlMjCo
         lpv4bQuUAaHkRA2sCDLvNJrPYhbCJmoLPdAc5Wi8MU89cHMtr+HkAGrOXtxinRcnv3jp
         tWkw==
X-Gm-Message-State: APjAAAXkRbnB04CJmkOk+xUHhjzx48jnPK79sPuziZIuNGzg3iND0z8Q
        CuYZTVbxd/jWGDxvU1/Tn/lUnkN+/i0=
X-Google-Smtp-Source: APXvYqzzQ7DLV1Das05aO6sYEFx7xJUSu0V1oZKFzjRRoiprKQaR1+zybXXU8M09XagBO8MiChg7FA==
X-Received: by 2002:a67:e9c8:: with SMTP id q8mr26496511vso.120.1555002767353;
        Thu, 11 Apr 2019 10:12:47 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id y18sm2822883vsm.10.2019.04.11.10.12.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:12:47 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id l17so1541667vke.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:12:46 -0700 (PDT)
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr25497993vke.80.1555002445937;
 Thu, 11 Apr 2019 10:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org> <20190410161612.18545-4-keescook@chromium.org>
 <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
In-Reply-To: <CAK7LNAQpm5Tz_Fo0rSq00emB7BLnfYB-+mwXd9GiMKAqKCfkrA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Apr 2019 10:07:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJYPO7buixedop=8e_e+Pf-4nmkz-iS3EV5CXC0obKpdA@mail.gmail.com>
Message-ID: <CAGXu5jJYPO7buixedop=8e_e+Pf-4nmkz-iS3EV5CXC0obKpdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: Implement Clang's stack initialization
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:06 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > CONFIG_INIT_STACK_ALL turns on stack initialization based on
> > -ftrivial-auto-var-init in Clang builds and on
> > -fplugin-arg-structleak_plugin-byref-all in GCC builds.
>
> Is CONFIG_INIT_STACK_ALL wired up to GCC plugin in any way?
> I could not understand it from the code.

No, it's only available under Clang. Clang is all-or-nothing, and the
GCC plugin has a degrees up to "all passed by reference" which isn't
truly "all" (i.e. Clang will initialize variables that aren't passed
by reference and trigger a compiler warning about being
uninitialized.)

> >  choice
> >         prompt "Initialize kernel stack variables at function entry"
> >         depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
> > +       default INIT_STACK_ALL if CC_HAS_AUTO_VAR_INIT
>
> Why should this be enabled by default?
> Ins't it a performance regression
> since it inserts instructions in function prologue?

There are very few users of Clang right now (mainly Android), so I
figured it'd be nice to start Clang builds from a "protected by
default" here, especially given Linus's thoughts on making this always
happen[1]. I don't want to do it for GCC yet, since that would likely
come as a huge surprise to everyone else. :) But I'm happy to change
this, of course.

-Kees

[1] https://lkml.kernel.org/r/CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com

--
Kees Cook
