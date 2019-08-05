Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE0CC32750
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E4F217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT3xQEGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfHEIE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:04:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39114 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfHEIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:04:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so36202211pls.6;
        Mon, 05 Aug 2019 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfW6a2PYuGK5ZprWVB+glOM15gVMdQKyTZZKrC2Gg3A=;
        b=hT3xQEGCv1BdLNetGqbMWvHkwZeF3ehQzHJ9SWUx4eHhItZ/r/bm/E1hul3o0ripNJ
         vGMCmrXG4jV8e1sljHAZb16skGhbO7X3A6YgBupoBWSpNmDC4WVkjtSuyF2aq5Et4tex
         kTbX2o6pbTnF8wYpePAQtUS0qa/q1Qb3ZKMJYEJrAgJhWbiNJgDFI6vSDALYMZzI9epQ
         JYvfaV5dkjHRFjlsUZZ3XpzX6gcDvs7jtBgjOoHVqXN5gSGJZfRRzGbidiQBFMSHH145
         oZWH6ZqI4W8Fqjk3KuCjLFCbAnF+FGMn1TKOae/NyuloQP63jyKT0TKGcSl7OYdOJdBc
         RT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfW6a2PYuGK5ZprWVB+glOM15gVMdQKyTZZKrC2Gg3A=;
        b=MB5HGQBxxpBJecdGxaKFEIjyZBVFpKd+lfzCcnmQRtVC48q+37TNkBJ6yrwti9EdNu
         7nY82T9ZcaDbM2NlxW8mSRIMVMyb2y2EtY3rh+3Cy2zNTrd0NhgE5sfnJuXz/UOXW9BL
         QGqS33J+eZECBMGGzpYDClodZzf/t9reIn94XmMPlSVmgwxKxlqq4e+AFmGAqUun0lpL
         nHv2BhhmmTIeEbLAd8cMKaOiYRr2zt8WxHorwyYDHLMmMHuP4dfSa9hh91AzmaXI7/Su
         Tcu59s76Qe0sqzHFGeRmQFVW0qP3SV+v9YZ7AqfYfAM65QikxsnU5MrfNHHRNgPKKldS
         v5+g==
X-Gm-Message-State: APjAAAX5gsoQDa21r7ATWZO9FLmb8uGF6wSY92ZqHOYw7XCfcHeofnhF
        BKiWJPkQl3pTbijRBjeso4c=
X-Google-Smtp-Source: APXvYqx6DUwmvIkP7/c5qy6FB2fro98V5dY6vTo27fxa2u41496MT9ShoYgaffmHszxc184rW8+vYA==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr144688955plv.106.1564992296966;
        Mon, 05 Aug 2019 01:04:56 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.gmail.com with ESMTPSA id y11sm85265681pfb.119.2019.08.05.01.04.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 01:04:56 -0700 (PDT)
Date:   Mon, 5 Aug 2019 17:04:51 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
Message-ID: <20190805080451.GB8904@localhost.localdomain>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
 <20190802173651.22247-3-suwan.kim027@gmail.com>
 <43f32889-0117-cd94-2494-23ab29be6ca8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f32889-0117-cd94-2494-23ab29be6ca8@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 04:41:52PM -0600, shuah wrote:
> Hi Suwan,
> 
> On 8/2/19 11:36 AM, Suwan Kim wrote:
> > There are bugs on vhci with usb 3.0 storage device.
> 
> This sentence doesn't make sense to me. What bugs? Ca you eloborate?

Alan's patch description "usb-storage: Set virt_boundary_mask to
avoid SG overflows" elaborates the problem. In USB, each SG list
entry buffer should be divisible by the bulk maxpacket size. But
with native SG support, this problem doesn't matter because the
SG buffer is treated as contiguous buffer. But without native SG
support, storage driver breaks SG list into several URBs and each
URB is sparate transfer.

