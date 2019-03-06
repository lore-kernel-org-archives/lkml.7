Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCDE206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5V6hV5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfCFKDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:03:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39939 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:03:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so10314664ljd.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byCTYfWGsQXMUhtXx7KcbdDVC4O0C0UiPWM/NHaLl6I=;
        b=H5V6hV5motwzXro7TMVtYzSefDS+2v0aXHwyBQ98iif1ehQOBIBMJNB6iAeAsFkEl/
         QYrnYM/HVgFn/vlnUPpTuwIxNZAmKGD93g6leL2+if5AgE2tkXR/yOhM/RguQ/s77DED
         LP5p4GzhynJI3g+a+UU8IEBNH9OlTLsEs3OCcclygLeZVW8NlXlXbfVh6V5eNVt3RjuK
         S7MaIOlnBmqNgXbWVVufhFY5n8wE8e9qPelxd2GHSgv9UM5a3Acssj5OdzrD2yShoctz
         TzCfWIiEG+nwDiOhECf05GdTQ1XP0S70zE1nTiJP5tdu/Dcp4Vwo7XaOiifl/u58wRjk
         +zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byCTYfWGsQXMUhtXx7KcbdDVC4O0C0UiPWM/NHaLl6I=;
        b=k5fbVUj/us50r2r8lQMHi+Pm1OjGzXkSJbKLEjmPozgltA2jMAmRZ9rWEcQw9EOU9R
         tv63wfXQ/eFZyYclvZuIp7vPL3yFoWwJYUSO/hmNm3mo5ns6W2o4DR7BsE6GdqPokvcc
         yrrcHde3VAx4XgW2srYxMPsYe1EYy2ALU7BufH4onrQiwo4QloyXItLGHgxMHy+fvLvl
         6/Jqls/+JZX2Y4kSum+OXXrPKaolCIeGIyL64Y4fqJcku9BRvZCFe16CiLivFNBmLqt1
         MicEoBvnpCHq2Ezgm5A3nT/pnxmqCbBoqqmJtVh3c2owkxWiKZtWGvE0ucmfyuuZxWLh
         jidQ==
X-Gm-Message-State: APjAAAWkHsxgxaw6/s0Vx6ePmDUjIlO3mJbUz0rlBDWnn3CJIrcssc1a
        pG4XvQ9ImHDnkMCtKVGB7U0y6WEUEb15WF/IGUQbD3eC
X-Google-Smtp-Source: APXvYqyzdP35EI2S2cxGMJ51CxUPIgeCwjjCp5ze+0Od5gvEkwvSZKK+Z+oHz9FA/8biwJvYCBhVqNhW5YTILVaaDh0=
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr1653001ljj.69.1551866603166;
 Wed, 06 Mar 2019 02:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <20190301184816.784-2-mans@mansr.com>
In-Reply-To: <20190301184816.784-2-mans@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Mar 2019 11:03:12 +0100
Message-ID: <CANiq72=1TDqUUsdHRM_=hL7pHj2RyWsabraAztYR5MTDcQ1BuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] auxdisplay: charlcd: simplify init message display
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:48 PM Mans Rullgard <mans@mansr.com> wrote:
>
>         /* display a short message */
> -#ifdef CONFIG_PANEL_CHANGE_MESSAGE
> -       charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" CONFIG_PANEL_BOOT_MESSAGE);
> -#else
> -       charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*Linux-" UTS_RELEASE "\n");
> -#endif
> +       charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" LCD_INIT_TEXT);
> +

Nice simplification, thanks!

CC'ing Willy & Geert in case they want to take a look for charlcd.c

Cheers,
Miguel
