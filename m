Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35084C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037DE223FA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424406;
	bh=Gto408/BdPyiQvvivbF3hNbAbCUk34Rag2PmMyiy2uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MCeZ+Skldc62XAlgC8D9BUoJyfvguHgxzXA4WPxahau7tl0VHhQ1crlQAG5QTuGFv
	 BBKHWasPXtSODpHO/HsYGaHmJLBGM+rW+OBik9vE4Q9aWXsqh03t2mykGIoDuyZLXk
	 s/zi3sAMoDBDbylWd7uFNPrt7BnDWKb8aFcVyXiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfDPOUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDPOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4D1223FE;
        Tue, 16 Apr 2019 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424402;
        bh=Gto408/BdPyiQvvivbF3hNbAbCUk34Rag2PmMyiy2uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUjrKiGCz1AFfv+YqGmuJ4gbMblJaaNDdKsJklWQtWJqAtsX3IKk++pBdHJ2T7Bcg
         Npm/BhJKAXykP3e+/ylOQ3dQSPKYels5P066NH9inYVa/h/uER4AL47LRkyVH4fclE
         cc4kKios9INM/MKSXatWB10BEAto8Ges//loCDvQ=
Date:   Tue, 16 Apr 2019 15:39:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: printk to pr_*
Message-ID: <20190416133917.GA17762@kroah.com>
References: <20190412154753.ouafktmagb3sw6gj@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412154753.ouafktmagb3sw6gj@macpro-scc.lancs.ac.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 04:47:54PM +0100, Willy Wolff wrote:
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>

I do not take patches without any changelog text, sorry.

> ---
>  drivers/base/dd.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a823f469e53f..1bc4557a0f49 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -328,7 +328,7 @@ bool device_is_bound(struct device *dev)
>  static void driver_bound(struct device *dev)
>  {
>  	if (device_is_bound(dev)) {
> -		printk(KERN_WARNING "%s: device %s already bound\n",
> +		pr_warn("%s: device %s already bound\n",
>  			__func__, kobject_name(&dev->kobj));

This really should be dev_warn() now, that way no need to use
kobject_name().


>  		return;
>  	}
> @@ -494,8 +494,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	}
>  
>  	if (driver_sysfs_add(dev)) {
> -		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
> -			__func__, dev_name(dev));
> +		pr_err("%s: driver_sysfs_add(%s) failed\n",
> +		       __func__, dev_name(dev));

dev_err()?

>  		goto probe_failed;
>  	}
>  
> @@ -575,9 +575,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		break;
>  	default:
>  		/* driver matched but the probe failed */
> -		printk(KERN_WARNING
> -		       "%s: probe of %s failed with error %d\n",
> -		       drv->name, dev_name(dev), ret);
> +		pr_warn("%s: probe of %s failed with error %d\n",
> +			drv->name, dev_name(dev), ret);

dev_warn()?

>  	}
>  	/*
>  	 * Ignore errors returned by ->probe so that the next driver can try
> @@ -602,8 +601,8 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>  	ret = really_probe(dev, drv);
>  	rettime = ktime_get();
>  	delta = ktime_sub(rettime, calltime);
> -	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
> -	       dev_name(dev), ret, (s64) ktime_to_us(delta));
> +	pr_debug("probe of %s returned %d after %lld usecs\n",
> +		 dev_name(dev), ret, (s64) ktime_to_us(delta));

dev_dbg()?

>  	return ret;
>  }
>  
> @@ -687,8 +686,7 @@ static inline bool cmdline_requested_async_probing(const char *drv_name)
>  static int __init save_async_options(char *buf)
>  {
>  	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> -		printk(KERN_WARNING
> -			"Too long list of driver names for 'driver_async_probe'!\n");
> +		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");

This one was ok.

thanks,

greg k-h
