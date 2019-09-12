Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E53C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBE5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6uGhEvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfILWar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:30:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34444 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILWar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:30:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id h2so18658367ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3TT+GSOg/XNFmiQvt1MI0oGk1fCWtZYNpAqFjvX5Cc=;
        b=l6uGhEvpfRHkzR9HMRJSD3LkVbzuamuxDiJHhEqHM1kEJ7xU2QEi3rrA9icJXwfRmC
         j7lp3VG8v9szixRqj6JlJZ0bR3DtxSwwj1Td/xvH/0ZF58rbJy1yeHPu51uGLsouddm4
         hky90C4poNeNrB6PYvdHIHwe0vt4rBkXBi2BLJekASJcKSkt8fzAOlCpvc5rD+kz4pz0
         BefULFR91FBq7yGgFJD0UEciZ9cCLhs9/Q56d01yu0nsZVdYn/5wX/QeyuXbw/iSQmga
         y4DATUobebEmJApbgUCoFRw4ViJELl2n4HSpHYiVjfGVui7dFqUnr/kwMaVdYd6+ZyQN
         +IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3TT+GSOg/XNFmiQvt1MI0oGk1fCWtZYNpAqFjvX5Cc=;
        b=lQlTd9kt1lDeG7GDfr8ETsF9ZJPHlqIaGowfhiJSU4K5NkLlmWJyOKEsH/gfSfk8qo
         pJSfCq4a4eievvG/ipk6UBwi3fFuqb+T94BVGf6N8KkoJGqzvy2/Pd8LWt3lKVvZiZqd
         zaK4tTrfHrQU1eqbI7FH52yzAmANUP1kVHJIpYYwoFzNQf9vEuyQDBPDyXggxRPM06pk
         H+wSbI0TLUWF8B9EVih25+3wPFkrUw5A4Ht0uVFL8uZ5C8HaYYK15hObe38M/Jn0e4FX
         yhORYNKqmDrwfRRxR0TIT7yOluKEWkzK9xevmDAzC3OwoXtmh59JfuhIZFGEjZBz1p4f
         1+HA==
X-Gm-Message-State: APjAAAUQi9F62/bbg1Qp2hMXLBWsDc1KcNLQJ4bBgWTz6cjWZMX0RNaL
        q4dIw/8v1OEwthfuaqjNRjyxExOfXe3LsAhSah0=
X-Google-Smtp-Source: APXvYqxH0EV5/zOEUgLqz13Rt/yVexbUed+hQwH72QuF+8OqI+nF2yzlwrbvtqgVYlAr8F5OmkePuvul+BlSJ0Qux3I=
X-Received: by 2002:a2e:8e85:: with SMTP id z5mr25062540ljk.220.1568327443590;
 Thu, 12 Sep 2019 15:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190912221927.18641-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190912221927.18641-1-linux@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 13 Sep 2019 00:30:32 +0200
Message-ID: <CANiq72n_KxKGwrN4onWotocTuZjVSAqENF_5Pk9t1-pk7NDrgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] make use of gcc 9's "asm inline()"
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:19 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Patch 1 has already been picked up by Greg in staging-next, it's
> included here for completeness. I don't know how to route the rest, or
> if they should simply wait for 5.5 given how close we are to the merge
> window for 5.4.

If you want I can pick this up in compiler-attributes and submit it as
a whole if we get Acks from rtl8723bs/x86/...maintainers.

Cheers,
Miguel
