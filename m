Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A9C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05E020449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564785718;
	bh=axZWqy241MK77tG5+dPiSYXWM1c0j2dHoV1lj7KPFqg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jzafNRneQ5834Lj/V5L5PNMM1avw+LIPenPTUkikcfCUOWmkW9TqOabrxBqlFVSVm
	 JwBPxhYiY0wCABxUhbzIA8yzpoBuJZTZGAkpBfS8HKoEMKybo35WZ2Zdas6wTBt+xS
	 yMhG+57DlwUJcTlgQFyS11E4XC2NsMZ1ZPNz1Dlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437286AbfHBWl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437252AbfHBWl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:41:56 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5014920449;
        Fri,  2 Aug 2019 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564785713;
        bh=axZWqy241MK77tG5+dPiSYXWM1c0j2dHoV1lj7KPFqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E9cRmQ2cpDKhTpxrxU968gEXzZ5kZrMZCBuC0hUtGAS0jfqtkdtilGedkahwVpa6z
         9f8gEvv767zwaJTBSvsp9G1J0wc/r6zpI8pl8lxreKJ7qxmBRu4ZNj2ePDjMZDfFxQ
         T7rAAzVvOvXLu6yn5Uw9dpAZWyH1XgNpEQ9OT1FU=
Subject: Re: [PATCH v3 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
 <20190802173651.22247-3-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <43f32889-0117-cd94-2494-23ab29be6ca8@kernel.org>
Date:   Fri, 2 Aug 2019 16:41:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802173651.22247-3-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suwan,

On 8/2/19 11:36 AM, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. 

This sentence doesn't make sense to me. What bugs? Ca you eloborate?

Currently, vhci
> doesn't supported SG, so USB storage driver on vhci breaks SG list
> into multiple URBs and it causes error that a transfer got terminated
> too early because the transfer length for one of the URBs was not
> divisible by the maxpacket size.
> 
> In this patch, vhci supports SG regardless of whether the server's
> host controller supports SG or not, because stub driver splits SG
> list into several URBs if the server's host controller doesn't
> support SG.
> 
> To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> urb->transfer_flags if URB has SG list and this flag will tell stub
> driver to use SG list.
> 
> vhci sends each SG list entry to stub driver. Then, stub driver sees
> the total length of the buffer and allocates SG table and pages
> according to the total buffer length calling sgl_alloc(). After stub
> driver receives completed URB, it again sends each SG list entry to
> vhci.
> 
> If the server's host controller doesn't support SG, stub driver
> breaks a single SG request into several URBs and submits them to
> the server's host controller. When all the split URBs are completed,
> stub driver reassembles the URBs into a single return command and
> sends it to vhci.
> 
> Moreover, in the situation where vhci supports SG, but stub driver
> does not, or vice versa, usbip works normally. Because there is no
> protocol modification, there is no problem in communication between
> server and client even if the one has a kernel without SG support.
> 
> In the case of vhci supports SG and stub driver doesn't, because
> vhci sends only the total length of the buffer to stub driver as
> it did before the patch applied, stub driver only needs to allocate
> the required length of buffers regardless of whether vhci supports
> SG or not.
> 
> If stub driver needs to send data buffer to vhci because of IN pipe,
> stub driver also sends only total length of buffer as metadata and
> then sends real data as vhci does. Then vhci receive data from stub
> driver and store it to the corresponding buffer of SG list entry.
> 
> In the case of stub driver that supports SG, buffer is allocated by
> sgl_alloc(). However, stub driver that does not support SG allocates
> buffer using only kmalloc(). Therefore, if vhci supports SG and stub
> driver doesn't, stub driver has to allocate buffer with kmalloc() as
> much as the total length of SG buffer which is quite huge when vhci
> sends SG request, so it has big overhead in buffer allocation.
> 
> And for the case of stub driver supports SG and vhci doesn't, since
> the USB storage driver checks that vhci doesn't support SG and sends
> the request to stub driver by splitting the SG list into multiple
> URBs, stub driver allocates a buffer with kmalloc() as it did before
> this patch.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---

Please add patch revision history to help reviews. What did you
change in this patch from previous version.


>   drivers/usb/usbip/stub.h         |   7 +-
>   drivers/usb/usbip/stub_main.c    |  55 ++++++---
>   drivers/usb/usbip/stub_rx.c      | 203 ++++++++++++++++++++++---------
>   drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
>   drivers/usb/usbip/usbip_common.c |  59 ++++++---
>   drivers/usb/usbip/vhci_hcd.c     |  15 ++-
>   drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
>   7 files changed, 375 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
> index 35618ceb2791..d11270560c24 100644
> --- a/drivers/usb/usbip/stub.h
> +++ b/drivers/usb/usbip/stub.h
> @@ -52,7 +52,11 @@ struct stub_priv {
>   	unsigned long seqnum;
>   	struct list_head list;
>   	struct stub_device *sdev;
> -	struct urb *urb;
> +	struct urb **urbs;
> +	struct scatterlist *sgl;
> +	int num_urbs;
> +	int completed_urbs;
> +	int urb_status;
>   
>   	int unlinking;
>   };
> @@ -86,6 +90,7 @@ extern struct usb_device_driver stub_driver;
>   struct bus_id_priv *get_busid_priv(const char *busid);
>   void put_busid_priv(struct bus_id_priv *bid);
>   int del_match_busid(char *busid);
> +void stub_free_priv_and_urb(struct stub_priv *priv);
>   void stub_device_cleanup_urbs(struct stub_device *sdev);
>   
>   /* stub_rx.c */
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 2e4bfccd4bfc..3ee636215e9c 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -6,6 +6,7 @@
>   #include <linux/string.h>
>   #include <linux/module.h>
>   #include <linux/device.h>
> +#include <linux/scatterlist.h>
>   
>   #include "usbip_common.h"
>   #include "stub.h"
> @@ -288,6 +289,42 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
>   	return NULL;
>   }
>   
> +void stub_free_priv_and_urb(struct stub_priv *priv)
> +{
> +	struct urb *urb;
> +	int i;
> +
> +	for (i = 0; i < priv->num_urbs; i++) {
> +		urb = priv->urbs[i];
> +
> +		if (!urb)
> +			return;
> +
> +		kfree(urb->setup_packet);
> +		urb->setup_packet = NULL;
> +
> +
> +		if (urb->transfer_buffer && !priv->sgl) {
> +			kfree(urb->transfer_buffer);
> +			urb->transfer_buffer = NULL;
> +		}
> +
> +		if (urb->num_sgs) {
> +			sgl_free(urb->sg);
> +			urb->sg = NULL;
> +			urb->num_sgs = 0;
> +		}
> +
> +		usb_free_urb(urb);
> +	}
> +
> +	list_del(&priv->list);
> +	if (priv->sgl)
> +		sgl_free(priv->sgl);
> +	kfree(priv->urbs);
> +	kmem_cache_free(stub_priv_cache, priv);
> +}
> +
>   static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
>   {
>   	unsigned long flags;
> @@ -314,25 +351,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
>   void stub_device_cleanup_urbs(struct stub_device *sdev)
>   {
>   	struct stub_priv *priv;
> -	struct urb *urb;
> +	int i;
>   
>   	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
>   
>   	while ((priv = stub_priv_pop(sdev))) {
> -		urb = priv->urb;
> -		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
> -			priv->seqnum);
> -		usb_kill_urb(urb);
> +		for (i = 0; i < priv->num_urbs; i++)
> +			usb_kill_urb(priv->urbs[i]);
>   
> -		kmem_cache_free(stub_priv_cache, priv);
> -
> -		kfree(urb->transfer_buffer);
> -		urb->transfer_buffer = NULL;
> -
> -		kfree(urb->setup_packet);
> -		urb->setup_packet = NULL;
> -
> -		usb_free_urb(urb);
> +		stub_free_priv_and_urb(priv);
>   	}
>   }
>   
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index b0a855acafa3..7630012f6827 100644
> --- a/drivers/usb/usbip/stub_rx.c
> +++ b/drivers/usb/usbip/stub_rx.c
> @@ -7,6 +7,7 @@
>   #include <linux/kthread.h>
>   #include <linux/usb.h>
>   #include <linux/usb/hcd.h>
> +#include <linux/scatterlist.h>
>   
>   #include "usbip_common.h"
>   #include "stub.h"
> @@ -201,7 +202,7 @@ static void tweak_special_requests(struct urb *urb)
>   static int stub_recv_cmd_unlink(struct stub_device *sdev,
>   				struct usbip_header *pdu)
>   {
> -	int ret;
> +	int ret, i;
>   	unsigned long flags;
>   	struct stub_priv *priv;
>   
> @@ -246,12 +247,13 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
>   		 * so a driver in a client host will know the failure
>   		 * of the unlink request ?
>   		 */
> -		ret = usb_unlink_urb(priv->urb);
> -		if (ret != -EINPROGRESS)
> -			dev_err(&priv->urb->dev->dev,
> -				"failed to unlink a urb # %lu, ret %d\n",
> -				priv->seqnum, ret);
> -
> +		for (i = priv->completed_urbs; i < priv->num_urbs; i++) {
> +			ret = usb_unlink_urb(priv->urbs[i]);
> +			if (ret != -EINPROGRESS)
> +				dev_err(&priv->urbs[i]->dev->dev,
> +					"failed to unlink a urb # %lu, ret %d\n",
> +					priv->seqnum, ret);

I am concerned about printing this message in this loop. It made sense
when there is just one urb.

> +		}
>   		return 0;
>   	}
>   
> @@ -433,14 +435,36 @@ static void masking_bogus_flags(struct urb *urb)
>   	urb->transfer_flags &= allowed;
>   }
>   
> +static int stub_recv_xbuff(struct usbip_device *ud, struct stub_priv *priv)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < priv->num_urbs; i++) {
> +		ret = usbip_recv_xbuff(ud, priv->urbs[i]);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>   static void stub_recv_cmd_submit(struct stub_device *sdev,
>   				 struct usbip_header *pdu)
>   {
> -	int ret;
>   	struct stub_priv *priv;
>   	struct usbip_device *ud = &sdev->ud;
>   	struct usb_device *udev = sdev->udev;
> +	struct scatterlist *sgl = NULL, *sg;
> +	void *buffer = NULL;
> +	unsigned long long buf_len;
> +	int nents;
> +	int num_urbs = 1;
>   	int pipe = get_pipe(sdev, pdu);
> +	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> +	int support_sg = 1;
> +	int np = 0;
> +	int ret, i;
>   
>   	if (pipe == -1)
>   		return;
> @@ -449,76 +473,139 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>   	if (!priv)
>   		return;
>   
> -	/* setup a urb */
> -	if (usb_pipeisoc(pipe))
> -		priv->urb = usb_alloc_urb(pdu->u.cmd_submit.number_of_packets,
> -					  GFP_KERNEL);
> -	else
> -		priv->urb = usb_alloc_urb(0, GFP_KERNEL);
> +	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
>   
> -	if (!priv->urb) {
> -		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> -		return;
> +	/* allocate urb transfer buffer, if needed */
> +	if (buf_len) {
> +		if (use_sg) {
> +			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> +			if (!sgl)
> +				goto err_malloc;
> +		} else {
> +			buffer = kzalloc(buf_len, GFP_KERNEL);
> +			if (!buffer)
> +				goto err_malloc;
> +		}
>   	}
>   
> -	/* allocate urb transfer buffer, if needed */
> -	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
> -		priv->urb->transfer_buffer =
> -			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
> -				GFP_KERNEL);
> -		if (!priv->urb->transfer_buffer) {
> +	/* Check if the server's HCD supports SG */
> +	if (use_sg && !udev->bus->sg_tablesize) {
> +		/*
> +		 * If the server's HCD doesn't support SG, break a single SG
> +		 * request into several URBs and map each SG list entry to
> +		 * corresponding URB buffer. The previously allocated SG
> +		 * list is stored in priv->sgl (If the server's HCD support SG,
> +		 * SG list is stored only in urb->sg) and it is used as an
> +		 * indicator that the server split single SG request into
> +		 * several URBs. Later, priv->sgl is used by stub_complete() and
> +		 * stub_send_ret_submit() to reassemble the divied URBs.
> +		 */
> +		support_sg = 0;
> +		num_urbs = nents;
> +		priv->completed_urbs = 0;
> +		pdu->u.cmd_submit.transfer_flags &= ~URB_DMA_MAP_SG;
> +	}
> +
> +	/* allocate urb array */
> +	priv->num_urbs = num_urbs;
> +	priv->urbs = kmalloc_array(num_urbs, sizeof(*priv->urbs), GFP_KERNEL);
> +	if (!priv->urbs)
> +		goto err_urbs;
> +
> +	/* setup a urb */
> +	if (support_sg) {
> +		if (usb_pipeisoc(pipe))
> +			np = pdu->u.cmd_submit.number_of_packets;
> +
> +		priv->urbs[0] = usb_alloc_urb(np, GFP_KERNEL);
> +		if (!priv->urbs[0])
> +			goto err_urb;
> +
> +		if (buf_len) {
> +			if (use_sg) {
> +				priv->urbs[0]->sg = sgl;
> +				priv->urbs[0]->num_sgs = nents;
> +				priv->urbs[0]->transfer_buffer = NULL;
> +			} else {
> +				priv->urbs[0]->transfer_buffer = buffer;
> +			}
> +		}
> +
> +		/* copy urb setup packet */
> +		priv->urbs[0]->setup_packet = kmemdup(&pdu->u.cmd_submit.setup,
> +					8, GFP_KERNEL);
> +		if (!priv->urbs[0]->setup_packet) {
>   			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
>   			return;
>   		}
> -	}
>   
> -	/* copy urb setup packet */
> -	priv->urb->setup_packet = kmemdup(&pdu->u.cmd_submit.setup, 8,
> -					  GFP_KERNEL);
> -	if (!priv->urb->setup_packet) {
> -		dev_err(&udev->dev, "allocate setup_packet\n");
> -		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
> -		return;
> +		usbip_pack_pdu(pdu, priv->urbs[0], USBIP_CMD_SUBMIT, 0);
> +	} else {
> +		for_each_sg(sgl, sg, nents, i) {
> +			priv->urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
> +			/* The URBs which is previously allocated will be freed
> +			 * in stub_device_cleanup_urbs() if error occurs.
> +			 */
> +			if (!priv->urbs[i])
> +				goto err_urb;
> +
> +			usbip_pack_pdu(pdu, priv->urbs[i], USBIP_CMD_SUBMIT, 0);
> +			priv->urbs[i]->transfer_buffer = sg_virt(sg);
> +			priv->urbs[i]->transfer_buffer_length = sg->length;
> +		}
> +		priv->sgl = sgl;
>   	}
>   
> -	/* set other members from the base header of pdu */
> -	priv->urb->context                = (void *) priv;
> -	priv->urb->dev                    = udev;
> -	priv->urb->pipe                   = pipe;
> -	priv->urb->complete               = stub_complete;
> +	for (i = 0; i < num_urbs; i++) {
> +		/* set other members from the base header of pdu */
> +		priv->urbs[i]->context = (void *) priv;
> +		priv->urbs[i]->dev = udev;
> +		priv->urbs[i]->pipe = pipe;
> +		priv->urbs[i]->complete = stub_complete;
>   
> -	usbip_pack_pdu(pdu, priv->urb, USBIP_CMD_SUBMIT, 0);
> +		/* no need to submit an intercepted request, but harmless? */
> +		tweak_special_requests(priv->urbs[i]);
>   
> +		masking_bogus_flags(priv->urbs[i]);
> +	}
>   
> -	if (usbip_recv_xbuff(ud, priv->urb) < 0)
> +	if (stub_recv_xbuff(ud, priv) < 0)
>   		return;
>   
> -	if (usbip_recv_iso(ud, priv->urb) < 0)
> +	if (usbip_recv_iso(ud, priv->urbs[0]) < 0)
>   		return;
>   
> -	/* no need to submit an intercepted request, but harmless? */
> -	tweak_special_requests(priv->urb);
> -
> -	masking_bogus_flags(priv->urb);
>   	/* urb is now ready to submit */
> -	ret = usb_submit_urb(priv->urb, GFP_KERNEL);
> -
> -	if (ret == 0)
> -		usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> -				  pdu->base.seqnum);
> -	else {
> -		dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> -		usbip_dump_header(pdu);
> -		usbip_dump_urb(priv->urb);
> -
> -		/*
> -		 * Pessimistic.
> -		 * This connection will be discarded.
> -		 */
> -		usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> +	for (i = 0; i < priv->num_urbs; i++) {
> +		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
> +
> +		if (ret == 0)
> +			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> +					pdu->base.seqnum);
> +		else {
> +			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> +			usbip_dump_header(pdu);
> +			usbip_dump_urb(priv->urbs[i]);
> +
> +			/*
> +			 * Pessimistic.
> +			 * This connection will be discarded.
> +			 */
> +			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> +			break;
> +		}
>   	}
>   
>   	usbip_dbg_stub_rx("Leave\n");
> +	return;
> +
> +err_urb:
> +	kfree(priv->urbs);
> +err_urbs:
> +	kfree(buffer);
> +	sgl_free(sgl);
> +err_malloc:
> +	usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
>   }
>   
>   /* recv a pdu */
> diff --git a/drivers/usb/usbip/stub_tx.c b/drivers/usb/usbip/stub_tx.c
> index f0ec41a50cbc..36010a82b359 100644
> --- a/drivers/usb/usbip/stub_tx.c
> +++ b/drivers/usb/usbip/stub_tx.c
> @@ -5,25 +5,11 @@
>   
>   #include <linux/kthread.h>
>   #include <linux/socket.h>
> +#include <linux/scatterlist.h>
>   
>   #include "usbip_common.h"
>   #include "stub.h"
>   
> -static void stub_free_priv_and_urb(struct stub_priv *priv)
> -{
> -	struct urb *urb = priv->urb;
> -
> -	kfree(urb->setup_packet);
> -	urb->setup_packet = NULL;
> -
> -	kfree(urb->transfer_buffer);
> -	urb->transfer_buffer = NULL;
> -
> -	list_del(&priv->list);
> -	kmem_cache_free(stub_priv_cache, priv);
> -	usb_free_urb(urb);
> -}
> -
>   /* be in spin_lock_irqsave(&sdev->priv_lock, flags) */
>   void stub_enqueue_ret_unlink(struct stub_device *sdev, __u32 seqnum,
>   			     __u32 status)
> @@ -85,6 +71,22 @@ void stub_complete(struct urb *urb)
>   		break;
>   	}
>   
> +	/*
> +	 * If the server breaks single SG request into the several URBs, the
> +	 * URBs must be reassembled before sending completed URB to the vhci.
> +	 * Don't wake up the tx thread until all the URBs are completed.
> +	 */
> +	if (priv->sgl) {
> +		priv->completed_urbs++;
> +
> +		/* Only save the first error status */
> +		if (urb->status && !priv->urb_status)
> +			priv->urb_status = urb->status;
> +
> +		if (priv->completed_urbs < priv->num_urbs)
> +			return;
> +	}
> +
>   	/* link a urb to the queue of tx. */
>   	spin_lock_irqsave(&sdev->priv_lock, flags);
>   	if (sdev->ud.tcp_socket == NULL) {
> @@ -156,18 +158,22 @@ static int stub_send_ret_submit(struct stub_device *sdev)
>   	size_t total_size = 0;
>   
>   	while ((priv = dequeue_from_priv_tx(sdev)) != NULL) {
> -		int ret;
> -		struct urb *urb = priv->urb;
> +		struct urb *urb = priv->urbs[0];
>   		struct usbip_header pdu_header;
>   		struct usbip_iso_packet_descriptor *iso_buffer = NULL;
>   		struct kvec *iov = NULL;
> +		struct scatterlist *sg;
> +		u32 actual_length = 0;
>   		int iovnum = 0;
> +		int ret;
> +		int i;
>   
>   		txsize = 0;
>   		memset(&pdu_header, 0, sizeof(pdu_header));
>   		memset(&msg, 0, sizeof(msg));
>   
> -		if (urb->actual_length > 0 && !urb->transfer_buffer) {
> +		if (urb->actual_length > 0 && !urb->transfer_buffer &&
> +		   !urb->num_sgs) {
>   			dev_err(&sdev->udev->dev,
>   				"urb: actual_length %d transfer_buffer null\n",
>   				urb->actual_length);
> @@ -176,6 +182,11 @@ static int stub_send_ret_submit(struct stub_device *sdev)
>   
>   		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
>   			iovnum = 2 + urb->number_of_packets;
> +		else if (usb_pipein(urb->pipe) && urb->actual_length > 0 &&
> +			urb->num_sgs)
> +			iovnum = 1 + urb->num_sgs;
> +		else if (usb_pipein(urb->pipe) && priv->sgl)
> +			iovnum = 1 + priv->num_urbs;
>   		else
>   			iovnum = 2;
>   
> @@ -192,6 +203,15 @@ static int stub_send_ret_submit(struct stub_device *sdev)
>   		setup_ret_submit_pdu(&pdu_header, urb);
>   		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
>   				  pdu_header.base.seqnum);
> +
> +		if (priv->sgl) {
> +			for (i = 0; i < priv->num_urbs; i++)
> +				actual_length += priv->urbs[i]->actual_length;
> +
> +			pdu_header.u.ret_submit.status = priv->urb_status;
> +			pdu_header.u.ret_submit.actual_length = actual_length;
> +		}
> +
>   		usbip_header_correct_endian(&pdu_header, 1);
>   
>   		iov[iovnum].iov_base = &pdu_header;
> @@ -200,12 +220,47 @@ static int stub_send_ret_submit(struct stub_device *sdev)
>   		txsize += sizeof(pdu_header);
>   
>   		/* 2. setup transfer buffer */
> -		if (usb_pipein(urb->pipe) &&
> +		if (usb_pipein(urb->pipe) && priv->sgl) {
> +			/* If the server split a single SG request into several
> +			 * URBs because the server's HCD doesn't support SG,
> +			 * reassemble the split URB buffers into a single
> +			 * return command.
> +			 */
> +			for (i = 0; i < priv->num_urbs; i++) {
> +				iov[iovnum].iov_base =
> +					priv->urbs[i]->transfer_buffer;
> +				iov[iovnum].iov_len =
> +					priv->urbs[i]->actual_length;
> +				iovnum++;
> +			}
> +			txsize += actual_length;
> +		} else if (usb_pipein(urb->pipe) &&
>   		    usb_pipetype(urb->pipe) != PIPE_ISOCHRONOUS &&
>   		    urb->actual_length > 0) {
> -			iov[iovnum].iov_base = urb->transfer_buffer;
> -			iov[iovnum].iov_len  = urb->actual_length;
> -			iovnum++;
> +			if (urb->num_sgs) {
> +				unsigned int copy = urb->actual_length;
> +				int size;
> +
> +				for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> +					if (copy == 0)
> +						break;
> +
> +					if (copy < sg->length)
> +						size = copy;
> +					else
> +						size = sg->length;
> +
> +					iov[iovnum].iov_base = sg_virt(sg);
> +					iov[iovnum].iov_len = size;
> +
> +					iovnum++;
> +					copy -= size;
> +				}
> +			} else {
> +				iov[iovnum].iov_base = urb->transfer_buffer;
> +				iov[iovnum].iov_len  = urb->actual_length;
> +				iovnum++;
> +			}
>   			txsize += urb->actual_length;
>   		} else if (usb_pipein(urb->pipe) &&
>   			   usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> index 45da3e01c7b0..6532d68e8808 100644
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -680,8 +680,12 @@ EXPORT_SYMBOL_GPL(usbip_pad_iso);
>   /* some members of urb must be substituted before. */
>   int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
>   {
> -	int ret;
> +	struct scatterlist *sg;
> +	int ret = 0;
> +	int recv;
>   	int size;
> +	int copy;
> +	int i;
>   
>   	if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
>   		/* the direction of urb must be OUT. */
> @@ -701,29 +705,48 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct urb *urb)
>   	if (!(size > 0))
>   		return 0;
>   
> -	if (size > urb->transfer_buffer_length) {
> +	if (size > urb->transfer_buffer_length)
>   		/* should not happen, probably malicious packet */
> -		if (ud->side == USBIP_STUB) {
> -			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> -			return 0;
> -		} else {
> -			usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> -			return -EPIPE;
> -		}
> -	}
> +		goto error;
>   
> -	ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
> -	if (ret != size) {
> -		dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> -		if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC) {
> -			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> -		} else {
> -			usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> -			return -EPIPE;
> +	if (urb->num_sgs) {
> +		copy = size;
> +		for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> +			int recv_size;
> +
> +			if (copy < sg->length)
> +				recv_size = copy;
> +			else
> +				recv_size = sg->length;
> +
> +			recv = usbip_recv(ud->tcp_socket, sg_virt(sg),
> +						recv_size);
> +
> +			if (recv != recv_size)
> +				goto error;
> +
> +			copy -= recv;
> +			ret += recv;
>   		}
> +
> +		if (ret != size)
> +			goto error;
> +	} else {
> +		ret = usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
> +		if (ret != size)
> +			goto error;
>   	}
>   
>   	return ret;
> +
> +error:
> +	dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
> +	if (ud->side == USBIP_STUB || ud->side == USBIP_VUDC)

Did you test VUDC and USB lowspeed cases? If you haven't please
test those two cases for regressions.

thanks,
-- Shuah

