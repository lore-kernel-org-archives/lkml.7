Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB93C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089712171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfDLKLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:11:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59621 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDLKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:11:09 -0400
Received: from localhost (alyon-652-1-80-232.w109-213.abo.wanadoo.fr [109.213.223.232])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CF589240005;
        Fri, 12 Apr 2019 10:11:06 +0000 (UTC)
Date:   Fri, 12 Apr 2019 12:11:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: ds1685: use correct device struct to get
 platform device struct
Message-ID: <20190412101106.GU3578@piout.net>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
 <20190411143323.20945-2-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411143323.20945-2-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Every patch need a commit message. Maybe you could indicate that this
never gave any issue because parent is the first member of struct
device.

On 11/04/2019 16:33:22+0200, Thomas Bogendoerfer wrote:
> Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/rtc/rtc-ds1685.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 2f5194df239e..929f28375b87 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -655,7 +655,7 @@ ds1685_rtc_work_queue(struct work_struct *work)
>  {
>  	struct ds1685_priv *rtc = container_of(work,
>  					       struct ds1685_priv, work);
> -	struct platform_device *pdev = to_platform_device(&rtc->dev->dev);
> +	struct platform_device *pdev = to_platform_device(rtc->dev->dev.parent);
>  	struct mutex *rtc_mutex = &rtc->dev->ops_lock;
>  	u8 ctrl4a, ctrl4b;
>  
> -- 
> 2.13.7
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
