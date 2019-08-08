Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CDA2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565281307;
	bh=O24S8Px2VH2u7UquG4Upocrqz56r0XNx8aTpKI5r3Xw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ecHfd1wj/ygyoIYR2oiacE2vQ0xx5hIa9+scS2w49CP6aI8vInifHdQVAvrQNBQqp
	 FU4X/OiRbdC5jW+bmUfjc8E9dfH8YHIpzb5Rs+0OJ/pTbeewCDm0xb9Y3qkAg/jUg4
	 8Ipd+PkbTjQ1tZcjysAxXoU/57IC6ehNAqyFcYvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfHHQVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732446AbfHHQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:21:45 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16A9217D7;
        Thu,  8 Aug 2019 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565281303;
        bh=O24S8Px2VH2u7UquG4Upocrqz56r0XNx8aTpKI5r3Xw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rcNNShSkgLWxYkw2kDgMnq8UDrdZL8bag5LKt2PBsvxDMlbWskUGNE7MS2kyWFMj7
         Ynvjrnh2/2aYyfvO2TW3+xLHjbALBCzGHz6AYyz5xz5ttkzFGxEIPJZrDvC5sE3Uz5
         FznPZCOMSQ6vPKTkuIRc4X/2IHHVsUxDZlKcS+R4=
