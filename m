Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C2C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083A2206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wZzyKFsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDAMmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:42:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52202 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDAMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:42:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31CfeIn051164;
        Mon, 1 Apr 2019 07:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554122500;
        bh=XqPg5t8n2NI2G3877JsWJNa5hR67kuHSjala70lVDKs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wZzyKFshdkHR1o9cP7n0PQcbOHac+hMW6ghpZpLQPCc+mWEmwqZe88cezOAjvuXbV
         NwGnYrHAr8Oc8TJV5nO1w2CSoBxdt6sXfgyuVeU1aeKoeC5VJVQuFO1MLFlSQIwZbC
         RTxhkhge9eUXAZmF21Whjtqrwcgb7aSWJiyy2jpw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31CfdYu046447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 07:41:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 07:41:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 07:41:39 -0500
Received: from [172.22.75.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31CfdvF058154;
        Mon, 1 Apr 2019 07:41:39 -0500
Subject: Re: [PATCH] iio: adc: ads124: avoid buffer overflow
To:     =?UTF-8?Q?Vincent_Stehl=c3=a9?= <vincent.stehle@laposte.net>,
        <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20190331185423.11749-1-vincent.stehle@laposte.net>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <95d93ae2-1b7b-76fc-f72b-014a006f4c21@ti.com>
Date:   Mon, 1 Apr 2019 07:41:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331185423.11749-1-vincent.stehle@laposte.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/19 1:54 PM, Vincent Stehlé wrote:
> When initializing the priv->data array starting from index 1, there is one
> less element to consider than when initializing the full array.
> 
> Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/ti-ads124s08.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 53f17e4f2f230..552c2be8d87ad 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
>  	};
>  
>  	priv->data[0] = ADS124S08_CMD_RDATA;
> -	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
> +	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
>  
>  	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
>  	if (ret < 0)
> 

Reviewed-by: Dan Murphy <dmurphy@ti.com>
-- 
------------------
Dan Murphy
