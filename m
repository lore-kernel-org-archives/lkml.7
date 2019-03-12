Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510EEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19850214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnJ9vN5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfCLHVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:21:41 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54174 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:21:40 -0400
Received: by mail-it1-f196.google.com with SMTP id x189so2773955itd.3;
        Tue, 12 Mar 2019 00:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8a8VmXlU8RObQvd/P/gvRLa/m3fDfJy4y8D2hopmt9c=;
        b=VnJ9vN5HiV6QDiYzX28+tlyE4Wiy/2cQ4T6oanTuk9E5OjlgQWM6O9b6foDZu7XHCy
         bDm/zW6hin7Uz2WAAzNwTu2bZxfLnxyaMl3Lhwi4IdZ4wxoVXQoEGPY/c4Axs/gxODEU
         IkwKUJPA8VyJ36K+rClr6ggh1lVBE/QOOXJNXmlOegRVPBfoYRjUjGOPFo8iOy1+Q04E
         1ZTyXO/nvZy3lMxU/oX9uj3Mc8gZKSPYxPoIQNbqZ2gHn0V3KqK5aekeYflC1RE3Q9bH
         xdaKccyugYLhkId37VauEv1o3i1RjUvU9Xuga70HmqsJwtkZ1GUaoXDOk4W22i2kkvVN
         SwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8a8VmXlU8RObQvd/P/gvRLa/m3fDfJy4y8D2hopmt9c=;
        b=VaKYc2tdKsEpHWZnzNJTlYDG0W9KdWf//+L01tFjq3rG0To+Mn1F7gCkbUUBUGpWlY
         hghZ7e31oTv1WmGobe7hnf56xckjbK1VsD+Pxab0UfJ1q0Qg8fjYwrvFs1mWiCoKwgbE
         LWGozwCVaWxoHj3mTBrng+6jGyj5qd12yg9D2YevOq9U/3/vIOPtG/5wD5BEzVTmmWJV
         FXk2PfqUz5kxU+b8cRFe+hnG6xd0r0ZtFsJFy0yhL8Avafc05bmdAtaHQbkvZsIVL5c4
         LwwPnME3bEjBg06V0CJHrfvN8YkNr5N739uFyERGahH7m8loza4fjg8vNvGYXZYmjqSh
         THGg==
X-Gm-Message-State: APjAAAXEzobMLSnqgxDcMZ5pDXWt6xrLELSVYpSNevveIp6mWN+YnpFc
        jm1fCIP+NBdJ3rHHaG1vl/kKHDzj
X-Google-Smtp-Source: APXvYqwojN/L1C7ypKcAJ8FY1ANWqNL/GRVG96CzZVE1iDA3iOJQ6/a5H53T9z2lQfj5aKAKxlCMtg==
X-Received: by 2002:a24:8092:: with SMTP id g140mr1239778itd.15.1552375299117;
        Tue, 12 Mar 2019 00:21:39 -0700 (PDT)
Received: from icarus ([2001:268:c0a3:c255:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id w6sm2892411iom.22.2019.03.12.00.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 00:21:38 -0700 (PDT)
Date:   Tue, 12 Mar 2019 16:22:22 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190312072222.GA2898@icarus>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
 <20190308085733.GA3903@icarus>
 <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:36:21PM +0900, Masahiro Yamada wrote:
> On Fri, Mar 8, 2019 at 5:57 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> > > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > > <vilhelm.gray@gmail.com> wrote:
> > >
> > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > bit offset of the found clump, while the respective clump value is
> > > > stored to the location pointed by "clump". Additionally, the
> > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > respectively get and set an 8-bit value in a bitmap memory region.
> > > >
> > > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > >
> > > Andrew: would you be OK with this being merged in v5.1?
> > >
> > > If we need to move the code to drivers/gpio that's OK (though
> > > I think it's generally useful) but I need to know to proceed with
> > > the William's nice optimization of these drivers.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > I was waiting on Andy to suggest some examples out of the GPIO realm,
> > but he may be under a heavy workload right so I decided to do a quick
> > search for one.
> >
> > In drivers/of/unittest.c, there is loop across a bitmap in the
> > of_unittest_destroy_tracked_overlays function:
> >
> >         for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
> >                 if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
> >                         continue;
> >
> > This section of code is checking each bit individually, and skipping if
> > that bit is not set. This looping can be optimized by using the
> > for_each_set_clump8 macro
> 
> 
> Probably no.
> 
> 
> I see this comment before the loop.
> /* remove in reverse order */

You're right, for_each_set_clump8 wouldn't work in this case since it
does not loop in reverse order. I shouldn't have rushed to find a case
and ignored the context of the code like that.

Since Andy appears to have hardware outside of the GPIO subsystem he's
testing, let's wait for that and see how it turns out.

William Breathitt Gray

> 
> 
> Also, the unittest code handles per-bit
> whereas your helper does per-byte.
> 
> 
> 
> 
> 
> > to skip clumps of nonset bits (not to mention
> > make the logic of the code much simpler and easier to follow by reducing
> > the code to a single line):
> >
> >         for_each_set_clump8(id, clump, overlay_id_bits, MAX_UNITTEST_OVERLAYS-1)
> >
> > The for_each_set_clump8 macro is not specific to the GPIO subsystem; I
> > just happen to use it in these GPIO drivers simply because I am most
> > familar with this section of the kernel (it's where most of my
> > contributions occur afterall).
> >
> > Consider this, if I am able to find a use for this macro outside of the
> > GPIO subsystem within a matter minutes, then there must be some benefit
> > in allowing the rest of the kernel to use the for_each_set_clump8 macro.
> > So let's put it in bitops.h rather than restrict it to just the GPIO
> > subsystem.
> 
> 
> If we do not find useful cases in other subsystem,
> this patch set looks over-engineering to me.
> 
> 
> 
> 
> 
> 
> > William Breathitt Gray
> 
> 
> --
> Best Regards
> Masahiro Yamada
