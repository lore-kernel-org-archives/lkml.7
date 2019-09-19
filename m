Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8AE21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbfISNEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:04:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40256 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbfISNEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:04:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B787728E9D2
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host
 command when probe failed.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190904062613.86401-1-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2c8e467f-fb78-4a2c-f6e4-c04336591bb9@collabora.com>
Date:   Thu, 19 Sep 2019 15:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190904062613.86401-1-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/9/19 8:26, Pi-Hsun Shih wrote:
> Since the rpmsg_endpoint is created before probe is called, it's
> possible that a host event is received during cros_ec_register, and
> there would be some pending work in the host_event_work workqueue while
> cros_ec_register is called.
> 
> If cros_ec_register fails, when the leftover work in host_event_work
> run, the ec_dev from the drvdata of the rpdev could be already set to
> NULL, causing kernel crash when trying to run cros_ec_get_next_event.
> 
> Fix this by creating the rpmsg_endpoint by ourself, and when
> cros_ec_register fails (or on remove), destroy the endpoint first (to
> make sure there's no more new calls to cros_ec_rpmsg_callback), and then
> cancel all works in the host_event_work workqueue.
> 
> Fixes: 2de89fd98958 ("platform/chrome: cros_ec: Add EC host command support using rpmsg")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---

Added the stable tag and applied for 5.4, the patches went to linux-next some
time ago, so sorry for late notice.

Thanks,
 Enric


>  drivers/platform/chrome/cros_ec_rpmsg.c | 33 +++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index 8b6bd775cc9a..0c3738c3244d 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -41,6 +41,7 @@ struct cros_ec_rpmsg {
>  	struct rpmsg_device *rpdev;
>  	struct completion xfer_ack;
>  	struct work_struct host_event_work;
> +	struct rpmsg_endpoint *ept;
>  };
>  
>  /**
> @@ -72,7 +73,6 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
>  				  struct cros_ec_command *ec_msg)
>  {
>  	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
> -	struct rpmsg_device *rpdev = ec_rpmsg->rpdev;
>  	struct ec_host_response *response;
>  	unsigned long timeout;
>  	int len;
> @@ -85,7 +85,7 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
>  	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
>  
>  	reinit_completion(&ec_rpmsg->xfer_ack);
> -	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
> +	ret = rpmsg_send(ec_rpmsg->ept, ec_dev->dout, len);
>  	if (ret) {
>  		dev_err(ec_dev->dev, "rpmsg send failed\n");
>  		return ret;
> @@ -196,11 +196,24 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
>  	return 0;
>  }
>  
> +static struct rpmsg_endpoint *
> +cros_ec_rpmsg_create_ept(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo = {};
> +
> +	strscpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +	chinfo.src = rpdev->src;
> +	chinfo.dst = RPMSG_ADDR_ANY;
> +
> +	return rpmsg_create_ept(rpdev, cros_ec_rpmsg_callback, NULL, chinfo);
> +}
> +
>  static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
>  {
>  	struct device *dev = &rpdev->dev;
>  	struct cros_ec_rpmsg *ec_rpmsg;
>  	struct cros_ec_device *ec_dev;
> +	int ret;
>  
>  	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
>  	if (!ec_dev)
> @@ -225,7 +238,18 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
>  	INIT_WORK(&ec_rpmsg->host_event_work,
>  		  cros_ec_rpmsg_host_event_function);
>  
> -	return cros_ec_register(ec_dev);
> +	ec_rpmsg->ept = cros_ec_rpmsg_create_ept(rpdev);
> +	if (!ec_rpmsg->ept)
> +		return -ENOMEM;
> +
> +	ret = cros_ec_register(ec_dev);
> +	if (ret < 0) {
> +		rpmsg_destroy_ept(ec_rpmsg->ept);
> +		cancel_work_sync(&ec_rpmsg->host_event_work);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
> @@ -234,7 +258,7 @@ static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
>  	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
>  
>  	cros_ec_unregister(ec_dev);
> -
> +	rpmsg_destroy_ept(ec_rpmsg->ept);
>  	cancel_work_sync(&ec_rpmsg->host_event_work);
>  }
>  
> @@ -271,7 +295,6 @@ static struct rpmsg_driver cros_ec_driver_rpmsg = {
>  	},
>  	.probe		= cros_ec_rpmsg_probe,
>  	.remove		= cros_ec_rpmsg_remove,
> -	.callback	= cros_ec_rpmsg_callback,
>  };
>  
>  module_rpmsg_driver(cros_ec_driver_rpmsg);
> 
