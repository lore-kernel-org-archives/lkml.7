Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6867E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EDdKCmHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfFQSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:41:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47898 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfFQSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:41:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5HIff7a085314;
        Mon, 17 Jun 2019 13:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560796901;
        bh=B3vkuFEUJ6Y+O0/Ge2hah5BykSfysAS/GfgDfsj6bMM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EDdKCmHTCHn9AKkRwgMVrf6ak3sB0ko3yysHGWqzNslmzDwDnj2TJzkzWSoMstDHJ
         9ronLXuw8GrxcdYsZhuEvLFzd5R9Idzm+INtWI+XiWMnt2SUHLyicvfKdxEHVQF6XQ
         SCOHMV5NGt126+VXoxFxQd1dKuj0r6k2rAs77jY8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5HIffow065358
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jun 2019 13:41:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 17
 Jun 2019 13:41:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 17 Jun 2019 13:41:40 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5HIfeus104041;
        Mon, 17 Jun 2019 13:41:40 -0500
Subject: Re: [PATCH v3 -next] firmware: ti_sci: Fix gcc
 unused-but-set-variable warning
To:     YueHaibing <yuehaibing@huawei.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190614154421.17556-1-yuehaibing@huawei.com>
 <20190615125054.16416-1-yuehaibing@huawei.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <e13fe9fa-4a79-8af5-6968-dfc9364a3c55@ti.com>
Date:   Mon, 17 Jun 2019 13:41:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190615125054.16416-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/19 7:50 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_config:
> drivers/firmware/ti_sci.c:2035:17: warning: variable dev set but not used [-Wunused-but-set-variable]
> drivers/firmware/ti_sci.c: In function ti_sci_cmd_ring_get_config:
> drivers/firmware/ti_sci.c:2104:17: warning: variable dev set but not used [-Wunused-but-set-variable]
> drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_tx_ch_cfg:
> drivers/firmware/ti_sci.c:2287:17: warning: variable dev set but not used [-Wunused-but-set-variable]
> drivers/firmware/ti_sci.c: In function ti_sci_cmd_rm_udmap_rx_ch_cfg:
> drivers/firmware/ti_sci.c:2357:17: warning: variable dev set but not used [-Wunused-but-set-variable]
> 
> Use the 'dev' variable instead of info->dev to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Suman Anna <s-anna@ti.com>

Hi Santosh,
Can you pick up this patch, goes on top of your for_5.3/driver-soc branch?

regards
Suman

> ---
> v3: fix patch title
> v2: use the 'dev' variable as Suman Anna's suggestion
> ---
>  drivers/firmware/ti_sci.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 86b2727..c8da6e2 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2046,7 +2046,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
>  				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> -		dev_err(info->dev, "RM_RA:Message config failed(%d)\n", ret);
> +		dev_err(dev, "RM_RA:Message config failed(%d)\n", ret);
>  		return ret;
>  	}
>  	req = (struct ti_sci_msg_rm_ring_cfg_req *)xfer->xfer_buf;
> @@ -2062,7 +2062,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
>  
>  	ret = ti_sci_do_xfer(info, xfer);
>  	if (ret) {
> -		dev_err(info->dev, "RM_RA:Mbox config send fail %d\n", ret);
> +		dev_err(dev, "RM_RA:Mbox config send fail %d\n", ret);
>  		goto fail;
>  	}
>  
> @@ -2071,7 +2071,7 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);
> -	dev_dbg(info->dev, "RM_RA:config ring %u ret:%d\n", index, ret);
> +	dev_dbg(dev, "RM_RA:config ring %u ret:%d\n", index, ret);
>  	return ret;
>  }
>  
> @@ -2115,7 +2115,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
>  				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> -		dev_err(info->dev,
> +		dev_err(dev,
>  			"RM_RA:Message get config failed(%d)\n", ret);
>  		return ret;
>  	}
> @@ -2125,7 +2125,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
>  
>  	ret = ti_sci_do_xfer(info, xfer);
>  	if (ret) {
> -		dev_err(info->dev, "RM_RA:Mbox get config send fail %d\n", ret);
> +		dev_err(dev, "RM_RA:Mbox get config send fail %d\n", ret);
>  		goto fail;
>  	}
>  
> @@ -2150,7 +2150,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);
> -	dev_dbg(info->dev, "RM_RA:get config ring %u ret:%d\n", index, ret);
> +	dev_dbg(dev, "RM_RA:get config ring %u ret:%d\n", index, ret);
>  	return ret;
>  }
>  
> @@ -2298,7 +2298,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>  				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> -		dev_err(info->dev, "Message TX_CH_CFG alloc failed(%d)\n", ret);
> +		dev_err(dev, "Message TX_CH_CFG alloc failed(%d)\n", ret);
>  		return ret;
>  	}
>  	req = (struct ti_sci_msg_rm_udmap_tx_ch_cfg_req *)xfer->xfer_buf;
> @@ -2323,7 +2323,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>  
>  	ret = ti_sci_do_xfer(info, xfer);
>  	if (ret) {
> -		dev_err(info->dev, "Mbox send TX_CH_CFG fail %d\n", ret);
> +		dev_err(dev, "Mbox send TX_CH_CFG fail %d\n", ret);
>  		goto fail;
>  	}
>  
> @@ -2332,7 +2332,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);
> -	dev_dbg(info->dev, "TX_CH_CFG: chn %u ret:%u\n", params->index, ret);
> +	dev_dbg(dev, "TX_CH_CFG: chn %u ret:%u\n", params->index, ret);
>  	return ret;
>  }
>  
> @@ -2368,7 +2368,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
>  				   sizeof(*req), sizeof(*resp));
>  	if (IS_ERR(xfer)) {
>  		ret = PTR_ERR(xfer);
> -		dev_err(info->dev, "Message RX_CH_CFG alloc failed(%d)\n", ret);
> +		dev_err(dev, "Message RX_CH_CFG alloc failed(%d)\n", ret);
>  		return ret;
>  	}
>  	req = (struct ti_sci_msg_rm_udmap_rx_ch_cfg_req *)xfer->xfer_buf;
> @@ -2392,7 +2392,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
>  
>  	ret = ti_sci_do_xfer(info, xfer);
>  	if (ret) {
> -		dev_err(info->dev, "Mbox send RX_CH_CFG fail %d\n", ret);
> +		dev_err(dev, "Mbox send RX_CH_CFG fail %d\n", ret);
>  		goto fail;
>  	}
>  
> @@ -2401,7 +2401,7 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);
> -	dev_dbg(info->dev, "RX_CH_CFG: chn %u ret:%d\n", params->index, ret);
> +	dev_dbg(dev, "RX_CH_CFG: chn %u ret:%d\n", params->index, ret);
>  	return ret;
>  }
>  
> 

