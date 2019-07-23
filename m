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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E82C218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeyXjkQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbfGWN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:56:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35844 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGWN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:56:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so20665391plt.3;
        Tue, 23 Jul 2019 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEaM5iARO/otY5CB0Q+ud/LRqI7Ysq17G3aAmdafXi8=;
        b=SeyXjkQAhvbw+tUwvo+eecFXjxIz3000spt05+4PQ146TkcTNLUDoZ+cIL7VBbcFhU
         WInpgqv0jahR+72BKNZc1XatHi13pLhnHmg+vCGOTvufKAE19A9BQlJ5Z35htv54Ylnd
         uYIRQOtdWFo4zdMCefVVPOVSlg5l5Ui7vLdUoAR6DOSb7gJkD9zOCM5jA+CRbSQx0iwn
         6fxNf7439Q2oErrhpb/K3MeSBFDBlDMLdOm4B7AX+e+WhXosjhtQCxBpbMvI2I04dFBk
         KXceBqIZ98NEL0LwAMeN0nY85Ril7FI/1Zkiq44NJ34No13OQ9cUvagioh5rAZlIHOEq
         nAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEaM5iARO/otY5CB0Q+ud/LRqI7Ysq17G3aAmdafXi8=;
        b=Se7b+U7hiF/0OY6oYyeevjRyhq1ZGpevcQZ/NQw4uivIuMBnAqvVi7rzzndqQ3tjp3
         Q7i7RtIGbIVF1XAyHfUffscEN8cuag5xj5SLnFpsp5Uv0iE6za5dEllL2cO1E/gAhasA
         3sXMswzKptqctAJ9xGT+dn0sFfMDHK2VP6uftqWhpqIuD3xTdoXiL80Qy5YpMB6rogb4
         xovet5Un667ZBHleaCnSnLmEQF0mO9H9zLX6oE50E7K8sMh6/MtdxS2OzBRhcG3U8gwa
         T4hLXxkEEYyxjf8xWbS3ncmy+Dvgz4vbUzEYzOBmhkuPm6XR2c6Al2Lbc8nJe26F/E41
         1gvA==
X-Gm-Message-State: APjAAAU74MWdZKk0vpBEeU9/4KzLc2MfdKisr7eHGFd+NPBj1H5e6eGY
        SK6npO6T3aq6oJX+x13C+uA=
X-Google-Smtp-Source: APXvYqwy0UdFfEUTseNw57g/L1CWJYiz26hdYYO3uV8l9BcOz+fo1TP4AbbyXm8FzaNUmTtLdwFIXQ==
X-Received: by 2002:a17:902:7894:: with SMTP id q20mr77830015pll.339.1563890198681;
        Tue, 23 Jul 2019 06:56:38 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id v10sm43807453pfe.163.2019.07.23.06.56.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:56:38 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:56:33 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
Message-ID: <20190723135633.GB5532@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <f66e55a2-16e0-8822-8b5b-3390b6c4073b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66e55a2-16e0-8822-8b5b-3390b6c4073b@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:51:30PM -0600, shuah wrote:
> On 7/5/19 10:43 AM, Suwan Kim wrote:
> > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > doesn't supported SG, so USB storage driver on vhci breaks SG list
> 
> grammar - Currently vhci doesn't support?

Yes, that is what I intended. Please excuse my poor english.

> > into multiple URBs and it causes error that a transfer got terminated
> > too early because the transfer length for one of the URBs was not
> > divisible by the maxpacket size.
> > 
> > In this patch, vhci basically support SG and it sends each SG list
> 
> What does basically support mean here? Do you mean basic support?

What I intended was that vhci supports SG regardless of whether the
server's host controller supports SG or not, because stub driver
splits SG list into several URBs if the server's host controller
doesn't support SG. I will rewrite the description to make it more
clear.

> > entry to the stub driver. Then, the stub driver sees the total length
> > of the buffer and allocates SG table and pages according to the total
> > buffer length calling sgl_alloc(). After the stub driver receives
> > completed URB, it again sends each SG list entry to vhci.
> > 
> > If HCD of the server doesn't support SG, the stub driver breaks a
> > single SG reqeust into several URBs and submit them to the server's
> > HCD. When all the split URBs are completed, the stub driver
> > reassembles the URBs into a single return command and sends it to
> > vhci.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> >   drivers/usb/usbip/stub.h         |   7 +-
> >   drivers/usb/usbip/stub_main.c    |  52 +++++---
> >   drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
> >   drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
> >   drivers/usb/usbip/usbip_common.c |  60 +++++++--
> >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
> >   drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> >   7 files changed, 372 insertions(+), 121 deletions(-)
> > 
> 
> btw checkpatch isn't very happy with this patch. A few coding style
> issues. Please run checkpatch before sending patches.

I'm sorry for sending it without running checkpatch.
I will fix all problems with checkpatch and resend v3.

> > diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
> > index 35618ceb2791..d11270560c24 100644
> > --- a/drivers/usb/usbip/stub.h
> > +++ b/drivers/usb/usbip/stub.h
> > @@ -52,7 +52,11 @@ struct stub_priv {
> >   	unsigned long seqnum;
> >   	struct list_head list;
> >   	struct stub_device *sdev;
> > -	struct urb *urb;
> > +	struct urb **urbs;
> > +	struct scatterlist *sgl;
> > +	int num_urbs;
> > +	int completed_urbs;
> > +	int urb_status;
> >   	int unlinking;
> >   };
> > @@ -86,6 +90,7 @@ extern struct usb_device_driver stub_driver;
> >   struct bus_id_priv *get_busid_priv(const char *busid);
> >   void put_busid_priv(struct bus_id_priv *bid);
> >   int del_match_busid(char *busid);
> > +void stub_free_priv_and_urb(struct stub_priv *priv);
> >   void stub_device_cleanup_urbs(struct stub_device *sdev);
> >   /* stub_rx.c */
> > diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> > index 2e4bfccd4bfc..dec5af9f7179 100644
> > --- a/drivers/usb/usbip/stub_main.c
> > +++ b/drivers/usb/usbip/stub_main.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/string.h>
> >   #include <linux/module.h>
> >   #include <linux/device.h>
> > +#include <linux/scatterlist.h>
> >   #include "usbip_common.h"
> >   #include "stub.h"
> > @@ -288,6 +289,39 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
> >   	return NULL;
> >   }
> > +void stub_free_priv_and_urb(struct stub_priv *priv)
> > +{
> > +	struct urb *urb;
> > +	int i;
> > +
> > +	for (i = 0; i < priv->num_urbs; i++) {
> > +		urb = priv->urbs[i];
> > +		if (urb->setup_packet) {
> > +			kfree(urb->setup_packet);
> > +			urb->setup_packet = NULL;
> > +		}
> > +
> 
> You don't need urb->setup_packet null check. kfree() is safe
> to call with null pointer. btw checkpatch tells you this.

Ok. I will remove null check.

> > +		if (urb->transfer_buffer && !priv->sgl) {
> 
> Is this conditional necessary? Why are you checking priv->sgl?
> Are there cases where you have memory leak? Is there a case
> when urb->transfer_buffer valid when priv->sgl isn't null?

In my implementation, if URB has an SG list, whether SG is supported
by the server's host controller or not, stub driver allocates SG list
and pages calling sg_alloc().

At this time, if the server's host controller does not support SG,
stub driver stores SG list in stub_priv->sgl (not in urb->sg) and
allocates URBs according to each entry of SG list. The page of each
SG list entry is mapped to each URB's transfer buffer.
(urb->transfer_buffer = sg_virt(sg))

So, when deallocating these URBs, stub driver doesn't deallocate the
URB's buffer with kfree(), but use sgl_free() to deallocate the SG
list stored in stub_priv (priv->sgl) and all the pages mapped to each
URB's buffer at once.

> > +			kfree(urb->transfer_buffer);
> > +			urb->transfer_buffer = NULL;
> > +		}
> > +
> > +		if (urb->num_sgs) {
> > +			sgl_free(urb->sg);
> > +			urb->sg = NULL;
> > +			urb->num_sgs = 0;
> > +		}
> > +
> > +		usb_free_urb(urb);
> > +	}
> > +
> > +	list_del(&priv->list);
> > +	if (priv->sgl)
> > +		sgl_free(priv->sgl);
> > +	kfree(priv->urbs);
> > +	kmem_cache_free(stub_priv_cache, priv);
> > +}
> > +
> >   static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
> >   {
> >   	unsigned long flags;
> > @@ -314,25 +348,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
> >   void stub_device_cleanup_urbs(struct stub_device *sdev)
> >   {
> >   	struct stub_priv *priv;
> > -	struct urb *urb;
> > +	int i;
> >   	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
> >   	while ((priv = stub_priv_pop(sdev))) {
> > -		urb = priv->urb;
> > -		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
> > -			priv->seqnum);
> > -		usb_kill_urb(urb);
> > -
> > -		kmem_cache_free(stub_priv_cache, priv);
> > -
> > -		kfree(urb->transfer_buffer);
> > -		urb->transfer_buffer = NULL;
> > +		for (i = 0; i < priv->num_urbs; i++)
> > +			usb_kill_urb(priv->urbs[i]);
> > -		kfree(urb->setup_packet);
> > -		urb->setup_packet = NULL;
> > -
> > -		usb_free_urb(urb);
> > +		stub_free_priv_and_urb(priv);
> >   	}
> >   }
> > diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> > index b0a855acafa3..8e32697acabb 100644
> > --- a/drivers/usb/usbip/stub_rx.c
> > +++ b/drivers/usb/usbip/stub_rx.c
> > @@ -7,6 +7,7 @@
> >   #include <linux/kthread.h>
> >   #include <linux/usb.h>
> >   #include <linux/usb/hcd.h>
> > +#include <linux/scatterlist.h>
> >   #include "usbip_common.h"
> >   #include "stub.h"
> > @@ -201,7 +202,7 @@ static void tweak_special_requests(struct urb *urb)
> >   static int stub_recv_cmd_unlink(struct stub_device *sdev,
> >   				struct usbip_header *pdu)
> >   {
> > -	int ret;
> > +	int ret, i;
> >   	unsigned long flags;
> >   	struct stub_priv *priv;
> > @@ -246,12 +247,13 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
> >   		 * so a driver in a client host will know the failure
> >   		 * of the unlink request ?
> >   		 */
> > -		ret = usb_unlink_urb(priv->urb);
> > -		if (ret != -EINPROGRESS)
> > -			dev_err(&priv->urb->dev->dev,
> > -				"failed to unlink a urb # %lu, ret %d\n",
> > -				priv->seqnum, ret);
> > -
> > +		for (i = priv->completed_urbs; i < priv->num_urbs; i++) {
> > +			ret = usb_unlink_urb(priv->urbs[i]);
> > +			if (ret != -EINPROGRESS)
> > +				dev_err(&priv->urbs[i]->dev->dev,
> > +					"failed to unlink a urb # %lu, ret %d\n",
> > +					priv->seqnum, ret);
> 
> This could result in several error messages. This code path is much
> longer now compared to previous.

I don't know what function or part you point to. stub_recv_cmd_unlink()?

Regards,
Suwan Kim