Let's assume that driver request 31.5 KB data and has SG list which
has 3584 bytes buffer followed by 7 4096 bytes buffer for some
reason. USB Storage driver splits this SG list into several URBs
because VHCI doesn't support SG and send them separately. So the
first URB buffer size is 3584 bytes. When receiving data from device,
USB 3.0 device sends data packet of 1024 bytes size because the max
packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
But the first URB buffer has only 3584 bytes buffer size. So host
controller terminates the transfer even though there is more data
to receive.

Please also reference the mail thread
https://marc.info/?t=155449209600003&r=1&w=2
https://marc.info/?l=linux-usb&m=155482317722223&w=2

> > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > into multiple URBs and it causes error that a transfer got terminated
> > too early because the transfer length for one of the URBs was not
> > divisible by the maxpacket size.
> > 
> > In this patch, vhci supports SG regardless of whether the server's
> > host controller supports SG or not, because stub driver splits SG
> > list into several URBs if the server's host controller doesn't
> > support SG.
> > 
> > To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> > urb->transfer_flags if URB has SG list and this flag will tell stub
> > driver to use SG list.
> > 
> > vhci sends each SG list entry to stub driver. Then, stub driver sees
> > the total length of the buffer and allocates SG table and pages
> > according to the total buffer length calling sgl_alloc(). After stub
> > driver receives completed URB, it again sends each SG list entry to
> > vhci.
> > 
> > If the server's host controller doesn't support SG, stub driver
> > breaks a single SG request into several URBs and submits them to
> > the server's host controller. When all the split URBs are completed,
> > stub driver reassembles the URBs into a single return command and
> > sends it to vhci.
> > 
> > Moreover, in the situation where vhci supports SG, but stub driver
> > does not, or vice versa, usbip works normally. Because there is no
> > protocol modification, there is no problem in communication between
> > server and client even if the one has a kernel without SG support.
> > 
> > In the case of vhci supports SG and stub driver doesn't, because
> > vhci sends only the total length of the buffer to stub driver as
> > it did before the patch applied, stub driver only needs to allocate
> > the required length of buffers regardless of whether vhci supports
> > SG or not.
> > 
> > If stub driver needs to send data buffer to vhci because of IN pipe,
> > stub driver also sends only total length of buffer as metadata and
> > then sends real data as vhci does. Then vhci receive data from stub
> > driver and store it to the corresponding buffer of SG list entry.
> > 
> > In the case of stub driver that supports SG, buffer is allocated by
> > sgl_alloc(). However, stub driver that does not support SG allocates
> > buffer using only kmalloc(). Therefore, if vhci supports SG and stub
> > driver doesn't, stub driver has to allocate buffer with kmalloc() as
> > much as the total length of SG buffer which is quite huge when vhci
> > sends SG request, so it has big overhead in buffer allocation.
> > 
> > And for the case of stub driver supports SG and vhci doesn't, since
> > the USB storage driver checks that vhci doesn't support SG and sends
> > the request to stub driver by splitting the SG list into multiple
> > URBs, stub driver allocates a buffer with kmalloc() as it did before
> > this patch.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > ---
> 
> Please add patch revision history to help reviews. What did you
> change in this patch from previous version.

Ok. I'm sorry for missing the revision history. I wiil it and send
v4.

