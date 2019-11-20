Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D8520674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfKTQIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:08:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfKTQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:08:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C918728B52B
Subject: Re: [PATCH] mfd / platform: cros_ec: Query EC protocol version if EC
 transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>, linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, gwendal@chromium.org,
        =?UTF-8?Q?Fabien_Lahoud=c3=a8re?= <fabien.lahoudere@collabora.com>
References: <20191118200000.35484-1-yichengli@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <64265e5d-abd6-313e-0022-dac3719d7201@collabora.com>
Date:   Wed, 20 Nov 2019 17:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118200000.35484-1-yichengli@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicheng,

Many thanks for sending the patch upstream.

On 18/11/19 21:00, Yicheng Li wrote:
> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
> 

cc'ing: Fabien.

I am wondering if we should be able to reproduce this from userspace, i.e by
setting firmware to RO and issuing a EC_CMD_REBOOT.

What's the actual issue, if the firmware hangs switches to RO and reboots? Is
this happening in products or is something that you detected while playing with
the firmware?

> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
> 
> Signed-off-by: Yicheng Li <yichengli@chromium.org>
> 
> Change-Id: Ib58032ff4a8e113bdbd07212e8aff42807afff38
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Gwendal Grignou <gwendal@chromium.org>

You should get rid of the three above lines, did you use patman correctly to
send this patch?

> ---
>  drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9b2d07422e17..0c910846d99d 100644
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
> +		mutex_unlock(&ec_dev->lock);
> +		return NOTIFY_OK;
> +	} else {
> +		return NOTIFY_DONE;
> +	}

no else, just

        return NOTIFY_DONE;

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
> +	if (err < 0)
> +		dev_warn(ec_dev->dev, "Failed to register notifier\n");
> +

Is that only a warning and should be ignored if it fails?

BTW, blocking_notfier_chain_register _always_ returns 0. So I'd say that better
do in case at some point starts to returning something different.

if (err)
   return err;


>  	dev_info(dev, "Chrome EC device registered\n");
>  
>  	return 0;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37a..9840408c0b01 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -161,6 +161,7 @@ struct cros_ec_device {
>  	int event_size;
>  	u32 host_event_wake_mask;
>  	u32 last_resume_result;
> +	struct notifier_block notifier_ready;

You should add documentations for this new entry.

>  
>  	/* The platform devices used by the mfd driver */
>  	struct platform_device *ec;
> 

Thanks,
 Enric
