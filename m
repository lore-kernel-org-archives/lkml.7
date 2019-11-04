Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10E8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9621D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572878939;
	bh=hVMop/i9b335c2j96uGaUkv8Zt/8ejZGsLInDF6c9xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dm9ZlFEl9XmSgknIhDk1ElMQsltVPdinC7oQkkBCouJ3tFkIy11wqYKHWWUywNv4j
	 Z7/VdMvX/d4NPwm2U+x2WnG+PhhCzP+qcneqYhAUQ1jdz3BMehck/RCQ9/6PerOtt8
	 NFZqNg6Qq9t9dwtrWa0kOD2OMhP3kQfAFdFKWt54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfKDOs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDOs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:48:58 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB78218BA;
        Mon,  4 Nov 2019 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572878937;
        bh=hVMop/i9b335c2j96uGaUkv8Zt/8ejZGsLInDF6c9xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esG+3K/THFd1ZTOaKJIZZxu+svtt4ljO41FAcQonXNZv3PBFTAugpxmVcYUvC85Vj
         hsDsqZX//V6lWmG+Fh8eGLsAeROn4dcMMJAazBHVT1IJAT4FC0xBezh1HJe2Apu34n
         wGQeJ4dqz2g5Fi+u+SjxTuLMLgMVU0NJ54em6yx4=
Date:   Mon, 4 Nov 2019 15:48:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gustavo@embeddedor.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] usb: isp1760: isp1760-hcd.c: Drop condition with no
 effect
Message-ID: <20191104144845.GC2183570@kroah.com>
References: <20191028211214.GA30014@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028211214.GA30014@saurav>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 02:42:14AM +0530, Saurav Girepunje wrote:
> As the "else if" and "else" branch body are identical the condition
> has no effect. So drop the "else if" condition.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/usb/isp1760/isp1760-hcd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
> index 320fc4739835..579a21bd70ad 100644
> --- a/drivers/usb/isp1760/isp1760-hcd.c
> +++ b/drivers/usb/isp1760/isp1760-hcd.c
> @@ -1032,8 +1032,6 @@ static int check_atl_transfer(struct usb_hcd *hcd, struct ptd *ptd,
>  			urb->status = -EOVERFLOW;
>  		else if (FROM_DW3_CERR(ptd->dw3))
>  			urb->status = -EPIPE;  /* Stall */
> -		else if (ptd->dw3 & DW3_ERROR_BIT)
> -			urb->status = -EPROTO; /* XactErr */
>  		else
>  			urb->status = -EPROTO; /* Unknown */

Yes, the same thing happens, but look at the comment, this is two
different things.  So the code is good as-is.

thanks,

greg k-h
