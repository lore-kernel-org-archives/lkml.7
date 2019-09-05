Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2C4C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C122168B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfIEHjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:39:51 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36847 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbfIEHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:39:51 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 30611100016;
        Thu,  5 Sep 2019 07:39:46 +0000 (UTC)
Date:   Thu, 5 Sep 2019 09:39:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     tony@atomide.com, udeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, kishon@ti.com, jonathanh@nvidia.com,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, arnd@arndb.de, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 4/4] rtc: ds1347: Use PTR_ERR_OR_ZERO rather than its
 implementation
Message-ID: <20190905073943.GA21254@piout.net>
References: <1567665795-5901-1-git-send-email-zhongjiang@huawei.com>
 <1567665795-5901-5-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567665795-5901-5-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 14:43:15+0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR. It is better to
> use it directly. hence just replace it.
> 

Unless you have a more significant contribution to this driver, I'm not
going to apply this patch, especially since it will have to be reverted
as soon as the probe function changes.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/rtc/rtc-ds1347.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
> index d392a7b..5a64eea 100644
> --- a/drivers/rtc/rtc-ds1347.c
> +++ b/drivers/rtc/rtc-ds1347.c
> @@ -151,10 +151,7 @@ static int ds1347_probe(struct spi_device *spi)
>  	rtc = devm_rtc_device_register(&spi->dev, "ds1347",
>  				&ds1347_rtc_ops, THIS_MODULE);
>  
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(rtc);
>  }
>  
>  static struct spi_driver ds1347_driver = {
> -- 
> 1.7.12.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
