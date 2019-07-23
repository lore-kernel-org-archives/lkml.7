Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA64C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90121E70
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563853894;
	bh=ZA2huNrm/Js6SetgIwTYXcWDIB/pZg6enTjORSOj3c0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dDEIS+yrlhX/8sJGOEJp/d7292DB9kBpZ0GtZPQYsUb/nPX1+sWu5XfgvIaOxOE+l
	 0Y1qZix9ZDj5E6/ecGPmlCeU7gAxn3QKXHSXrSj7MWMX1JQp4USD9MwIkOdI1um9+t
	 1sUUEa3uCBA7xErXBdmUIDszdxFMyuM6cmTLTi6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfGWDvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfGWDvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:51:32 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA17B21E70;
        Tue, 23 Jul 2019 03:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563853891;
        bh=ZA2huNrm/Js6SetgIwTYXcWDIB/pZg6enTjORSOj3c0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2od/wFzhjir9TWVcFE3chENfb5aSFIHcpR80wKG1vedPs6Tnt2LWiTYZFyxp9Mcj+
         BMG+C92P8RwjCGwJUPLibBe/8zvDA0Qot/RxnUo5M5LA+sNrIdxw2ptgZ+iYtISQD5
         c4UHTh1g4ImpBM/hASeidqo0vXH6gg52V50KHKYc=
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f66e55a2-16e0-8822-8b5b-3390b6c4073b@kernel.org>
Date:   Mon, 22 Jul 2019 21:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190705164355.14025-3-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/19 10:43 AM, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> doesn't supported SG, so USB storage driver on vhci breaks SG list

grammar - Currently vhci doesn't support?

> into multiple URBs and it causes error that a transfer got terminated
> too early because the transfer length for one of the URBs was not
> divisible by the maxpacket size.
> 
> In this patch, vhci basically support SG and it sends each SG list

What does basically support mean here? Do you mean basic support?

> entry to the stub driver. Then, the stub driver sees the total length
> of the buffer and allocates SG table and pages according to the total
> buffer length calling sgl_alloc(). After the stub driver receives
> completed URB, it again sends each SG list entry to vhci.
> 
> If HCD of the server doesn't support SG, the stub driver breaks a
> single SG reqeust into several URBs and submit them to the server's
> HCD. When all the split URBs are completed, the stub driver
> reassembles the URBs into a single return command and sends it to
> vhci.
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>   drivers/usb/usbip/stub.h         |   7 +-
>   drivers/usb/usbip/stub_main.c    |  52 +++++---
>   drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
>   drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
>   drivers/usb/usbip/usbip_common.c |  60 +++++++--
>   drivers/usb/usbip/vhci_hcd.c     |  10 +-
>   drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
>   7 files changed, 372 insertions(+), 121 deletions(-)
> 

btw checkpatch isn't very happy with this patch. A few coding style
issues. Please run checkpatch before sending patches.

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
> index 2e4bfccd4bfc..dec5af9f7179 100644
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
> @@ -288,6 +289,39 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
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
> +		if (urb->setup_packet) {
> +			kfree(urb->setup_packet);
> +			urb->setup_packet = NULL;
> +		}
> +

You don't need urb->setup_packet null check. kfree() is safe
to call with null pointer. btw checkpatch tells you this.

> +		if (urb->transfer_buffer && !priv->sgl) {

Is this conditional necessary? Why are you checking priv->sgl?
Are there cases where you have memory leak? Is there a case
when urb->transfer_buffer valid when priv->sgl isn't null?

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
> @@ -314,25 +348,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
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
> -
> -		kfree(urb->transfer_buffer);
> -		urb->transfer_buffer = NULL;
> +		for (i = 0; i < priv->num_urbs; i++)
> +			usb_kill_urb(priv->urbs[i]);
>   
> -		kfree(urb->setup_packet);
> -		urb->setup_packet = NULL;
> -
> -		usb_free_urb(urb);
> +		stub_free_priv_and_urb(priv);
>   	}
>   }
>   
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index b0a855acafa3..8e32697acabb 100644
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

This could result in several error messages. This code path is much
longer now compared to previous.

This is how far I have gotten. I am going to take a look at the rest
tomorrow.

thanks,
-- Shuah
