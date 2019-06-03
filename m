Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B03326FF8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559589097;
	bh=QNbpdzJvYkNU1G5jHELqN1BiDzvtS38cc8fnFwWFbuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YYrLXjkjTrkEPUih9EsFf8vErv3Whbw6VGsrXWPiV+2moRqQP5KuLNJpCEwQMfILm
	 47dvTjtyN043kHdAl0cGUx/7FYE2WwVFU25V7wE7XdQ2zyAGwPr3snRzacoXabwJak
	 i9Epsx/9PN+yobeX9wRWD3ketUnmyO7Xt9d2dy2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFCTLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:11:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBF5240BB;
        Mon,  3 Jun 2019 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589095;
        bh=QNbpdzJvYkNU1G5jHELqN1BiDzvtS38cc8fnFwWFbuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEJgQPN2mGn/z2nfLc6R7m1MDj11nzlo06TYs6SLcyzrpdf3HDZXxHtS/I/+q+1mq
         F1Yz9gsAOKEpGNv8gn/tIB3QBxLVeo4GOPPuLA2Ftk15komFZ6BKDcjsVVCH/0Yoog
         xLKXgufCE+c7FVCLmSr6GfJrWxD9kMEyrIwYHo3g=
Date:   Mon, 3 Jun 2019 21:11:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Message-ID: <20190603191133.GE6487@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> Add a wrappers to lookup a device by name for a given driver, by various
> generic properties of a device. This can avoid the proliferation of custom
> match functions throughout the drivers.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 52d59d5..68d6e04 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -401,6 +401,50 @@ struct device *driver_find_device(struct device_driver *drv,
>  				  struct device *start, void *data,
>  				  int (*match)(struct device *dev, const void *data));
>  
> +/**
> + * driver_find_device_by_name - device iterator for locating a particular device
> + * of a specific name.
> + * @driver: the driver we're iterating
> + * @start: Device to begin with
> + * @name: name of the device to match
> + */
> +static inline struct device *driver_find_device_by_name(struct device_driver *drv,
> +							struct device *start,
> +							const char *name)
> +{
> +	return driver_find_device(drv, start, (void *)name, device_match_name);

Why is the cast needed?

> +}
> +
> +/**
> + * driver_find_device_by_of_node- device iterator for locating a particular device
> + * by of_node pointer.
> + * @driver: the driver we're iterating
> + * @start: Device to begin with
> + * @np: of_node pointer to match.
> + */
> +static inline struct device *
> +driver_find_device_by_of_node(struct device_driver *drv,
> +			      struct device *start,
> +			      const struct device_node *np)
> +{
> +	return driver_find_device(drv, start, (void *)np, device_match_of_node);

Same here.

> +}
> +
> +/**
> + * driver_find_device_by_fwnode- device iterator for locating a particular device
> + * by fwnode pointer.
> + * @driver: the driver we're iterating
> + * @start: Device to begin with
> + * @fwnode: fwnode pointer to match.
> + */
> +static inline struct device *
> +driver_find_device_by_fwnode(struct device_driver *drv,
> +			     struct device *start,
> +			     const struct fwnode_handle *fwnode)
> +{
> +	return driver_find_device(drv, start, (void *)fwnode, device_match_fwnode);

And here

thanks,

greg k-h
