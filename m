Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D959C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DC02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW+NuIEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404598AbfFKIJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:09:04 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32934 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404401AbfFKIJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:09:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id f20so4197936ual.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymfUHuEw6a4KJ+dzAGtlZ28yY4L9Bb8N3OI1F30T1wg=;
        b=OW+NuIEqcnugYX9K3R4rmbgs2X2r6DWluKygkZvcTQLs19tMCQFNPkHAvjSN5rMObn
         pk4eJcpJ2NwFGTauF9Xsz+LqtXI5MtkC8Ipx04sXbSh+HVZre+W5Bt4P4cQv3LMwqPHH
         76eOwLcG28yL9rMrK1Ds4H6UtEm/9jGTS1NOmIMZ2uqda+KgH5la/hvmcYaCQeSiB+2l
         vVikavTSZnRMrQXmesDlb5gEx1/+8AjlT04IczhCNmoh7GsiG7QqVT2iG0in92z/JC3p
         Bqy05Bgzuynl5FMwbCgj0dZ3fMm85MLvaEZUGyV5Mggx/Z0dtXdyzpQkw18utLRIH2PL
         ny5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymfUHuEw6a4KJ+dzAGtlZ28yY4L9Bb8N3OI1F30T1wg=;
        b=DASLgcsSSxOOIVEgKc0WJeAdP8ifduOMttpQCFse1X/eiX0PCDDeQe5XOc+VXYvzvB
         XumEkNJ4tyzyDuXXyRgqzuMgoDoK6hnhDnfuxLJiAwTYrbAoedxxHyt5q47G54QhbKLC
         ArUpzoZo4R8gV3qZh9Myew0DGLBL5u3qQM0Lhf4OuMuWlvinJSKv5gUM3i4JX7G6FEti
         7bYRZKxGewossAjhY3fyF3QsNjHvXBivC3DTSslEWi50W5Ry+E9hC1ZdhHpOj8ZTG4/5
         zOl32YePOtUoEgAU0RxZVQyqynngSp9rpbmeFkwdZKQRH5MpISA++2KGQQ8tpuctNSMW
         rJIg==
X-Gm-Message-State: APjAAAVFxe1hi2LR6FhUGQyi0DM8lj9QJDNznNu3JtKOEQD8EKcM0+TQ
        GA6FUO1y6IW5v7/Jw16LgDbdD4C61/s5ao5wnaE/8G0M
X-Google-Smtp-Source: APXvYqzwg6CQ8roNT6YJv9aPGhM26Z7ZVhgpVH046rpFBxD0Sq2H3fw9DlvExU6AmCGbhbEqwrQVs8y6pEaUpD5gSJI=
X-Received: by 2002:ab0:4a55:: with SMTP id r21mr19143398uae.133.1560240543093;
 Tue, 11 Jun 2019 01:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190611055045.15945-1-oded.gabbay@gmail.com> <20190611055045.15945-9-oded.gabbay@gmail.com>
 <20190611075933.GB13408@kroah.com>
In-Reply-To: <20190611075933.GB13408@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 11:08:37 +0300
Message-ID: <CAFCwf12GRn6ePeH1cLuC_-C9pyQJJSZ9RaGdMUz6MkGrtR=Lvg@mail.gmail.com>
Subject: Re: [PATCH 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 11, 2019 at 08:50:45AM +0300, Oded Gabbay wrote:
> > --- a/drivers/misc/habanalabs/habanalabs_drv.c
> > +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> > @@ -28,6 +28,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
> >
> >  static int timeout_locked = 5;
> >  static int reset_on_lockup = 1;
> > +static int power9_64bit_dma_enable;
> >
> >  module_param(timeout_locked, int, 0444);
> >  MODULE_PARM_DESC(timeout_locked,
> > @@ -37,6 +38,10 @@ module_param(reset_on_lockup, int, 0444);
> >  MODULE_PARM_DESC(reset_on_lockup,
> >       "Do device reset on lockup (0 = no, 1 = yes, default yes)");
> >
> > +module_param(power9_64bit_dma_enable, int, 0444);
> > +MODULE_PARM_DESC(power9_64bit_dma_enable,
> > +     "Enable 64-bit DMA mask. Should be set only in POWER9 machine (0 = no, 1 = yes, default no)");
> > +
> >  #define PCI_VENDOR_ID_HABANALABS     0x1da3
> >
> >  #define PCI_IDS_GOYA                 0x0001
>
>
> This is not the 1990's, please do not use module parameters.  Yeah, you
> have a bunch of them already, but do not add additional ones that can be
> easily determined at runtime, like this one.
>
> thanks,
>
> greg k-h

Hi Greg,
I would love to do this in runtime and that was my intent all along
until I hit a wall on *how* to find out it in runtime if I'm running
on POWER9 with PHB4 or not.
I did a search in the kernel code, consulted with a couple of people
but I didn't get any way of doing this in runtime.
If you have some way, please share it with me because I hit a wall
with this issue.

The fact of the matter is, I have two different configurations of *my*
device's PCIe controller. One is only suitable to POWER9 with PHB4 and
the other one suits all the rest architectures/systems (that we have
tested so far). So I have to know which system I'm running on and as I
said, I didn't find a kernel API which can help me do that.

Thanks,
Oded
