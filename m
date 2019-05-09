Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A83C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B0F217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvZ6FfLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfEIRBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:01:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39943 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfEIRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:01:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so1435200plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdvvFe4BkIp3b7mnRhmSmtM8iVd7O7mPWgxjVeW2r74=;
        b=YvZ6FfLqkCLwg0RXt97ETkf1zBpl0R5wJOGGli5uw/GEl0JXidDWRTX84yjlUV0OaL
         rfiJgBIlmZYZEzGBjJl1Pfimc6Y8KtyD18DrFBOG70zW94DGzIONHMCGFqB9UPFSoWTM
         TbOK2BLlrTlkRfRC5Z1FQ2TTsq+yLTjQ/Kngu9p7ExpOc5qdlY2FN3K/QVyxD5TLoFBb
         vZbeK5PK5UB2Ivd1FSiOC2bCestoGrXt3DXDTEzQci427useXy2/dx71RyIo34hspYkD
         mI4jfGHYQ9Z/SKbVjMAgQL8IK8o+8OG36dgk216Fz0YOgkOX/Dgu9KREW18seIY1pPu1
         nLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdvvFe4BkIp3b7mnRhmSmtM8iVd7O7mPWgxjVeW2r74=;
        b=sBQT012pQ+ECxJjaMq6TwqLP6RMVmsmS6eobLypNAnOfmQMSVzk+d0mNIrsV5RPd6s
         Xzm5D1P46BuqKYrYVoiozdu7AVOtc8JfxzA6TAp0nX1xq39uRGMRP5Zl88ok+VFSYoYq
         q5vMp2OkhAs8RHtpuk11w9LJXOZ8tQOUuFmr51pV4nxrfk9t8yCZJ56619rLbEHVX4Fl
         ha9zpjnAjrEkBMgEFtMj6ZBjoYXgUpcnuPHzECQ8lAsHIj6ZtGfqDE4ZO+mSqYYoL1cK
         9/guY28ECI3K1cGfeJ8k0iQUuBww1f4F6FK5feeEvgpucsRMQkp04JfF3d/2Err1e9mx
         y7Ag==
X-Gm-Message-State: APjAAAW3uOBiPZ8PRM3nq7l1yF+XKSlkXej/0alGGpW4+gKnUzk0Vkjk
        L18N9Zp6ES5P+wHa6Gk7sj46c1cFTnlkejvYGR9Ppw==
X-Google-Smtp-Source: APXvYqwDxtDS2K1shctsc+8evA6YFokeIrz181rTl7BWeAC13GrDNtUhiD/aN1XuWZ/gK8GEc59YncloA04rNVSkgvI=
X-Received: by 2002:a17:902:e287:: with SMTP id cf7mr6577691plb.217.1557421292762;
 Thu, 09 May 2019 10:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASpsid7_sh4rdRNSTwZ1YtW_+uH2eoarJNNUttntQZ-kg@mail.gmail.com>
 <20190509114824.25866-1-natechancellor@gmail.com> <CA+icZUUN7cVXnkUv9DzYC7voys_CS=DJDm19EeYSWPyQwVdXVw@mail.gmail.com>
In-Reply-To: <CA+icZUUN7cVXnkUv9DzYC7voys_CS=DJDm19EeYSWPyQwVdXVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 May 2019 10:01:21 -0700
Message-ID: <CAKwvOdkofHbT0qTvEkevvKUmzw5Ex5AD0wm+u4KYm7-HHMrnow@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Don't try to add '-fcatch-undefined-behavior' flag
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 9, 2019 at 1:49 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > This is no longer a valid option in clang, it was removed in 3.5, which
> > we don't support.
> >
> > https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4

lol, good catch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> >
>
> Cool.
>
> Can you test with -mglobal-merge (inverted -mno-global-merge) which is
> default for Clang?

Looks like these were added in r234668 in 2015, which would've been
Clang 3.6.2, according to:
http://releases.llvm.org/

I'd be fine with dropping the option check there.

There's a few here (-Qunused-arguments) that don't need cc-option
checks.  I recommend someone audit all of them, rather than send a
bunch of little patches.
-- 
Thanks,
~Nick Desaulniers
