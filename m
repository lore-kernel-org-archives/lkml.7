Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE0FC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A3C213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2urjqZV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OYXPvLVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDFSzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:55:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:55:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D3E2F60DAA; Sat,  6 Apr 2019 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576913;
        bh=sZIi7sVtnIyFpIMtRjg0FPo3f2P8xs6wosVrzi5Tm4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q2urjqZV7B6Z8neobFNYqluDovBespft6bwHaJkMUELV4tvrLOYZWQjpy0MjFI8dZ
         2vf33Lz8Y+Ar1lZIB5VPrMvZlpS38McLz/tsmFb0Tr9uKgG2cYs+55Aod36NO2EaL6
         F7xpYMsLkfXD51iFEg2czaRh4eN8+npjx1pDS58s=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1724F60350;
        Sat,  6 Apr 2019 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576912;
        bh=sZIi7sVtnIyFpIMtRjg0FPo3f2P8xs6wosVrzi5Tm4A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OYXPvLVoH+G69BsDew8YHd91gdaPxNfbRjw6M3WMugoAWCMGP4ZlWeIB6r/rguD4A
         a1WT/Hu+BZp7d5xkRdqYotTGm2L/cEJTX+yRkZpVGsdKUxJm2oSVPgshnrV8ndDtEZ
         lJHbC+C0m99822fnZRNMY0YKDnjKsv00VlGtBtwk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1724F60350
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS
To:     Yue Haibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, eric@anholt.net,
        stefan.wahren@i2se.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20190406151457.32104-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <093507a3-7eb0-3025-57a8-525811627a59@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:25:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406151457.32104-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 8:44 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_DEBUG_FS is not set
> gcc warn this:
>
> drivers/spi/spi-bcm2835aux.c: In function bcm2835aux_spi_probe:
> drivers/spi/spi-bcm2835aux.c:591:2: error: too many arguments to function bcm2835aux_debugfs_create
>    bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/spi/spi-bcm2835aux.c:145:13: note: declared here
>   static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 8048d151eb4d ("spi: bcm2835aux: add driver stats to debugfs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/spi/spi-bcm2835aux.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index fd8252d..bbf87ad 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -142,7 +142,8 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
>   	bs->debugfs_dir = NULL;
>   }
>   #else
> -static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
> +static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
> +				      const char *dname)
>   {
>   }
>   
