Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF2AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CF12440F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559626414;
	bh=/AqLXxgwU4HMMp5AMsGXiUDAhlo3C581VimuqQkrBiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EPrgXu0XoNEwIEQQOKbPBjJzZ7Th5O1TuqA10qg0q4mJOW44wuYJ1vMjWF2+mMaSy
	 EXc2dp6sjxdLDj6pztlhgQG3fUnO8oFCLcDwzfPiDrk2bnEtTKGH4MdcfIUMjPpg75
	 E5jxLPrYsZA05eOK5u5brPjB6RWomoQrNlTXQMEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFDFdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFDFdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D420241D0;
        Tue,  4 Jun 2019 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559626412;
        bh=/AqLXxgwU4HMMp5AMsGXiUDAhlo3C581VimuqQkrBiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUEJCZD9NJn527j6EMeooX3N7pRo6FkECG2hGrnvfFkFHY7gid989MWX9GrNyQPTw
         0g0kjVIJcBCqZ4DpvxsKELqcDwGTKRmZk8nucRTkGWpjDzsSS7yBduLjd2NhqXlv91
         EKcqL71a1SF5IEvcMiPqjQnySUuFFHhDivWf4buE=
Date:   Tue, 4 Jun 2019 07:33:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: show the error number when
 driver_sysfs_add() fails
Message-ID: <20190604053330.GA1588@kroah.com>
References: <20190604041546.54380-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604041546.54380-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:15:46PM +0800, Kefeng Wang wrote:
> If driver_sysfs_add() fails, kernel shows following message,
> 
>   really_probe: driver_sysfs_add(portman.0) failed
>   ppdev: probe of portman.0 failed with error 0
> 
> It's better to show the error number like other probe_failed path.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/base/dd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0df9b4461766..04ee4e196530 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -493,7 +493,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  			goto probe_failed;
>  	}
>  
> -	if (driver_sysfs_add(dev)) {
> +	ret = driver_sysfs_add(dev);
> +	if (ret) {
>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>  			__func__, dev_name(dev));

Shouldn't this be where the error number is shown?  No need for all
callers to also show the same thing.

thanks,

greg k-h
