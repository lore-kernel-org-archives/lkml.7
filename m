Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159BC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F842083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGvGQHsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfGMOD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:03:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46563 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGMOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:03:26 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so26461000iol.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cKNodCrmuMmW2mUrlymHEAfLAQF1HAbPtJIM1Tnsg4=;
        b=OGvGQHsjyDk8f4XWoqQq+WuQIzCyoBTMYUoyqlvoCDyR1S+Lf/Lho3AoQWVhXqGALm
         yMkGgS6re0yU+GCMPBZm3KEhbI9BPUTgbZZlj2pfxoFJb/L0i6Es2coDKCGIkTOy2EIt
         o5mF7e/yEuncIly4dYAMfKP90WxKQrAled7GW///w9kqYgR3K3mUnkv5LOFKxe894W1i
         WJWS+eHiKrayx2x/tX+lGP6L3f9WSzcWYeI4ApY2vhihIk0lUxtKq1klzxT2+Z5nN4jd
         9ZGkDpLVXVqJtM52Gwb+LYdGVZ4L1DyneN/CQE/H8pnvakyjmfLPuxLe5b/jJUAppVv1
         Dc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cKNodCrmuMmW2mUrlymHEAfLAQF1HAbPtJIM1Tnsg4=;
        b=iiEkS7ohVwl9uubWZg7qK0YP8byeKLUOaU7FiaMSLrpyMmSPKH8bW2kD31vskOUlDI
         gmaL77G+NpfVgTaikvIJvKiQRTUkgM73WXjqljONEnlKbCFTP1JPp2v0bJvV1DWp8r3g
         cIxmdGr9/xWbHl38RPANa9tU377R9BeEEVxjRZtJONBd0nV16DaepzcMiUuOAwDJivDG
         C7T4fu1ipypwKgcjB6JZEWuPMkxPPEhToGD+fVecFkvKUlkceRJrpvbWuiOHuWvZmkjb
         TUuWZwvJebKnw5TDJ2Rgp/V8Ol+JhTYskZ5WfkCTrfQyPLdXp+rSFs95RUZRYR5APmDc
         zWMg==
X-Gm-Message-State: APjAAAU7wi7TOCkeBoQcuM/EUjfzQjGoQuP5hKOgoimZzfOUCL2h7f1W
        8qB8pzwv308Bp6k0obkbGTDmOOxzgte2ZBibyPA=
X-Google-Smtp-Source: APXvYqyVyWO314FGp8+WdjoeD7BtY0AQa3FQpiJALcvRUnD5hZTpVwa6/LQjv+WrtbnD9rAjFhkTL/4M1o5puBS7kTA=
X-Received: by 2002:a02:1948:: with SMTP id b69mr17622056jab.55.1563026605670;
 Sat, 13 Jul 2019 07:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain> <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
In-Reply-To: <20190713131947.GA4464@tigerII.localdomain>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sat, 13 Jul 2019 17:03:14 +0300
Message-ID: <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump from
 NMI context
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 4:20 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (07/13/19 09:46), Konstantin Khlebnikov wrote:
> > > On (07/12/19 17:54), Konstantin Khlebnikov wrote:
> >
> > Yep printk() can deal with NMI, but kmsg_dump() is a different beast.
> > It reads printk buffer and saves content into persistent storage like ACPI ERST.
>
> Ah, sorry! I misread your patch. Yeah, I see what you are doing.
>
> OK. So, I guess that for kmsg_dump(KMSG_DUMP_PANIC) we should be
> fine in general.
>
> We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop() and after
> printk_safe_flush_on_panic(). printk_safe_flush_on_panic() resets
> the state of logbuf_lock, so logbuf_lock, in general case, should
> be unlocked by the time we call kmsg_dump(KMSG_DUMP_PANIC).
> Even for nested contexts.
>
>         CPU0
>         printk()
>          logbuf_lock_irqsave(flags)
>           -> NMI
>            panic()
>             smp_send_stop()
>              printk_safe_flush_on_panic()
>               raw_spin_lock_init(&logbuf_lock) << reinit >>
>             kmsg_dump(KMSG_DUMP_PANIC)
>              logbuf_lock_irqsave(flags)        << expected to be OK >>
>
> So do we have strong reasons to disable NMI->panic->kmsg_dump(DUMP_PANIC)?
>
> Other kmsg_dump(), maybe, can experience some troubles sometimes,
> need to check that.

Indeed, panic is especially handled and looks fine.

Sanity check in my patch could be relaxed:

       if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
               return;

>
>         -ss
