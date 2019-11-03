Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF835CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3EB20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572784927;
	bh=xbgHsJBJRvoxAQ7KVYp/h1DOPwN2mmCDsuUBaPIhuf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pew00n/JXHZEJwW275uLsz3IjubAmMjFnzCo8uan87/dg0HbAmMiJlThCPbZTI7Q2
	 wlP28m0DSVV7wZnvsOIQsUBNgIdICniW1uT+WVtDJzgqRWaFVMmM2D2G2mNuccytJa
	 i/LFYpb88qZVnCyk8eaea7oSrjeeKB50OHLqLCKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfKCMmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:42:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCMmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:42:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F4A32080F;
        Sun,  3 Nov 2019 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572784923;
        bh=xbgHsJBJRvoxAQ7KVYp/h1DOPwN2mmCDsuUBaPIhuf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mF2mfMyfseqyne4SCDmzGdBzWYPpkcIoSgPZRVnZz9wjd9L3pQc9Y8EhfHVqFBVhF
         jgi9RVkJcqDkt6VwMyDk6IuFHp1cdBEjCdtgp70+DMZbyqHJoU8HePyDqflDbMCYkL
         gQ0WbiZxk/B5tsnMrSBhfJV1LROvcrgRK6b4l2nI=
Date:   Sun, 3 Nov 2019 13:42:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hui yang <yanghui.def@gmail.com>
Cc:     balbi@kernel.org, mirq-linux@rere.qmqm.pl,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] USB(u_serial.c): it has a NULL point
Message-ID: <20191103124201.GB619218@kroah.com>
References: <1572749044-6091-1-git-send-email-yanghui.def@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572749044-6091-1-git-send-email-yanghui.def@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 10:44:04AM +0800, hui yang wrote:
> From: YangHui <yanghui.def@gmail.com>
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000002a0
> Kernel BUG at tty_wakeup+0x18/0x8c
> [<0000000095135e9d>] tty_wakeup+0x18/0x8c
> [<00000000c35f19e4>] gs_start_io+0xc8/0x158
> [<00000000b11b184e>] gserial_connect+0xd0/0x174
> [<00000000642201de>] acm_set_alt+0x70/0x180
> [<00000000a9d38e8b>] composite_setup+0x1848/0x1a7c
> [<0000000072c88781>] android_setup+0x1ec/0x1f4
> [<000000004c0127a5>] msm_udc_irq+0x8d0/0xc0c
> [<00000000f8bb9acf>] __handle_irq_event_percpu+0x74/0x294
> [<00000000afd57256>] handle_irq_event+0x60/0xc8
> [<0000000076719b24>] handle_fasteoi_irq+0xc8/0x1c4
> [<00000000421f3d87>] generic_handle_irq+0x34/0x4c
> [<00000000b2f2d343>] __handle_domain_irq+0x6c/0xbc
> [<00000000c74325e8>] gic_handle_irq+0x6c/0xe0
> yes,we can see the port->port.tty==NULL, so system crashed
> 
> Signed-off-by: YangHui <yanghui.def@gmail.com>
> ---
>  drivers/usb/gadget/function/u_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 65f634e..a1c2ac2 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -562,6 +562,8 @@ static int gs_start_io(struct gs_port *port)
>  
>  	/* unblock any pending writes into our circular buffer */
>  	if (started) {
> +		if (port->port.tty == NULL)
> +			return -EIO;

How can this happen?  Shouldn't this be handled earlier?

If not, can you document this how this can be true and what should be
done about it?

thanks,

greg k-h
