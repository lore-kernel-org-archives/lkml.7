Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7DD2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMtLwACj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfH1X2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:28:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38715 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfH1X2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:28:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so759983pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XyfWMjZjslCIkbHpIEJO6yFk4GM8tJmlHzY8WN3VpE=;
        b=XMtLwACj6fCFbm6guyZbm9jzJBOyNJEoTy7r2/RB7UJhbFEszjyOEmVaFj5OGiCRBf
         qcwmnxKJjdE3lGkxDWEMahPwvr5c+YAxRrI8cG5n+zOmmLrJahXlDwAXq5+wA2AcHz76
         WaqGsJGM5nuCtZLonWi9OvF2Be8jS7WGn5Pj+hQ3v8aaJNepAwK5xj2I2cDfQs1zW9+J
         6fOyt8MXAbfwKRkBaz4NpP54uDc6X2cszk53YroJpf9X30zWd6WkFvyuoGVuxG5eiDeZ
         UT/Wp8nZ/3iNs+YQhwOb4rgch1ZUzr9bu/mva13GF1CqV2Kf0BJjYbYGwYFGPGpdcRD3
         m1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XyfWMjZjslCIkbHpIEJO6yFk4GM8tJmlHzY8WN3VpE=;
        b=kAtRiBENSwfltnLH4bbonziYAb7pMbZv+A2ZjfqHHrYLNMclkMQiYBlHo1VXUnPg+H
         C8Ab6D3trEzWf7R2s0ygTINmmDa9QhOn13pxUc6+SFcJhSBXL2SQixlY9sBm4B6mLwLJ
         CensMoNBXWwZfGdoi/dm+ir+V6pqSOOQ+/lki+DC4LucRMXHhPfByM4g/BqVazKqHkHc
         1JEQzs5Ncv/DBeC4Vcft35n9RYHH5VHetbvEHFK7wz+O3UFe8TGwTDWE3FwUAVAaMsEg
         8P9az/Uuyw+DNfkzcFpFojQsXoWbrtQyS3M8z7KeLml6Ol/0r0ln+AqtztyQDa55UX9X
         mCug==
X-Gm-Message-State: APjAAAWqP4h4krMHwgVrFhztyCwt8sTJ1me+A/8KHbzKcZcbYWy+klXR
        gfsbazsLe1ANzrzrG0FohFVscJL1QLwnhvo3+w2DqA==
X-Google-Smtp-Source: APXvYqxoPTiNQF9WXfZ7KaeaFJq1LN79r5ZLWpR7OhqM82xMZYPECA6QfKBmE72pTjxXDBUtXDDp1GOIi1r5C5wFNFI=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr5724062pgb.263.1567034921605;
 Wed, 28 Aug 2019 16:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190828055425.24765-1-yamada.masahiro@socionext.com>
 <20190828055425.24765-2-yamada.masahiro@socionext.com> <20190828182017.GB127646@archlinux-threadripper>
In-Reply-To: <20190828182017.GB127646@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 16:28:30 -0700
Message-ID: <CAKwvOd=r5Y8hQQBeKZ6zAokPdyeT2AVKFsdviTvwV5AyDQQHrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: allow Clang to find unused static inline
 functions for W=1 build
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Sven Schnelle <svens@stackframe.org>,
        Xiaozhou Liu <liuxiaozhou@bytedance.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:20 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Aug 28, 2019 at 02:54:25PM +0900, Masahiro Yamada wrote:
> > GCC and Clang have different policy for -Wunused-function; GCC does not
> > warn unused static inline functions at all whereas Clang does if they
> > are defined in source files instead of included headers although it has
> > been suppressed since commit abb2ea7dfd82 ("compiler, clang: suppress
> > warning for unused static inline functions").
> >
> > We often miss to delete unused functions where 'static inline' is used
> > in *.c files since there is no tool to detect them. Unused code remains
> > until somebody notices. For example, commit 075ddd75680f ("regulator:
> > core: remove unused rdev_get_supply()").
> >
> > Let's remove __maybe_unused from the inline macro to allow Clang to
> > start finding unused static inline functions. For now, we do this only
> > for W=1 build since it is not a good idea to sprinkle warnings for the
> > normal build.
> >
> > My initial attempt was to add -Wno-unused-function for no W=1 build
> > (https://lore.kernel.org/patchwork/patch/1120594/)
> >
> > Nathan Chancellor pointed out that would weaken Clang's checks since
> > we would no longer get -Wunused-function without W=1. It is true GCC
> > would detect unused static non-inline functions, but it would weaken
> > Clang as a standalone compiler at least.

Got it. No problem.

> >
> > Here is a counter implementation. The current problem is, W=... only
> > controls compiler flags, which are globally effective. There is no way
> > to narrow the scope to only 'static inline' functions.
> >
> > This commit defines KBUILD_EXTRA_WARN[123] corresponding to W=[123].
> > When KBUILD_EXTRA_WARN1 is defined, __maybe_unused is omitted from
> > the 'inline' macro.
> >
> > This makes the code a bit uglier, so personally I do not want to carry
> > this forever. If we can manage to fix most of the warnings, we can
> > drop this entirely, then enable -Wunused-function all the time.

How many warnings?

> >
> > If you contribute to code clean-up, please run "make CC=clang W=1"
> > and check -Wunused-function warnings. You will find lots of unused
> > functions.
> >
> > Some of them are false-positives because the call-sites are disabled
> > by #ifdef. I do not like to abuse the inline keyword for suppressing
> > unused-function warnings because it is intended to be a hint for the
> > compiler optimization. I prefer #ifdef around the definition, or
> > __maybe_unused if #ifdef would make the code too ugly.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I can still see warnings from static unused functions and with W=1, I
> see plenty more. I agree that this is uglier because of the
> __inline_maybe_unused but I think this is better for regular developers.
> I will try to work on these unused-function warnings!

How many are we talking here?

>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

This is getting kind of messy.  I was more ok when the goal seemed to
be simplifying the definition of `inline`, but this is worse IMO.

-- 
Thanks,
~Nick Desaulniers
