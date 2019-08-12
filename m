Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D9AC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC72067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTrR1jRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfHLXLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:11:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44221 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfHLXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:11:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so50235751pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Her0OYFs2zX3q5iZN56afRNSN+fnKJ3NNrx8jJX8o8k=;
        b=vTrR1jRTgL4iRmAZ5fdobfuvth2/y2plNQkF0DzSCYwhlvvdjHuepm8xF+TFmUwYar
         EmuOSOPo44nU4I0F9hv5lbc9SZ9aOQlmbirCC4tApOfimxf+iDHl0fkW74gwmu7xpDGu
         UBpuj9Vl6+ebOYa4MZZ+Alu/34qNOmGyZbVH56rLd3246C9JGdSF+mH4fGTEingXgt6Q
         tl2SKpLTr3kBgYcxUWca8zANYFfFPD68TXaHao/KESX2HTYzLFPN7HR0ccFNZKu9L008
         W4I7E7DbZFW+cJcbjLkMLOE8MTlFM3DZj7gonoRZUO6ZiJfSDu1QnbiHQA2Py09u7gd6
         EX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Her0OYFs2zX3q5iZN56afRNSN+fnKJ3NNrx8jJX8o8k=;
        b=pobLwSfzGmwj4bdJPNOsp8TJT1+5J/jFcshp0rWjPJIA3dn/grXWpfMXvf+KJSNiCC
         yD2/09XbIe4Steio/FIQYZ2JTjcuh/5N7exMp2N+GijgxGmolrC1IsKeSc+z49pDzQ0c
         3HxUoid4IhOBfn0is1FtV9MdwDo0wuxfRsaYdQvNB8P8DhrW5p7TWeMwbdNHPpCM60T/
         V7c8PqkkoYMwdROF7IFbImgbay71R+J/pKLEFCk3Iu46uO5jAlGy2V9UJr304khpgku6
         QQ6pyzPRbAbLTSMuSTNHQBcKOu5fA3jwPbP5EnSpXeJU4bGBtiq0AuXWeZTZ4jDVNUMg
         Zn0w==
X-Gm-Message-State: APjAAAVUNmxgQ5cRgsqCPC5twLa/9FHeha08SXC/d+e7tnjcVkZXE4x5
        dkOzlYIN7wnTMQfCEPaMANL/bvrz0Au7kA/lifjMkg==
X-Google-Smtp-Source: APXvYqwca6tZ65ZmZZkZUZTAK/puSDKQ1Znn+us2FkoPx+5t5hHQ8l+KdKMU434nDW1cC4UrHfPz8BKtXr2Ign1LyYA=
X-Received: by 2002:a63:f94c:: with SMTP id q12mr31673758pgk.10.1565651497838;
 Mon, 12 Aug 2019 16:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190812214711.83710-1-nhuck@google.com> <20190812221416.139678-1-nhuck@google.com>
 <814c1b19141022946d3e0f7e24d69658d7a512e4.camel@perches.com>
In-Reply-To: <814c1b19141022946d3e0f7e24d69658d7a512e4.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 16:11:26 -0700
Message-ID: <CAKwvOdnpXqoQDmHVRCh0qX=Yh-8UpEWJ0C3S=syn1KN8rB3OGQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Change fallthrough comments to attributes
To:     Joe Perches <joe@perches.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 3:40 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-08-12 at 15:14 -0700, Nathan Huckleberry wrote:
> > Clang does not support the use of comments to label
> > intentional fallthrough. This patch replaces some uses
> > of comments to attributesto cut down a significant number
> > of warnings on clang (from ~50000 to ~200). Only comments
> > in commonly used header files have been replaced.
> >
> > Since there is still quite a bit of noise, this
> > patch moves -Wimplicit-fallthrough to
> > Makefile.extrawarn if you are compiling with
> > clang.
>
> Unmodified clang does not emit this warning without a patch.

Correct, Nathan is currently implementing support for attribute
fallthrough in Clang in:
https://reviews.llvm.org/D64838

I asked him in person to evaluate how many warnings we'd see in an
arm64 defconfig with his patch applied.  There were on the order of
50k warnings, mostly from these headers.  I asked him to send these
patches, then land support in the compiler, that way should our CI
catch fire overnight, we can carry out of tree fixes until they land.
With the changes here to Makefile.extrawarn, we should not need to
carry any out of tree patches.

>
> > diff --git a/Makefile b/Makefile
> []
> > @@ -846,7 +846,11 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> >  KBUILD_CFLAGS += -Wdeclaration-after-statement
> >
> >  # Warn about unmarked fall-throughs in switch statement.
> > +# If the compiler is clang, this warning is only enabled if W=1 in
> > +# Makefile.extrawarn
> > +ifndef CONFIG_CC_IS_CLANG
> >  KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough,)
> > +endif
>
> It'd be better to remove CONFIG_CC_IS_CLANG everywhere
> eventually as it adds complexity and makes .config files
> not portable to multiple systems.
>
> > diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> []
> > @@ -253,4 +253,8 @@
> >   */
> >  #define __weak                          __attribute__((__weak__))
> >
> > +#if __has_attribute(fallthrough)
> > +#define __fallthrough                   __attribute__((fallthrough))
>
> This should be __attribute__((__fallthrough__))

Agreed.  I think the GCC documentation on attributes had a point about
why the __ prefix/suffix was important, which is why we went with that
in Miguel's original patchset.

>
> And there is still no agreement about whether this should
> be #define fallthrough or #define __fallthrough
>
> https://lore.kernel.org/patchwork/patch/1108577/
>
> > diff --git a/include/linux/jhash.h b/include/linux/jhash.h
> []
> > @@ -86,19 +86,43 @@ static inline u32 jhash(const void *key, u32 length, u32 initval)
> []
> > +     case 12:
> > +             c += (u32)k[11]<<24;
> > +             __fallthrough;
>
> You might consider trying out the scripted conversion tool
> attached to this email:
>
> https://lore.kernel.org/lkml/61ddbb86d5e68a15e24ccb06d9b399bbf5ce2da7.camel@perches.com/

I guess the thing I'm curious about is why /* fall through */ is being
used vs __attribute__((__fallthrough__))?  Surely there's some
discussion someone can point me to?
-- 
Thanks,
~Nick Desaulniers
