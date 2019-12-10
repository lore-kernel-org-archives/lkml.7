Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57694C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7662073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLJRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:03:01 -0500
Received: from foss.arm.com ([217.140.110.172]:51096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfLJRDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:03:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93101FB;
        Tue, 10 Dec 2019 09:02:59 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79C833F6CF;
        Tue, 10 Dec 2019 09:02:59 -0800 (PST)
Subject: Re: [PATCH 01/15] firmware: arm_scmi: Add support for multiple device
 per protocol
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-2-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <3d3a3b53-dc2e-bcac-66c6-9537ffaf7be1@arm.com>
Date:   Tue, 10 Dec 2019 17:02:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-2-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 10/12/2019 14:53, Sudeep Holla wrote:
> Currently only one scmi device is created for each protocol enumerated.
> However, there is requirement to make use of some procotols by multiple
> kernel subsystems/frameworks. One such example is SCMI PERFORMANCE
> protocol which can be used by both cpufreq and devfreq drivers.
> Similarly, SENSOR protocol may be used by hwmon and iio subsystems,
> and POWER protocol may be used by genpd and regulator drivers.
> 
> In order to achieve that, let us extend the scmi bus to match based
> not only protocol id but also the scmi device name if one is available.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/bus.c    | 20 +++++++++++++++++---
>  drivers/firmware/arm_scmi/driver.c |  6 +++---
>  include/linux/scmi_protocol.h      |  5 ++++-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 

Looks good to me.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Cheers

Cristian

> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 7a30952b463d..3714e6307b05 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -28,8 +28,12 @@ scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
>  		return NULL;
> 
>  	for (; id->protocol_id; id++)
> -		if (id->protocol_id == scmi_dev->protocol_id)
> -			return id;
> +		if (id->protocol_id == scmi_dev->protocol_id) {
> +			if (!id->name)
> +				return id;
> +			else if (!strcmp(id->name, scmi_dev->name))
> +				return id;
> +		}
> 
>  	return NULL;
>  }
> @@ -125,7 +129,8 @@ static void scmi_device_release(struct device *dev)
>  }
> 
>  struct scmi_device *
> -scmi_device_create(struct device_node *np, struct device *parent, int protocol)
> +scmi_device_create(struct device_node *np, struct device *parent, int protocol,
> +		   const char *name)
>  {
>  	int id, retval;
>  	struct scmi_device *scmi_dev;
> @@ -134,8 +139,15 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
>  	if (!scmi_dev)
>  		return NULL;
> 
> +	scmi_dev->name = kstrdup_const(name ?: "unknown", GFP_KERNEL);
> +	if (!scmi_dev->name) {
> +		kfree(scmi_dev);
> +		return NULL;
> +	}
> +
>  	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
>  	if (id < 0) {
> +		kfree_const(scmi_dev->name);
>  		kfree(scmi_dev);
>  		return NULL;
>  	}
> @@ -154,6 +166,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
> 
>  	return scmi_dev;
>  put_dev:
> +	kfree_const(scmi_dev->name);
>  	put_device(&scmi_dev->dev);
>  	ida_simple_remove(&scmi_bus_id, id);
>  	return NULL;
> @@ -161,6 +174,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
> 
>  void scmi_device_destroy(struct scmi_device *scmi_dev)
>  {
> +	kfree_const(scmi_dev->name);
>  	scmi_handle_put(scmi_dev->handle);
>  	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
>  	device_unregister(&scmi_dev->dev);
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 3eb0382491ce..dee7ce3bd815 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -803,11 +803,11 @@ scmi_mbox_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
> 
>  static inline void
>  scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
> -			    int prot_id)
> +			    int prot_id, const char *name)
>  {
>  	struct scmi_device *sdev;
> 
> -	sdev = scmi_device_create(np, info->dev, prot_id);
> +	sdev = scmi_device_create(np, info->dev, prot_id, name);
>  	if (!sdev) {
>  		dev_err(info->dev, "failed to create %d protocol device\n",
>  			prot_id);
> @@ -892,7 +892,7 @@ static int scmi_probe(struct platform_device *pdev)
>  			continue;
>  		}
> 
> -		scmi_create_protocol_device(child, info, prot_id);
> +		scmi_create_protocol_device(child, info, prot_id, NULL);
>  	}
> 
>  	return 0;
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 881fea47c83d..5c873a59b387 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -257,6 +257,7 @@ enum scmi_std_protocol {
>  struct scmi_device {
>  	u32 id;
>  	u8 protocol_id;
> +	const char *name;
>  	struct device dev;
>  	struct scmi_handle *handle;
>  };
> @@ -264,11 +265,13 @@ struct scmi_device {
>  #define to_scmi_dev(d) container_of(d, struct scmi_device, dev)
> 
>  struct scmi_device *
> -scmi_device_create(struct device_node *np, struct device *parent, int protocol);
> +scmi_device_create(struct device_node *np, struct device *parent, int protocol,
> +		   const char *name);
>  void scmi_device_destroy(struct scmi_device *scmi_dev);
> 
>  struct scmi_device_id {
>  	u8 protocol_id;
> +	const char *name;
>  };
> 
>  struct scmi_driver {
> --
> 2.17.1
> 

