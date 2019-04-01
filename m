Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F7220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C5L8Irnn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j9QY/Lhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfDAHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:06:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:06:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5137B60850; Mon,  1 Apr 2019 07:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554102370;
        bh=mhLkSTo++toEVlLAx2ok7ONIAoi1fuWBpctNY0cUh28=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C5L8Irnn1TsICQNXJFfQkcGxSQcFYyy7fQ+ir6uteTx8U9UB1D6slt3UmLoV8RXgt
         LQBDa2he32nHd5H5g5HN3q4WRh8HfhhmZJhrDI4kKU/mj9yw2NvHtF7iN9QSqty1th
         2q5/0nnD6vgBB+TMbbjkHGk2abb6giW04RuV9DZo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B739760735;
        Mon,  1 Apr 2019 07:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554102369;
        bh=mhLkSTo++toEVlLAx2ok7ONIAoi1fuWBpctNY0cUh28=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j9QY/Lhe2JQa48RR08DkEbGC2skuGdkjihY/3W2S6bXjhNji9zgvQcAk8klwB5h21
         60m5BCZVPoYlI5rE1rnBaNajnUjx3tsEowpsJzVeUkgWtEv4aM5INdE0zWIUoD5JTh
         uRS6/ZNDJxJVQs20EgGdfsnPmNPDLgUE9hXIqrv0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B739760735
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH V2] arm/mach-at91/pm : fix possible object reference leak
To:     Peng Hao <peng.hao2@zte.com.cn>, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1554117631-108215-1-git-send-email-peng.hao2@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7c01bd62-7aee-3a84-0af0-e07f1801b571@codeaurora.org>
Date:   Mon, 1 Apr 2019 12:36:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554117631-108215-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 4:50 PM, Peng Hao wrote:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device. When returning error we should
> call put_device.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>   arch/arm/mach-at91/pm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 51e808a..b60fcc9 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -591,7 +591,7 @@ static int __init at91_pm_backup_init(void)
>   
>   	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
>   	if (!np)
> -		goto securam_fail;
> +		goto securam_fail_1;
>   
>   	pdev = of_find_device_by_node(np);
>   	of_node_put(np);


I think you missed the label in

if (!pdev)

     goto securam_fail_1


Please fix that and also if possible give some proper name to the label.

Cheers,
Mukesh

> @@ -620,6 +620,8 @@ static int __init at91_pm_backup_init(void)
>   	return 0;
>   
>   securam_fail:
> +	put_device(&pdev->dev);
> +securam_fail_1:



>   	iounmap(pm_data.sfrbu);
>   	pm_data.sfrbu = NULL;
>   	return ret;
