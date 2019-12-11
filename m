Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EAFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731FD206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfLKSJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:09:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKSJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:09:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7208C31B;
        Wed, 11 Dec 2019 10:09:35 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72FF3F6CF;
        Wed, 11 Dec 2019 10:09:34 -0800 (PST)
Subject: Re: [PATCH 10/15] firmware: arm_scmi: Drop logging individual scmi
 protocol version
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-11-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <a5116e8e-d667-a7d5-fbb3-7f8bd19573b8@arm.com>
Date:   Wed, 11 Dec 2019 18:09:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-11-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> SCMI firmware and individual protocol versions and other attributes are
> now exposed as device attributes through sysfs entries. These debug logs
> can be dropped as the same information is available through sysfs.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/clock.c   | 3 ---
>  drivers/firmware/arm_scmi/perf.c    | 3 ---
>  drivers/firmware/arm_scmi/power.c   | 3 ---
>  drivers/firmware/arm_scmi/reset.c   | 3 ---
>  drivers/firmware/arm_scmi/sensors.c | 3 ---
>  5 files changed, 15 deletions(-)
> 

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>


Cristian


> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index b68736ae7f88..ce8cbefb0aa6 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -326,9 +326,6 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)
> 
>  	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
> 
> -	dev_dbg(handle->dev, "Clock Version %d.%d\n",
> -		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> -
>  	cinfo = devm_kzalloc(handle->dev, sizeof(*cinfo), GFP_KERNEL);
>  	if (!cinfo)
>  		return -ENOMEM;
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 8a02dc453894..2ad3bc792692 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -720,9 +720,6 @@ static int scmi_perf_protocol_init(struct scmi_device *dev)
> 
>  	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
> 
> -	dev_dbg(handle->dev, "Performance Version %d.%d\n",
> -		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> -
>  	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
>  	if (!pinfo)
>  		return -ENOMEM;
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 6267111e38e6..29d72fa7d085 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -195,9 +195,6 @@ static int scmi_power_protocol_init(struct scmi_device *dev)
> 
>  	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
> 
> -	dev_dbg(handle->dev, "Power Version %d.%d\n",
> -		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> -
>  	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
>  	if (!pinfo)
>  		return -ENOMEM;
> diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> index 76f1cee85a06..a49155628ccf 100644
> --- a/drivers/firmware/arm_scmi/reset.c
> +++ b/drivers/firmware/arm_scmi/reset.c
> @@ -205,9 +205,6 @@ static int scmi_reset_protocol_init(struct scmi_device *dev)
> 
>  	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);
> 
> -	dev_dbg(handle->dev, "Reset Version %d.%d\n",
> -		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> -
>  	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
>  	if (!pinfo)
>  		return -ENOMEM;
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index fb3bed4cb171..61e12f2fb587 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -286,9 +286,6 @@ static int scmi_sensors_protocol_init(struct scmi_device *dev)
> 
>  	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
> 
> -	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
> -		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> -
>  	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
>  	if (!sinfo)
>  		return -ENOMEM;
> --
> 2.17.1
> 

