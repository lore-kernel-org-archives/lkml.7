Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F27BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9042082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCEHtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:49:49 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36102 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfCEHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:49:48 -0500
Received: by mail-vk1-f195.google.com with SMTP id v131so1757846vkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGxkzNFi32YNEmyF1SWEwggqFSdVpxap6plubpH4mrs=;
        b=dwsJkI3HeVNTcKMNvfAYTngi8cZm5gelz8gaaSlp5icg/v31RxMiua6RX/GD21visG
         WMwndYyEkfm2iOKPaTwfNxqDmB+HC6P88SSpJWI0mdJeKYz/g+BN9bc3pOUUtZRcbl/Y
         0ik+NsPb3n1WLF1uxFC0gTGTDGXZUe+kl9u8OVgBde0njfHtNIT1GtKwR8d21Tw8On9B
         KeWSVUz7Ekzwm84DFSh7jJPp+R08XIxmNGEE5rHLknc0KTOdmutuOBgm7OKlL5iZPZcP
         nehGQt+cUrD9eLXelsoaZtIP8DwcsbscRLN0zQBp2to8k6WHyY11EVyZ0sw0lzCtkuNY
         /vfw==
X-Gm-Message-State: APjAAAXS6zc9yIFd9St9NGRrM67nfIuPBOAshjU6DvkPn+T2YBAsA8JR
        oFCv6WxFHBgeJiT/eQXy8ZBzybv1zz2W2yZFWkU=
X-Google-Smtp-Source: APXvYqz6PTVCJqBVGrE2NzahicvqXtfk+HOL7GLJVdEpRoQATVmajyL4vXW1IGTuvWjcwDuYbnfA+sPit+w3jjwzJQY=
X-Received: by 2002:a1f:711:: with SMTP id 17mr12649292vkh.65.1551772187790;
 Mon, 04 Mar 2019 23:49:47 -0800 (PST)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
 <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Mar 2019 08:49:35 +0100
Message-ID: <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, Mar 5, 2019 at 3:58 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 5 Mar 2019, Finn Thain wrote:
> > Looks bogus to me.
> >
> > If you change memcpy to __builtin_memcpy, then we avoid the macro and the
> > warning changes to,
> >
> > ./include/linux/string.h:456:3: warning: '__builtin_memcpy' forming offset [7, 8] is out of the bounds [0, 6] [-Warray-bounds]
> >    __builtin_memcpy(dest, src, dest_len);
> >
> > The compiler has nothing to complain about here. dest is known to be
> > id->fr and dest_len is known to be sizeof(id->fr).
> >
> > The error message indicates that gcc has applied the bounds [0, 6] to dest
> > when in fact those are the bounds for src.
> >
>
> My mistake. GCC is right, it seems memcpy will read past the end of
> "5.0.0+".

But only if the else branch is taken, which is not the case.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