Subject: Re: [PATCH v5 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190808155435.10050-3-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d7377b4f-b5c7-13e4-2107-c9170f312ddf@kernel.org>
Date:   Thu, 8 Aug 2019 10:21:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808155435.10050-3-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 9:54 AM, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. In USB, each SG
> list entry buffer should be divisible by the bulk max packet size.
> But with native SG support, this problem doesn't matter because the
> SG buffer is treated as contiguous buffer. But without native SG
> support, USB storage driver breaks SG list into several URBs and the
> error occurs because of a buffer size of URB that cannot be divided
> by the bulk max packet size. The error situation is as follows.
> 
> When USB Storage driver requests 31.5 KB data and has SG list which
> has 3584 bytes buffer followed by 7 4096 bytes buffer for some
> reason. USB Storage driver splits this SG list into several URBs
> because VHCI doesn't support SG and sends them separately. So the
> first URB buffer size is 3584 bytes. When receiving data from device,
> USB 3.0 device sends data packet of 1024 bytes size because the max
> packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
> But the first URB buffer has only 3584 bytes buffer size. So host
> controller terminates the transfer even though there is more data to
> receive. So, vhci needs to support SG transfer to prevent this error.
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
> the required length of buffers using only kmalloc() regardless of
> whether vhci supports SG or not. But stub driver has to allocate
> buffer with kmalloc() as much as the total length of SG buffer which
> is quite huge when vhci sends SG request, so it has overhead in
> buffer allocation in this situation.
> 
> If stub driver needs to send data buffer to vhci because of IN pipe,
> stub driver also sends only total length of buffer as metadata and
> then sends real data as vhci does. Then vhci receive data from stub
> driver and store it to the corresponding buffer of SG list entry.
> 
> And for the case of stub driver supports SG and vhci doesn't, since
> the USB storage driver checks that vhci doesn't support SG and sends
> the request to stub driver by splitting the SG list into multiple
> URBs, stub driver allocates a buffer for each URB with kmalloc() as
> it did before this patch.
> 
> * Test environment
> 
> Test uses two difference machines and two different kernel version
> to make mismatch situation between the client and the server where
> vhci supports SG, but stub driver does not, or vice versa. All tests
> are conducted in both full SG support that both vhci and stub support
> SG and half SG support that is the mismatch situation.
> 
>   - Test kernel version
>      - 5.2-rc6 with SG support
>      - 5.1.20-200.fc29.x86_64 without SG support
> 
> * SG support test
> 
>   - Test devices
>      - Super-speed storage device - SanDisk Ultra USB 3.0
>      - High-speed storage device - SMI corporation USB 2.0 flash drive
> 
>   - Test description
> 
> Test read and write operation of mass storage device that uses the
> BULK transfer. In test, the client reads and writes files whose size
> is over 1G and it works normally.
> 
> * Regression test
> 
>   - Test devices
>      - Super-speed device - Logitech Brio webcam
>      - High-speed device - Logitech C920 HD Pro webcam
>      - Full-speed device - Logitech bluetooth mouse
>                          - Britz BR-Orion speaker
>      - Low-speed device - Logitech wired mouse
> 
>   - Test description
> 
> Moving and click test for mouse. To test the webcam, use gnome-cheese.
> To test the speaker, play music and video on the client. All works
> normally.
> 
> * VUDC compatibility test
> 
> VUDC also works well with this patch. Tests are done with two USB
> gadget created by CONFIGFS USB gadget. Both use the BULK pipe.
> 
>          1. Serial gadget
>          2. Mass storage gadget
> 
>   - Serial gadget test
> 
> Serial gadget on the host sends and receives data using cat command
> on the /dev/ttyGS<N>. The client uses minicom to communicate with
> the serial gadget.
> 
>   - Mass storage gadget test
> 
> After connecting the gadget with vhci, use "dd" to test read and
> write operation on the client side.
> 
> Read  - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
> Write - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1
> 

Thanks for including the detailed test description.

> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
> v4 - v5
> - Add the test description about SG support test and regression test
>    for other USB devices which have various speed.
> - Fix list_del() error in stub_device_cleanup_urbs()
>    - when stub_device_cleanup_urbs() calls stub_pirv_pop() to get a
>    stub_priv, stub_priv_pop() uses list_del_init() instead of
>    list_del(). After getting the stub_priv, stub_device_cleanup_urbs()
>    calls stub_free_priv_and_urb() and it checks if list of the
>    stub_priv is empty. Because stub_priv_pop() calls list_del_init(),
>    stub_free_priv_and_urb() doesn't call list_del()
> 
> v3 - v4
> - Rewrite the description about the vhci bug with USB 3.0 storage
>    device.
> - Add the description about the test with VUDC.
> - Fix the error message in stub_recv_cmd_unlink().
> 
> v2 - v3
> - Rewrite the commit log to make it more clear.
> - Add the description about the mismatch situation in commit log.
> - Run chechpatch.pl and fix errors with coding style and typos.
> - Fix the error path of usbip_recv_xbuff() to stop receiving data
>    after TCP error occurs.
> - Consolidate the duplicated error path in usbip_recv_xbuff() and
>    vhci_send_cmd_submit().
> - Undo the unnecessary changes
>    * Undo the deletion of empty line in stub_send_ret_submit()
>    * Move memset() lines in stub_send_ret_submit() to the original
>      position.
> 
> v1 - v2
> - Add the logic that splits single SG request into several URBs in
>    stub driver if server’s HC doesn’t support SG.
> ---
>   drivers/usb/usbip/stub.h         |   7 +-
>   drivers/usb/usbip/stub_main.c    |  57 ++++++---
>   drivers/usb/usbip/stub_rx.c      | 204 ++++++++++++++++++++++---------
>   drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
>   drivers/usb/usbip/usbip_common.c |  59 ++++++---
>   drivers/usb/usbip/vhci_hcd.c     |  15 ++-
>   drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
>   7 files changed, 377 insertions(+), 127 deletions(-)
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
> index 2e4bfccd4bfc..c1c0bbc9f8b1 100644
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
> @@ -281,13 +282,49 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
>   	struct stub_priv *priv, *tmp;
>   
>   	list_for_each_entry_safe(priv, tmp, listhead, list) {
> -		list_del(&priv->list);
> +		list_del_init(&priv->list);
>   		return priv;
>   	}
>   
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
> +	if (!list_empty(&priv->list))
> +		list_del(&priv->list);
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
> -
> -		kmem_cache_free(stub_priv_cache, priv);
> +		for (i = 0; i < priv->num_urbs; i++)
> +			usb_kill_urb(priv->urbs[i]);
>   
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
> index b0a855acafa3..66edfeea68fe 100644
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
> @@ -246,12 +247,14 @@ static int stub_recv_cmd_unlink(struct stub_device *sdev,
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
> +					"failed to unlink %d/%d urb of seqnum %lu, ret %d\n",
> +					i + 1, priv->num_urbs,
> +					priv->seqnum, ret);
> +		}
>   		return 0;
>   	}
>   
> @@ -433,14 +436,36 @@ static void masking_bogus_flags(struct urb *urb)
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
> @@ -449,76 +474,139 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
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
> +		usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
> +	else
> +		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
> +
> +	return -EPIPE;
>   }
>   EXPORT_SYMBOL_GPL(usbip_recv_xbuff);
>   
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index ea82b932a2f9..e64ab50cbe2b 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -697,7 +697,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>   	}
>   	vdev = &vhci_hcd->vdev[portnum-1];
>   
> -	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> +	if (!urb->transfer_buffer && !urb->num_sgs &&
> +	     urb->transfer_buffer_length) {
>   		dev_dbg(dev, "Null URB transfer buffer\n");
>   		return -EINVAL;
>   	}
> @@ -1143,6 +1144,15 @@ static int vhci_setup(struct usb_hcd *hcd)
>   		hcd->speed = HCD_USB3;
>   		hcd->self.root_hub->speed = USB_SPEED_SUPER;
>   	}
> +
> +	/*
> +	 * Support SG.
> +	 * sg_tablesize is an arbitrary value to alleviate memory pressure
> +	 * on the host.
> +	 */
> +	hcd->self.sg_tablesize = 32;
> +	hcd->self.no_sg_constraint = 1;
> +
>   	return 0;
>   }
>   
> @@ -1296,6 +1306,9 @@ static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>   		return -EINVAL;
>   	}
>   
> +	if (urb->num_sgs)
> +		urb->transfer_flags |= URB_DMA_MAP_SG;
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> index 2fa26d0578d7..865eb1276b6c 100644
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/kthread.h>
>   #include <linux/slab.h>
> +#include <linux/scatterlist.h>
>   
>   #include "usbip_common.h"
>   #include "vhci.h"
> @@ -50,19 +51,23 @@ static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
>   
>   static int vhci_send_cmd_submit(struct vhci_device *vdev)
>   {
> +	struct usbip_iso_packet_descriptor *iso_buffer = NULL;
>   	struct vhci_priv *priv = NULL;
> +	struct scatterlist *sg;
>   
>   	struct msghdr msg;
> -	struct kvec iov[3];
> +	struct kvec *iov;
>   	size_t txsize;
>   
>   	size_t total_size = 0;
> +	int iovnum;
> +	int err = -ENOMEM;
> +	int i;
>   
>   	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
>   		int ret;
>   		struct urb *urb = priv->urb;
>   		struct usbip_header pdu_header;
> -		struct usbip_iso_packet_descriptor *iso_buffer = NULL;
>   
>   		txsize = 0;
>   		memset(&pdu_header, 0, sizeof(pdu_header));
> @@ -72,18 +77,42 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>   		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
>   				  priv->seqnum);
>   
> +		if (urb->num_sgs && usb_pipeout(urb->pipe))
> +			iovnum = 2 + urb->num_sgs;
> +		else
> +			iovnum = 3;
> +
> +		iov = kcalloc(iovnum, sizeof(*iov), GFP_KERNEL);
> +		if (!iov) {
> +			usbip_event_add(&vdev->ud, SDEV_EVENT_ERROR_MALLOC);
> +			return -ENOMEM;
> +		}
> +
>   		/* 1. setup usbip_header */
>   		setup_cmd_submit_pdu(&pdu_header, urb);
>   		usbip_header_correct_endian(&pdu_header, 1);
> +		iovnum = 0;
>   
> -		iov[0].iov_base = &pdu_header;
> -		iov[0].iov_len  = sizeof(pdu_header);
> +		iov[iovnum].iov_base = &pdu_header;
> +		iov[iovnum].iov_len  = sizeof(pdu_header);
>   		txsize += sizeof(pdu_header);
> +		iovnum++;
>   
>   		/* 2. setup transfer buffer */
>   		if (!usb_pipein(urb->pipe) && urb->transfer_buffer_length > 0) {
> -			iov[1].iov_base = urb->transfer_buffer;
> -			iov[1].iov_len  = urb->transfer_buffer_length;
> +			if (urb->num_sgs &&
> +				      !usb_endpoint_xfer_isoc(&urb->ep->desc)) {
> +				for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> +					iov[iovnum].iov_base = sg_virt(sg);
> +					iov[iovnum].iov_len = sg->length;
> +					iovnum++;
> +				}
> +			} else {
> +				iov[iovnum].iov_base = urb->transfer_buffer;
> +				iov[iovnum].iov_len  =
> +						urb->transfer_buffer_length;
> +				iovnum++;
> +			}
>   			txsize += urb->transfer_buffer_length;
>   		}
>   
> @@ -95,23 +124,26 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>   			if (!iso_buffer) {
>   				usbip_event_add(&vdev->ud,
>   						SDEV_EVENT_ERROR_MALLOC);
> -				return -1;
> +				goto err_iso_buffer;
>   			}
>   
> -			iov[2].iov_base = iso_buffer;
> -			iov[2].iov_len  = len;
> +			iov[iovnum].iov_base = iso_buffer;
> +			iov[iovnum].iov_len  = len;
> +			iovnum++;
>   			txsize += len;
>   		}
>   
> -		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, 3, txsize);
> +		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum,
> +				     txsize);
>   		if (ret != txsize) {
>   			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
>   			       txsize);
> -			kfree(iso_buffer);
>   			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_TCP);
> -			return -1;
> +			err = -EPIPE;
> +			goto err_tx;
>   		}
>   
> +		kfree(iov);
>   		kfree(iso_buffer);
>   		usbip_dbg_vhci_tx("send txdata\n");
>   
> @@ -119,6 +151,13 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>   	}
>   
>   	return total_size;
> +
> +err_tx:
> +	kfree(iso_buffer);
> +err_iso_buffer:
> +	kfree(iov);
> +
> +	return err;
>   }
>   
>   static struct vhci_unlink *dequeue_from_unlink_tx(struct vhci_device *vdev)
> 

Thanks for doing this work.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
