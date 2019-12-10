Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E765C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2206F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575982148;
	bh=hUT2jtwORm5+GKr0gw3ZYWzdb2gXCbLCj9MRwm9xywY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ixakvHr5MhKC4gLyMc06YxFFlKJVC4D0D5Ni2eNvvGmEaGBof/2VfSljmrlDv91rS
	 gKlMKyBKCm/KfuQeteCfiN8BtjP0BCOveTPHavvc7bzycUuNcVpHbNKHquyooWxbsv
	 n3bDF49v4rxjHJrOL2hQa/aE+L1yZ7MQg2XNzGwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLJMtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfLJMtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:49:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5572073B;
        Tue, 10 Dec 2019 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575982144;
        bh=hUT2jtwORm5+GKr0gw3ZYWzdb2gXCbLCj9MRwm9xywY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydFIaQevf5K0X+XeD5O7r0t/O44xcJ+NlGDeEHcWvGuZ4jqYr36DDabMh+Ie3YZ8Q
         PdOijCVaVRF8OL00eedxv1LCKJaDh0bYdVBBkKU/i+SNuJmnOYLi+ZgDlOtRz9X88R
         5ioca5VQWr+IdJssC5BQ9h4EV47nGnU0Z7kQjD9c=
Date:   Tue, 10 Dec 2019 13:49:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Simon Geis <simon.geis@fau.de>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: Re: [PATCH v2 01/10] PCMCIA/i82092: use dev_<level> instead of printk
Message-ID: <20191210124902.GA3810481@kroah.com>
References: <20191210114333.12239-1-simon.geis@fau.de>
 <20191210114333.12239-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210114333.12239-2-simon.geis@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:43:26PM +0100, Simon Geis wrote:
> Improve the log output by using the
> device-aware dev_err()/dev_info() functions. While at it, update one
> remaining printk(KERN_ERR ...) call to the preferred pr_err() call.
> 
> Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
> Signed-off-by: Simon Geis <simon.geis@fau.de>
> 
> ---
>  drivers/pcmcia/i82092.c | 79 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
> index aad8a46605be..ba33293b1a34 100644
> --- a/drivers/pcmcia/i82092.c
> +++ b/drivers/pcmcia/i82092.c
> @@ -92,11 +92,13 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
>  			break;
>  			
>  		default:
> -			printk(KERN_ERR "i82092aa: Oops, you did something we didn't think of.\n");
> +			dev_err(&dev->dev,
> +				"i82092aa: Oops, you did something we didn't think of.\n");

You already know the device and driver type (it comes built-into the
dev_err() message), so there's no need to keep the i82092aa everywhere
here, right?

> @@ -417,7 +422,9 @@ static int i82092aa_init(struct pcmcia_socket *sock)
>                                                                                                                                                                                                                                                
>  static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
>  {
> -	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
> +	struct socket_info *sock_info = container_of(socket, struct socket_info,
> +						     socket);
> +	unsigned int sock = sock_info->number;


This does not look like a printk cleanup :(

>  	unsigned int status;
>  	
>  	enter("i82092aa_get_status");
> @@ -458,7 +465,9 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
>  
>  static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state) 
>  {
> -	unsigned int sock = container_of(socket, struct socket_info, socket)->number;
> +	struct socket_info *sock_info = container_of(socket, struct socket_info,
> +						     socket);
> +	unsigned int sock = sock_info->number;

Nor does this :(


> -/*	printk("set_io_map: Setting range to %x - %x \n",io->start,io->stop);  */
> +/*	dev_info(&sock_info->dev->dev,
> + *		 "set_io_map: Setting range to %x - %x\n",
> + *		 io->start, io->stop);
> + */

Just delete commented out lines.

> -/* 	printk("set_mem_map: Setting map %i range to %x - %x on socket %i, speed is %i, active = %i \n",map, region.start,region.end,sock,mem->speed,mem->flags & MAP_ACTIVE);  */
> +/*	dev_info(&sock_info->dev->dev,
> + *		 "set_mem_map: Setting map %i range to %x - %x on socket %i, "
> + *		 "speed is %i, active = %i\n", map,
> + *		 region.start, region.end, sock,mem->speed,
> + *		 mem->flags & MAP_ACTIVE);
> + */

same here.

>  	/* write the start address */
>  	base = I365_MEM(map);
> @@ -669,10 +700,16 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
>  	if (mem->flags & MAP_WRPROT)
>  		i |= I365_MEM_WRPROT;
>  	if (mem->flags & MAP_ATTRIB) {
> -/*		printk("requesting attribute memory for socket %i\n",sock);*/
> +/*		dev_info(&sock_info->dev->dev,
> + *			 "requesting attribute memory for socket %i\n",
> + *			 sock);
> + */

And here and elsewhere. They were just debugging lines.

thanks,

greg k-h
