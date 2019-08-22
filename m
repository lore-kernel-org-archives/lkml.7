Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D54121848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfHVTge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:36:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37694 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfHVTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:36:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9266E28D43E
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Add host command AP sleep
 state support
To:     Yilun Lin <yllin@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     pihsun@chromium.org, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20190814081757.65056-1-yllin@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2dae986a-17c4-f06d-c7c9-47c93132f4aa@collabora.com>
Date:   Thu, 22 Aug 2019 21:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814081757.65056-1-yllin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/8/19 10:17, Yilun Lin wrote:
> Add EC host command to inform EC of AP suspend/resume status.
> 
> Signed-off-by: Yilun Lin <yllin@chromium.org>

The patch looks good to me but as I don't have the hardware to test this, could
I get a Tested-by Pi-Hsun if possible before queuing in chrome-platform-5.4

Thanks,
Enric

> ---
> 
>  drivers/platform/chrome/cros_ec_rpmsg.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index 5d3fb2abad1d..6f34fe629e2c 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -236,6 +236,25 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
>  	cancel_work_sync(&ec_rpmsg->host_event_work);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_ec_rpmsg_suspend(struct device *dev)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +	return cros_ec_suspend(ec_dev);
> +}
> +
> +static int cros_ec_rpmsg_resume(struct device *dev)
> +{
> +	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +	return cros_ec_resume(ec_dev);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_rpmsg_pm_ops, cros_ec_rpmsg_suspend,
> +			 cros_ec_rpmsg_resume);
> +
>  static const struct of_device_id cros_ec_rpmsg_of_match[] = {
>  	{ .compatible = "google,cros-ec-rpmsg", },
>  	{ }
> @@ -246,6 +265,7 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
>  	.drv = {
>  		.name   = "cros-ec-rpmsg",
>  		.of_match_table = cros_ec_rpmsg_of_match,
> +		.pm	= &cros_ec_rpmsg_pm_ops,
>  	},
>  	.probe		= cros_ec_rpmsg_probe,
>  	.remove		= cros_ec_rpmsg_remove,
> 
