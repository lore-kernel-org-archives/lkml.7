Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64ECC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772A020644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568959576;
	bh=0NS6Av10YtD0Vn0fLDttwo6ERRmj/WxyxPOpGzccm0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=neauRf9p0jIMLBnk29O0jVafQZftUbmRXJWi7BeXsBTWhNswOEsnjqmX9Kuenw/2u
	 1eRX6eEwOkMnpYpv5/rTRf5WxnLGz9OFl3ciRXHQZ7hGTmGq4U/0Z2a1N4BoyRN0b3
	 GOdSPjnLgDm4BrqsNoetzyAZAr/yTCKH471i7oP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408254AbfITGGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408243AbfITGGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:06:07 -0400
Received: from localhost (unknown [145.15.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B657920640;
        Fri, 20 Sep 2019 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568959566;
        bh=0NS6Av10YtD0Vn0fLDttwo6ERRmj/WxyxPOpGzccm0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZUnqBsqeAcrrp6oAT+sVt0Vr/Z+1icFMFxfXMY2VMlYMLc3pJ7xe8AiD3TBmFoc2
         pIpDBOMgx6CsrRYb4AYkn6O2mfG+EMOAIyhqT1NsWtpVTGOogSJEmbptNhS9d+k18/
         2V7drzjSyRAUs0+w09CZveLw+HgVXYv3L1cbSNHY=
Date:   Fri, 20 Sep 2019 08:05:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, emamd001@umn.edu,
        Nishka Dasgupta <nishkadg.linux@gmail.com>, smccaman@umn.edu,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: rtl8192u: fix multiple memory leaks on error
 path
Message-ID: <20190920060507.GD473496@kroah.com>
References: <20190920025137.29407-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920025137.29407-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 09:51:33PM -0500, Navid Emamdoost wrote:
> In rtl8192_tx on error handling path allocated urbs and also skb should
> be released.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index fe1f279ca368..b62b03802b1b 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1422,7 +1422,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  		(struct tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
>  	struct usb_device *udev = priv->udev;
>  	int pend;
> -	int status;
> +	int status, rt = -1;
>  	struct urb *tx_urb = NULL, *tx_urb_zero = NULL;
>  	unsigned int idx_pipe;
>  
> @@ -1566,8 +1566,10 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  		}
>  		if (bSend0Byte) {
>  			tx_urb_zero = usb_alloc_urb(0, GFP_ATOMIC);
> -			if (!tx_urb_zero)
> -				return -ENOMEM;
> +			if (!tx_urb_zero) {
> +				rt = -ENOMEM;
> +				goto error;
> +			}
>  			usb_fill_bulk_urb(tx_urb_zero, udev,
>  					  usb_sndbulkpipe(udev, idx_pipe),
>  					  &zero, 0, tx_zero_isr, dev);
> @@ -1577,7 +1579,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  					 "Error TX URB for zero byte %d, error %d",
>  					 atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
>  					 status);
> -				return -1;
> +				goto error;
>  			}
>  		}
>  		netif_trans_update(dev);
> @@ -1588,7 +1590,12 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>  	RT_TRACE(COMP_ERR, "Error TX URB %d, error %d",
>  		 atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
>  		 status);
> -	return -1;
> +
> +error:
> +	dev_kfree_skb_any(skb);
> +	usb_free_urb(tx_urb);
> +	usb_free_urb(tx_urb_zero);
> +	return rt;
>  }
>  
>  static short rtl8192_usb_initendpoints(struct net_device *dev)
> -- 
> 2.17.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel


Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot
