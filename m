Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F15A20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CoqP6ZBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfH1XK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:10:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH1XK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:10:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so489691pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maM1ojqJifdUsFgge/qaHK4HvmJyTKAP1bwPNUVbauM=;
        b=CoqP6ZBWZexG4zx4P3Z0hyz5luNndnAM9uwV0BKqUA7PZ1es/9ehQ7pkOC9Go+IshW
         CigSOg+kriQ5Od71j4CaX4//YV5Trlou/0hEy2fiGNxK/QKo4DlXklacQ9Wc9IKHmQLo
         iA4i9I2koJCvIKWDBl2pTSEoab7WXzlePtTi0yZgaDYzB7TOPcqVfgAGkHk+qUlYJeB+
         tIndUZw5HTHZma1oGCrm/PTQJ/b/Oc/5My+no7ip+eyrFw2nfYU5oZ4HpIad6l91XmU0
         zl68nkzBTHHSAG03NR0a/jxI3amFj5IuUlAIHsq968yH+jkypJcMExGZ9j4Z7P1AfaJR
         oXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maM1ojqJifdUsFgge/qaHK4HvmJyTKAP1bwPNUVbauM=;
        b=EL13EeVfi5/vZsnI2c76dleFocHvf2AxNK/H1WISlILdIWohykHMYLb4MA25IIT257
         q2/oRqha4krJWrNZJGyn84gOmwDgdDS60XcROXPZTvqTKbMDfpioPU47OG5C3w+riI3U
         /R8jYInSINGsQ7bZy+CZxFfW3lpwsMdXzT6JjDD3/W0VQ7q4zrX+I1HsIZbKtgyOswky
         uZ53JOavckvo+3Cu+z7Dnt+qRl5vKOIvZLRoFzqDnteMdJB4hWIAryQmvTqFuuaB8Npw
         0WdH2+neqTAiaGYvrxazAzpKIDOWrB8bgulwyku/Ecqrj9yNLBlOOKG+n4SyeptjPNFv
         CW+g==
X-Gm-Message-State: APjAAAVvX/x7ZDzkjAkFvJ8qCeX7hgfrmUkAJ5CVl47LFIjFLDyo3E1X
        lB8PbENUJ6b0KkuO1+C36sEJz8miqZNQ92sRIkVb/A==
X-Google-Smtp-Source: APXvYqyBkUur1MD0ri9FpGE1y6Y892AFfQGNxC+0LHOa79X9Ax6KxItGnMgIgKpd0mOuC+JL/NR1NTiffQxnEHd21V4=
X-Received: by 2002:aa7:984a:: with SMTP id n10mr7703356pfq.3.1567033826824;
 Wed, 28 Aug 2019 16:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190827103621.1073-1-yamada.masahiro@socionext.com>
 <20190827192811.GA24626@archlinux-threadripper> <CAKwvOd=7Jf13PDC9Q1FMhZUJQsq7Ggn=wRz5xpRY0YrU6tP9Kw@mail.gmail.com>
 <20190827213447.GA26954@archlinux-threadripper> <CAKwvOd=pQm7ytZSJeRzXoWwzouDADOYkO8S_+zSPtXOAO3Jc5g@mail.gmail.com>
 <CAK7LNARduZNvwQ2AJbP3NNDojM+1AACx=wRqdRz+DRSCuVMK2w@mail.gmail.com>
In-Reply-To: <CAK7LNARduZNvwQ2AJbP3NNDojM+1AACx=wRqdRz+DRSCuVMK2w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 16:10:15 -0700
Message-ID: <CAKwvOdkOo-6aS=Tu_QkArHK=rhK34Qe+SKJtY4sM-7YupAsCNA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: enable unused-function warnings for W= build
 with Clang
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 7:58 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Wed, Aug 28, 2019 at 6:56 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Masahiro, does your patch correctly make -Wunused-function work for
> > clang at W=1?  It looks like -Wunused gets added to warning-1, but
> > then -Wno-unused-function gets added to KBUILD_CFLAGS after `warning`
> > does.  Will that work correctly?  I'd imagine that at W=1,
> > KBUILD_CFLAGS for clang will look like:
> > ... -Wunused -Wno-unused-function ...
> > which is probably not what we want?
>
> Hmm?
>
> -Wunused is added only when W=1.
>
> -Wno-unused-function is added only when W= was not passed.
>
> They do not happen at the same time.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
