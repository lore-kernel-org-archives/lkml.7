Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FCBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA59F22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfLKRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:35:41 -0500
Received: from foss.arm.com ([217.140.110.172]:40932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfLKRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:35:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 894E131B;
        Wed, 11 Dec 2019 09:35:40 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED623F52E;
        Wed, 11 Dec 2019 09:35:39 -0800 (PST)
Subject: Re: [PATCH 07/15] firmware: arm_scmi: Stash version in protocol init
 functions
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-8-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <48ee5468-f068-efb1-5a29-c16099e11618@arm.com>
Date:   Wed, 11 Dec 2019 17:35:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-8-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> In order to avoid querying the individual protocol versions multiple
> time with more that one device created for each protocol, we can simple
> store the copy in the protocol specific private data and use them whenever
> required.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/clock.c   | 2 ++
>  drivers/firmware/arm_scmi/perf.c    | 2 ++
>  drivers/firmware/arm_scmi/power.c   | 2 ++
>  drivers/firmware/arm_scmi/reset.c   | 2 ++
>  drivers/firmware/arm_scmi/sensors.c | 2 ++
>  5 files changed, 10 insertions(+)
> 

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>


Cristian



> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 6c24eb8a4e68..b567ec03f711 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -65,6 +65,7 @@ struct scmi_clock_set_rate {
>  };
> 
>  struct clock_info {
> +	u32 version;
>  	int num_clocks;
>  	int max_async_req;
>  	atomic_t cur_async_req;
> @@ -344,6 +345,7 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)
>  			scmi_clock_describe_rates_get(handle, clkid, clk);
>  	}
> 
> +	cinfo->version = version;
>  	handle->clk_ops = &clk_ops;
>  	handle->clk_priv = cinfo;
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 4f02bfba98ba..b1de6197f61c 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -145,6 +145,7 @@ struct perf_dom_info {
>  };
> 
>  struct scmi_perf_info {
> +	u32 version;
>  	int num_domains;
>  	bool power_scale_mw;
>  	u64 stats_addr;
> @@ -740,6 +741,7 @@ static int scmi_perf_protocol_init(struct scmi_device *dev)
>  			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
>  	}
> 
> +	pinfo->version = version;
>  	handle->perf_ops = &perf_ops;
>  	handle->perf_priv = pinfo;
> 
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 5a8faa369d82..d11c6cd6bbab 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -50,6 +50,7 @@ struct power_dom_info {
>  };
> 
>  struct scmi_power_info {
> +	u32 version;
>  	int num_domains;
>  	u64 stats_addr;
>  	u32 stats_size;
> @@ -211,6 +212,7 @@ static int scmi_power_protocol_init(struct scmi_device *dev)
>  		scmi_power_domain_attributes_get(handle, domain, dom);
>  	}
> 
> +	pinfo->version = version;
>  	handle->power_ops = &power_ops;
>  	handle->power_priv = pinfo;
> 
> diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> index 438d74a2c80a..dce103781b3f 100644
> --- a/drivers/firmware/arm_scmi/reset.c
> +++ b/drivers/firmware/arm_scmi/reset.c
> @@ -48,6 +48,7 @@ struct reset_dom_info {
>  };
> 
>  struct scmi_reset_info {
> +	u32 version;
>  	int num_domains;
>  	struct reset_dom_info *dom_info;
>  };
> @@ -221,6 +222,7 @@ static int scmi_reset_protocol_init(struct scmi_device *dev)
>  		scmi_reset_domain_attributes_get(handle, domain, dom);
>  	}
> 
> +	pinfo->version = version;
>  	handle->reset_ops = &reset_ops;
>  	handle->reset_priv = pinfo;
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index afa51bedfa5d..aac0243e2880 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -68,6 +68,7 @@ struct scmi_msg_sensor_reading_get {
>  };
> 
>  struct sensors_info {
> +	u32 version;
>  	int num_sensors;
>  	int max_requests;
>  	u64 reg_addr;
> @@ -298,6 +299,7 @@ static int scmi_sensors_protocol_init(struct scmi_device *dev)
> 
>  	scmi_sensor_description_get(handle, sinfo);
> 
> +	sinfo->version = version;
>  	handle->sensor_ops = &sensor_ops;
>  	handle->sensor_priv = sinfo;
> 
> --
> 2.17.1
> 

