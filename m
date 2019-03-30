Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40709C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DACB2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553971569;
	bh=zzl/zDEw0Hq5zSqdjWALylGcLgQhjb66fgDrn2ugLF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9tUsYf4GcPb5XLAP/pJwuCxofC01a95RGu/9UP0vbw1rzCs8GNUuZjrujZOk09P4
	 /HRqc1285oUDwg7A1HM5odvcp45o8eHWnuknKrCC/ye6X4dQ53NcORq671MjjgCfyZ
	 UTel+xDLXYfCyURQki8KFApUXNMo6Ut3uhkuapCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfC3SqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730542AbfC3SqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:46:07 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF4F218E2;
        Sat, 30 Mar 2019 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553971566;
        bh=zzl/zDEw0Hq5zSqdjWALylGcLgQhjb66fgDrn2ugLF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hI9m7FbkDxmF7bCb6cutNQr1qpJMS3nIShkvmg8ERKh+LM22naWjGW5nTS4Pv/sPm
         8vF4R6ZkEeldInkyY/zyy/WDk0kjiXAboXiwRQybSwXKgAJUlMNT+R6CuQ7Yt+pC1/
         57VYiTMSaKWBz57iOhCvJMFvkoIKhpmkC4ptXEZU=
Date:   Sat, 30 Mar 2019 19:45:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: fix kernel address leaks in rp_ioctl
Message-ID: <20190330184550.GA22377@kroah.com>
References: <CABXRUiTTBDvVC9Z1uRTpmyNgoE2qPY8PXptAEP6nwQFeAFgE7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXRUiTTBDvVC9Z1uRTpmyNgoE2qPY8PXptAEP6nwQFeAFgE7A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 06:33:44PM +0800, Fuqian Huang wrote:
> The RCKP_GET_STRUCT case in rp_ioctl will copy a kernel
> pointer(info->port.ops) to user space. The info->port.ops points to a
> constant object 'rocket_port_ops' during the initialization. (init_r_port
> in drivers/tty/rocket.c:633)
> 
> Add a function clear_pointer_fields to set the pointer fields of struct
> r_port to NULL before copy_to_user.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> Reported-by: Fuqian Huang <huangfq.daxian@gmail.com>
> --
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index b121d8f..28016e1 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1271,21 +1271,42 @@ static int get_version(struct r_port *info, struct
> rocket_version __user *retver
>   return 0;
>  }
> 
> +static void clear_pointer_fields(struct r_port *old, struct r_port *new)
> +{
> + memcpy(new, old, sizeof (struct r_port));
> + new->port.tty = NULL;
> + new->port.itty = NULL;
> + new->port.ops = NULL;
> + new->port.client_ops = NULL;
> + memset(&new->port.open_wait.head, 0, sizeof(struct list_head));
> + memset(&new->port.delta_msr_wait.head, 0, sizeof(struct list_head));
> + memset(&new->port.mutex.wait_list, 0, sizeof(struct list_head));
> + memset(&new->port.buf_mutex.wait_list, 0, sizeof(struct list_head));
> + new->port.xmit_buf = NULL;
> + new->port.client_data = NULL;
> + new->ctlp = NULL;
> + new->xmit_buf = NULL;
> + memset(&new->write_mtx.wait_list, 0, sizeof(struct list_head));
> +}
> +
>  /*  IOCTL call handler into the driver */
>  static int rp_ioctl(struct tty_struct *tty,
>       unsigned int cmd, unsigned long arg)
>  {
>   struct r_port *info = tty->driver_data;
> + struct r_port *masked_info;
>   void __user *argp = (void __user *)arg;
>   int ret = 0;
> 
>   if (cmd != RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl"))
>   return -ENXIO;
> -
>   switch (cmd) {
>   case RCKP_GET_STRUCT:
> - if (copy_to_user(argp, info, sizeof (struct r_port)))
> + masked_info = kzalloc(sizeof (struct r_port), GFP_KERNEL);
> + clear_pointer_fields(info, masked_info);
> + if (copy_to_user(argp, masked_info, sizeof (struct r_port)))
>   ret = -EFAULT;
> + kfree(masked_info);
>   break;
>   case RCKP_GET_CONFIG:
>   ret = get_config(info, argp);

The patch is totally whitespace corrupted and can not be applied :(

You can not cut/paste in gmail when sending a patch.

Also, your change leaks memory on the error path :(

Please fix up and try again.

thanks,

greg k-h
