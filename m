Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC41C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5D920674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfKYRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:09:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfKYRJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:09:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A2F4D28FB79
Subject: Re: [PATCH v2] mfd / platform: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>, linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, gwendal@chromium.org
References: <20191122212905.35679-1-yichengli@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0f223903-ec93-a5ec-e858-fa0e2e282cf3@collabora.com>
Date:   Mon, 25 Nov 2019 18:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122212905.35679-1-yichengli@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/11/19 22:29, Yicheng Li wrote:
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
>  drivers/platform/chrome/cros_ec.c           | 23 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  5 +++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9b2d07422e17..a72514ac3ce7 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -104,6 +104,22 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
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
> +		mutex_unlock(&ec_dev->lock);
> +		return NOTIFY_OK;

I think you're missing a closing bracket here. Please make sure to do a build
test before sending the patches to the mailing list.

> +
> +	return NOTIFY_DONE;
> +}
> +
>  /**
>   * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>   * @ec_dev: Device to register.
> @@ -201,6 +217,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
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
> index 0d4e4aaed37a..4b016d5dbf50 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -161,6 +161,11 @@ struct cros_ec_device {
>  	int event_size;
>  	u32 host_event_wake_mask;
>  	u32 last_resume_result;
> +	/*
> +	 * The notifier block to let the kernel re-query EC communication
> +	 * protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
> +	 */

The comment should go in the documentation of the struct, above `struct
cros_ec_device` in correct kernel-doc format, not here.

Thanks,
 Enric

> +	struct notifier_block notifier_ready;
>  
>  	/* The platform devices used by the mfd driver */
>  	struct platform_device *ec;
> 
