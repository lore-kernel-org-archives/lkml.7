Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A75DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05414206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="B956XR0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfDZGVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:21:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45877 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:21:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so2700363wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHfiL2ALiZrSpzP8Kz5apkSsL4ZLblvwvjS3oOXzqXk=;
        b=B956XR0Eab0mcPJVqmnXubGaXKdRJSpLE2iuIY2JYwklVmRrjvhL1qNiYicGGkfABn
         ZR1+t06pXO4f0HLR5yVsACP+00Ie9hrPYOCr9I8E9P1gZSagIYWOaa4wPyJY4m+ozJH3
         ecZXwI6VI6UmbAxpCiTR8feoS9An579k740dQnTWSC//24tw1b5hrmdQoxu8iF5syE9r
         r+h84Z/9Ec+z6wCwKJfgejHMqmB6HJjllD+pYC2qoVGWqoG4Cynwur6RO0yHLRpcrsXl
         5OwiJPTI8IK6edEaGcJsWkjUATZ07GLYQjo0FKJYA3LtLxM9+7yq7ZkNZDlLv0XInXux
         6ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHfiL2ALiZrSpzP8Kz5apkSsL4ZLblvwvjS3oOXzqXk=;
        b=qow1fUrePylHfbEn34xhw8b1zDOvHTOFQfZwFL2WNvzxhOX1rE3yWuav05vEJZprIT
         AYGXkA3mDS0nkAJZGSwFz/qLnltMG21+IuYU3bUif00vHtGb8cSiLPU0FpGoUNtSlCfG
         hX0QD0mdf9LDF7JPy79J8DHrmW2dyKclNu9Lv+WAhEfFe7pVkMZRZDbZSJEkaMBlTvGO
         syLR5zH4i+hVi8nS6Tjz4ZJ/mtH8ghLRYPPo4NONyg9isQt8oC5Qb98zpVLgt5ttEFlI
         XJu+u+qLhjui6AVQED0yAkqbRHfRg21eJtBRl4HgJ9/5Yyg6QaCatmhb82Oj4T40OVbq
         0uDA==
X-Gm-Message-State: APjAAAUwArNUfUqXtxL8J7xZXDOelbhcde5+yfCuMIxH1CA+edTGxWmP
        SWbRPMAU+0z6DLgBGpdrzIZ54tkR9LVErgEPbFlcKg==
X-Google-Smtp-Source: APXvYqwS0AEQ713uTrtxyPjqKF38GEnooNTuWItIuSvsw1UBC1jCZSYuGqnknP7DTXT/PTv3bwZ1EZ+tcXFR9Q4AqWE=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr26165281wrt.99.1556259689461;
 Thu, 25 Apr 2019 23:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190425133435.56065-1-anup.patel@wdc.com> <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
In-Reply-To: <9a8be7ef-e62e-2a93-9170-e3dc70dfb25f@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 26 Apr 2019 11:51:18 +0530
Message-ID: <CAAhSdy3z1aDdVZ3dM1bec0z_pNtmfdJ0XukX_0YWwy7Q90G9AA@mail.gmail.com>
Subject: Re: [PATCH] tty: Don't force RISCV SBI console as preferred console
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:11 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 4/25/19 6:35 AM, Anup Patel wrote:
> > The Linux kernel will auto-disables all boot consoles whenever it
> > gets a preferred real console.
> >
> > Currently on RISC-V systems, if we have a real console which is not
> > RISCV SBI console then boot consoles (such as earlycon=sbi) are not
> > auto-disabled when a real console (ttyS0 or ttySIF0) is available.
> > This results in duplicate prints at boot-time after kernel starts
> > using real console (i.e. ttyS0 or ttySIF0) if "earlycon=" kernel
> > parameter was passed by bootloader.
> >
> > The reason for above issue is that RISCV SBI console always adds
> > itself as preferred console which is causing other real consoles
> > to be not used as preferred console.
> >
>
> Do we even need HVC_SBI console to be enabled by default? Disabling
> CONFIG_HVC_RISCV_SBI seems to be fine while running in QEMU.

Actually, HVC_SBI console is useful on boards (such as SiFive Unleashed)
lacking upstream serial driver. It allows us to boot upstream kernel to prompt
on such boards with just timer driver (and probably irqchip driver).

Also, we should be able to use same kernel image on QEMU and SiFive
Unleashed board so disabling CONFIG_HVC_RISCV_SBI for QEMU is
a temporary solution.

>
> If we don't need it, I suggest we should remove the config option from
> defconfig in addition to this patch.

Like mentioned above, HVC_SBI is useful for newer SOCs and boards
where serial driver is not yet up-streamed.

Regards,
Anup

>
> Regards,
> Atish
> > Ideally "console=" kernel parameter passed by bootloaders should
> > be the one selecting a preferred real console.
> >
> > This patch fixes above issue by not forcing RISCV SBI console as
> > preferred console.
> >
> > Fixes: afa6b1ccfad5 ("tty: New RISC-V SBI console driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >   drivers/tty/hvc/hvc_riscv_sbi.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> > index 75155bde2b88..31f53fa77e4a 100644
> > --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> > +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> > @@ -53,7 +53,6 @@ device_initcall(hvc_sbi_init);
> >   static int __init hvc_sbi_console_init(void)
> >   {
> >       hvc_instantiate(0, 0, &hvc_sbi_ops);
> > -     add_preferred_console("hvc", 0, NULL);
> >
> >       return 0;
> >   }
> >
>
