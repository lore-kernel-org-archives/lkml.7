Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD0C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F4E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfJANUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:20:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46180 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388146AbfJANUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:20:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id 89so5951336oth.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZmRbEsruWyw6QjQdADmS+Xo1vkXkRcFYI1pBoUt5gs=;
        b=rTZBWrqmUV/5UAc9jTUKMQljp88Hb8Rp9W+C9iS3ye3tej9IoznaoVGOqWaRxOEt9o
         HpA4bbMkY3OIANtOX/+5zwD6kk9ySdcVkggSSDW37IGqGowgpqrMqiCZP29DnXHy28st
         gJQaNRyb2eGAok+KRorJ9qXCmWTnx4+Mhyp1XZa4F9Pm++KeNKFffvqMdYrMF0lpkC4C
         DdJpeFzsdc1uHQZdQpeS+/FuFLauxaLOwFC+jRd+MTkbFQKYc1ter14j8UQUPjOa+x69
         IPFnRrNme5x72GRecm71pR06X6eL6vQPhlA554JprNhfzZ+n/rdNrYnVBuDWjTg5oZ9s
         nBxg==
X-Gm-Message-State: APjAAAXxixnJGnhpMhFb1DaIt0C4SdVeZH5H9x3e4PFxegqYtPZDPDQf
        2edie08CKYKE8vhwhmxx407aODHO2er+8e8aGUo=
X-Google-Smtp-Source: APXvYqx7Tma9gFELdx5dgWCcbj/8O8IS5mK2hSemheEmozquet1YALg33qx4hyX5hlnLo1QxMET9Xge8UlykS2h7HrE=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr18265756oti.39.1569936039027;
 Tue, 01 Oct 2019 06:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191001121724.23886-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191001121724.23886-1-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 15:20:27 +0200
Message-ID: <CAMuHMdUFMC0hbv68Ggsu4q2A+OyHwS1kMsgjjRvxZ7qnqqov7A@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: clear local varaible to make it
 work for sh
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

s/varaible/variable/ in subject.

On Tue, Oct 1, 2019 at 2:17 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Geert Uytterhoeven reports a strange side-effect of commit 858805b336be
> ("kbuild: add $(BASH) to run scripts with bash-extension"), which
> inserts the contents of a localversion file in the build directory twice.
>
> [Steps to Reproduce]
>   $ echo bar > localversion
>   $ mkdir build
>   $ cd build/
>   $ echo foo > localversion
>   $ make -s -f ../Makefile defconfig include/config/kernel.release
>   $ cat include/config/kernel.release
>   5.4.0-rc1foofoobar
>
> This comes down to the behavior change of 'local' variables.
>
> The 'man sh' on my Ubuntu machine, where sh is an alias to dash,
> explains as follows:
>   When a variable is made local, it inherits the initial value and
>   exported and readonly flags from the variable with the same name
>   in the surrounding scope, if there is one. Otherwise, the variable
>   is initially unset.
>
> [Test Code]
>
>   foo ()
>   {
>           local res
>           echo "res: $res"
>   }
>
>   res=1
>   foo
>
> [Result]
>
>   $ sh test.sh
>   res: 1
>   $ bash test.sh
>   res:
>
> So, scripts/setlocalversion correctly works only for bash in spite of
> its hashbang being #!/bin/sh. Nobody had noticed it before because
> CONFIG_SHELL was previously set to sh only when bash is missing, which
> is very unlikely to happen.
>
> The benefit of commit 858805b336be is to make people write portable and
> correct code. I gave it the Fixes tag since it uncovered the issue for
> most of people.
>
> Clear the variable 'res' in collect_files() to make it work for sh
> (and it also works on distributions where sh is an alias to bash).
>
> Fixes: commit 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Can you please use

    Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>

instead?

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, that fixes the issue for me!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
