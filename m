Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9386C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9816620718
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKYJMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:12:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43225 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKYJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:12:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so11906865oti.10;
        Mon, 25 Nov 2019 01:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk+NkhPjFnnbYDFyM1TauhWaIKmKIDDNin0WNg1qiO0=;
        b=bndipuz+obl4ELE/rSaPln3cdMFh9+ael7ipGz7t6jJ3QHko6G15HCfIVQ0G9U+qX7
         W+PtY7CJqoKNzw2oW2xFakyP4iHdmj46kI0VR4ReyEtnrILYiWkQMgRWPLOCkPHYM9Tz
         BRDXb1PqtnXAH1BJTfBMu/ixwV9mn6F/f/Yb033U2FKrdEhvij3aN4gn1aMu/GYeWIee
         kNQ4mIfnt8PNpFo9bpZw26bCb8UGNIZ85OTtNzA2N3TBqMQlSYnnn/eal5FSj6Q+a6ms
         7xTyTdQth9YFYfbhV1cCf4pcm6YWGNy1Y+P/l29oHI4GVndwJdYgE8857YXm3kMzDXQ2
         GBcA==
X-Gm-Message-State: APjAAAWy0SBPqLX7/XIJLFF1X6okf8QQbCBEsBk2fpxUumXtb/OrszeR
        6QkvRFxaJ3OOd609X6iCOEbqLFoMCYuaQf94aGzXag==
X-Google-Smtp-Source: APXvYqwtaFjNw3p3OBu4OKAJDj7WItOPP5K7234KxGIbUHqdFyD6gSxBAnKBWQtJsY/gq7QrDdAgLP8YoayWmUqik7A=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr20163543oth.39.1574673156887;
 Mon, 25 Nov 2019 01:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20191124195225.31230-1-jongk@linux-m68k.org>
In-Reply-To: <20191124195225.31230-1-jongk@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Nov 2019 10:12:25 +0100
Message-ID: <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kars,

On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> Wire up the clone3() syscall for m68k. The special entry point is done in
> assembler as was done for clone() as well. This is needed because all
> registers need to be saved. The C wrapper then calls the generic
> sys_clone3() with the correct arguments.
>
> Tested on A1200 using the simple test program from:
>
>   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
>
> Cc: linux-m68k@vger.kernel.org
> Signed-off-by: Kars de Jong <jongk@linux-m68k.org>

Thanks a lot!
Works fine on ARAnyM, too.

Looks good to me, but I'll wait a bit before applying, so the syscall experts
can chime in, if needed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
