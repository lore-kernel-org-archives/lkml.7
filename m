Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A22C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471C52086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569776416;
	bh=O7Au76RC+mZ4j5oya48DjoDo29q9lKW170STez8LAWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xyg/1yzH4Z5knWgRBYrHC3/rbk2kCnHbduMM3XTDwPsyCaJ6Wgdw6jnUKfOsXgFce
	 HMMXapeB8v0F1zVdt/FvOlGoMCKyHBzm+8TXKv/apP+CnBaAju1YCj+LmjfumfxPFm
	 DR7AttxCRggAwtMEIIvVxnX85uEUy06JNj2BhIMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfI2RAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:00:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43734 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfI2RAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:00:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so5255232lfl.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNDoutGDvOZvHTVduDc/xowF3Yl3vCcT50+XRcdHU+4=;
        b=a9TpzaH3q3HwmagNzHo1UyLPfKUrFN8tPFY8I1+plKnNTY1e10w+JBEJFpaTuRBvRW
         W2yIcI3Xrultoz6vVXOdWNqGlQo+iCB6FGJsrDMifCWX1Qms3kf26i2WdF88FE2sIvJA
         AEgkWZvERAKYAY8SVcmU5Emsf3IfqPwGrj15g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNDoutGDvOZvHTVduDc/xowF3Yl3vCcT50+XRcdHU+4=;
        b=bTgpiD5sa+rbaKKaXg+IBeDI8Gt1lrLfbhRK2UvU2bsA7cwMQfYlJlo1MwTqr/gpx7
         VcjaXPtShxFrNjokCSlTuw9Rgu6aeVjPsSZMH7IspEAKFgL98Y+WBC4aNl2XIpjISOHY
         aMqoYAYuE/3o6U5/A40PCwSfb2IJNR9ni/FvuIKaqImKsQV/nMcGEhn3Y5wKFdrsD639
         ArEIHzEG1+E2/oxiVb+Ngx4sCXHSRxspWj0f/hJQ8+fEWzVIMX8mlvnCM7kXfXJk3cnc
         Q4nAh5Kz9E1Pubm1Q1ybTq72vDaanidRZvbr1Y05dyEZu5Az+2R33FlrCHa0ZN4msq3P
         h6bQ==
X-Gm-Message-State: APjAAAUj0Qc8ZwIognVuGCWyKxS3l1ZFfmZG9XJR8jcsIZ2zKW1Etn7r
        QNAp9hWzHIOghokz/pPDErHmJATOPJ0=
X-Google-Smtp-Source: APXvYqzvrwqA46HEPV/Kj56vRgtM55nSEgS0q9+I+v13DbFVqwWZuPVgDa+SWwXjnYJqNheKJMrsSQ==
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr8870080lfm.170.1569776411554;
        Sun, 29 Sep 2019 10:00:11 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x30sm2397939ljd.39.2019.09.29.10.00.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 10:00:10 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 7so7009567ljw.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 10:00:10 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr9326176lja.180.1569776410194;
 Sun, 29 Sep 2019 10:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT-D68xMFrE-D_F-2y+iZt45+8iLF9dmTyO8YwUX-bTqA@mail.gmail.com>
 <CAHk-=wjdc7Ovi-iVGBGzuP6prTXVRT8rgbnabBd0AiHRqECMCg@mail.gmail.com> <CAK7LNAQuY50tB790n85LGpX3m6yuxHTyB++0BwVFnSnz1B0gWA@mail.gmail.com>
In-Reply-To: <CAK7LNAQuY50tB790n85LGpX3m6yuxHTyB++0BwVFnSnz1B0gWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Sep 2019 09:59:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhKeCH+yGOmHk_2v8GY2EHwXboSS6R-Jov63JHat21XQ@mail.gmail.com>
Message-ID: <CAHk-=wjhKeCH+yGOmHk_2v8GY2EHwXboSS6R-Jov63JHat21XQ@mail.gmail.com>
Subject: Re: [GIT PULL] More Kbuild updates for v5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 9:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The concept of header test is to make sure every header
> is self-contained,

Yes, I realize. But at the same time the filenames it creates are very
annoying and clutter up the tree, and I'm not sure we really want that
in the first place.

The thing _I_ would want is actually a lot less includes, and a lot
more streamlined, just for better build times. I sometimes get a small
pull, and wonder why the *whole* tree recompiles, and realize that
it's due to some really obscure header file that just gets included
"in case".

So I'd like us to be stricter about header files another way entirely,
and I'm not sure that header files should need to be completely
independent.

> Of course, you can argue that it is addressing hypothetical issues
> "what if the include directives are arranged in this order?",
> that nobody has been hit before.

Well, I think people hit it all the time but just add the right header
file when some build fails.

In a perfect world, we'd have something that understands what symbols
get declared in each header file, and what symbols each header file
needs, and have a SAT solver for this that actually also understands
about different configurations and architectures. And actually
minimize the headers, and have a tool that warns when you have
unnecessary ones - or are lacking some.

Yeah, it's probably too complex to be worth the pain, but it would be lovely.

> But, at least, I want to continue compile-testing
> uapi headers that are exported to user-space.

I think the uapi headers have a much stronger case for being
self-sufficient, but even there I'd really prefer some other model
than "*.h.s".

We have the dot-files for dependencies and for tracking the command
that was used to generate them, I'd much rather have that. At least
then we wouldn't uglify the directory structure.

Yea, I realize that some people "solve" that problem by just not
building in the source-tree at all, but I find that annoying too.

               Linus
