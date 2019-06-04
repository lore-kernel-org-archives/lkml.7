Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E486C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1B724891
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559649564;
	bh=Z3XO3oNEi5/5cBT7blM/rDurAsFcvi2cI8yOPOcHAmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uDFSv29ki04Sh5Vclm+4hnvkGB96pr5xx8YPX9ays5GLkAsbAyhYmFAukqkvkWhqW
	 sSL2N5JO69WnynnNDvJ9eJbhECxFNk3UDQSfUtL/9B2vYRwV5Hxc2bzXJTVv2ylP+g
	 Faym9I9huWFhWoz5MWzJ4tuDvcEch+ePGwNpNo6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfFDL7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfFDL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AD324891;
        Tue,  4 Jun 2019 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559649561;
        bh=Z3XO3oNEi5/5cBT7blM/rDurAsFcvi2cI8yOPOcHAmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7T5sA/E2GlQZD03vvdIiG1CS2Ci9xcqsSsS+0uONfWAe/OFiA0jKN3FI43RbjxgS
         LXDNCJ8E/Ic6Ci4r6t6wd69SKvUX66KvwdLm4fAhedRA46On0BZo83vPlN4YI5/Rpi
         j9DHYqDnYoB33Z862/bycdkeBXJdp4J6Q2g/IvfI=
Date:   Tue, 4 Jun 2019 13:59:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] USB: move usb debugfs directory creation to the usb
 common core
Message-ID: <20190604115919.GA24346@kroah.com>
References: <20190604093258.GB30054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604093258.GB30054@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:32:58AM +0200, Greg Kroah-Hartman wrote:
> The USB gadget subsystem wants to use the USB debugfs root directory, so
> move it to the common "core" USB code so that it is properly initialized
> and removed as needed.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> 
> This should be the "correct" version of this, Chunfeng, can you test
> this to verify it works for you?
> 
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 18f5dcf58b0d..3b5e4263ffef 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -15,6 +15,7 @@
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
>  #include <linux/of_platform.h>
> +#include <linux/debugfs.h>
>  
>  static const char *const ep_type_names[] = {
>  	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
> @@ -291,4 +292,21 @@ struct device *usb_of_get_companion_dev(struct device *dev)
>  EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
>  #endif
>  
> +struct dentry *usb_debug_root;
> +EXPORT_SYMBOL_GPL(usb_debug_root);
> +
> +static int usb_common_init(void)
> +{
> +	usb_debug_root = debugfs_create_dir("usb", NULL);
> +	return 0;
> +}
> +
> +static void usb_common_exit(void)
> +{
> +	debugfs_remove_recursive(usb_debug_root);
> +}
> +
> +module_init(usb_common_init);
> +module_exit(usb_common_exit);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 7fcb9f782931..f3d6b1ab80cb 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb = {
>  	.notifier_call = usb_bus_notify,
>  };
>  
> -struct dentry *usb_debug_root;
> -EXPORT_SYMBOL_GPL(usb_debug_root);
> +static struct dentry *usb_devices_root;
>  
>  static void usb_debugfs_init(void)
>  {
> -	usb_debug_root = debugfs_create_dir("usb", NULL);
> -	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
> -			    &usbfs_devices_fops);
> +	usb_devices_root = debugfs_create_file("devices", 0444, usb_debug_root,
> +					       NULL, &usbfs_devices_fops);
>  }
>  
>  static void usb_debugfs_cleanup(void)
>  {
> -	debugfs_remove_recursive(usb_debug_root);
> +	debugfs_remove_recursive(usb_devices_root);

That should just be debugfs_remove();

I'll fix it up after someone tests this :)

thanks,

greg k-h
