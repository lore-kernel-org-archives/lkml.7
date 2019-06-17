Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B530DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941F7208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfFQPEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:04:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfFQPEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:04:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C92BC1D85F75F7B0EB3E;
        Mon, 17 Jun 2019 23:04:42 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 23:04:36 +0800
Subject: Re: [PATCH v3] bus: hisi_lpc: Avoid use-after-free from probe failure
To:     <xuwei5@huawei.com>
References: <1560770148-57960-1-git-send-email-john.garry@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <joe@perches.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bda4130a-411e-cb51-5736-a51226c3a99f@huawei.com>
Date:   Mon, 17 Jun 2019 16:04:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1560770148-57960-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2019 12:15, John Garry wrote:
> If, after registering a logical PIO range, the driver probe later fails,
> the logical PIO range memory will be released automatically.
>
> This causes an issue, in that the logical PIO range is not unregistered
> and the released range memory may be later referenced.
>
> As an interim fix, allocate the logical PIO range with kzalloc() to avoid
> this memory being freed.
>
> Further memory will not be leaked from later attempts to probe the
> driver, as any attempts to allocate logical PIO ranges will fail, and we
> would release the 'range' memory.
>
> The correct fix for this problem would be to tear down what had been setup
> during the probe, i.e. unregister the logical PIO range, but this is not
> supported.
>
> Support for unregistering logical PIO ranges will need be to added in
> future.
>
> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>

I just realized that there is another bug in this driver, regarding 
unbinding the driver from the device.

@xuwei, please ignore this patch. I need to fix this all properly, 
including adding the logical PIO unregister method.

John

> Change in v2:
> - update commit message
>
> Change to v1:
> - add comment, as advised by Joe Perches
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 19d7b6ff2f17..5f0130a693fe 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -599,7 +599,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lpcdev->membase))
>  		return PTR_ERR(lpcdev->membase);
>
> -	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> +	/* Logical PIO may reference 'range' memory even if the probe fails */
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);
>  	if (!range)
>  		return -ENOMEM;
>
> @@ -610,6 +611,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  	ret = logic_pio_register_range(range);
>  	if (ret) {
>  		dev_err(dev, "register IO range failed (%d)!\n", ret);
> +		kfree(range);
>  		return ret;
>  	}
>  	lpcdev->io_host = range;
>


