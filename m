Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DCEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E997621874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aogvwp1J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fAP1VKAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfCTThR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:37:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:37:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6FAF602AE; Wed, 20 Mar 2019 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110635;
        bh=9zaHzkeM463//IkYhrQ5tOjwBRqgT+gb/DtAbGX/xeA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aogvwp1JwfWeN1QErAyr65s5CG8uZPZ6Tb4tD4VBzZ2ZD5DF7rQWCIm9CYfrGktcI
         y26C95dSLLef3edY6+ByiNzLZAp6KbhG71jf8y4DZtW3jyecvyFzxHBAX0Fkt7gjXQ
         WSU11iXGXt2a33uGXvkC5IH4NVbKsuLZ5j+jIRpM=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3272960159;
        Wed, 20 Mar 2019 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110634;
        bh=9zaHzkeM463//IkYhrQ5tOjwBRqgT+gb/DtAbGX/xeA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fAP1VKAt7TSARouRsMMsstOWNN02EniZO0hu/F1VTFDhp14ZIdzxQx2B+LCcB68Ke
         JAEwWAlQ8oNbUscFZn/RY4WYCJdHHhFImn47JwqgdxjLgKEP8Ox/s7RBs9zq3hlIsJ
         iDVaEw5VPsmgNHVpBjTqbbqHZqqcYFOtcvvUaNTo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3272960159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] irqchip/brcmstb-l2: Make two init functions static
To:     Yue Haibing <yuehaibing@huawei.com>, cernekee@gmail.com,
        f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, computersforpeace@gmail.com,
        gregory.0xf0@gmail.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org
References: <20190320142220.3224-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e1418be9-881b-3460-a820-44432d29419f@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:07:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320142220.3224-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:52 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/irqchip/irq-brcmstb-l2.c:278:12: warning:
>   symbol 'brcmstb_l2_edge_intc_of_init' was not declared. Should it be static?
> drivers/irqchip/irq-brcmstb-l2.c:285:12: warning:
>   symbol 'brcmstb_l2_lvl_intc_of_init' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/irqchip/irq-brcmstb-l2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
> index 83364fe..5e4ca13 100644
> --- a/drivers/irqchip/irq-brcmstb-l2.c
> +++ b/drivers/irqchip/irq-brcmstb-l2.c
> @@ -275,14 +275,14 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
>   	return ret;
>   }
>   
> -int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
> +static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
>   	struct device_node *parent)
>   {
>   	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
>   }
>   IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
>   
> -int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
> +static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
>   	struct device_node *parent)
>   {
>   	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>


Thanks,
Mukesh

