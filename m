Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9D4213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hP/6QKoX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n+7oqdtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDAIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:51:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfDAIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:51:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8437F611C5; Mon,  1 Apr 2019 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554108701;
        bh=P9UW3kzvEZEtvm5b0zY6w2l784BEgiTxmTqtkIMc0Rs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hP/6QKoXLhAQAig4lhba5zewzLMTamqVgpmfiC0dOz10GvnaAtzCvHdwmWKKHFMkW
         8dqAug4KXk6Yt8KNEKMgPnNw/qTBU9MuX5BHN6fr/mKX36O9WuCrr3jo6/HIIEhrUl
         HEfNBAPZlik05p/n+ywqbf9XU+sXyCpnWkluEq1g=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60CE4602AE;
        Mon,  1 Apr 2019 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554108699;
        bh=P9UW3kzvEZEtvm5b0zY6w2l784BEgiTxmTqtkIMc0Rs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n+7oqdtnjeksBu6Sza3rf4YLpI/HRCrSEIbQEDhAI2ZoyxOdOvZKDyfLYjHCK4cb2
         UV1hEPVEHxYkVQy9H52WS77R54Gy2kREgwcOs4pESah+W9mrDLfCbQQ89SoHvso/8y
         k1c8XwLk/epu+HPP3CqPYegy1nMh0F0pCmJMcvjo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60CE4602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] arm/mach-at91/pm : fix possible object reference leak
To:     Peng Hao <peng.hao2@zte.com.cn>, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1554135981-109288-1-git-send-email-peng.hao2@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2fd43a6c-f57b-d66e-740e-705a9a010e2b@codeaurora.org>
Date:   Mon, 1 Apr 2019 14:21:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554135981-109288-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 9:56 PM, Peng Hao wrote:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device. When returning error we should
> call put_device.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   arch/arm/mach-at91/pm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 51e808a..38511a5 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -591,13 +591,13 @@ static int __init at91_pm_backup_init(void)
>   
>   	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
>   	if (!np)
> -		goto securam_fail;
> +		goto securam_fail_no_get;


s/securam_fail_no_get/securam_fail_no_ref_dev

otherwise looks good.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


>   
>   	pdev = of_find_device_by_node(np);
>   	of_node_put(np);
>   	if (!pdev) {
>   		pr_warn("%s: failed to find securam device!\n", __func__);
> -		goto securam_fail;
> +		goto securam_fail_no_get;
>   	}
>   
>   	sram_pool = gen_pool_get(&pdev->dev, NULL);
> @@ -620,6 +620,8 @@ static int __init at91_pm_backup_init(void)
>   	return 0;
>   
>   securam_fail:
> +	put_device(&pdev->dev);
> +securam_fail_no_get:
>   	iounmap(pm_data.sfrbu);
>   	pm_data.sfrbu = NULL;
>   	return ret;
