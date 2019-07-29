Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65CCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9508F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tws5FiCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfG2Ows (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:52:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfG2Ows (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:52:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so28167587pfg.10;
        Mon, 29 Jul 2019 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P41fnf9Fdfv1/bqH+j1bd0v2b5hCraHD+dyYYVCNFrU=;
        b=Tws5FiCJi6IDlubAg2YZvcrOJiayRPo2fDkyBYXgo23/O8DO9nT9F0zdphWSPAreKZ
         wwiF5p5zAAZuEkytzAAn5uqBAvg3801qprXW3aq5dNy+fk8FnS63Wm3WBqmyOyA/AgIl
         qkAixrsGpEloCtVhm6LtoAI148/7l6daYR0vworBjUYK7W8mmwFfqAnLKAA3uKspPkyr
         U12f+9wx2gNXQoWjBDasZ7QjOtY3B0Gul+ykwOHINOtzJ6X/LxGeqToM4gNAsmEpubgQ
         z9mBtXhmIIQ6BzznI4jkNTqKA6o6xQUQQX1PK+AdhkWnFwLqXEMigkIcaV3QJ/lkecPm
         CFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P41fnf9Fdfv1/bqH+j1bd0v2b5hCraHD+dyYYVCNFrU=;
        b=lH373tNpWbynVDlEUAzgDhebJbiEL8UabkFk+XAXwE4uXubgiSWAncJrQw30RHFnH/
         E76zQHAAtME9ax7W9yraY8azB5p6ANQtq+1tZGjlXKzOoRgz3ho6q34QlzdVxGAe8F+i
         Vu/95XWww/g9GMg7QAgdqAHd/NZKlmwTeLoKyfXkvJ+PEztlfQH7Nhvt512kBKGFPmPr
         ml9v7xl34TZFucyyHPVj/+li4JAqN3RYI7D36EahW7QQwxaM+PQw+D/C8whYxCYLsnq7
         36twpb9PUdiCeY8kXdaT0UQVR7EHdxdYjCprudl19advzCfoiGgRFrm2f6f1ak//IPhp
         S9kg==
X-Gm-Message-State: APjAAAUIUEIATbEEjeCWcMSPKzZ+Y3p9R5jbo8pXfsxUvHbs0bh2X6z4
        8iYSxF/zmLMLJ8TgHXZinKY=
X-Google-Smtp-Source: APXvYqz1qg+lFlNy41Rew0BfAn3W9QmxA/9cwEHbi9MN/qonLYmu25qigUIVuNgTb2fEwdrkV4E1Yw==
X-Received: by 2002:a62:ab18:: with SMTP id p24mr37226705pff.113.1564411966735;
        Mon, 29 Jul 2019 07:52:46 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id n98sm61785108pjc.26.2019.07.29.07.52.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:52:46 -0700 (PDT)
Date:   Mon, 29 Jul 2019 23:52:41 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
Message-ID: <20190729145241.GA4557@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Tue, Jul 23, 2019 at 06:21:53PM -0600, shuah wrote:
> Hi Suwan,
> 
> On 7/5/19 10:43 AM, Suwan Kim wrote:
> > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > into multiple URBs and it causes error that a transfer got terminated
> > too early because the transfer length for one of the URBs was not
> > divisible by the maxpacket size.
> > 
> > In this patch, vhci basically support SG and it sends each SG list
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
> >   drivers/usb/usbip/usbip_common.c |  60 +++++++-- >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
> >   drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> >   7 files changed, 372 insertions(+), 121 deletions(-)
> 
> While you are working on v3 to fix chekpatch and other issues
> I pointed out, I have more for you.
> 
> What happens when you have mismatched server and client side?
> i.e stub does and vhci doesn't and vice versa.
> 
> Make sure to run checkpatch. Also check spelling errors in
> comments and your commit log.
> 
> I am not sure if your eeror paths are correct. Run usbip_test.sh
> 
> tools/testing/selftests/drivers/usb/usbip

I don't know what mismatch you mentioned. Are you saying
"match busid table" at the end of usbip_test.sh?
How does it relate to SG support of this patch?
Could you tell me more about the problem situation?

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
> > @@ -449,76 +473,143 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
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
> > +		/* If the server's HCD doesn't support SG, break a single SG
> > +		 * reqeust into several URBs and map the each SG list entry to
> request - spelling?
> 
> map each - not map the each
> 
> > +		 * the each URB buffer. The previously allocated SG list is
> 
> drop "the each" reword to "corresponding URB"

Thank you for pointing out. I will fix it.

> > +		 * stored in priv->sgl (If the server's HCD support SG, SG list
> > +		 * is stored only in urb->sg) and it is used as an indicator
> > +		 * that the server split single SG request into several URBs.
> > +		 * Later, priv->sgl is used by stub_complete() and
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
> > +			}
> > +			else {
> > +				priv->urbs[0]->transfer_buffer = buffer;
> > +			}
> > +		}
> > +
> > +		/* copy urb setup packet */
> > +		priv->urbs[0]->setup_packet = kmemdup(&pdu->u.cmd_submit.setup,
> > +					8, GFP_KERNEL);
> > +		if (!priv->urbs[0]->setup_packet) {
> > +			dev_err(&udev->dev, "allocate setup_packet\n");
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
> > +			* Pessimistic.
> > +			* This connection will be discarded.
> > +			*/
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
> > +	if (buffer)
> > +		kfree(buffer);
> 
> No need to check buffer
> 
> > +	if (sgl)
> > +		sgl_free(sgl);
> 
> No need to check sgl before calling sgl_free()

Ok.

> > +err_malloc:
> > +	usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> > +	return;
> >   }
> >   /* recv a pdu */
> > diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
> > index f0ec41a50cbc..4561147ec1a1 100644
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
> > @@ -85,6 +71,21 @@ void stub_complete(struct urb *urb)
> >   		break;
> >   	}
> > +	/* If the server break single SG reqeust into the several URBs, the
> 
> breaks instead of break
> request mispelled

Ok.

> > +	 * URBs must be reassembled before sending completed URB to the vhci.
> > +	 * Don't wake up the tx thread until all the URBs are completed.
> > +	 */
> > +	if (priv->sgl) {
> > +		priv->completed_urbs++;
> > +
> > +		/* Only save the first error status */
> > +		if (urb->status && !priv->urb_status)
> > +			priv->urb_status = urb->status;
> 
> I don't understand the saving first error status.
> 
> You could overwrite an error. urb->status could be 0?

I think that urb->status can be overwritten with different values in
error situations. For example, in a situation where a single SG
request is split into multiple URBs in stub driver, the endpoint can
be stalled with an error in any intermediate URB.

The URB with the error has specific error status which tells us the
exact error situation, but the other URBs can have different error
state which indicates just endpoint stall.

Stub driver should reassemble these URBs and send exact error status
to vhci. So I save the first error status. My thoughts may be wrong.
Please let me know if something goes wrong.

> > +
> > +		if (priv->completed_urbs != priv->num_urbs)
> > +			return;
> 
> What happens when some urbs don't make it? What happens if
> priv->completed_urbs > priv->num_urbs

Complete function of URB is called even if URB fails. So I think
priv->completed_urbs counts normally, whether urb succeeds or fails.
I am going to modify "priv->completed_urbs != priv->num_urbs" to
"priv-> completed_urbs! = Priv-> num_urbs.

> > +	}
> > +
> >   	/* link a urb to the queue of tx. */
> >   	spin_lock_irqsave(&sdev->priv_lock, flags);
> >   	if (sdev->ud.tcp_socket == NULL) {
> > @@ -149,33 +150,40 @@ static int stub_send_ret_submit(struct stub_device *sdev)
> >   {
> >   	unsigned long flags;
> >   	struct stub_priv *priv, *tmp;
> > -
> 
> Don't delete the empty line used for groupong the variables.
> 
> >   	struct msghdr msg;
> >   	size_t txsize;
> > -
> 
> Don't delete the empty line used for groupong the variables.
> Not worth combining with this patch.

Ok. I'm sorry for that.

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
> > -		txsize = 0;
> > -		memset(&pdu_header, 0, sizeof(pdu_header));
> > -		memset(&msg, 0, sizeof(msg));
> > -
> > -		if (urb->actual_length > 0 && !urb->transfer_buffer) {
> > +		if (urb->actual_length > 0 && !urb->transfer_buffer &&
> > +		   !urb->num_sgs) {
> 
> Here you check for !urb->num_sgs and the code below usb_pipetype()
> seems to indicate num_sgs can be 0.
> 
> >   			dev_err(&sdev->udev->dev,
> >   				"urb: actual_length %d transfer_buffer null\n",
> >   				urb->actual_length);
> >   			return -1;
> >   		}
> > +		txsize = 0;
> > +		memset(&pdu_header, 0, sizeof(pdu_header));
> > +		memset(&msg, 0, sizeof(msg));
> > +
> 
> Why did you move these lines? It makes it hard to review the patch.
> This change isn't necessary for what you are doing. I just want to
> see the changes for sg support.

I'm sorry. I will undo what I changed.

> >   		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
> >   			iovnum = 2 + urb->number_of_packets;
> > +		else if (usb_pipein(urb->pipe) && urb->actual_length > 0
> > +				&& urb->num_sgs)
> > +			iovnum = 1 + urb->num_sgs;
> > +		else if (usb_pipein(urb->pipe) && priv->sgl)
> > +			iovnum = 1 + priv->num_urbs;
> >   		else
> >   			iovnum = 2;
> 
> Can num_sgs be 0 here. See comment above where you check valid urb case.
> There is a diconnect here?

urb-> transfer_buffer and urb-> num_sgs are different in their usage.
If a driver uses a normal buffer instead of SG, it uses transfer
buffer and num_sgs is set to 0. However, if the driver uses SG buffer,
urb->num_sgs and urb->sg are used and urb->transfer_buffer is set to
NULL.

Other usb codes use urb->num_sgs or urb->num_mapped_urb as the SG
usage indicator. So the above code that checks URB buffer validation
decides that if transfer_buffer and num_sgs is all 0, there is no
buffer. Considering that, I think this code is not a problem.

> > @@ -192,6 +200,15 @@ static int stub_send_ret_submit(struct stub_device *sdev)
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
> > @@ -200,12 +217,47 @@ static int stub_send_ret_submit(struct stub_device *sdev)
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
> > +				for_each_sg(urb->sg, sg, urb->num_sgs ,i) {
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
> > index 45da3e01c7b0..6affbfcfc927 100644
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
> > @@ -712,14 +716,52 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
> >   		}
> >   	}
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
> > +			if (recv != recv_size) {
> > +				dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> > +				if (ud->side == USBIP_STUB ||
> > +				    ud->side == USBIP_VUDC) {
> > +					usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> 
> This doesn't look right. You continue to send after adding
> SDEV_EVENT_ERROR_TCP ?? Shouldn't you bail out instead?

This is my fault. I will fix it.

> > +				} else {
> > +					usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> > +					return -EPIPE;
> > +				}
> > +			}
> > +			copy -= recv;
> > +			ret += recv;
> > +		}
> > +
> > +		if (ret != size) {
> > +			dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> > +			if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
> > +				usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> > +			} else {
> > +				usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> > +				return -EPIPE;
> > +			}
> > +		}
> 
> Get rid of the duplicate code block for usbip_recv() error paths.
> 
> > +	} else {
> > +		ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
> > +		if (ret != size) {
> > +			dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> > +			if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
> > +				usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> > +			} else {
> > +				usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> > +				return -EPIPE;
> > +			}
> >   		}
> 
> Get rid of the duplicate code block for usbip_recv() error paths.
> There are 3 now and the above in the loop doesn't look right.

