Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5497821743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iENwDtro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfHHOVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:21:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34569 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:21:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so37929163pgc.1;
        Thu, 08 Aug 2019 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6UB4KD/LTiv8IBgEBo1kFNoYgVM5DkcpvuNbardx3hE=;
        b=iENwDtropmP05k+YUaieuVlcGRdyMUjViPdEODHecXmloPXL2liteJxZ8oJT2rUoTW
         HK0HPAAVie+esclhA7AoqKJJJW/Z6dwgUj/5hqXc6EBQmkJSY0nVeKW5edNp5/KVrvza
         d4RgzX4YC9vqVRdoFfAE4YxrtJ48Pf5NoqBkZEaxxvqW25prtn3h2JWfaYxZWGIAGPb2
         qeSmKPmPR/llhQkDu/UT9VkfhFs+2Nsbr5Lgl4a98A4zI932OAOtiwWpjyQuDPk6D21r
         nt/bDwkDBM2GlSTC56Mhx/pcsY5cfvVYm4aTXA+EpgXVDGL3OAD2VFe78wk/dIbT8WPK
         gWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6UB4KD/LTiv8IBgEBo1kFNoYgVM5DkcpvuNbardx3hE=;
        b=dknHLOL3dJ1HKh9oQ5E8KSoetXyLx3CHLlWvrWAkScERhOrnhZbfL8G38g+ZR/GLaB
         g3A77ILgx/AgNftpNkptV+PkBQ2D090tqhMOlNrYoBlCu4aVVFoYrUn/MFnDcMXGW1el
         ugF4M5YvmPc6/g7KUBLC7Ir4TkjcGftvtbuoraDWPs5EkrRijbc0Fc0G/WX5KxGXVZlH
         jgBai6/biCUJwcWHGXWxAwTUWeUeh8kas/kiTpFF5WdfreZ2LQKuCU8PQ0BY+mFidbp2
         vq0SxuBRo3vYkD+Hz+3A2m1WfAxyMGxEdSd1/msI3FS4aVD7QT8obJqIJpMfxvk57h1Y
         pd6Q==
X-Gm-Message-State: APjAAAUFsHzdq6KUHcPZTGH0REC2cLFoPmqHSO1LMw+Zz5C8gdnBuHbT
        2CkyVKiuFMkC006dgSzxIwI=
X-Google-Smtp-Source: APXvYqxAExDEJSE9J4l4gfFW4LxPnviZ7HQl39ovYjPM0+QhfFLlwQ0va2zCdC1ZciVuqoY4LtliPQ==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr4447707pje.11.1565274105339;
        Thu, 08 Aug 2019 07:21:45 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id p20sm123185226pgi.81.2019.08.08.07.21.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 07:21:44 -0700 (PDT)
