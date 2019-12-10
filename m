Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7E120836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfLJSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:14:50 -0500
Received: from foss.arm.com ([217.140.110.172]:52834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfLJSOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:14:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79181FB;
        Tue, 10 Dec 2019 10:14:48 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795A93F6CF;
        Tue, 10 Dec 2019 10:14:48 -0800 (PST)
Subject: Re: [PATCH 03/15] firmware: arm_scmi: Skip protocol initialisation
 for additional devices
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-4-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <944a2d76-a3d3-9238-1960-63c3f29bea05@arm.com>
Date:   Tue, 10 Dec 2019 18:14:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-4-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> The scmi bus now supports adding multiple devices per protocol,
> and since scmi_protocol_init is called for each scmi device created,
> we must avoid allocating protocol private data and initialising the
> protocol itself if it is already initialised.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Wouldn't be better to add some kind of per-protocol 'initialized' flag somewhere
in the bus abstraction so that the protocol_id itself could be marked as initialized
once bus::scmi_protocol_init() completes successfully so that we could just skip the
invocation itself of bus::scmi_protocol_init() for all the protocols already detected
as initialized ?

Or, if not a flag, maybe deactivating the registered protocol init function itself
once it has been successfully called once .....something along the lines of:

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 7a30952b463d..a551a00586c6 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -73,6 +73,8 @@ static int scmi_dev_probe(struct device *dev)
        ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev->handle);
        if (ret)
                return ret;
+       idr_replace(&scmi_protocols, dummy_return_0_callback,
+                       scmi_dev->protocol_id);
 
        return scmi_drv->probe(scmi_dev);

[not really tested eh ... :D]

This way we can drop this patch as a whole and avoid any future needs to remember
to add this same sort of logic in the next XYZ protocol implementation.

Cheers

Cristian

>  drivers/firmware/arm_scmi/clock.c   | 3 +++
>  drivers/firmware/arm_scmi/perf.c    | 3 +++
>  drivers/firmware/arm_scmi/power.c   | 3 +++
>  drivers/firmware/arm_scmi/reset.c   | 3 +++
>  drivers/firmware/arm_scmi/sensors.c | 3 +++
>  5 files changed, 15 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 32526a793f3a..922b22aaaf84 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -316,6 +316,9 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
>  	int clkid, ret;
>  	struct clock_info *cinfo;
> 
> +	if (handle->clk_ops && handle->clk_priv)
> +		return 0; /* initialised already for the first device */
> +
>  	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
> 
>  	dev_dbg(handle->dev, "Clock Version %d.%d\n",
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 601af4edad5e..55c2a4c21ccb 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -710,6 +710,9 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
>  	u32 version;
>  	struct scmi_perf_info *pinfo;
> 
> +	if (handle->perf_ops && handle->perf_priv)
> +		return 0; /* initialised already for the first device */
> +
>  	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
> 
>  	dev_dbg(handle->dev, "Performance Version %d.%d\n",
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 5abef7079c0a..9a7593238b8f 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -185,6 +185,9 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
>  	u32 version;
>  	struct scmi_power_info *pinfo;
> 
> +	if (handle->power_ops && handle->power_priv)
> +		return 0; /* initialised already for the first device */
> +
>  	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
> 
>  	dev_dbg(handle->dev, "Power Version %d.%d\n",
> diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> index ab42c21c5517..809dc8faee1e 100644
> --- a/drivers/firmware/arm_scmi/reset.c
> +++ b/drivers/firmware/arm_scmi/reset.c
> @@ -195,6 +195,9 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
>  	u32 version;
>  	struct scmi_reset_info *pinfo;
> 
> +	if (handle->reset_ops && handle->reset_priv)
> +		return 0; /* initialised already for the first device */
> +
>  	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);
> 
>  	dev_dbg(handle->dev, "Reset Version %d.%d\n",
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index a400ea805fc2..b7f92c37c8a4 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -276,6 +276,9 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
>  	u32 version;
>  	struct sensors_info *sinfo;
> 
> +	if (handle->sensor_ops && handle->sensor_priv)
> +		return 0; /* initialised already for the first device */
> +
>  	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
> 
>  	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
> --
> 2.17.1
> 

