Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CACC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266424649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578138369;
	bh=3yQtApWHrxtkiAUMD6R/mOeW0KEC9vC8PtzXH+HA9Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fOCI8ERre3lCf/CfTVfkDJsqlDCoSdS7DT/C+JKNKPgDwBNj6fQAJJ8GcVcVGXXOr
	 +fksA5ZL1niS2jrMM04Za5qXTYDbXJ7O0Xa55gQ8w0Tdp0ZgEAblFyZtZ3UkWfRFtA
	 xR+O950h7FHR3fct8pCUFSwdA6FrnlElaYXyZleU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgADLpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 06:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgADLpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 06:45:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE082215A4;
        Sat,  4 Jan 2020 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578138333;
        bh=3yQtApWHrxtkiAUMD6R/mOeW0KEC9vC8PtzXH+HA9Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vs9xTaCkVezxEDGeWNYdZ7JlAs/Aq9gMn8yQtDCacoRHTu0atxqmjh/YS73qNMNmD
         yzYkv3a5g9EIA8aHXAv3iJ9jJQh4LqE4AYdxW90TvIGx1W63iSBGL4vpMAfY2eiKq7
         t/7xMJxRezumAe6g11AYrOx5hPH0dLAWMyLsl5As=
Date:   Sat, 4 Jan 2020 12:45:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: core: Warn about failed to find udc
Message-ID: <20200104114530.GA1288021@kroah.com>
References: <20200104112836.28036-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104112836.28036-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 07:28:36PM +0800, Dejin Zheng wrote:
> If we do not warn here, the user may not know failed to
> find udc class driver because it silently fails.
> Let's print a warning in that case so developers find
> these problems faster.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/usb/gadget/udc/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 51fa614b4079..9b11046480fe 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1414,6 +1414,8 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
>  	}
>  
>  	mutex_unlock(&udc_lock);
> +	if (ret)
> +		pr_warn("udc-core: couldn't find an available UDC or it's busy\n");
>  	return ret;
>  found:
>  	ret = udc_bind_to_driver(udc, driver);
> -- 
> 2.17.1
> 

Isn't this going to cause a lot more messages than is really needed?

And as you have a device, shouldn't this be dev_warn()?

thanks,

greg k-h
