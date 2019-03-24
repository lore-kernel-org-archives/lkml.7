Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB00220880
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553461853;
	bh=49Q36mgLGZFH0oTyMFeZGZ/knycNkO9zSFkEUEgu9lU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZXDogqHBZD03r5TAwnd0sd+IWOukAcWrYSQB2GVAyir31fhb82FRK1ly5L6FEBw9a
	 DzlH/2jEwR7eCsRryomWC3h4zYGgF0HfVMpu8VWCyFUgyf1mIk8bjpB/V1NZt+jpFa
	 fpx9InPpbkzJOhBBwuQdkmal66xROhmCaXOpOrvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfCXVKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:10:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38719 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:10:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so5077812ljg.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPnZUl2pyPSTZ9/Y8P81ZMWjsc3IOBpSLH8EhbRIm8s=;
        b=eNwWe+05WtC/sP+9fbn+hwObXfeoF7nfk4dDkpz6Z8PIOyZpydyrq2OlyztXekrllc
         h2vaz210Dijd5aRi5IuQJzsvrCEDFpogg8Eku2we1Nd2d9SB9si95Hq+WvuUgOg9Y4XP
         EM9+NVFiM4wmx19lvoADaOHQtxmeZzFgYWAPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPnZUl2pyPSTZ9/Y8P81ZMWjsc3IOBpSLH8EhbRIm8s=;
        b=cHSSe5xaymOPFMrPFS9zLOinRdhJiWn9P00snJFO6AGnbQ3WtNSQDLZ3656pWUZoub
         JSXREPhrYQihUc/l6bLX3TrERWJRuBcECUt+EnZyCl++z8m3AQ3I3gyfz5ORaM0kHQGT
         BjML/oRGfFtliXFEtfgiZ/nOoV7m3a+frEcQTZrccfRo1DIjM+fubnhvTF6oFQKCKyu1
         l7Ppt0t+frkVQ1B0ey7F4oeG8M8O6xZn9H34SBmjHmfoR01nZRdO4MPGhGOr6i49AY6R
         8u1AvwPxeUY8zZgsg1C2AGAKWuEwJ5fvfP13PtJ+Ni5TdLVSYT2g+WJwtf4UnK+hxkVJ
         lGfg==
X-Gm-Message-State: APjAAAVecD82c2WwOlESZdITsnu64bckc/4Rq9xGgR3qp2K7tUmN7ukw
        f/5uzn842Y3DJgcRq76MSW0Kemzazpg=
X-Google-Smtp-Source: APXvYqxgWsdTc85qhw3qRJl2ha0uf0BUcIhwZLk/gUMP/a/C5gQJ8zMG7PI2gxtyB1akiK//I9VBDQ==
X-Received: by 2002:a2e:9682:: with SMTP id q2mr10130819lji.168.1553461849513;
        Sun, 24 Mar 2019 14:10:49 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 88sm3103478ljs.34.2019.03.24.14.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 14:10:48 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y6so6026212ljd.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:10:48 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr10085435lji.79.1553461848154;
 Sun, 24 Mar 2019 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190323171343.GA19483@gmail.com>
In-Reply-To: <20190323171343.GA19483@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 14:10:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLMT2kaYwwcdMtjvadjdv0aULvb8fsGWqT0V=DUMjp+w@mail.gmail.com>
Message-ID: <CAHk-=whLMT2kaYwwcdMtjvadjdv0aULvb8fsGWqT0V=DUMjp+w@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v5.1-rc2
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mans Rullgard <mans@mansr.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>   - Series to clean up the Kconfig menus and
>     a couple of improvements for charlcd.
>     From Mans Rullgard

Side note: this is very annoying. As part of the rc release I'm going
through things like this, and I notice that the new Kconfig option has
absolutely no help text.

That might be acceptable if the choice of options made sense and would
be obvious to people, but they aren't obvious. Particularly not when
you come from not having an option at all, it's not at all clear that
what _used_ to happen was that "flash" option.

And yes, the Kconfig source code makes it look like there are help
texts. But a help text on the individual options for a choice isn't
actually shown when you ask for help - it's the help text for the
*choice* that matters. Not that those invisible help texts actually
_help_ anything anyway.

                Linus
