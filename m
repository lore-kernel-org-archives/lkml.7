Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52537C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574344668;
	bh=cf0uWOIfUkIj9zjrethb4lj0w1bhSCTZgxGIhOJ55EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oTYE0L7BIyieQRAhZ8VXQKM9pmssq5RXSaiLpUsiMZmeovAd2TNhYaAL6LAmpXcKx
	 k8tj3T3gz7P90OoagopDqXDlzqJXwAIzIzJFO6Ue+ETexo0pq6u/Y83FggcfZkifyw
	 8zlEI24YRPVM6IUwC0SSEF3WzprRW4wZaSEDacLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKUN5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKUN5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:57:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1EAB2070B;
        Thu, 21 Nov 2019 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574344666;
        bh=cf0uWOIfUkIj9zjrethb4lj0w1bhSCTZgxGIhOJ55EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAe0p8myHUaTS3uGM7P/wWCP1xJdsJuJW7np3Sw3RsUY4HcC48A/M/Oe+vOPJOumt
         A1vN2q+pRUyf6OrW5tvaRAQhbCqdEDOy4tcReFO3Ay2EueWrsn7hEFB7mFB0IaSp0T
         BunpTt1lEbNchA2Knmpsu5+/F++klqJtUWKZ+Ssc=
Date:   Thu, 21 Nov 2019 14:57:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: Print device in really_probe() warning
 backtrace
Message-ID: <20191121135743.GA552517@kroah.com>
References: <20191120143619.1027-1-geert+renesas@glider.be>
 <20191120143619.1027-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120143619.1027-3-geert+renesas@glider.be>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 03:36:19PM +0100, Geert Uytterhoeven wrote:
> If a device already has devres items attached before probing, a warning
> backtrace is printed.  However, this backtrace does not reveal the
> offending device, leaving the user uninformed.
> 
> Use dev_WARN_ON() instead of WARN_ON() to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index d811e60610d33ae9..a7e8040ef0003f44 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -516,7 +516,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	atomic_inc(&probe_count);
>  	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
>  		 drv->bus->name, __func__, drv->name, dev_name(dev));
> -	WARN_ON(!list_empty(&dev->devres_head));
> +	dev_WARN_ON(dev, !list_empty(&dev->devres_head));

We really do not want WARN_ON() anywhere, as that causes systems with
panic-on-warn to reboot.

If this can happen, we should switch it to a real error message, with
dev_err() and the like, and recover properly.

I don't want to make it easier to add WARN_ON() lines, like
dev_WARN_ON() would allow, instead we should be removing them, as they
encourage slopping programming habits.

thanks,

greg k-h
