Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB36C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E8A218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKCz6nXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbfGWNkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:40:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39412 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfGWNkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:40:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so20667460pls.6;
        Tue, 23 Jul 2019 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BOVz1Kra82hvNBDxaReMCbJJTvETWWuqjVtK593JxVg=;
        b=UKCz6nXPPMCWqPF41HW9bNtwUGdbj5rSSH1jwIFH++xNuEzFlFd7CDAr7fw3vkiS98
         /aasHjo0MjqTA16kYFth+5RYuejKYNMgxLs1SUiMOzKleZYl8o1X9FeXeioylDMz81Lh
         f7P88/TOAd44OUhuteOseWGkJcIZdkRWPie7sMQyV5FolIaJCEhV5+Sr9o8LluQD5Wkp
         ENzRsW68zxrARTrhHDCKGfHpKdcn/5VWYnR4TW+5GsMJ9rCneIFwv8xuCiAW86D1+wHK
         cVli1HRc3iDb+InjAAoGWVtY/kpbd45jRoFLDP+8VEfswzyk4bdefYpwT4WBvXuSmaGy
         ooew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BOVz1Kra82hvNBDxaReMCbJJTvETWWuqjVtK593JxVg=;
        b=D+m35PmVUJse6+qaj/1iRoE7Pdvs9w5QaPYupj510G/SQ91bQpod2prtX0NScT/c38
         mOkLnsgdQCvGhA3NVX/ZNbwQd3TIDIYwHBN3LJH9cQbZ5iVakzEyEYSU59jG90iJIFHU
         8tCMMfbq1sd5L6jSiw2sZCIdFEobBhgIAOaluCim1yU6jaTUOmqad8t0lPbrmFKYiT2s
         ZqTfQM+I4VtOgkZSLGBCTYFBajHNx8Yh1xIJ6BUxEqbDZMffr3/oIMYkw6wb0chYQfLr
         pWV7hU1sNHEmROEa6Pw3zewn9TE7mpfIkJr2hLjEjHnTEycwaAnVV/M1jjmvyAaOCKZ/
         Z52g==
X-Gm-Message-State: APjAAAWwVNg5839fvFVYoU0pn5B4J5pmm+lT1K4XXn5WlYtHzOqGtlUa
        bzeprZqKxMSnfDoorb3Jb9g=
X-Google-Smtp-Source: APXvYqxY2wAyoAcNyqtGx+9qMC4h6LiQiC7bwt8cnuKWM7LHRHO75xH4vxYdWAEdtUbyeSSgS5bYrA==
X-Received: by 2002:a17:902:7407:: with SMTP id g7mr81559137pll.214.1563889218366;
        Tue, 23 Jul 2019 06:40:18 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id g62sm41407999pje.11.2019.07.23.06.40.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:40:17 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:40:12 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
Message-ID: <20190723134012.GA5532@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-2-suwan.kim027@gmail.com>
 <d10b23b3-601d-c2c6-df2e-77b2ed9adc66@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d10b23b3-601d-c2c6-df2e-77b2ed9adc66@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:26:42PM -0600, shuah wrote:
> Hi Suwan,
> 
> On 7/5/19 10:43 AM, Suwan Kim wrote:
> > vhci doesn’t do DMA for remote device. Actually, the real DMA
> > operation is done by network card driver. vhci just passes virtual
> > address of the buffer to the network stack, so vhci doesn’t use and
> > need dma address of the buffer of the URB.
> > 
> > When it comes to supporting SG for vhci, it is useful to use native
> > SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
> > fnuction can adjust the number of SG list (urb->num_mapped_sgs).
> > 
> > But HCD provides DMA mapping and unmapping function by default.
> > Moreover, it causes unnecessary DMA mapping and unmapping which
> > will be done again at the NIC driver and it wastes CPU cycles.
> > So, implement map_urb_for_dma and unmap_urb_for_dma function for
> > vhci in order to skip the DMA mapping and unmapping procedure.
> > 
> > To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> > urb->transfer_flags if URB has SG list and this flag will tell the
> > stub driver to use SG list.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 000ab7225717..14fc6d9f4e6a 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
> >   	return 0;
> >   }
> > +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +			gfp_t mem_flags)
> > +{
> > +	dev_dbg(hcd->self.controller, "vhci does not map urb for dma\n");
> > +
> > +	if (urb->num_sgs)
> > +		urb->transfer_flags |= URB_DMA_MAP_SG;
> > +
> 
> Shouldn't this be part of patch 2. The debug message saying "no map"
> and setting flag doesn't make sense.

I think you are right. Setting flag should be in patch 2. Thank you
for pointing out :)
I will remove unnecessary debug messages and move setting flag to
patch 2.

> > +       return 0;
> 
> This should be a tab and no spaces btw. chekpatch isn't happy.
> 
> > +}
> > +
> > +static void vhci_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
> > +{
> > +       dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");
> 
> This should be a tab and no spaces btw. chekpatch isn't happy.
> 
> 
> WARNING: please, no spaces at the start of a line
> #144: FILE: drivers/usb/usbip/vhci_hcd.c:1299:
> +       return 0;$
> 
> WARNING: please, no spaces at the start of a line
> #149: FILE: drivers/usb/usbip/vhci_hcd.c:1304:
> +       dev_dbg(hcd->self.controller, "vhci does not unmap urb for dma\n");$
> 
> total: 0 errors, 2 warnings, 31 lines checked

I'm sorry for my fault. I will check it.

Regards,
Suwan Kim
