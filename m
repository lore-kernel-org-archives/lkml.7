Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E724C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05720883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554743701;
	bh=w3axn3IKmbbdHADBFVXh5IYdObTPM3blY3lwyXK2Uvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NZxnqycoSq8eNkWqcp0VzO7xq1suKcQSeV8/pkAvTlCv0OW95XxKJH4aPvtlUJ7ya
	 GdI2A214Ik3fyseAHZFvzMoxHucq2Zu+fBpjrzFLrcCU4OhDM7VYAMdvQqtQfQnytJ
	 qIOUFCFYD/uxt+rnnHq+Es6leKmt/QTI6K4yzTYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfDHRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:15:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42355 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfDHRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:15:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so7678016pgh.9;
        Mon, 08 Apr 2019 10:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fneGyeT7Wy+lpONyF0RwS0qJrvMNzcNI01c4V1XGc1k=;
        b=pnvYX23f/0Ry9ySTEs0ByaANDtzAvWif4Hvt/83tZksc0mRWXeBlvZ0LbTO2sqrsP1
         +WAjEHLT11OYYx5+pkZYjS6GT4rx5fvfoJWl3n0ybHX3swqHIjZ7Y+q/T68Waid4v/5Z
         ujWKsSKO9RvUh38cNdNQ7uDUDZ/U2jK7t9/1DVtuC6vzIIP19tzb5Vs7VJ0hFoPTJJ5F
         mpFeDweBAzYY92INaDRMWARRN3CaEVDl88FBICA6Z7iqu91H24//ky1Vod+dwpk2aJnB
         zSuIG1Y4fa1pyDivfAWvaI480+pnJGZqmtdD/7j5tRHE//ofdocjJ+UfeXmCYqk+1Ejd
         zt9g==
X-Gm-Message-State: APjAAAW9iJindPzrtAmqwC2sQv/nGE0vflmWj5BIM2GlamUYBUS2aISG
        GQ2ZCqhBlajyMsRnoZnfNYg=
X-Google-Smtp-Source: APXvYqyjYWBT4xUbsv+enNk3INNLO1xpIwZiy6IIBvf2u4gXCX3mXwDes1nU4CpxjNjjL8Hec+TVug==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr31475397pfh.187.1554743698537;
        Mon, 08 Apr 2019 10:14:58 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id p66sm33186024pfb.4.2019.04.08.10.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 10:14:57 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:14:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com,
        jollys@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Subject: Re: [PATCH v4 1/3] firmware: xilinx: Add fpga API's
Message-ID: <20190408171456.GA4293@archbook>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402123123.915-2-nava.manne@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nava,

On Tue, Apr 02, 2019 at 06:01:21PM +0530, Nava kishore Manne wrote:
> This Patch Adds fpga API's to support the Bitstream loading
> by using firmware interface.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
> 		-None.
> 
> Chnages for v3:
> 		-Created patches on top of 5.0-rc5.
> 		 No functional changes.
> 
> Changes for v2:
> 		-Added Firmware FPGA Manager flags As suggested by
> 		 Moritz.
> 
> Changes for v1:
> 		-None.
> 
> Changes for RFC-V2:
> 		-New Patch
> 
>  drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 10 ++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 98f936125643..7159a90abc44 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -537,6 +537,50 @@ static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
>  	return ret;
>  }
>  
> +/*
> + * zynqmp_pm_fpga_load - Perform the fpga load
> + * @address:	Address to write to
> + * @size:	pl bitstream size
> + * @flags:
> + *	BIT(0) - Bit-stream type.
> + *		 0 - Full Bitstream.
> + *		 1 - Partial Bitstream.
> + *
> + * This function provides access to pmufw. To transfer
> + * the required bitstream into PL.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
> +			       const u32 flags)
> +{
> +	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> +				   upper_32_bits(address), size, flags, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_fpga_get_status - Read value from PCAP status register
> + * @value: Value to read
> + *
> + * This function provides access to the xilfpga library to get

xilfpga? Is that PMU firmware you're talking about?

> + * the PCAP status
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_fpga_get_status(u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
> +	*value = ret_payload[1];
> +
> +	return ret;
> +}
> +
>  /**
>   * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
>   *			       master has initialized its own power management
> @@ -640,6 +684,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>  	.request_node = zynqmp_pm_request_node,
>  	.release_node = zynqmp_pm_release_node,
>  	.set_requirement = zynqmp_pm_set_requirement,
> +	.fpga_load = zynqmp_pm_fpga_load,
> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
>  };
>  
>  /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 642dab10f65d..4df226b6ab0f 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -48,6 +48,12 @@
>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>  #define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
>  
> +/*
> + * Firmware FPGA Manager flags
> + * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
> + */
> +#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
> +
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
>  	PM_REQUEST_NODE = 13,
> @@ -56,6 +62,8 @@ enum pm_api_id {
>  	PM_RESET_ASSERT = 17,
>  	PM_RESET_GET_STATUS,
>  	PM_PM_INIT_FINALIZE = 21,
> +	PM_FPGA_LOAD = 22,
> +	PM_FPGA_GET_STATUS,

Any reason you can't do 'PM_FPGA_GET_STATUS = 23' here? Trying to
understand your reasoning. Are you planning to move them around?
>  	PM_GET_CHIPID = 24,
>  	PM_IOCTL = 34,
>  	PM_QUERY_DATA,
> @@ -258,6 +266,8 @@ struct zynqmp_pm_query_data {
>  struct zynqmp_eemi_ops {
>  	int (*get_api_version)(u32 *version);
>  	int (*get_chipid)(u32 *idcode, u32 *version);
> +	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
> +	int (*fpga_get_status)(u32 *value);
>  	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
>  	int (*clock_enable)(u32 clock_id);
>  	int (*clock_disable)(u32 clock_id);
> -- 
> 2.18.0
> 

Thanks,
Moritz