Ok, I will get rid of the duplication.

> >   	}
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 14fc6d9f4e6a..b5fe85adb42b 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -697,7 +697,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
> >   	}
> >   	vdev = &vhci_hcd->vdev[portnum-1];
> > -	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> > +	if (!urb->transfer_buffer && !urb->num_sgs &&
> > +	     urb->transfer_buffer_length) {
> 
> Is there a case where transfer_buffer is valid without any num_sgs?

num_sgs must always be 0 for transfer_buffer to be valid.

> >   		dev_dbg(dev, "Null URB transfer buffer\n");
> >   		return -EINVAL;
> >   	}
> > @@ -1143,6 +1144,13 @@ static int vhci_setup(struct usb_hcd *hcd)
> >   		hcd->speed = HCD_USB3;
> >   		hcd->self.root_hub->speed = USB_SPEED_SUPER;
> >   	}
> > +
> > +	/* support SG.
> > +	 * sg_tablesize is an arbitrary vaule to alleviate memory pressure
> > +	 * on the host. */
> > +	hcd->self.sg_tablesize = 32;
> > +	hcd->self.no_sg_constraint = 1;
> > +
> >   	return 0;
> >   }
> > diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> > index 2fa26d0578d7..3472180f5af8 100644
> > --- a/drivers/usb/usbip/vhci_tx.c
> > +++ b/drivers/usb/usbip/vhci_tx.c
> > @@ -5,6 +5,7 @@
> >   #include <linux/kthread.h>
> >   #include <linux/slab.h>
> > +#include <linux/scatterlist.h>
> >   #include "usbip_common.h"
> >   #include "vhci.h"
> > @@ -51,12 +52,13 @@ static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
> >   static int vhci_send_cmd_submit(struct vhci_device *vdev)
> >   {
> >   	struct vhci_priv *priv = NULL;
> > -
> > +	struct scatterlist *sg;
> >   	struct msghdr msg;
> > -	struct kvec iov[3];
> > +	struct kvec *iov;
> >   	size_t txsize;
> > -
> >   	size_t total_size = 0;
> > +	int iovnum;
> > +	int i;
> >   	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
> >   		int ret;
> > @@ -72,18 +74,41 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
> >   		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
> >   				  priv->seqnum);
> > +		if (urb->num_sgs && usb_pipeout(urb->pipe))
> > +			iovnum = 2 + urb->num_sgs;
> 
> Don't you want to do some kind of range check on num_sgs?

