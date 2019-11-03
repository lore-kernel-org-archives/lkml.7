Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9454CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF92080F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctfNhpnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKCMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:03:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39739 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfKCMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:03:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id e17so3597834otk.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 04:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDfHxxU96azcwEo9cIE2KOmHovRw/1aoC+X8NzKe5fk=;
        b=ctfNhpnpBtbVZPlNJSj+lRi4gaBVgWNiYvWQdcVFqBee+vMMkesBY8mLSk6RjF2UeD
         8LBDOZw6nmrJHU6DH/ybGV5k8qAXYiuXfywQJqN091idVSu6u2BCJLB1JZsQKdR8+yGt
         miCElIhM3m8R/KdA/XSPvdiX7D5350+b2PB5tan554FSo0nO+cjaSYiIpeGAoQv53oFx
         8kks4sxwbqZ6jAQ2VLnL/Ogbg0guwONN0N3E98fWHuBZAPNIkP2fJTVnAGwry+kTdulF
         08e6+y0pp8itLt6m+qHhhcJWwhFkwbY/9xNW7eVgu1j6hIkl06B9Foladn3Y2BBPTGr2
         madQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDfHxxU96azcwEo9cIE2KOmHovRw/1aoC+X8NzKe5fk=;
        b=eKF2YvSruFC6gOfuH4ab9+MMHnB7GNDp0MqbSIk7Naics+FmiWbIdDw3iDcrP6+jr8
         BCK83vlqTIkimhn0tGIQ37RbPzUIGhjVZiiDyYotj/tckPfxq5srEh7MPL3rGx0mrMES
         rvYPZNlMtoj1z4x/DexfR/kB76clXGREIfzJqcudRQDRtm90sJ/k/5K9aCuIbBgJclGE
         /7bXmG/qLoXYYb4kJ3Id9HB/jTGi0e7ifslewVFts6HSzdsEwpO7TVy1DF9iCzDQTAz+
         HTllSJfyRTtQSt8pKCPw94BqPAbUmHqfZx+8Xo36VriDqduU9z30EiTKoGukqmoe+J08
         1d0Q==
X-Gm-Message-State: APjAAAWaof6b5gSWyuos18MK/j7phufygoyUWFAHIEMmV7BKmPho3/B1
        7YyrKc/GG0vUhpwzj50aHhTy2SOvjq3gpeBOfYumlzq2
X-Google-Smtp-Source: APXvYqzdQVVKe8h42rzht3dU5PsFk7b7U9bcRi88xJ9MMrZCM3zeMSynQ2CnIZQMs1PkkZq7qt+Jhm24IPrnHDTWQe8=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr15631474otk.86.1572782612287;
 Sun, 03 Nov 2019 04:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20191016013845.23508-1-gch981213@gmail.com> <20191028174131.65c3d580@xps13>
In-Reply-To: <20191028174131.65c3d580@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sun, 3 Nov 2019 20:03:21 +0800
Message-ID: <CAJsYDVJgwRfg2kfmuG4P-NCEAZ4box+=Yb53d0J+rAjLRpc3Ww@mail.gmail.com>
Subject: Re: [PATCH][RFC] mtd: spinand: fix detection of GD5FxGQ4xA flash
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Stefan Roese <sr@denx.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Oct 29, 2019 at 12:41 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> Chuanhong Guo <gch981213@gmail.com> wrote on Wed, 16 Oct 2019 09:38:24
> +0800:
>
> > GD5FxGQ4xA didn't follow the SPI spec to keep MISO low while slave is
> > reading, and instead MISO is kept high. As a result, the first byte
> > of id becomes 0xFF.
> > Since the first byte isn't supposed to be checked at all, this patch
> > just removed that check.
> >
> > While at it, redo the comment above to better explain what's happening.
> >
> > Fixes: cfd93d7c908e ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG")
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > CC: Jeff Kletsky <git-commits@allycomm.com>
> > ---
> > RFC:
> > I doubt whether this patch is a proper fix for the underlying problem:
> > The actual problem is that we have two different implementation of read id
> > command: One replies immediately after master sending 0x9f and the other
> > need to send 0x9f and an offset byte (found in winbond and early GD flashes.)

Correction: Only early GigaDevice nand chips uses this implementation.
Winbond chips uses a dummy byte instead of an address byte so there's
no problem for Winbond chips.

> > Current code only works if SPI master is properly implemented (i.e. keep MOSI
> > low while reading.)
>
> I am not entirely against the fix, but this is a SPI host controller
> issue, right? Can you try to fix the controller driver instead?

I think this is a spi nand framework issue. GigaDevice uses an unusual
READ ID implementation, and as a result, both host controller and chip
are reading during the first byte after 0x9f command: chip is reading
the address/offset byte and host is expecting the first ID byte.
Here lies two problems:
1. According to the sequence diagram in their datasheet, MISO pin is
in High-Z state during the 0x9f command and the offset byte, and host
could read anything during this time instead of a fixed 0x0 or 0xff
byte, so the check of first byte should be removed. This is what this
patch is doing.
2. If there's a buggy SPI host controller that didn't keep MOSI low
during reading operation, the chip will get 0xff as ID offset, causing
the read vendor/device ID to be swapped. I never met such a controller
so far, but if there is one, it will be a silicon bug that can't be
fixed by software. To fix this one, we'll have to make a second
read-id implementation in spi nand framework.

The second problem only exist in theory, so my preference is to apply
this patch and fix only the first problem for now.

Regards,
Chuanhong Guo
