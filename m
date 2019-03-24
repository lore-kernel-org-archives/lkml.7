Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28285C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566C222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt9t/cVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfCXMIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:08:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34452 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:08:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so4558165pgq.1;
        Sun, 24 Mar 2019 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHMQh4Fxw7DuEssbrRlPu0oxFwy4l1mv21FNEgGkcOw=;
        b=dt9t/cVZq7y/Ccz8c+ICIfRtP7bCCAmeqzihhAyFEsdi33gJuQQUMoOpYJH/UHg76r
         MAhFHApB9okRHR4ueCbVi8tVlh71c5Vmvtd8EgckSQpl4t+t5mtz+Kka6S/vtZrZyjqD
         hOZphzhukHDJAZHqFxgjEyIH1XGMgM3hDrxI1ePsD8dT+ivd4xB88+oDAZipIGf35H5+
         yMZhi3aKnFU4blxYG+s//jOyCkOqhnqm2HgIY5jWMoPwSAkrYN8r6r307hD/vsVqtmBJ
         8Wppn1SsuYNXEaOPu7P5RUV2L/AfdpleOZOPvbmCVSR6yTLzL6yMfybK/EC7wO5C8ym0
         bvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHMQh4Fxw7DuEssbrRlPu0oxFwy4l1mv21FNEgGkcOw=;
        b=Wd6+O5AWqkJ6PI0H9If72Ls1xtMsEZuM5EhulFFTc3cL1AOlrOSJ5rpTPZdfjNFdRL
         VY4lYdJgJn3YZtrfZgRFeegMRgqQCwhFnVu8XNX0bA5vPVESWl1fvUXiZhG+HJ7E+Y2n
         JzJN1FjchwQ8xVx1lLMm3AELZ8e+9sHd4/NN8xOyjtzwGDH2dtcfhBvAYPWpFsI1lq/r
         GkKNitTZZzEv7FVXySc1/Z7GLH+Mgl21IY4heJMhrhJcX/vtjHjQrnebMlk+10LvebbT
         4c21lSIAseYddr68g2w3FtdKgKh+Jmdfyd4xWdkKpJ3hxNBofg7aJR3uP8lMdOekqcRM
         svzw==
X-Gm-Message-State: APjAAAVdVi/hWiqddFs4jow6coMo+ryTdXIk71Be37nxXuGdhK7N0OMs
        CScKH/sabULW1IKQocbRfHWTuXpNpLn0felBlWI=
X-Google-Smtp-Source: APXvYqyuQDCk1jx6qUNks7YiOISA42oNvsCNiNJhxQ/1cxTc2p4Wa6hl0O9ZPA+3Ly0k6RUhveHKoBPdFb4tx8uTsoM=
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr57954pln.144.1553429320607;
 Sun, 24 Mar 2019 05:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552566113.git.vilhelm.gray@gmail.com> <20190322191202.GC9224@smile.fi.intel.com>
 <20190324040704.GA8285@icarus>
In-Reply-To: <20190324040704.GA8285@icarus>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Mar 2019 14:08:29 +0200
Message-ID: <CAHp75Ve2zR9uZE6c42gY6xcruEEfaS5gv7gD1gr_GR-DgZ2vrA@mail.gmail.com>
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
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 6:12 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
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
> for_each_set_clump8 macro;

Yes, see below.

> otherwise we would need the more generic
> for_each_set_clump macro to handle the non-8-bit looping cases.

> Will BITS_PER_BYTE always be defined as 8 bits?

It's not correct question, the right one "is the hardware always in
8-bit chunks". And datasheet is crystal clear about this.
This very old and famous IC has 8-bit from the 70-s (IIRC the epoch of
the design).
So, it is always in 8-bit chunks.

-- 
With Best Regards,
Andy Shevchenko
