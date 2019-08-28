Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB5AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FD720644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrZfzjuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfH1S0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:26:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42615 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfH1S0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:26:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so316184pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2ELFCvPtWq7P/iBoFB+bDhTH6F6gZMcRs7pKSMkPZ0=;
        b=WrZfzjuQAiJeyCbI6jHnj8D+AK+KMLOLl1eaVP4JgWwVLtgFI6iVBl8OFgwkGfopj1
         XnLpMTHDNIci/IJ9m8znBva0rSgnEQ7GVHyIefiaQPdmIznyZCKl8Xc8ZuztfjSfin7+
         xgiv6fhHWTpOuuzx57DiiF9XV4j2Udj36RqMUZgYj4Lm5rADTEicVClvrvxfPlxvznzz
         OxAe0zMf8oUKsjq8B6KtuXljFFO+I5tN8krSxj2FyLoe9Gorb8N5n66A4SYP9/bInsEO
         0oEdsvRDuXfsyd6MVyvqD5ALJ37EAU1g70cdYKZ0TPREQp/FzJ27PI0YpzXhOChNP0/L
         Zjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2ELFCvPtWq7P/iBoFB+bDhTH6F6gZMcRs7pKSMkPZ0=;
        b=h71skfktWG91/iZUcjRwye3AIP5xJcq7SVblTJIZhujjuFDsqdbte0cnZEthEdS4mK
         FcZetaAYauSuM3L1Md8UrU0oTshH5f2dOGrTok0Uy7/ontFwHo2FLAC+I6NntO4AUK6H
         Z2YeO2UcAq52S0uxid8xyIVTQSTr+9WFcv5RfKbLz3laiGLTczokv2KxJUWTQbbmauTc
         lld+DIuaidu8O/3xTU/6/7zvrrwNqobNoUKdBu32A7A7yENZorCK9+a5deyEYzReOIG2
         P8qx9mLuBjibTPNrqjWyJZmPhtInz8IJrNnWEci5JwMeeBJTsK3mDDZhifaslewdS/US
         fFfg==
X-Gm-Message-State: APjAAAVdrg/WjY25iTVoeg0KysVf8QTipTX0eRa6TQdhd5j9vGXAPvgD
        5RKJemEx6TbPXB0foNUpEHVfTsCJpH6B00ztThgAaQ==
X-Google-Smtp-Source: APXvYqwgq6GracV991sCW77HnUuRKoJAO+84cTfDtVfoqGVajWF/+QhM0kqUny8Jabemf0jwZfIKEvj1fo3VUHWGMi8=
X-Received: by 2002:aa7:8085:: with SMTP id v5mr6354559pff.165.1567016779610;
 Wed, 28 Aug 2019 11:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190828055425.24765-1-yamada.masahiro@socionext.com> <CA+icZUWigJkh-VtJc4=xE06oMgE=ci2Mfdo2JaDv0fth8PKH+A@mail.gmail.com>
In-Reply-To: <CA+icZUWigJkh-VtJc4=xE06oMgE=ci2Mfdo2JaDv0fth8PKH+A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 11:26:08 -0700
Message-ID: <CAKwvOd=Zwkm33_8MTFKoVfs8XEEUKgzQFqJN3nar_ryKnbJTPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: refactor scripts/Makefile.extrawarn
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:20 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Aug 28, 2019 at 7:55 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Instead of the warning-[123] magic, let's accumulate compiler options
> > to KBUILD_CFLAGS directly as the top Makefile does. I think this makes
> > easier to understand what is going on in this file.
> >
> > This commit slightly changes the behavior, I think all of which are OK.
> >
> > [1] Currently, cc-option calls are needlessly evaluated. For example,
> >       warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
> >     needs evaluating only when W=3, but it is actually evaluated for
> >     W=1, W=2 as well. With this commit, only relevant cc-option calls
> >     will be evaluated. This is a slight optimization.
> >
> > [2] Currently, unsupported level like W=4 is checked by:
> >       $(error W=$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
> >     This will no longer be checked, but I do not think it is a big
> >     deal.
> >
>
> Hi Masahiro Yamada,
>
> thanks for your patch series.
>
> If KBUILD_ENABLE_EXTRA_GCC_CHECKS does extra(-warning)-checks for GCC and Clang,
> please rename the Kconfig into...
>
> KBUILD_ENABLE_EXTRA_CC_CHECKS
>
> ...or something similiar (and maybe with some notes in its Kconfig help-text?).

I too would like to see that changed.

-- 
Thanks,
~Nick Desaulniers
