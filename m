Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C60C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71924BCA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559633831;
	bh=yYjY9dPy0rYXxHJBZ1dR1jEtdGG5VdpSBr1YZrJynDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NO6ZfK+ntZ3Zh9kbUbILf6jdGeTbvDD4aaQ95t7av2uGL+Pz7mDUBW6wlzwHiX5/y
	 LLr2uAyz9QVyUDOY75icyT9MHb8ZM01EHmjlNU8fVm9nypEwtBL6a0YeFGOS3WWLga
	 h4He5+Y1bYW2pfy99NH5o4tFZn/pKO7pUF1zOUo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfFDHhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFDHhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:37:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2DA249F4;
        Tue,  4 Jun 2019 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559633828;
        bh=yYjY9dPy0rYXxHJBZ1dR1jEtdGG5VdpSBr1YZrJynDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtKXT2B1mmCgfmSocSk422rsl4VwCBPwwgyDUn74Z9p1rd8VASnFg7wZ797DfmPo6
         L76rjNkBWerw3wHawBdh2+nIVCt7FIxBYUL7nasWGYXLG+DS/jsLtTzzAxDcigSCqv
         K1eZzEuWRcwO5TV5GhrOFWs/kPQkxzZSoG+m9z/I=
Date:   Tue, 4 Jun 2019 09:37:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4] usb: create usb_debug_root for gadget only
Message-ID: <20190604073706.GA25045@kroah.com>
References: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559633647-29040-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:34:07PM +0800, Chunfeng Yun wrote:
> When CONFIG_USB is not set, and CONFIG_USB_GADGET is set,
> there is an issue, e.g.:
> 
> drivers/usb/mtu3/mtu3_debugfs.o: in function 'ssusb_debugfs_create_root':
> mtu3_debugfs.c:(.text+0xba3): undefined reference to 'usb_debug_root'
> 
> usb_debug_root is currently only built when host is supported
> (CONFIG_USB is set), for convenience, we also want it created when
> gadget only is enabled, this patch try to support it.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4:
>   move common API into common.c suggested by Felipe
> 
> v3:
>   1. still create usb_debug_root for gadget only
>   2. abandon mtu3's change
>   3. drop acked-by Randy
> 
> v2(resend): add acked-by Randy
> 
> v1: fix mtu3's build error, replace usb_debug_root by NULL;
> ---
>  drivers/usb/common/common.c   | 26 ++++++++++++++++++++++++++
>  drivers/usb/core/usb.c        | 16 ++++------------
>  drivers/usb/gadget/udc/core.c |  3 +++
>  include/linux/usb.h           |  2 ++
>  4 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 18f5dcf58b0d..c52e9c9f58ec 100644
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
> @@ -139,6 +140,31 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
>  
> +struct dentry *usb_debug_root;
> +EXPORT_SYMBOL_GPL(usb_debug_root);
> +
> +static atomic_t usb_debug_root_refcnt = ATOMIC_INIT(0);

Ick, no.

> +
> +struct dentry *usb_debugfs_init(void)
> +{
> +	if (!usb_debug_root)
> +		usb_debug_root = debugfs_create_dir("usb", NULL);
> +
> +	atomic_inc(&usb_debug_root_refcnt);
> +
> +	return usb_debug_root;
> +}
> +EXPORT_SYMBOL_GPL(usb_debugfs_init);
> +
> +void usb_debugfs_cleanup(void)
> +{
> +	if (atomic_dec_and_test(&usb_debug_root_refcnt)) {
> +		debugfs_remove_recursive(usb_debug_root);
> +		usb_debug_root = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(usb_debugfs_cleanup);

Only remove the debugfs subdir if the usbcore module is removed.  Create
the debugfs subdir when the usbcore module is loaded.  No need for any
reference counting of any sort at all.  No need to overthink this :)

thanks,

greg k-h
