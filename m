Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA138C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73484205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsYufJjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfG3HTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:19:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55189 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfG3HTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:19:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so55995698wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZt6vkvXDTCmaHGGjiNswfodyAXn9IWa9yBxuOiSg1E=;
        b=FsYufJjwqp5VVH/4FN9Vk3nxH0jNCRjcDIlpadgiX4rTPO6+sk8keBlw/LFdyAcjp5
         NDvCAVT3mzGk58TuXvRvIZ6CMU0VEq7LqOIDeve6Enk46ld+tcmETsr9j/JZJm7Jq+FV
         ygvQGhKpT6oAfQNv4FnR3hNx5i+KUYUy2CIhJIo8X06pp6L2lOLIH/BHAjVrcRzYzK3e
         Msy9r8B+PoEoGZyD/082UTR/9FckdXu3oAjDYka6KgzdV5mndvvYsSHwDaLFX9eQkU0G
         rs40dOuvUIl11Lm6ifPyuqmFU3fq5ENRCCIwACRr/t4KmINhB/oLr8P0DWgGQ1O2Mozh
         Y2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZt6vkvXDTCmaHGGjiNswfodyAXn9IWa9yBxuOiSg1E=;
        b=CDJ95KVHjqTSzxNJ3jB3FtKnMXa0NxayOQ/Um09DwI2vZ0/sTAsN8wfTTI8VUEAzhh
         r1GulWg+VyycaxK5KB4U1J9ehRda2fqMY0tbDCry1j05YjUyuhsM4A5qkGHwIfZj1KpO
         r9FOgn2iK8G7LRWe7biI8S5xdDut+XcM/QuXPb6+zxmkMhdTJN068Pa6mqBDukDe5O6i
         7ytb9fAnlZ2Q/nrTz9EJG0nCctpPyIiOEHKHAm7EhK3eIhoghEGo1U6vQ77R4cM9+Q0q
         NZqouM4Q3GsfVUCu7qxMmSBPifdZ+ZlJQ/htXPmXeBL1xnobY88Bi3mWLY88Sf4tvTXI
         ET/g==
X-Gm-Message-State: APjAAAWp79SKsmyRtUKGVs0FqHoF+/qtWp0CLrn+jlartEiyfki5A0QA
        mUN8BxtcUdO0Kw126GJHAFpSOY+rvA99O3Pf7JLT+g==
X-Google-Smtp-Source: APXvYqy7X+m5nMBdYWJvObDm1/TffZatcBrS6OcX+i57wYVXzbjHVSZEO5NsRhWXZuMJ+wNmsJ3vWnw8+4uEdeTAPNw=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr103653071wme.29.1564471147596;
 Tue, 30 Jul 2019 00:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190722071122.22434-1-zhang.lyra@gmail.com> <20190722071419.22535-1-zhang.lyra@gmail.com>
In-Reply-To: <20190722071419.22535-1-zhang.lyra@gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 30 Jul 2019 15:18:31 +0800
Message-ID: <CAAfSe-tPVsMjmu0CoUATGRGevCpgqk999-rpfMuXqZ-V9ft7gg@mail.gmail.com>
Subject: Re: [PATCH] ARM: check stmfd instruction using right shift
To:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Lvqiang Huang <lvqiang.huang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping

probably this patch was missed or entered into spam?

On Mon, 22 Jul 2019 at 15:14, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
>
> In the commit ef41b5c92498 ("ARM: make kernel oops easier to read"),
> -               .word   0xe92d0000 >> 10        @ stmfd sp!, {}
> +               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> then the shift need to change to 11.
>
> Fixes: ef41b5c92498 ("ARM: make kernel oops easier to read")
> Signed-off-by: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  arch/arm/lib/backtrace.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
> index 7d7952e..926851b 100644
> --- a/arch/arm/lib/backtrace.S
> +++ b/arch/arm/lib/backtrace.S
> @@ -70,7 +70,7 @@ for_each_frame:       tst     frame, mask             @ Check for address exceptions
>
>  1003:          ldr     r2, [sv_pc, #-4]        @ if stmfd sp!, {args} exists,
>                 ldr     r3, .Ldsi+4             @ adjust saved 'pc' back one
> -               teq     r3, r2, lsr #10         @ instruction
> +               teq     r3, r2, lsr #11         @ instruction
>                 subne   r0, sv_pc, #4           @ allow for mov
>                 subeq   r0, sv_pc, #8           @ allow for mov + stmia
>
> --
> 1.7.9.5
>
