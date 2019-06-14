Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128AFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01292184B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ls6KWUT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFNQ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:27:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58734 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:27:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5EGQlZT119525;
        Fri, 14 Jun 2019 11:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560529607;
        bh=vqmvjxwgTo3qzEabnNtuwlRFMigOUexhlp/v7GIfBK8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ls6KWUT/hNWveAtXvTmMRIWkU5o6j68AaN1MLH/a2B6dHmuTgg4R/Vb/FYzBPF5/e
         uvOvDP7e/+trQWCWYMB2HIjE4KeyZaypr9nFpu3fYemLnVVK2TCbQGxNlezv7ykOHl
         P9GOGYZt+aVRHRFtOzU8mgh5gCr2XQKuchnNln1c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5EGQlDK081795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jun 2019 11:26:47 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 14
 Jun 2019 11:26:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 14 Jun 2019 11:26:47 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5EGQlVw037597;
        Fri, 14 Jun 2019 11:26:47 -0500
Subject: Re: [PATCH -next] firmware: ti_sci: remove set but not used variable
 'dev'
To:     YueHaibing <yuehaibing@huawei.com>, <nm@ti.com>, <t-kristo@ti.com>,
        <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190614154421.17556-1-yuehaibing@huawei.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1c1fad17-6efd-ceb7-8583-534e50627dbc@ti.com>
Date:   Fri, 14 Jun 2019 11:26:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614154421.17556-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 10:44 AM, YueHaibing wrote:
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

Thanks for the fix.

> 
> It is never used since commit 1e407f337f40 ("firmware:
> ti_sci: Add support for processor control")

Warnings are actually introduced in commit 68608b5e5063 ("firmware:
ti_sci: Add resource management APIs for ringacc, psi-l and udma").

While this patch fixes the warnings as well, I suggest to replace the
dev_dbg/dev_err traces in these functions to use the dev variable
instead of info->dev, to be consistent with the usage in the rest of the
file.

regards
Suman

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/firmware/ti_sci.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 86b2727..8c1a961 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2032,14 +2032,12 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
>  	struct ti_sci_msg_hdr *resp;
>  	struct ti_sci_xfer *xfer;
>  	struct ti_sci_info *info;
> -	struct device *dev;
>  	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(handle))
>  		return -EINVAL;
>  
>  	info = handle_to_ti_sci_info(handle);
> -	dev = info->dev;
>  
>  	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_CFG,
>  				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> @@ -2101,14 +2099,12 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
>  	struct ti_sci_msg_rm_ring_get_cfg_req *req;
>  	struct ti_sci_xfer *xfer;
>  	struct ti_sci_info *info;
> -	struct device *dev;
>  	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(handle))
>  		return -EINVAL;
>  
>  	info = handle_to_ti_sci_info(handle);
> -	dev = info->dev;
>  
>  	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_GET_CFG,
>  				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> @@ -2284,14 +2280,12 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
>  	struct ti_sci_msg_hdr *resp;
>  	struct ti_sci_xfer *xfer;
>  	struct ti_sci_info *info;
> -	struct device *dev;
>  	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(handle))
>  		return -EINVAL;
>  
>  	info = handle_to_ti_sci_info(handle);
> -	dev = info->dev;
>  
>  	xfer = ti_sci_get_one_xfer(info, TISCI_MSG_RM_UDMAP_TX_CH_CFG,
>  				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> @@ -2354,14 +2348,12 @@ static int ti_sci_cmd_rm_udmap_rx_ch_cfg(const struct ti_sci_handle *handle,
>  	struct ti_sci_msg_hdr *resp;
>  	struct ti_sci_xfer *xfer;
>  	struct ti_sci_info *info;
> -	struct device *dev;
>  	int ret = 0;
>  
>  	if (IS_ERR_OR_NULL(handle))
>  		return -EINVAL;
>  
>  	info = handle_to_ti_sci_info(handle);
> -	dev = info->dev;
>  
>  	xfer = ti_sci_get_one_xfer(info, TISCI_MSG_RM_UDMAP_RX_CH_CFG,
>  				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> 

