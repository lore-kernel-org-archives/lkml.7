Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C567C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD9F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221367;
	bh=nye3IbpCS3dE9F8PT3M7YbLbAm3Mxl3uldmBKOSgRdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ouNH8YQ+HGsPosyYxcGThodsxyQKY4k4uLXk8igdfK7YNG8Rdpw/iuqyIuBMBRcQ4
	 ijLCYQmWq7T+Bcct6Oo50J9KqrWALWuXgiZ2+D70TGOSW4Ltip5Byl4kIi2ZiJ3k+N
	 IEJw6qYLnOGzSuhDAsCLqVq0itXCCvvHe28dMtAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbfDYTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:42:45 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CAD205ED;
        Thu, 25 Apr 2019 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221365;
        bh=nye3IbpCS3dE9F8PT3M7YbLbAm3Mxl3uldmBKOSgRdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SI8DqdWhRmeK6HNLgczAWLTzYsiZUkD4n0itG9PGw8UCi28S3YIDdztp331MUjJPu
         7LRoI6iSeRv0+J8e6bTY07QTYLW1k+ysGfqlowWr1WyjmexO/gX1Zrez8WvN66k+Lv
         DXF/tF17HdjkoDauxK+Cy9zOLm1QrqTkZKEdU18M=
Date:   Thu, 25 Apr 2019 21:42:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: printk to pr_*
Message-ID: <20190425194242.GA14372@kroah.com>
References: <20190415145349.vqfhcp4iv4uka4lt@macpro-scc.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415145349.vqfhcp4iv4uka4lt@macpro-scc.lancs.ac.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:53:50PM +0100, Willy Wolff wrote:
> This patch change usage of printk to their pr_* equivalent.
> 
> Note, pr_debug(...) will not be emitted unless DEBUG is defined or
> CONFIG_DYNAMIC_DEBUG is enabled.
> 
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
> Changes in v2:
>   - Add a cover letter.
> 
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

This should just use dev_warn()

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

dev_err()

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

dev_warn()

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

dev_dbg()


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

this one is ok.

thanks,

greg k-h
