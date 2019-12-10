Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28574C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A820637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfLJS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:26:45 -0500
Received: from foss.arm.com ([217.140.110.172]:53124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLJS0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:26:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 060981FB;
        Tue, 10 Dec 2019 10:26:44 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86FA53F6CF;
        Tue, 10 Dec 2019 10:26:43 -0800 (PST)
Subject: Re: [PATCH 04/15] firmware: arm_scmi: Add names to scmi devices
 created
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-5-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <22634361-320b-e08e-d7f2-34a95038e838@arm.com>
Date:   Tue, 10 Dec 2019 18:26:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-5-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/12/2019 14:53, Sudeep Holla wrote:
> Now that scmi bus provides option to create named scmi device, let us
> create the default devices with names. This will help to add names for
> matching to respective drivers and eventually to add multiple devices
> and drivers per protocol.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 36 +++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 2952fcd8dd8a..0bbdc7c9eb0f 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -829,6 +829,40 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
>  	scmi_set_handle(sdev);
>  }
> 
> +#define MAX_SCMI_DEV_PER_PROTOCOL	2
> +struct scmi_prot_devnames {
> +	int protocol_id;
> +	char *names[MAX_SCMI_DEV_PER_PROTOCOL];
> +};
> +
> +static struct scmi_prot_devnames devnames[] = {
> +	{ SCMI_PROTOCOL_POWER,  { "genpd" },},
> +	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
> +	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
> +	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
> +	{ SCMI_PROTOCOL_RESET,  { "reset" },},
> +};
> +
> +static inline void
> +scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
> +			     int prot_id)
> +{
> +	int loop, cnt;
> +
> +	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
> +		if (devnames[loop].protocol_id != prot_id)
> +			continue;
> +
> +		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
> +			const char *name = devnames[loop].names[cnt];
> +
> +			if (name)
> +				scmi_create_protocol_device(np, info, prot_id,
> +							    name);
> +		}
> +	}
> +}
> +
>  static int scmi_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -897,7 +931,7 @@ static int scmi_probe(struct platform_device *pdev)
>  			continue;
>  		}
> 
> -		scmi_create_protocol_device(child, info, prot_id, NULL);
> +		scmi_create_protocol_devices(child, info, prot_id);
>  	}
> 
>  	return 0;
> --
> 2.17.1
> 

I'm a little bit puzzled by the builtin fixed define MAX_SCMI_DEV_PER_PROTOCOL, but
I have not really an alternative solution as of now, so looks good to me.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Cheers

Cristian
