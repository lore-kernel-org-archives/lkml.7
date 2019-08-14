Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFB6214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lpqyJ6l8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EYWlmCrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHNVcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:32:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfHNVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:32:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D07E6086B; Wed, 14 Aug 2019 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565818333;
        bh=V1w5/Cl6FN+mlyKiklwwibF13l54ZK0EiCg73ykYHa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpqyJ6l8//MaOYD1/ISranQPfz0kHDc/qXDvcWEgdIjW887ERNvSQH+I5631iH4sy
         gk5p5s4dkc/d8sbJ7qU/bVYIabMyAN8VSlBSf/bl2kJVLA51G0q5/lKh1j5faRHtPM
         skocUykH6h7OOJPmeVHaAaW2M8jxI4GxuRtwwimE=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8C5960128;
        Wed, 14 Aug 2019 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565818329;
        bh=V1w5/Cl6FN+mlyKiklwwibF13l54ZK0EiCg73ykYHa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYWlmCrkJrEF7O2x1Rz6kqEVeeO5zBhgMZrB/wHGbMHSiA3c2UvantKou9Ic3O4tH
         ii+XHWhpEukCsABe9g1Y8Nt4fcmJ2+jnx4jfNYgHk0w7xfNqZd7tCDsHMjsb3twTB5
         uqY0ogKNcSLy6iEnnQE15J9Sj2p5102BxLzGolUM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8C5960128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Wed, 14 Aug 2019 14:32:03 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:USB \"USBNET\" DRIVER FRAMEWORK" <netdev@vger.kernel.org>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: fix a memory leak bug
Message-ID: <20190814213203.GA9754@jackp-linux.qualcomm.com>
References: <1565804493-7758-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565804493-7758-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:41:33PM -0500, Wenwen Wang wrote:
> In usbnet_start_xmit(), 'urb->sg' is allocated through kmalloc_array() by
> invoking build_dma_sg(). Later on, if 'CONFIG_PM' is defined and the if
> branch is taken, the execution will go to the label 'deferred'. However,
> 'urb->sg' is not deallocated on this execution path, leading to a memory
> leak bug.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/net/usb/usbnet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 72514c4..f17fafa 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1433,6 +1433,7 @@ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
>  		usb_anchor_urb(urb, &dev->deferred);
>  		/* no use to process more packets */
>  		netif_stop_queue(net);
> +		kfree(urb->sg);
>  		usb_put_urb(urb);

The URB itself is not getting freed here; it is merely added to the
anchor list and will be submitted later upon usbnet_resume(). Therefore
freeing the SG list is premature and incorrect, as it will get freed in
either the tx_complete/tx_done path or upon URB submission failure.

>  		spin_unlock_irqrestore(&dev->txq.lock, flags);
>  		netdev_dbg(dev->net, "Delaying transmission for resumption\n");

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
