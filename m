Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623A8C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332B7206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfFRJYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:24:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729113AbfFRJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:24:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 159D584C95F6DBDB2F57;
        Tue, 18 Jun 2019 17:24:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 17:23:59 +0800
Subject: Re: [PATCH v2] irqchip/mbigen: stop printing kernel addresses
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
References: <20190618032202.11087-1-wangkefeng.wang@huawei.com>
 <20190618091505.151466-1-wangkefeng.wang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <172a0767-284b-7d10-5c8a-1d4414aaad3e@huawei.com>
Date:   Tue, 18 Jun 2019 17:23:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190618091505.151466-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/18 17:15, Kefeng Wang wrote:
> After commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> it will print "____ptrval____" instead of actual addresses when mbigen
> create domain fails,
> 
>   Hisilicon MBIGEN-V2 HISI0152:00: Failed to create mbi-gen@(____ptrval____) irqdomain
>   Hisilicon MBIGEN-V2: probe of HISI0152:00 failed with error -12
> 
> dev_xxx() helper contains the device info, HISI0152:00, which stands for
> mbigen ACPI HID and its UID, we can identify the failing probed mbigen,
> so just remove the printing "mgn_chip->base", and also add missing "\n".
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 98b6e1d4b1a6..c0f65ea0ae0f 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -355,8 +355,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  		err = -EINVAL;
>  
>  	if (err) {
> -		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
> -			mgn_chip->base);
> +		dev_err(&pdev->dev, "Failed to create mbi-gen irqdomain\n");
>  		return err;

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

