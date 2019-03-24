Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58142C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8D220685
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfCXIyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:54:13 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38482 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:54:13 -0400
Received: by mail-vs1-f67.google.com with SMTP id s2so2380586vsi.5;
        Sun, 24 Mar 2019 01:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlX5NVZHDNgHoVz3vRrZP7Qr5w4ujkQOALBwEQe8WUM=;
        b=IIJeemqcj1XxJjAPax03JtLTPelnQSckjCIuBqoTCwJJW2G704arhntEqWQfT40fHm
         7Rp2/5O/5aaFlanNOcTyE2f3nKZ961YVJtHWy153u/j/eMmxZ271VmOw+NnY/MXjQCst
         FmG7VE5k5oM1Fk21pL5XjjWwwlhpToIzV0lA5iHv5N8OqNSksGXiQ6mYerKUFFdbRSKE
         euKFnM/IHShQICyvwUR965AKSoVAgNyWD2qUtkj8ywz4AEKlf0+CPgc7brNjNp+SBYtz
         oR1IEec0bgZlDH9xcqLoUOr/2AAJ2rVsqVVw0Na0+jGNriOWgVgXbglTNu+p1Wlpjl9Y
         XZHA==
X-Gm-Message-State: APjAAAXS/jUIDtpgLIVX9kFT7SooOABOlw7hfKvSFdotN6KsE2KbCl6y
        AxQ7V0S1qJK/aXr3I3vM1gDXCWQgOx+4Ha+KBa4=
X-Google-Smtp-Source: APXvYqwd4Oa+YSkmZkwiwJ+ImxSEtW21xnJZHbSvqC3n5tZRmbtLkBJAbyEyNDPF1t8xTBYcEjmHh4XqLcpFP9FLLlg=
X-Received: by 2002:a67:f843:: with SMTP id b3mr11388126vsp.152.1553417652024;
 Sun, 24 Mar 2019 01:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552566113.git.vilhelm.gray@gmail.com> <20190322191202.GC9224@smile.fi.intel.com>
 <20190324040704.GA8285@icarus>
In-Reply-To: <20190324040704.GA8285@icarus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 24 Mar 2019 09:53:59 +0100
Message-ID: <CAMuHMdUbXFRZZeE0gT-qhpps4SmHz4N5i_6329cz_vfCPBLtTw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Reid <preid@electromag.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 5:07 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Fri, Mar 22, 2019 at 09:12:02PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 14, 2019 at 09:29:32PM +0900, William Breathitt Gray wrote:
> > > Changes in v10:
> > >   - Fix off-by-one error in bitmap initialization in the
> > >     test_for_each_set_clump8 function
> > >   - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
> > >     should have been "0x38")
> > >   - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c
> >
> > One more, can you look at gen_74x164_set_multiple() ? It seems a candidate as
> > well, if I'm not mistaken.
>
> We can utilize the for_each_set_clump8 macro in the
> gen_74x164_set_multiple function, but I skipped over it earlier since I
> noticed it used the BITS_PER_BYTE define rather than a hardcoded 8. If
> it always loops 8 bits at a time, then we can use the
> for_each_set_clump8 macro; otherwise we would need the more generic
> for_each_set_clump macro to handle the non-8-bit looping cases.
>
> Will BITS_PER_BYTE always be defined as 8 bits?

Yes, Linux cannot run on platforms where BITS_PER_BYTE != 8
(no 9-bit bytes ;)

include/linux/bits.h:#define BITS_PER_BYTE              8

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
