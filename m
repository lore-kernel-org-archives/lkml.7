Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270C4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E643020857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N/m4Cwuf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="la5Q967n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfDAIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:32:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfDAIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:32:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B02F860A42; Mon,  1 Apr 2019 08:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107560;
        bh=Wwj+iFfUNzFeVqF1/xRHN56BiO8707yelBUyM6qJ198=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N/m4CwufTYt2qK6r/OmZQxonJaqoTC9dSkNePF13siasHFRy9hyGVuM2k9Y+fu6oM
         SWnlo7ees/tMXmZ0+asAsYHqxC6Xj7YY9ouz1VLrKYG0L9iDpbtNOroWlkNO/nOH9c
         +XdrfpxpNeDcj5D7iYFaoL4K0p/NhFtB4NDTR630=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E92E760A42;
        Mon,  1 Apr 2019 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107559;
        bh=Wwj+iFfUNzFeVqF1/xRHN56BiO8707yelBUyM6qJ198=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=la5Q967nm1Ynrxf5PEzrWe7ueAzjz6eoPcri/Y97aqbW47Yopk8aCAhZwaMDHDF4X
         /XIqOHdDRWrY75dk9OZXegywSrsn7qlO4x+kDIfoccwvQAzdvOet18Y8jiyat0wWbJ
         +LfOHismQAPu1WxYoZLPIPeU+2rhpt34g7NM1ibk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E92E760A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] iio: adc: ads124: avoid buffer overflow
To:     =?UTF-8?Q?Vincent_Stehl=c3=a9?= <vincent.stehle@laposte.net>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20190331185423.11749-1-vincent.stehle@laposte.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a133aeda-6477-0fd7-77b3-7a5383370f96@codeaurora.org>
Date:   Mon, 1 Apr 2019 14:02:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331185423.11749-1-vincent.stehle@laposte.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 12:24 AM, Vincent Stehlé wrote:
> When initializing the priv->data array starting from index 1, there is one
> less element to consider than when initializing the full array.
>
> Fixes: e717f8c6dfec8f76 ("iio: adc: Add the TI ads124s08 ADC code")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/iio/adc/ti-ads124s08.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 53f17e4f2f230..552c2be8d87ad 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -202,7 +202,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
>   	};
>   
>   	priv->data[0] = ADS124S08_CMD_RDATA;
> -	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
> +	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data) - 1);
>   
>   	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
>   	if (ret < 0)
