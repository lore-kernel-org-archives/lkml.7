Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F186C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D167206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RJ9/hWEe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RJ9/hWEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfC1Oby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:31:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfC1Obx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:31:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8B966083E; Thu, 28 Mar 2019 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553783512;
        bh=v6IWSctTVL4JjYveJIIOcEvQIEIZmB0b/72b+JKB8PA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RJ9/hWEekdeA8mxMynlBiHFu8LZZf03/aKm0IXBMoAbTBpyXSRZHE97QykW3ZpSnh
         8KYoohLUu3WFPvC+ZTEF4eNtfflsmlAnuZR4s4TM3Kn0SgxAnXy60PSouLge+hqvOP
         b1K9lcrCFlOm5wySUbCt/I5CXvrNMG6PO8lqCcFI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65D4560ADE;
        Thu, 28 Mar 2019 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553783512;
        bh=v6IWSctTVL4JjYveJIIOcEvQIEIZmB0b/72b+JKB8PA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RJ9/hWEekdeA8mxMynlBiHFu8LZZf03/aKm0IXBMoAbTBpyXSRZHE97QykW3ZpSnh
         8KYoohLUu3WFPvC+ZTEF4eNtfflsmlAnuZR4s4TM3Kn0SgxAnXy60PSouLge+hqvOP
         b1K9lcrCFlOm5wySUbCt/I5CXvrNMG6PO8lqCcFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65D4560ADE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] vlynq: Fix uninitialized error code in probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190328141742.GM32590@kadam>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9a8d9a48-e95d-8607-5181-f264bcabd3c8@codeaurora.org>
Date:   Thu, 28 Mar 2019 20:01:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328141742.GM32590@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 7:47 PM, Dan Carpenter wrote:
> The "result" variable isn't initialized on this error path.
>
> Fixes: 55e331cf7ebe ("drivers: add support for the TI VLYNQ bus")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   drivers/vlynq/vlynq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vlynq/vlynq.c b/drivers/vlynq/vlynq.c
> index c0227f9418eb..44d3485d1108 100644
> --- a/drivers/vlynq/vlynq.c
> +++ b/drivers/vlynq/vlynq.c
> @@ -727,7 +727,8 @@ static int vlynq_probe(struct platform_device *pdev)
>   	dev->local_irq = dev->irq_end - dev->irq_start;
>   	dev->remote_irq = dev->local_irq - 1;
>   
> -	if (device_register(&dev->dev))
> +	result = device_register(&dev->dev);
> +	if (result)
>   		goto fail_register;
>   	platform_set_drvdata(pdev, dev);
>   