I don't think I need it. I have not seen the code that checks the
range of num_sgs.

> > +		else
> > +			iovnum = 3;
> > +
> > +		iov = kzalloc(iovnum * sizeof(*iov), GFP_KERNEL);
> > +		if (!iov) {
> > +			usbip_event_add(&vdev->ud,
> > +						SDEV_EVENT_ERROR_MALLOC);
> > +			return -ENOMEM;
> > +		}
> > +
> >   		/* 1. setup usbip_header */
> >   		setup_cmd_submit_pdu(&pdu_header, urb);
> >   		usbip_header_correct_endian(&pdu_header, 1);
> > +		iovnum = 0;
> > -		iov[0].iov_base = &pdu_header;
> > -		iov[0].iov_len  = sizeof(pdu_header);
> > +		iov[iovnum].iov_base = &pdu_header;
> > +		iov[iovnum].iov_len  = sizeof(pdu_header);
> >   		txsize += sizeof(pdu_header);
> > +		iovnum++;
> >   		/* 2. setup transfer buffer */
> >   		if (!usb_pipein(urb->pipe) && urb->transfer_buffer_length > 0) {
> > -			iov[1].iov_base = urb->transfer_buffer;
> > -			iov[1].iov_len  = urb->transfer_buffer_length;
> > +			if (urb->num_sgs && !usb_endpoint_xfer_isoc(&urb->ep->desc)) {
> > +				for_each_sg(urb->sg, sg, urb->num_sgs ,i) {
> > +					iov[iovnum].iov_base = sg_virt(sg);
> > +					iov[iovnum].iov_len = sg->length;
> > +					iovnum++;
> > +				}
> > +			} else {
> > +				iov[iovnum].iov_base = urb->transfer_buffer;
> > +				iov[iovnum].iov_len  = urb->transfer_buffer_length;
> > +				iovnum++;
> 
> You would have allocated 2 + urb->num_sgs for the isochronous
> case as well and not use them?

Isoc pipe doesn't use SG (only urb->transfer_buffer is used).
So iovnum = 3 in the above conditional.

In usb_hcd_map_urb_for_dma(), it checks whether isoc pipe uses SG,
and I will also add this logic to vhci_map_urb_for_dma() of patch 1.

> > +			}
> >   			txsize += urb->transfer_buffer_length;
> >   		}
> > @@ -93,25 +118,29 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
> >   			iso_buffer = usbip_alloc_iso_desc_pdu(urb, &len);
> >   			if (!iso_buffer) {
> > +				kfree(iov);
> 
> Consolidate error handling for kfree(iov)
> 
> >   				usbip_event_add(&vdev->ud,
> >   						SDEV_EVENT_ERROR_MALLOC);
> >   				return -1;
> >   			}
> > -			iov[2].iov_base = iso_buffer;
> > -			iov[2].iov_len  = len;
> > +			iov[iovnum].iov_base = iso_buffer;
> > +			iov[iovnum].iov_len  = len;
> > +			iovnum++;
> >   			txsize += len;
> >   		}
> > -		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, 3, txsize);
> > +		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum, txsize);
> >   		if (ret != txsize) {
> >   			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
> >   			       txsize);
> > +			kfree(iov);
> >   			kfree(iso_buffer);
> 
> Consolidate error handling for kfree(iov) and kfree(iso_buffer)

Ok.

Regards
Suwan Kim
