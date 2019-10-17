Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAEB2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404792AbfJQKAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:00:40 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:59686 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfJQKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:00:39 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 89FC525B76F;
        Thu, 17 Oct 2019 21:00:36 +1100 (AEDT)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 6D2FC9403D6; Thu, 17 Oct 2019 12:00:34 +0200 (CEST)
Date:   Thu, 17 Oct 2019 12:00:34 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] usb: renesas_usbhs: fix __le16 warnings
Message-ID: <20191017100034.qif4kcrcrvzkz5t3@verge.net.au>
References: <20191015155044.11858-1-ben.dooks@codethink.co.uk>
 <20191016122656.3jpmes4rnz47u5wc@verge.net.au>
 <TYAPR01MB45440369B72F2C994CF8C85FD86D0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdWsRDyUh0MzYNX=mQuuPem1NxArFOqXGVAba3TWGEXxWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWsRDyUh0MzYNX=mQuuPem1NxArFOqXGVAba3TWGEXxWg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:57:26AM +0200, Geert Uytterhoeven wrote:
> Hi Shimoda-san, Simon,
> 
> On Thu, Oct 17, 2019 at 4:18 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Simon Horman, Sent: Wednesday, October 16, 2019 9:27 PM
> > <snip>
> > > > diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> > > > index 4c3de777ef6c..a3c30b609433 100644
> > > > --- a/drivers/usb/renesas_usbhs/common.c
> > > > +++ b/drivers/usb/renesas_usbhs/common.c
> > > > @@ -162,17 +162,17 @@ void usbhs_usbreq_get_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> > > >     req->bRequest           = (val >> 8) & 0xFF;
> > > >     req->bRequestType       = (val >> 0) & 0xFF;
> > > >
> > > > -   req->wValue     = usbhs_read(priv, USBVAL);
> > > > -   req->wIndex     = usbhs_read(priv, USBINDX);
> > > > -   req->wLength    = usbhs_read(priv, USBLENG);
> > > > +   req->wValue     = cpu_to_le16(usbhs_read(priv, USBVAL));
> > > > +   req->wIndex     = cpu_to_le16(usbhs_read(priv, USBINDX));
> > > > +   req->wLength    = cpu_to_le16(usbhs_read(priv, USBLENG));
> > >
> > > usbhs_read is backed by readl which performs
> > > a le->cpu conversion. Rather than have a double conversion
> > > perhaps it would be nicer to introduce usbhs_read_le.
> > > Likewise for write.
> >
> > I'm afraid but, I could not understand these comments.
> > At the moment, the usbhs_{read,write}() call io{read,write}16(),
> > not {read,write}l().
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/renesas_usbhs/common.c?h=v5.4-rc3#n62
> 
> ioread16() and readw() don't do byteswapping on ARM, as ARM is
> little-endian. Likewise, cpu_to_le16() is a no-op on ARM.
> 
> Double swapping would matter only on a big-endian platform, and could
> indeed be avoided by introducing usbhs_read_le*() functions that are
> just wrappers around __raw_read16() on big-endian.
> However, until the Renesas USBHS IP core ends up on a big-endian
> platform, it's not worth doing that, IMHO.

Yes, that is all true.
I'm fine with this patch as it is.

> 
> > > >  }
> > > >
> > > >  void usbhs_usbreq_set_val(struct usbhs_priv *priv, struct usb_ctrlrequest *req)
> > > >  {
> > > >     usbhs_write(priv, USBREQ,  (req->bRequest << 8) | req->bRequestType);
> > > > -   usbhs_write(priv, USBVAL,  req->wValue);
> > > > -   usbhs_write(priv, USBINDX, req->wIndex);
> > > > -   usbhs_write(priv, USBLENG, req->wLength);
> > > > +   usbhs_write(priv, USBVAL,  le16_to_cpu(req->wValue));
> > > > +   usbhs_write(priv, USBINDX, le16_to_cpu(req->wIndex));
> > > > +   usbhs_write(priv, USBLENG, le16_to_cpu(req->wLength));
> > > >
> > > >     usbhs_bset(priv, DCPCTR, SUREQ, SUREQ);
> > > >  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
