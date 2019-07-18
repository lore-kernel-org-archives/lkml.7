Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F918C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C072173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563438155;
	bh=g4IuIvW9pxmuWhc4yVBUShOQ7C6dIX/1CpC97IThK1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q6gygY4yIX5gPKkSnLyu9zbW3qYTcNKeUnk8vKXdi/wHmQKfm++TCbPcf3GZHqMkj
	 b/Ket1pfg5QPiybxeJyobvsmXiwImN8CFcVxQnUgmKxFUXiELYnoxHKZl8X1hUFPgj
	 ESn9hzqE7Zs1hCMsCva7ximFB1JBhJkb/Z8ti0jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbfGRIWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRIWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:22:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1A32173B;
        Thu, 18 Jul 2019 08:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563438153;
        bh=g4IuIvW9pxmuWhc4yVBUShOQ7C6dIX/1CpC97IThK1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFLfokf78OfrmVaEQ82oKyna3QYuK1PvnANlsbLTa+qRGtykWAWvvcCbmMyV85ut6
         WFvLS2A/4SWlaVUtLc5HRoCWOLAjfm1OCtvQBZhSVEdtJWMDhva2rX4Q996k46K2eM
         L8MXo/fdx6oytGFxjHN5iFZGPRaIHRgDcnG4moPQ=
Date:   Thu, 18 Jul 2019 16:22:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com, Marco Felsch <m.felsch@pengutronix.de>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3] soc: imx-scu: Add SoC UID(unique identifier) support
Message-ID: <20190718082216.GO3738@dragon>
References: <20190702074545.48267-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702074545.48267-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 03:45:45PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX SCU SoC's UID(unique identifier) support, user
> can read it from sysfs:
> 
> root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

@Marco, are you happy with it?

Shawn

> ---
> Change since V2:
> 	- The SCU FW API for getting UID does NOT have response, so we should set
> 	  imx_scu_call_rpc()'s 3rd parameter as false and still can check the returned
> 	  value, and comment is no needed any more.
> ---
>  drivers/soc/imx/soc-imx-scu.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
> index 676f612..50831eb 100644
> --- a/drivers/soc/imx/soc-imx-scu.c
> +++ b/drivers/soc/imx/soc-imx-scu.c
> @@ -27,6 +27,40 @@ struct imx_sc_msg_misc_get_soc_id {
>  	} data;
>  } __packed;
>  
> +struct imx_sc_msg_misc_get_soc_uid {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 uid_low;
> +	u32 uid_high;
> +} __packed;
> +
> +static ssize_t soc_uid_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct imx_sc_msg_misc_get_soc_uid msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	u64 soc_uid;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
> +	hdr->size = 1;
> +
> +	ret = imx_scu_call_rpc(soc_ipc_handle, &msg, false);
> +	if (ret) {
> +		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	soc_uid = msg.uid_high;
> +	soc_uid <<= 32;
> +	soc_uid |= msg.uid_low;
> +
> +	return sprintf(buf, "%016llX\n", soc_uid);
> +}
> +
> +static DEVICE_ATTR_RO(soc_uid);
> +
>  static int imx_scu_soc_id(void)
>  {
>  	struct imx_sc_msg_misc_get_soc_id msg;
> @@ -102,6 +136,11 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
>  		goto free_revision;
>  	}
>  
> +	ret = device_create_file(soc_device_to_device(soc_dev),
> +				 &dev_attr_soc_uid);
> +	if (ret)
> +		goto free_revision;
> +
>  	return 0;
>  
>  free_revision:
> -- 
> 2.7.4
> 