Date:   Thu, 8 Aug 2019 23:21:39 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
Message-ID: <20190808142139.GA4761@localhost.localdomain>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190806123154.23798-3-suwan.kim027@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:31:54PM +0900, Suwan Kim wrote:
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
> VUDC also works well with this patch. Tests are done with two USB
> gadget created by CONFIGFS USB gadget. Both use the BULK pipe.
> 
>         1. Serial gadget
>         2. Mass storage gadget
> 
>  * Serial gadget test
> 
> Serial gadget on the host sends and receives data using cat command
> on the /dev/ttyGS<N>. The client uses minicom to communicate with
> the serial gadget.
> 
>  * Mass storage gadget test
> 
> After connecting the gadget with vhci, use "dd" to test read and
> write operation on the client side.
> 
> Read  - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
> Write - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1
> 
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
> v3 - v4
> 
> - Rewrite the description about the vhci bug with USB 3.0 storage
>   device.
> - Add the description about the test with VUDC.
> - Fix the error message in stub_recv_cmd_unlink().
> 
> v2 - v3
> 
> - Rewrite the commit log to make it more clear.
> - Add the description about the mismatch situation in commit log.
> - Run chechpatch.pl and fix errors with coding style and typos.
> - Fix the error path of usbip_recv_xbuff() to stop receiving data
>   after TCP error occurs.
> - Consolidate the duplicated error path in usbip_recv_xbuff() and
>   vhci_send_cmd_submit().
> - Undo the unnecessary changes
>   * Undo the deletion of empty line in stub_send_ret_submit()
>   * Move memset() lines in stub_send_ret_submit() to the original
>     position.
> 
> v1 - v2
> 
> - Add the logic that splits single SG request into several URBs in
>   stub driver if server’s HC doesn’t support SG.
> ---
>  drivers/usb/usbip/stub.h         |   7 +-
>  drivers/usb/usbip/stub_main.c    |  55 ++++++---
>  drivers/usb/usbip/stub_rx.c      | 204 ++++++++++++++++++++++---------
>  drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
>  drivers/usb/usbip/usbip_common.c |  59 ++++++---
>  drivers/usb/usbip/vhci_hcd.c     |  15 ++-
>  drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
>  7 files changed, 376 insertions(+), 126 deletions(-)
> 
> diff --git a/drivers/usb/usbip/stub.h b/drivers/usb/usbip/stub.h
> index 35618ceb2791..d11270560c24 100644
> --- a/drivers/usb/usbip/stub.h
> +++ b/drivers/usb/usbip/stub.h
> @@ -52,7 +52,11 @@ struct stub_priv {
>  	unsigned long seqnum;
>  	struct list_head list;
>  	struct stub_device *sdev;
> -	struct urb *urb;
> +	struct urb **urbs;
> +	struct scatterlist *sgl;
> +	int num_urbs;
> +	int completed_urbs;
> +	int urb_status;
>  
>  	int unlinking;
>  };
> @@ -86,6 +90,7 @@ extern struct usb_device_driver stub_driver;
>  struct bus_id_priv *get_busid_priv(const char *busid);
>  void put_busid_priv(struct bus_id_priv *bid);
>  int del_match_busid(char *busid);
> +void stub_free_priv_and_urb(struct stub_priv *priv);
>  void stub_device_cleanup_urbs(struct stub_device *sdev);
>  
>  /* stub_rx.c */
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 2e4bfccd4bfc..3ee636215e9c 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -6,6 +6,7 @@
>  #include <linux/string.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/scatterlist.h>
>  
>  #include "usbip_common.h"
>  #include "stub.h"
> @@ -288,6 +289,42 @@ static struct stub_priv *stub_priv_pop_from_listhead(struct list_head *listhead)
>  	return NULL;
>  }
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

I find list_del() error in my implementation. When client closes
connection with server, stub driver calls stub_device_cleanup_urbs()
to free all the privs and urbs. stub_device_cleanup_urbs() takes
stub_priv from the lists calling stub_priv_pop() and calls
stub_free_priv_and_urb() to free priv and urbs. But the error occurs
when stub_free_priv_and_urb() tries to call list_del() to delete
stub priv from the list because it was already deleted from the
list in stub_priv_pop().

> +	if (priv->sgl)
> +		sgl_free(priv->sgl);
> +	kfree(priv->urbs);
> +	kmem_cache_free(stub_priv_cache, priv);
> +}
> +
>  static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
>  {
>  	unsigned long flags;
> @@ -314,25 +351,15 @@ static struct stub_priv *stub_priv_pop(struct stub_device *sdev)
>  void stub_device_cleanup_urbs(struct stub_device *sdev)
>  {
>  	struct stub_priv *priv;
> -	struct urb *urb;
> +	int i;
>  
>  	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
>  
>  	while ((priv = stub_priv_pop(sdev))) {
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
>  	}
>  }

I modified stub_free_priv_and_urb() and stub_device_cleanup_urbs()
to support SG. In stub_device_cleanup_urbs(), the code is the same
as stub_free_priv_and_urb() except that it does not call list_del()
when freeing stub priv and urbs. So I removed the duplicated code
and make stub_device_cleanup_urbs() call stub_free_priv_and_urb()
to free stub priv and urbs. But when calling stub_free_priv_and_urb()
in stub_device_cleanup_urbs(), it should avoid calling list_del()
but it calls. I will fix it up and send v5.

Regards
Suwan Kim
