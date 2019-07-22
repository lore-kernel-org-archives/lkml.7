Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247BDC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF842190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfGVK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:26:13 -0400
Received: from foss.arm.com ([217.140.110.172]:35182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfGVK0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0FD28;
        Mon, 22 Jul 2019 03:26:12 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4AE3F71A;
        Mon, 22 Jul 2019 03:26:10 -0700 (PDT)
Subject: Re: [PATCH] rqchip/stm32: Remove unneeded call to kfree
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20190719184606.GA4701@hari-Inspiron-1545>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1d9aa4be-4da2-b532-4787-c98869c0bd9d@arm.com>
Date:   Mon, 22 Jul 2019 11:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719184606.GA4701@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2019 19:46, Hariprasad Kelam wrote:
> Memory allocated by devm_ alloc will be freed upon device detachment. So
> we may not require free memory.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/irqchip/irq-stm32-exti.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index e00f2fa..46ec0af 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -779,8 +779,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>  	irq_domain_remove(domain);
>  out_unmap:
>  	iounmap(host_data->base);
> -	kfree(host_data->chips_data);
> -	kfree(host_data);

In the commit this is based on these variables are not allocated using a
devm_ alloc function:

$ git show e00f2fa | grep -A12 *stm32_exti_host_init
> stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
> 					   struct device_node *node)
> {
> 	struct stm32_exti_host_data *host_data;
> 
> 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
> 	if (!host_data)
> 		return NULL;
> 
> 	host_data->drv_data = dd;
> 	host_data->chips_data = kcalloc(dd->bank_nr,
> 					sizeof(struct stm32_exti_chip_data),
> 					GFP_KERNEL);
The function stm32_exti_probe *does* use devm_k?alloc, so perhaps you
were getting confused with that?

Steve

>  	return ret;
>  }
>  
> 

