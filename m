Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C7C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DF620872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407871AbfJQG5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:57:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32902 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392691AbfJQG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:57:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so1272803oic.0;
        Wed, 16 Oct 2019 23:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpbexsAaJKGXtyeEN5Jk64plg1Z6QAlcAhFxTzBWpB0=;
        b=naRJZscLNaz8RRrCMCCL8mkDxUYxseHyq6ogcswZh+/E7vSWPvhag8UtsdrdDjgyPl
         AHhMfUh59TRuMLHEYjYs88In29hgmczsHNNJNKtqy17Z/cV2ZpDpCed6hBKKyy3PJ4Xj
         BKEjmwv5GOA+0dqI0w9xz2utwTi3iAjXk5mEHOKc4PRWiJPZBVmFeVsvPAvsWLcnGqnh
         IOBv3ZC2wZTgwnk2Dl5lUgDpBX7gd/rUn+cQVkIF5rGQ3/Rqy7Cjc71suLnQfp/2zRQJ
         K+cH/E5n5uFnib8ZKPaoh7Wffh5oTcoXxvy8tSLatLAF4jTcK5BSEX1oqyqVwM/7/VkR
         rCNg==
X-Gm-Message-State: APjAAAWMZCC2YHHwdt2UvQmhHAphG4QMikRUkzDvfRlb3JA3JToEocUg
        r+4GansHalsXAEYoxfGnkIM5pbIghKzFeP08uPSHQ9gp
X-Google-Smtp-Source: APXvYqxGTAoSZtd+rRjTloaWngnXATMJw7NKpZEz+zg6U/MMfMCAOds74hz/UbHuy8M4x5XoparCCZdaSLj4Qh7pGv4=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr1775447oiy.148.1571295458039;
 Wed, 16 Oct 2019 23:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191015155044.11858-1-ben.dooks@codethink.co.uk>
 <20191016122656.3jpmes4rnz47u5wc@verge.net.au> <TYAPR01MB45440369B72F2C994CF8C85FD86D0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45440369B72F2C994CF8C85FD86D0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Oct 2019 08:57:26 +0200
Message-ID: <CAMuHMdWsRDyUh0MzYNX=mQuuPem1NxArFOqXGVAba3TWGEXxWg@mail.gmail.com>
Subject: Re: [PATCH] usb: renesas_usbhs: fix __le16 warnings
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms@verge.net.au>
Cc:     "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san, Simon,

On Thu, Oct 17, 2019 at 4:18 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Simon Horman, Sent: Wednesday, October 16, 2019 9:27 PM
> <snip>
> > > diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> > > index 4c3de777ef6c..a3c30b609433 100644
> > > --- a/drivers/usb/renesas_usbhs/common.c
> > > +++ b/drivers/usb/renesas_usbhs/common.c
> > > @@ -162,17 +162,17 @@ void usbhs_usbreq_get_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> > >     req->bRequest           = (val >> 8) & 0xFF;
> > >     req->bRequestType       = (val >> 0) & 0xFF;
> > >
> > > -   req->wValue     = usbhs_read(priv, USBVAL);
> > > -   req->wIndex     = usbhs_read(priv, USBINDX);
> > > -   req->wLength    = usbhs_read(priv, USBLENG);
> > > +   req->wValue     = cpu_to_le16(usbhs_read(priv, USBVAL));
> > > +   req->wIndex     = cpu_to_le16(usbhs_read(priv, USBINDX));
> > > +   req->wLength    = cpu_to_le16(usbhs_read(priv, USBLENG));
> >
> > usbhs_read is backed by readl which performs
> > a le->cpu conversion. Rather than have a double conversion
> > perhaps it would be nicer to introduce usbhs_read_le.
> > Likewise for write.
>
> I'm afraid but, I could not understand these comments.
> At the moment, the usbhs_{read,write}() call io{read,write}16(),
> not {read,write}l().
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/renesas_usbhs/common.c?h=v5.4-rc3#n62

ioread16() and readw() don't do byteswapping on ARM, as ARM is
little-endian. Likewise, cpu_to_le16() is a no-op on ARM.

Double swapping would matter only on a big-endian platform, and could
indeed be avoided by introducing usbhs_read_le*() functions that are
just wrappers around __raw_read16() on big-endian.
However, until the Renesas USBHS IP core ends up on a big-endian
platform, it's not worth doing that, IMHO.

> > >  }
> > >
> > >  void usbhs_usbreq_set_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> > >  {
> > >     usbhs_write(priv, USBREQ,  (req->bRequest << 8) | req->bRequestType);
> > > -   usbhs_write(priv, USBVAL,  req->wValue);
> > > -   usbhs_write(priv, USBINDX, req->wIndex);
> > > -   usbhs_write(priv, USBLENG, req->wLength);
> > > +   usbhs_write(priv, USBVAL,  le16_to_cpu(req->wValue));
> > > +   usbhs_write(priv, USBINDX, le16_to_cpu(req->wIndex));
> > > +   usbhs_write(priv, USBLENG, le16_to_cpu(req->wLength));
> > >
> > >     usbhs_bset(priv, DCPCTR, SUREQ, SUREQ);
> > >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
