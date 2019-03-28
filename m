Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3767C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A623820811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B4Uoes4z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nQ+prVcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfC1TOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:14:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfC1TOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:14:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0538B60DAD; Thu, 28 Mar 2019 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553800485;
        bh=/8eqhQXu8FqXoW/MEwlYvhUO/A3s8uDfg887oyukISQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B4Uoes4zJzsEFGgfRUVh9aibuoJtG40qFXsGMEBjTw6vN5M0bql5evoN5/umrYRuR
         LEIirgFhTRTQmvHptzL6/cdrSSFl585FUSErjCoCo2Oh9yvrKdPfe7X+QrQWnrDD9V
         ulsvwzHR4dmNqZuTJzx2ZLbv060fO89z2lFB/6ig=
Received: from [10.79.174.182] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF5AD60DAD;
        Thu, 28 Mar 2019 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553800483;
        bh=/8eqhQXu8FqXoW/MEwlYvhUO/A3s8uDfg887oyukISQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nQ+prVcnpzZj2CbcLF/vXJnyKcEPm/6bwLoLM9LrR3GFyVfmcL7VZsRgv17Jfu41k
         TW4ldD5eh1b7Xc0VOL0X7oOZYxE45HxTQBI+yANeQCr5n0DbcLmEUb4u61NHDNE4oF
         jNW0cOS6BYFwy7oLfP3seBEpWbf5UV6uKOEUqxnw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF5AD60DAD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] irqchip/irq-ls1x: Missing error code in
 ls1x_intc_of_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190328143854.GN32613@kadam>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a90ad2ff-acc1-0baf-d7e4-1292bb1c8464@codeaurora.org>
Date:   Fri, 29 Mar 2019 00:44:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328143854.GN32613@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 8:08 PM, Dan Carpenter wrote:
> We forgot to set "err" on this error path.

What is "this" error path, please describe

like

"Currently, when irq_domain_add_linear() fails, error code does not get 
set due to which

it return zero which is wrong.Fix it by setting appropriate error code."

> Fixes: 9e543e22e204 ("irqchip: Add driver for Loongson-1 interrupt controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>


Other wise change looks good .
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/irqchip/irq-ls1x.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
> index 86b72fbd3b45..353111a10413 100644
> --- a/drivers/irqchip/irq-ls1x.c
> +++ b/drivers/irqchip/irq-ls1x.c
> @@ -130,6 +130,7 @@ static int __init ls1x_intc_of_init(struct device_node *node,
>   					     NULL);
>   	if (!priv->domain) {
>   		pr_err("ls1x-irq: cannot add IRQ domain\n");
> +		err = -ENOMEM;
>   		goto out_iounmap;
>   	}
>   
