Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819DC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E820656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjutGs8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEHBSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:18:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37399 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:18:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so2145976qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+01/fhDqtai1N/X2yLycMXv1SIs+oDpJCrUUWcrjMA=;
        b=FjutGs8Upc4X6Ku/pI/PhsHhXsb8sSJIphZ2Bg6gKbUsba2yYhZiL0CQ1dmLmyiNMY
         1DoyzoBrbX/9wIuVbbJxqDoh6T5/SjSLneERnFf2MvvZ4dEnh5JkyfUIml41Djky5/16
         mUowZUTgIE3HBR+V4Tj+h5zLTs801GBy08Ld8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+01/fhDqtai1N/X2yLycMXv1SIs+oDpJCrUUWcrjMA=;
        b=BdJ6iVoBzZRCK4GcjXOaUTnRrgq+8TcTEPEi/wE3O8f4y7VL+2vU7E8d96BKUcMfii
         IMaEI8S8FXrS8U9sxEaGyvi52Vfy1aZfXiiiYCN0pTZeZ8VNwuE6nHliYO7vwD00LxeT
         ZJcr0Uq0LdjId41QGjVimLeQpvr1qDWqaVt+2dnsOvEA4IAHXaN9Vy3/i+DisEKklSYy
         xTixx2qGbwnP0PpzTYABDWUiuSyEhDTrcKrQFTBjZYPrjLRX86+UCoHxWzOuIlnXE/gm
         kC0WkjkEnP9P6ztWf92ZFAnM1cbhs+qDEbfoTiAv0+SNXXs6HQZkiIltLJ3y4RPGj5Ae
         mWiA==
X-Gm-Message-State: APjAAAVd6q1OqaAVA09AnsJoQZGE05OhHHnaUeiZKM1TGdVC5wkSeuhk
        y6XR8mw0WmecrdEvx2OcN1T5Q2map1ButUvggWcaQQ==
X-Google-Smtp-Source: APXvYqxL08Ax+gOyBauc0IC54ns9XncT6heXSua50dh6BBwY1PpGYWMo0JAbDc87rrA5Nn7hmelfVODRA0RtyuYUK6Y=
X-Received: by 2002:a37:2e05:: with SMTP id u5mr6103515qkh.124.1557278279873;
 Tue, 07 May 2019 18:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190502045631.229386-1-drinkcat@chromium.org> <6844539f-3d5e-e3ff-b498-390cdc731880@linux.intel.com>
In-Reply-To: <6844539f-3d5e-e3ff-b498-390cdc731880@linux.intel.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 8 May 2019 10:17:48 +0900
Message-ID: <CANMq1KArM_sttW0-hq9sS4gVfWnZbHevfJ+YEg0YQ3ML_Okygg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: xhci: Make it possible to not have a secondary
 HCD (3.0)
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 10:19 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 2.5.2019 7.56, Nicolas Boichat wrote:
> > Some XHCI controllers may not have any USB 3.0 port, in this case, it
> > is not useful to create add hcd->shared_hcd, which has 2 main
> > downsides:
> >   - A useless USB 3.0 root hub is created.
> >   - A warning is thrown on boot:
> > hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
> >
> > The change is mostly about checking if hcd->shared_hcd is NULL before
> > accessing it. The one special case is in xhci_run, where we need to
> > call xhci_run_finished immediately, if there is no secondary hcd.
>
> To me it looks like this creates an controller starting issue for
> xHC hardware that have both usb2 and usb3 ports.
>
> When we have usb3 ports xhci->shared_hcd is not set yet when xhci_run is called
> the first time. We will end up starting the xHC before properly setting up the secondary hcd.
>
> See further down for details

Thanks Mathias and Chunfeng, I need to test this on platforms that
actually support USB 3.0 (both PCI and MTK), as you both highlighted,
there might be issues.

I'll do that a spin a v2. It might take a while though (this is not a
very critical issue).


> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > This is a respin of https://lore.kernel.org/patchwork/patch/863993/,
> > hopefully addressing the comments there. Note that I dropped the change
> > in xhci-plat.c, as I do not have a device to test it, but made a
> > similar change in xhci-mtk.c, in the next patch.
> >
> > (the @apm.com addresses seem to bounce, so I added some
> > @amperecomputing.com instead, if somebody there can track back the
> > original issue, I'm happy to provide a patch for xhci-plat.c as well)
> >
> > drivers/usb/host/xhci-hub.c |  7 ++++--
> >   drivers/usb/host/xhci.c     | 45 +++++++++++++++++++++++++++----------
> >   2 files changed, 38 insertions(+), 14 deletions(-)
> >
>
> ...
>
> > @@ -698,6 +703,10 @@ int xhci_run(struct usb_hcd *hcd)
> >
> >       xhci_debugfs_init(xhci);
> >
> > +     /* There is no secondary HCD, start the host controller immediately. */
> > +     if (!xhci->shared_hcd)
> > +             return xhci_run_finished(xhci);
> > +
>
> PCI xHC controllers with both usb2 and usb3 ports will be started before usb3 parts are properly set up.
>
> xhci_pci_probe()
>    usb_hcd_pci_probe()
>      usb_add_hcd()
>        hcd->driver->start(hcd)  // .start = xhci_run
>          xhci_run()
>            if (!xhci->shared_hcd)  // TRUE as xhci->shared_hcd is not yet set,
>             return xhci_run_finished(xhci)  // starting controller too early here
>    xhci->shared_hcd = usb_create_shared_hcd()   // now xhci->shared_hcd is set.
>
> -Mathias
