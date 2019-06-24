Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F52C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00820674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+sZ1zdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFXO67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:58:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45752 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFXO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:58:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so7648824pfq.12;
        Mon, 24 Jun 2019 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRMTWS0cPEEAhit+uZ2HEz5EhK22AdHx0UBIHnvpe0s=;
        b=t+sZ1zdWZTip2CFxNZMQXxFxHl02l9mBF1G1GdEBxsOzyEqCjy19IrnvhFVQqG5Jsu
         HKc5h3UtXpXM2+pZamRlW/35dJTpBaSHcbXGlL2CrAzexBZ7+eDZaqFlGjun6Qwk6TaN
         03piFOleKJKbKbJTPESIEpNtZTJNmjg8GRlGw5mhHzjBM4xJtmDbgLUWoVEj8EOVrw9E
         5L11cVwmC7RDx7CmojvaxHp9XRW3TjN7sOuiNyaEWlpU9hSNguiCAY3sQFy3Wyuwp7kO
         gOxJr909vvQHYgrmoWzOd4YMY7KtNcx5a/sNVAWaO2bNOXik954iAjCchuxfoa/xwSGL
         9A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRMTWS0cPEEAhit+uZ2HEz5EhK22AdHx0UBIHnvpe0s=;
        b=mUfd010dcYbndt6xQj80Jaavr4xaItyInxgOgG3/Z2wgd6m0G7h00LVxZO/s/5v84H
         I+hGOKmMLhBc2+nsQSKjIoY2FB+JKZVcK23FJU39YSWmYLfLt+PCjnP4tWfommqTt6mg
         /gqiz8bXOXtiIlQxfzFBzSf4hcKAgQcl2FdN/D9B2Fz+jEjCG5JGv6NAdJ7b9+2oM71C
         tyUd75LPBXIXCl2Jj2DUxX+kssrWzdGpZ0RaECJ0q1J8GCsBoxW+RCoveFXmXtMcd5UB
         qF0rD2dakTM9x/5AKRbp4ufbgTfgXLve47KRh2nVZeemgZv2ZRCp5T295v21XN8KdriG
         laaw==
X-Gm-Message-State: APjAAAXiUFd01xftJCKqcRua1upxbooGmK0rhcZGTL8kAa8eeUsMkVLJ
        1XU1h6quBsqQKN0MzknBMyU=
X-Google-Smtp-Source: APXvYqwThNykeYeT1DwTNSsyUEF6bR+BMk2qXnrOqE1ZANRkHewSr0lh2qOuTQ5WTIEHg4JxMr9IIw==
X-Received: by 2002:a65:510c:: with SMTP id f12mr32304339pgq.92.1561388338217;
        Mon, 24 Jun 2019 07:58:58 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id w16sm15623074pfj.85.2019.06.24.07.58.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 07:58:57 -0700 (PDT)
Date:   Mon, 24 Jun 2019 23:58:53 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usbip: Implement SG support to vhci
Message-ID: <20190624145852.GC7547@localhost.localdomain>
References: <20190621174553.28862-3-suwan.kim027@gmail.com>
 <Pine.LNX.4.44L0.1906211548560.1471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906211548560.1471-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:05:24PM -0400, Alan Stern wrote:
> On Sat, 22 Jun 2019, Suwan Kim wrote:
> 
> > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > doesn't supported SG. So, USB storage driver on vhci divides SG list
> > into multiple URBs and it causes buffer overflow on the xhci of the
> > server. So we need to add SG support to vhci
> 
> It doesn't cause buffer overflow.  The problem was that a transfer got
> terminated too early because the transfer length for one of the URBs
> was not divisible by the maxpacket size.

Oh.. I misunderstood the problem. I will rewrite the problem
situation.

> > In this patch, vhci basically support SG and it sends each SG list
> > entry to the stub driver. Then, the stub driver sees total length of
> > the buffer and allocates SG table and pages according to the total
> > buffer length calling sgl_alloc(). After the stub driver receives
> > completed URB, it again sends each SG list entry to the vhci.
> > 
> > If HCD of server doesn't support SG, the stub driver allocates
> > big buffer using kmalloc() instead of using sgl_alloc() which
> > allocates SG list and pages.
> 
> You might be better off not using kmalloc.  It's easier for the kernel 
> to allocate a bunch of small buffers than a single big one.  Then you 
> can create a separate URB for each buffer.

Ok. I will implement it as usb_sg_init() does and send v2 patch
including the logic of submitting separate URBs.

> > Alan fixed vhci bug with the USB 3.0 storage device by modifying
> > USB storage driver.
> > ("usb-storage: Set virt_boundary_mask to avoid SG overflows")
> > But the fundamental solution of it is to add SG support to vhci.
> > 
> > This patch works well with the USB 3.0 storage devices without Alan's
> > patch, and we can revert Alan's patch if it causes some troubles.
> 
> These last two paragraphs don't need to be in the patch description.

I will remove these paragraphs in v2 patch.

> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> 
> I'm not sufficiently familiar with the usbip drivers to review most of 
> this.  However...
> 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index be87c8a63e24..cc93c1a87a3e 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -696,7 +696,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
> >  	}
> >  	vdev = &vhci_hcd->vdev[portnum-1];
> >  
> > -	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> > +	if (!urb->transfer_buffer && !urb->num_sgs &&
> > +	     urb->transfer_buffer_length) {
> >  		dev_dbg(dev, "Null URB transfer buffer\n");
> >  		return -EINVAL;
> >  	}
> > @@ -1142,6 +1143,11 @@ static int vhci_setup(struct usb_hcd *hcd)
> >  		hcd->speed = HCD_USB3;
> >  		hcd->self.root_hub->speed = USB_SPEED_SUPER;
> >  	}
> > +
> > +	/* support sg */
> > +	hcd->self.sg_tablesize = ~0;
> > +	hcd->self.no_sg_constraint = 1;
> 
> You probably shouldn't do this, for two reasons.  First, sg_tablesize
> of the server's HCD may be smaller than ~0.  If the client's value is
> larger than the server's, a transfer could be accepted on the client
> but then fail on the server because the SG list was too big.
> 
> Also, you may want to restrict the size of SG transfers even further,
> so that you don't have to allocate a tremendous amount of memory all at
> once on the server.  An SG transfer can be quite large.  I don't know 
> what a reasonable limit would be -- 16 perhaps?

Is there any reason why you think that 16 is ok? Or Can I set this
value as the smallest value of all HC? I think that sg_tablesize
cannot be a variable value because vhci interacts with different
machines and all machines has different sg_tablesize value.

Regards

Suwan Kim
