Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58097C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E558217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558723897;
	bh=+PiQxhORYMt326tyGMmMXRxjOS2IPxS8uRhZIcpuKbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HSgudEZAjeeQW24w92z/RCBAlhmJvuvQQgdObKKMMm8o0HcU44m886K1bwBv5PtbE
	 wLP7/3CAubHUphhaORPuYhuXMRdYKhKZOVR36eEhCPjVjIGob1B91VlhsZg6R0D1g0
	 SE8OdK+ePf9GLEhJIB9xoU57BmhU3aDZ6s3Z2T0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403910AbfEXSvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391687AbfEXSvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:51:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3441821848;
        Fri, 24 May 2019 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558723894;
        bh=+PiQxhORYMt326tyGMmMXRxjOS2IPxS8uRhZIcpuKbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybqjOnB26JLHuvWJ9GeSMnhWV3+Tb+iqO9nk0HbNeOJPW8bcGYr/IFStHGHhwlb34
         kb8wNFQ/XkYQDzbq2yROu3vLBHMkY1JeRb+bD1NMCOS5JdAH7V7ijCJ/dsH9Lffw2W
         J1Wac1tQbt471p6LglL03GVbvffVTavPWHpueTDw=
Date:   Fri, 24 May 2019 20:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     amit@kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Cc:     amit@kernel.org, arnd@arndb.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_console: remove vq buf while unpluging port
Message-ID: <20190524185132.GA10695@kroah.com>
References: <1556416204-30311-1-git-send-email-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556416204-30311-1-git-send-email-pizhenwei@bytedance.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 09:50:04AM +0800, zhenwei pi wrote:
> A bug can be easily reproduced:
> Host# cat guest-agent.xml
> <channel type="unix">
>   <source mode="bind" path="/var/lib/libvirt/qemu/stretch.agent"/>
>   <target type="virtio" name="org.qemu.guest_agent.0" state="connected"/>
> </channel>
> Host# virsh attach-device instance guest-agent.xml
> Host# virsh detach-device instance guest-agent.xml
> Host# virsh attach-device instance guest-agent.xml
> 
> and guest report: virtio-ports vport0p1: Error allocating inbufs
> 
> The reason is that the port is unplugged and the vq buf still remained.
> So, fix two cases in this patch:
> 1, fix memory leak with attach-device/detach-device.
> 2, fix logic bug with attach-device/detach-device/attach-device.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/char/virtio_console.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index fbeb719..f6e37f4 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -251,6 +251,7 @@ struct port {
>  
>  /* This is the very early arch-specified put chars function. */
>  static int (*early_put_chars)(u32, const char *, int);
> +static void remove_vq(struct virtqueue *vq);
>  
>  static struct port *find_port_by_vtermno(u32 vtermno)
>  {
> @@ -1550,6 +1551,9 @@ static void unplug_port(struct port *port)
>  	}
>  
>  	remove_port_data(port);
> +	spin_lock_irq(&port->inbuf_lock);
> +	remove_vq(port->in_vq);
> +	spin_unlock_irq(&port->inbuf_lock);
>  
>  	/*
>  	 * We should just assume the device itself has gone off --
> @@ -1945,17 +1949,22 @@ static const struct file_operations portdev_fops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static void remove_vq(struct virtqueue *vq)
> +{
> +	struct port_buffer *buf;
> +
> +	flush_bufs(vq, true);
> +	while ((buf = virtqueue_detach_unused_buf(vq)))
> +		free_buf(buf, true);
> +}
> +
>  static void remove_vqs(struct ports_device *portdev)
>  {
>  	struct virtqueue *vq;
>  
> -	virtio_device_for_each_vq(portdev->vdev, vq) {
> -		struct port_buffer *buf;
> +	virtio_device_for_each_vq(portdev->vdev, vq)
> +		remove_vq(vq);
>  
> -		flush_bufs(vq, true);
> -		while ((buf = virtqueue_detach_unused_buf(vq)))
> -			free_buf(buf, true);
> -	}
>  	portdev->vdev->config->del_vqs(portdev->vdev);
>  	kfree(portdev->in_vqs);
>  	kfree(portdev->out_vqs);
> -- 
> 2.7.4


Amit, any ideas if this is valid or not and if this should be applied?

thanks,

greg k-h
