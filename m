Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA66C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EE5208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDIsOCVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbfFKIsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:48:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36070 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391273AbfFKIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:48:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so7399088vsp.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhGjZy3FShlMVj6urlTA25d/osBk/AQ2ZtSq05JHNew=;
        b=jDIsOCVMKmx1/mxpnKvXtAk8R3OIiSZIUqpirx/7epmu850GAkJpg0O1RlND0iRN1K
         DTE1UXMoIP5kX1xb4fWo02MnFI7OALqb3Awmi4lhnNdtxHbLTa/Y7GtBdFURMhf5CcZn
         5Sc81izUhzgdwFs10HjqeOVBvVKz1Ad6eCbPUDJRup+suBIzC+HWgavP1Tynr/+8sMvf
         vePOrTFZV/bB/ABoGD2YzB/QTG+B64Dod145cyfLC2Vopyi8NjvWhG6L6OKMuxZ2lJ0d
         HsDtjNx7ILhZEDca2YFgEpJLqlmFpU9Ib16peJZlRoXbaGDsZ24UmgGsjKu0IPWir73s
         nr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhGjZy3FShlMVj6urlTA25d/osBk/AQ2ZtSq05JHNew=;
        b=nslroeRNtIVF/t4tpN+G0IPTAKn+fmQOiZ+i3h6I6a9Z5Zen2Y5A0GMGzbV/omHCpv
         tTFv7WKCValGuQS7veeXv0bSdW2NcVQI6+TNJenoqfpateuRefrwkQVqd9jA1oifXlfl
         5EJ96lfIx+orYYUtM7zx+HgI4PaKICCC/WbwJb92hv1dxKuEajF4Aqwg+xdd3wHuIcuP
         5bMcOw2mAFiR9EaPwmw8cyiPvP5a+51akXZjO+IJuJ9HtNqhNZSiHceotxIFLfXxipti
         S6p7JPsjcaDCDHnw4/AQpBhub8LiTmGByC9COobwiy/X6YpnQZ4CzWX+L9zBytW08kk6
         E4Xg==
X-Gm-Message-State: APjAAAUc0TWV3q+L+letZIPnX79Rytm9RsBw0seXWaws+1V3xlOebxRQ
        DiQb2Cjn+gfsw+m4ePiMAGu6TXJOwAEZx81PlB8vYK0f
X-Google-Smtp-Source: APXvYqzErwxz0QH5HGzLwRxK3WgciFx3M+VKPW3e7a8OIhyLNapMDEJcbfRDj6Cv4b085/enYmXb7FJN6/+3T6WYwJE=
X-Received: by 2002:a67:dd81:: with SMTP id i1mr6201015vsk.236.1560242893139;
 Tue, 11 Jun 2019 01:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190611055045.15945-1-oded.gabbay@gmail.com> <20190611055045.15945-9-oded.gabbay@gmail.com>
 <20190611075933.GB13408@kroah.com> <CAFCwf12GRn6ePeH1cLuC_-C9pyQJJSZ9RaGdMUz6MkGrtR=Lvg@mail.gmail.com>
In-Reply-To: <CAFCwf12GRn6ePeH1cLuC_-C9pyQJJSZ9RaGdMUz6MkGrtR=Lvg@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 11 Jun 2019 11:47:47 +0300
Message-ID: <CAFCwf123XC_SM3-P-Va4YO707ghSuqahtbFqpkWs+cTmkPvnEg@mail.gmail.com>
Subject: Re: [PATCH 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:08 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Tue, Jun 11, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 11, 2019 at 08:50:45AM +0300, Oded Gabbay wrote:
> > > --- a/drivers/misc/habanalabs/habanalabs_drv.c
> > > +++ b/drivers/misc/habanalabs/habanalabs_drv.c
> > > @@ -28,6 +28,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
> > >
> > >  static int timeout_locked = 5;
> > >  static int reset_on_lockup = 1;
> > > +static int power9_64bit_dma_enable;
> > >
> > >  module_param(timeout_locked, int, 0444);
> > >  MODULE_PARM_DESC(timeout_locked,
> > > @@ -37,6 +38,10 @@ module_param(reset_on_lockup, int, 0444);
> > >  MODULE_PARM_DESC(reset_on_lockup,
> > >       "Do device reset on lockup (0 = no, 1 = yes, default yes)");
> > >
> > > +module_param(power9_64bit_dma_enable, int, 0444);
> > > +MODULE_PARM_DESC(power9_64bit_dma_enable,
> > > +     "Enable 64-bit DMA mask. Should be set only in POWER9 machine (0 = no, 1 = yes, default no)");
> > > +
> > >  #define PCI_VENDOR_ID_HABANALABS     0x1da3
> > >
> > >  #define PCI_IDS_GOYA                 0x0001
> >
> >
> > This is not the 1990's, please do not use module parameters.  Yeah, you
> > have a bunch of them already, but do not add additional ones that can be
> > easily determined at runtime, like this one.
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg,
> I would love to do this in runtime and that was my intent all along
> until I hit a wall on *how* to find out it in runtime if I'm running
> on POWER9 with PHB4 or not.
> I did a search in the kernel code, consulted with a couple of people
> but I didn't get any way of doing this in runtime.
> If you have some way, please share it with me because I hit a wall
> with this issue.
>
> The fact of the matter is, I have two different configurations of *my*
> device's PCIe controller. One is only suitable to POWER9 with PHB4 and
> the other one suits all the rest architectures/systems (that we have
> tested so far). So I have to know which system I'm running on and as I
> said, I didn't find a kernel API which can help me do that.
>
> Thanks,
> Oded

btw, even the powernv code determines the PHB model by reading the
device-tree file. They don't even read it from the controller.

Having said that, it occurred to me that I may be able to determine
this by the PCI ID of the parent bus of my device. It has a unique PCI
ID so hopefully that will be enough.
I will check and update here.

Thanks,
Oded
