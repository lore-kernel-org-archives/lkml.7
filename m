Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8602075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfKZJ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:56:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47132 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKZJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:56:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7419A28D903
Subject: Re: [PATCH v4] mfd / platform: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>, linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, gwendal@chromium.org
References: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
 <20191125221517.91611-1-yichengli@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5fd3e86c-21ac-82fb-c3c5-4ff1f43e0219@collabora.com>
Date:   Tue, 26 Nov 2019 10:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125221517.91611-1-yichengli@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicheng,

I looked at this patch deeply and I have a question.

On 25/11/19 23:15, Yicheng Li wrote:
> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
> 
> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
> 
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  3 +++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9b2d07422e17..38ec1fb409a5 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  	return ret;
>  }
>  
> +static int cros_ec_ready_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> +						     notifier_ready);
> +	u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> +		mutex_lock(&ec_dev->lock);
> +		cros_ec_query_all(ec_dev);

I am wondering if instead of calling cros_ec_query_all we can just set the proto
version to unknown:

   ec_dev->proto_version == EC_PROTO_VERSION_UNKNOWN

and let the cros_ec_cmd_xfer function do its magic.

Should that work?

Thanks,
 Enric

> +		mutex_unlock(&ec_dev->lock);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>   * @ec_dev: Device to register.
> @@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
>  			err);
>  
> +	/* Register the notifier for EC_HOST_EVENT_INTERFACE_READY event. */
> +	ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> +	err = blocking_notifier_chain_register(&ec_dev->event_notifier,
> +					       &ec_dev->notifier_ready);
> +	if (err)
> +		return err;
> +
>  	dev_info(dev, "Chrome EC device registered\n");
>  
>  	return 0;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37a..a1c545c464e7 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -121,6 +121,8 @@ struct cros_ec_command {
>   * @event_data: Raw payload transferred with the MKBP event.
>   * @event_size: Size in bytes of the event data.
>   * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> + * @notifier_ready: The notifier_block to let the kernel re-query EC
> + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
>   * @ec: The platform_device used by the mfd driver to interface with the
>   *      main EC.
>   * @pd: The platform_device used by the mfd driver to interface with the
> @@ -161,6 +163,7 @@ struct cros_ec_device {
>  	int event_size;
>  	u32 host_event_wake_mask;
>  	u32 last_resume_result;
> +	struct notifier_block notifier_ready;
>  
>  	/* The platform devices used by the mfd driver */
>  	struct platform_device *ec;
> 