> >   drivers/usb/usbip/stub.h         |   7 +-
> >   drivers/usb/usbip/stub_main.c    |  55 ++++++---
> >   drivers/usb/usbip/stub_rx.c      | 203 ++++++++++++++++++++++---------
> >   drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
> >   drivers/usb/usbip/usbip_common.c |  59 ++++++---
> >   drivers/usb/usbip/vhci_hcd.c     |  15 ++-
> >   drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
> >   7 files changed, 375 insertions(+), 126 deletions(-)
> > 
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
> > index 2e4bfccd4bfc..3ee636215e9c 100644
> > --- a/drivers/usb/usbip/stub_main.c
> > +++ b/drivers/usb/usbip/stub_main.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/string.h>
> >   #include <linux/module.h>
> >   #include <linux/device.h>
> > +#include <linux/scatterlist.h>
> >   #include "usbip_common.h"
> >   #include "stub.h"
> > @@ -288,6 +289,42 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
> >   	return NULL;
> >   }
> > +void stub_free_priv_and_urb(struct stub_priv *priv)
> > +{
> > +	struct urb *urb;
> > +	int i;
> > +
> > +	for (i = 0; i < priv->num_urbs; i++) {
> > +		urb = priv->urbs[i];
> > +
> > +		if (!urb)
> > +			return;
> > +
> > +		kfree(urb->setup_packet);
> > +		urb->setup_packet = NULL;
> > +
> > +
> > +		if (urb->transfer_buffer && !priv->sgl) {
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
> > @@ -314,25 +351,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
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
> > +		for (i = 0; i < priv->num_urbs; i++)
> > +			usb_kill_urb(priv->urbs[i]);
> > -		kmem_cache_free(stub_priv_cache, priv);
> > -
> > -		kfree(urb->transfer_buffer);
> > -		urb->transfer_buffer = NULL;
> > -
> > -		kfree(urb->setup_packet);
> > -		urb->setup_packet = NULL;
> > -
> > -		usb_free_urb(urb);
> > +		stub_free_priv_and_urb(priv);
> >   	}
> >   }
> > diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> > index b0a855acafa3..7630012f6827 100644
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
> I am concerned about printing this message in this loop. It made sense
> when there is just one urb.

You are right. Thank you for pointing out. I will fix it.

> > +		}
> >   		return 0;
> >   	}
> > @@ -433,14 +435,36 @@ static void masking_bogus_flags(struct urb *urb)
> >   	urb->transfer_flags &= allowed;
> >   }
> > +static int stub_recv_xbuff(struct usbip_device *ud, struct stub_priv *priv)
> > +{
> > +	int ret;
> > +	int i;
> > +
> > +	for (i = 0; i < priv->num_urbs; i++) {
> > +		ret = usbip_recv_xbuff(ud, priv->urbs[i]);
> > +		if (ret < 0)
> > +			break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >   static void stub_recv_cmd_submit(struct stub_device *sdev,
> >   				 struct usbip_header *pdu)
> >   {
> > -	int ret;
> >   	struct stub_priv *priv;
> >   	struct usbip_device *ud = &sdev->ud;
> >   	struct usb_device *udev = sdev->udev;
> > +	struct scatterlist *sgl = NULL, *sg;
> > +	void *buffer = NULL;
> > +	unsigned long long buf_len;
> > +	int nents;
> > +	int num_urbs = 1;
> >   	int pipe = get_pipe(sdev, pdu);
> > +	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> > +	int support_sg = 1;
> > +	int np = 0;
> > +	int ret, i;
> >   	if (pipe == -1)
> >   		return;
> > @@ -449,76 +473,139 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> >   	if (!priv)
> >   		return;
> > -	/* setup a urb */
> > -	if (usb_pipeisoc(pipe))
> > -		priv->urb = usb_alloc_urb(pdu->u.cmd_submit.number_of_packets,
> > -					  GFP_KERNEL);
> > -	else
> > -		priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> > +	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> > -	if (!priv->urb) {
> > -		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> > -		return;
> > +	/* allocate urb transfer buffer, if needed */
> > +	if (buf_len) {
> > +		if (use_sg) {
> > +			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> > +			if (!sgl)
> > +				goto err_malloc;
> > +		} else {
> > +			buffer = kzalloc(buf_len, GFP_KERNEL);
> > +			if (!buffer)
> > +				goto err_malloc;
> > +		}
> >   	}
> > -	/* allocate urb transfer buffer, if needed */
> > -	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
> > -		priv->urb->transfer_buffer =
> > -			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
> > -				GFP_KERNEL);
> > -		if (!priv->urb->transfer_buffer) {
> > +	/* Check if the server's HCD supports SG */
> > +	if (use_sg && !udev->bus->sg_tablesize) {
> > +		/*
> > +		 * If the server's HCD doesn't support SG, break a single SG
> > +		 * request into several URBs and map each SG list entry to
> > +		 * corresponding URB buffer. The previously allocated SG
> > +		 * list is stored in priv->sgl (If the server's HCD support SG,
> > +		 * SG list is stored only in urb->sg) and it is used as an
> > +		 * indicator that the server split single SG request into
> > +		 * several URBs. Later, priv->sgl is used by stub_complete() and
> > +		 * stub_send_ret_submit() to reassemble the divied URBs.
> > +		 */
> > +		support_sg = 0;
> > +		num_urbs = nents;
> > +		priv->completed_urbs = 0;
> > +		pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
> > +	}
> > +
> > +	/* allocate urb array */
> > +	priv->num_urbs = num_urbs;
> > +	priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
> > +	if (!priv->urbs)
> > +		goto err_urbs;
> > +
> > +	/* setup a urb */
> > +	if (support_sg) {
> > +		if (usb_pipeisoc(pipe))
> > +			np = pdu->u.cmd_submit.number_of_packets;
> > +
> > +		priv->urbs[0] = usb_alloc_urb(np, GFP_KERNEL);
> > +		if (!priv->urbs[0])
> > +			goto err_urb;
> > +
> > +		if (buf_len) {
> > +			if (use_sg) {
> > +				priv->urbs[0]->sg = sgl;
> > +				priv->urbs[0]->num_sgs = nents;
> > +				priv->urbs[0]->transfer_buffer = NULL;
> > +			} else {
> > +				priv->urbs[0]->transfer_buffer = buffer;
> > +			}
> > +		}
> > +
> > +		/* copy urb setup packet */
> > +		priv->urbs[0]->setup_packet = kmemdup(&pdu->u.cmd_submit.setup,
> > +					8, GFP_KERNEL);
> > +		if (!priv->urbs[0]->setup_packet) {
> >   			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> >   			return;
> >   		}
> > -	}
> > -	/* copy urb setup packet */
> > -	priv->urb->setup_packet = kmemdup(&pdu->u.cmd_submit.setup, 8,
> > -					  GFP_KERNEL);
> > -	if (!priv->urb->setup_packet) {
> > -		dev_err(&udev->dev, "allocate setup_packet\n");
> > -		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> > -		return;
> > +		usbip_pack_pdu(pdu, priv->urbs[0], USBIP_CMD_SUBMIT, 0);
> > +	} else {
> > +		for_each_sg(sgl, sg, nents, i) {
> > +			priv->urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
> > +			/* The URBs which is previously allocated will be freed
> > +			 * in stub_device_cleanup_urbs() if error occurs.
> > +			 */
> > +			if (!priv->urbs[i])
> > +				goto err_urb;
> > +
> > +			usbip_pack_pdu(pdu, priv->urbs[i], USBIP_CMD_SUBMIT, 0);
> > +			priv->urbs[i]->transfer_buffer = sg_virt(sg);
> > +			priv->urbs[i]->transfer_buffer_length = sg->length;
> > +		}
> > +		priv->sgl = sgl;
> >   	}
> > -	/* set other members from the base header of pdu */
> > -	priv->urb->context                = (void *) priv;
> > -	priv->urb->dev                    = udev;
> > -	priv->urb->pipe                   = pipe;
> > -	priv->urb->complete               = stub_complete;
> > +	for (i = 0; i < num_urbs; i++) {
> > +		/* set other members from the base header of pdu */
> > +		priv->urbs[i]->context = (void *) priv;
> > +		priv->urbs[i]->dev = udev;
> > +		priv->urbs[i]->pipe = pipe;
> > +		priv->urbs[i]->complete = stub_complete;
> > -	usbip_pack_pdu(pdu, priv->urb, USBIP_CMD_SUBMIT, 0);
> > +		/* no need to submit an intercepted request, but harmless? */
> > +		tweak_special_requests(priv->urbs[i]);
> > +		masking_bogus_flags(priv->urbs[i]);
> > +	}
> > -	if (usbip_recv_xbuff(ud, priv->urb) < 0)
> > +	if (stub_recv_xbuff(ud, priv) < 0)
> >   		return;
> > -	if (usbip_recv_iso(ud, priv->urb) < 0)
> > +	if (usbip_recv_iso(ud, priv->urbs[0]) < 0)
> >   		return;
> > -	/* no need to submit an intercepted request, but harmless? */
> > -	tweak_special_requests(priv->urb);
> > -
> > -	masking_bogus_flags(priv->urb);
> >   	/* urb is now ready to submit */
> > -	ret = usb_submit_urb(priv->urb, GFP_KERNEL);
> > -
> > -	if (ret == 0)
> > -		usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> > -				  pdu->base.seqnum);
> > -	else {
> > -		dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> > -		usbip_dump_header(pdu);
> > -		usbip_dump_urb(priv->urb);
> > -
> > -		/*
> > -		 * Pessimistic.
> > -		 * This connection will be discarded.
> > -		 */
> > -		usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> > +	for (i = 0; i < priv->num_urbs; i++) {
> > +		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
> > +
> > +		if (ret == 0)
> > +			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> > +					pdu->base.seqnum);
> > +		else {
> > +			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> > +			usbip_dump_header(pdu);
> > +			usbip_dump_urb(priv->urbs[i]);
> > +
> > +			/*
> > +			 * Pessimistic.
> > +			 * This connection will be discarded.
> > +			 */
> > +			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> > +			break;
> > +		}
> >   	}
> >   	usbip_dbg_stub_rx("Leave\n");
> > +	return;
> > +
> > +err_urb:
> > +	kfree(priv->urbs);
> > +err_urbs:
> > +	kfree(buffer);
> > +	sgl_free(sgl);
> > +err_malloc:
> > +	usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> >   }
> >   /* recv a pdu */
> > diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
> > index f0ec41a50cbc..36010a82b359 100644
> > --- a/drivers/usb/usbip/stub_tx.c
> > +++ b/drivers/usb/usbip/stub_tx.c
> > @@ -5,25 +5,11 @@
> >   #include <linux/kthread.h>
> >   #include <linux/socket.h>
> > +#include <linux/scatterlist.h>
> >   #include "usbip_common.h"
> >   #include "stub.h"
> > -static void stub_free_priv_and_urb(struct stub_priv *priv)
> > -{
> > -	struct urb *urb = priv->urb;
> > -
> > -	kfree(urb->setup_packet);
> > -	urb->setup_packet = NULL;
> > -
> > -	kfree(urb->transfer_buffer);
> > -	urb->transfer_buffer = NULL;
> > -
> > -	list_del(&priv->list);
> > -	kmem_cache_free(stub_priv_cache, priv);
> > -	usb_free_urb(urb);
> > -}
> > -
> >   /* be in spin_lock_irqsave(&sdev->priv_lock, flags) */
> >   void stub_enqueue_ret_unlink(struct stub_device *sdev, __u32 seqnum,
> >   			     __u32 status)
> > @@ -85,6 +71,22 @@ void stub_complete(struct urb *urb)
> >   		break;
> >   	}
> > +	/*
> > +	 * If the server breaks single SG request into the several URBs, the
> > +	 * URBs must be reassembled before sending completed URB to the vhci.
> > +	 * Don't wake up the tx thread until all the URBs are completed.
> > +	 */
> > +	if (priv->sgl) {
> > +		priv->completed_urbs++;
> > +
> > +		/* Only save the first error status */
> > +		if (urb->status && !priv->urb_status)
> > +			priv->urb_status = urb->status;
> > +
> > +		if (priv->completed_urbs < priv->num_urbs)
> > +			return;
> > +	}
> > +
> >   	/* link a urb to the queue of tx. */
> >   	spin_lock_irqsave(&sdev->priv_lock, flags);
> >   	if (sdev->ud.tcp_socket == NULL) {
> > @@ -156,18 +158,22 @@ static int stub_send_ret_submit(struct stub_device *sdev)
> >   	size_t total_size = 0;
> >   	while ((priv = dequeue_from_priv_tx(sdev)) != NULL) {
> > -		int ret;
> > -		struct urb *urb = priv->urb;
> > +		struct urb *urb = priv->urbs[0];
> >   		struct usbip_header pdu_header;
> >   		struct usbip_iso_packet_descriptor *iso_buffer = NULL;
> >   		struct kvec *iov = NULL;
> > +		struct scatterlist *sg;
> > +		u32 actual_length = 0;
> >   		int iovnum = 0;
> > +		int ret;
> > +		int i;
> >   		txsize = 0;
> >   		memset(&pdu_header, 0, sizeof(pdu_header));
> >   		memset(&msg, 0, sizeof(msg));
> > -		if (urb->actual_length > 0 && !urb->transfer_buffer) {
> > +		if (urb->actual_length > 0 && !urb->transfer_buffer &&
> > +		   !urb->num_sgs) {
> >   			dev_err(&sdev->udev->dev,
> >   				"urb: actual_length %d transfer_buffer null\n",
> >   				urb->actual_length);
> > @@ -176,6 +182,11 @@ static int stub_send_ret_submit(struct stub_device *sdev)
> >   		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
> >   			iovnum = 2 + urb->number_of_packets;
> > +		else if (usb_pipein(urb->pipe) && urb->actual_length > 0 &&
> > +			urb->num_sgs)
> > +			iovnum = 1 + urb->num_sgs;
> > +		else if (usb_pipein(urb->pipe) && priv->sgl)
> > +			iovnum = 1 + priv->num_urbs;
> >   		else
> >   			iovnum = 2;
> > @@ -192,6 +203,15 @@ static int stub_send_ret_submit(struct stub_device *sdev)
> >   		setup_ret_submit_pdu(&pdu_header, urb);
> >   		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
> >   				  pdu_header.base.seqnum);
> > +
> > +		if (priv->sgl) {
> > +			for (i = 0; i < priv->num_urbs; i++)
> > +				actual_length += priv->urbs[i]->actual_length;
> > +
> > +			pdu_header.u.ret_submit.status = priv->urb_status;
> > +			pdu_header.u.ret_submit.actual_length = actual_length;
> > +		}
> > +
> >   		usbip_header_correct_endian(&pdu_header, 1);
> >   		iov[iovnum].iov_base = &pdu_header;
> > @@ -200,12 +220,47 @@ static int stub_send_ret_submit(struct stub_device *sdev)
> >   		txsize += sizeof(pdu_header);
> >   		/* 2. setup transfer buffer */
> > -		if (usb_pipein(urb->pipe) &&
> > +		if (usb_pipein(urb->pipe) && priv->sgl) {
> > +			/* If the server split a single SG request into several
> > +			 * URBs because the server's HCD doesn't support SG,
> > +			 * reassemble the split URB buffers into a single
> > +			 * return command.
> > +			 */
> > +			for (i = 0; i < priv->num_urbs; i++) {
> > +				iov[iovnum].iov_base =
> > +					priv->urbs[i]->transfer_buffer;
> > +				iov[iovnum].iov_len =
> > +					priv->urbs[i]->actual_length;
> > +				iovnum++;
> > +			}
> > +			txsize += actual_length;
> > +		} else if (usb_pipein(urb->pipe) &&
> >   		    usb_pipetype(urb->pipe) != PIPE_ISOCHRONOUS &&
> >   		    urb->actual_length > 0) {
> > -			iov[iovnum].iov_base = urb->transfer_buffer;
> > -			iov[iovnum].iov_len  = urb->actual_length;
> > -			iovnum++;
> > +			if (urb->num_sgs) {
> > +				unsigned int copy = urb->actual_length;
> > +				int size;
> > +
> > +				for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> > +					if (copy == 0)
> > +						break;
> > +
> > +					if (copy < sg->length)
> > +						size = copy;
> > +					else
> > +						size = sg->length;
> > +
> > +					iov[iovnum].iov_base = sg_virt(sg);
> > +					iov[iovnum].iov_len = size;
> > +
> > +					iovnum++;
> > +					copy -= size;
> > +				}
> > +			} else {
> > +				iov[iovnum].iov_base = urb->transfer_buffer;
> > +				iov[iovnum].iov_len  = urb->actual_length;
> > +				iovnum++;
> > +			}
> >   			txsize += urb->actual_length;
> >   		} else if (usb_pipein(urb->pipe) &&
> >   			   usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
> > diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> > index 45da3e01c7b0..6532d68e8808 100644
> > --- a/drivers/usb/usbip/usbip_common.c
> > +++ b/drivers/usb/usbip/usbip_common.c
> > @@ -680,8 +680,12 @@ EXPORT_SYMBOL_GPL(usbip_pad_iso);
> >   /* some members of urb must be substituted before. */
> >   int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
> >   {
> > -	int ret;
> > +	struct scatterlist *sg;
> > +	int ret = 0;
> > +	int recv;
> >   	int size;
> > +	int copy;
> > +	int i;
> >   	if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
> >   		/* the direction of urb must be OUT. */
> > @@ -701,29 +705,48 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
> >   	if (!(size > 0))
> >   		return 0;
> > -	if (size > urb->transfer_buffer_length) {
> > +	if (size > urb->transfer_buffer_length)
> >   		/* should not happen, probably malicious packet */
> > -		if (ud->side == USBIP_STUB) {
> > -			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> > -			return 0;
> > -		} else {
> > -			usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> > -			return -EPIPE;
> > -		}
> > -	}
> > +		goto error;
> > -	ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
> > -	if (ret != size) {
> > -		dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> > -		if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
> > -			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> > -		} else {
> > -			usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> > -			return -EPIPE;
> > +	if (urb->num_sgs) {
> > +		copy = size;
> > +		for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> > +			int recv_size;
> > +
> > +			if (copy < sg->length)
> > +				recv_size = copy;
> > +			else
> > +				recv_size = sg->length;
> > +
> > +			recv = usbip_recv(ud->tcp_socket, sg_virt(sg),
> > +						recv_size);
> > +
> > +			if (recv != recv_size)
> > +				goto error;
> > +
> > +			copy -= recv;
> > +			ret += recv;
> >   		}
> > +
> > +		if (ret != size)
> > +			goto error;
> > +	} else {
> > +		ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
> > +		if (ret != size)
> > +			goto error;
> >   	}
> >   	return ret;
> > +
> > +error:
> > +	dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> > +	if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC)
> 
> Did you test VUDC and USB lowspeed cases? If you haven't please
> test those two cases for regressions.

I already tested high-speed USB 2.0 storage device along with
super-speed 3.0 device under same environment (2 machines, mismatch
situations) It works well as USB 3.0 storage device does.

I forgot to test VUDC, so I newly tested VUDC-VHCI communication
with 2 machines including mismatch situations. I used configfs usb
gadget and created two gadgets. Both use the BULK pipe.

	1. Serial gadget
	2. Mass storage gadget

  * Serial gadget test

I followed Document/usb/gadget-testing.rst.
Serial gadget on the host sends and receives data using cat command
on the /dev/ttyGS<N>.

I tested read and write operation on the client using minicom.
Serial communication between the client and the host works well.


  * Mass storage gadget test

I created mass storage gadget using configfs.
After connecting VUDC and VHCI, I tested read and write operation
of the mass storage gadget. On the client side, I used "dd" to test
read and write and I confirmed that it works well.

read command - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
write command - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1

Regards
Suwan Kim
