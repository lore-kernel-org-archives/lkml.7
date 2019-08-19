Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B9C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62E2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfHSL2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:28:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39447 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:28:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id b1so1311576otp.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 04:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9D4LJCrvyAjq0B6uegoMe+NT34sKYRDI6GJznmJGKs=;
        b=FHalniGC5REnMYrpah9O6X6V3azoMr+6kNIvni2rJmTobTblV6SMBZvt5b572QTehQ
         58Z4vTEzV3OIWxmT7nBkhyX2HtuBM2S49CXD0lrHlYFrr2dtpxUJVPWj+Zsc+dQa1nWe
         0AzAImZZHW/uZK1dA2RDjbmm1pYqLN3y3HidfIaayPyuwPIq5PAMl+7n5LkUhD+PdwxM
         p6bOldG2+NyczmFIbGAcJtU9mvFeGQeDUldmq4kY35lNA5bnCslsSlaWwGXVrMM8IDWA
         J2Fa7XkmFYzCYAHm7dIfOB4eJgTOFPMPeLDTDoLNDrkZf8ubJDf35joOX04z7/RPWg5m
         RigA==
X-Gm-Message-State: APjAAAVezNnUtzJfocxd6p6ccqG9VQlhe2YqSLDTkhM/CZ2NS0K1pXbf
        YZ/3hgyGGuWQzATykyrGTts6hwUUirLmueC2W4w=
X-Google-Smtp-Source: APXvYqztKOiN1Ipa8eZPROk0Wtpn3x/FZWN8hMadlD50DRGrJwsJZzXwymbqvLdC2glo+GcGBG17sYj0c2mqdGGZz5o=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr17693931oto.250.1566214083926;
 Mon, 19 Aug 2019 04:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <9ec2190f5be1c4e676a803901200364578662b6d.1564704625.git.fthain@telegraphics.com.au>
 <fd5ccd89-987a-3d4b-5c49-9068abadf81d@linux-m68k.org> <CAMuHMdW=cPipS6pmxAtU6r1MaVaPWfhGQ-AAe0E-TJGbXftHfA@mail.gmail.com>
 <e73a9616-23c3-f04d-1519-185483adcb98@linux-m68k.org>
In-Reply-To: <e73a9616-23c3-f04d-1519-185483adcb98@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 13:27:52 +0200
Message-ID: <CAMuHMdW-6k6Gbq4iVK+QHKh=KrLwQyyZhLLbeoUX14ouprTfuA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Prevent some compiler warnings in coldfire builds
To:     Greg Ungerer <gregungerer00@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 2:18 PM Greg Ungerer <gregungerer00@gmail.com> wrote:
> On 5/8/19 5:14 pm, Geert Uytterhoeven wrote:
> > On Sat, Aug 3, 2019 at 1:36 AM Greg Ungerer <gregungerer00@gmail.com> wrote:
> >> On 2/8/19 10:10 am, Finn Thain wrote:
> >>> Since commit d3b41b6bb49e ("m68k: Dispatch nvram_ops calls to Atari or
> >>> Mac functions"), Coldfire builds generate compiler warnings due to the
> >>> unconditional inclusion of asm/atarihw.h and asm/macintosh.h.
> >>>
> >>> The inclusion of asm/atarihw.h causes warnings like this:
> >>>
> >>> In file included from ./arch/m68k/include/asm/atarihw.h:25:0,
> >>>                    from arch/m68k/kernel/setup_mm.c:41,
> >>>                    from arch/m68k/kernel/setup.c:3:
> >>> ./arch/m68k/include/asm/raw_io.h:39:0: warning: "__raw_readb" redefined
> >>>    #define __raw_readb in_8
> >>>
> >>> In file included from ./arch/m68k/include/asm/io.h:6:0,
> >>>                    from arch/m68k/kernel/setup_mm.c:36,
> >>>                    from arch/m68k/kernel/setup.c:3:
> >>> ./arch/m68k/include/asm/io_no.h:16:0: note: this is the location of the previous definition
> >>>    #define __raw_readb(addr) \
> >>> ...
> >>>
> >>> This issue is resolved by dropping the asm/raw_io.h include. It turns out
> >>> that asm/io_mm.h already includes that header file.
> >>>
> >>> Moving the relevant macro definitions helps to clarify this dependency
> >>> and make it safe to include asm/atarihw.h.
> >>>
> >>> The other warnings look like this:
> >>>
> >>> In file included from arch/m68k/kernel/setup_mm.c:48:0,
> >>>                    from arch/m68k/kernel/setup.c:3:
> >>> ./arch/m68k/include/asm/macintosh.h:19:35: warning: 'struct irq_data' declared inside parameter list will not be visible outside of this definition or declaration
> >>>    extern void mac_irq_enable(struct irq_data *data);
> >>>                                      ^~~~~~~~
> >>> ...
> >>>
> >>> This issue is resolved by adding the missing linux/irq.h include.
> >>>
> >>> Cc: Michael Schmitz <schmitzmic@gmail.com>
> >>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> >
> >>
> >> Looks good to me:
> >>
> >> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> >>
> >> Geert: I can take this via the m68knommu tree if you like?
> >> Or if you want to pick it up then no problem.
> >
> > If you have fixes for m68knommu for v5.3, feel free to queue it.
> > Else I can queue it for v5.4.
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I don't currently have any fixes for 5.3 queued.
> And there is no real hurry on this anyway, it can wait for 5.4.
> So please add to your queue for 5.4

Thanks, applied and queued for v5.4.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
