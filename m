Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BCDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD520850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfCUJLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:11:43 -0400
Received: from foss.arm.com ([217.140.101.70]:52980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfCUJLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:11:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45B7F374;
        Thu, 21 Mar 2019 02:11:42 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5223F71A;
        Thu, 21 Mar 2019 02:11:39 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:11:35 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     chenjianguo <chenjianguo3@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liyou (leeyou, RTOS)" <leeyou.li@huawei.com>,
        "Joey Yan(Bo)" <joey.yanbo@huawei.com>,
        "Xiaowei (C)" <xiaowei774@huawei.com>,
        "zhanghan (Q)" <zhanghan23@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        yaohongbo <yaohongbo@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] mbigen: don't clear eventid when free_irq
Message-ID: <20190321091135.5574b496@why.wild-wind.fr.eu.org>
In-Reply-To: <D08D06C366851D40A251D08BEEAA0F9A04367BD6@dggeml529-mbx.china.huawei.com>
References: <D08D06C366851D40A251D08BEEAA0F9A04367BD6@dggeml529-mbx.china.huawei.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 11:15:03 +0000
chenjianguo <chenjianguo3@huawei.com> wrote:

> From: Jianguo Chen <chenjianguo3@huawei.com>
> 
> mbigen_write_msg clears eventid bits of a mbigen register
> when free a interrupt, because msi_domain_deactivate memset
> struct msg to zero. Then multiple mbigen pins with zero eventid
> will report the same interrupt number.
> 
> The eventid clear call trace:
>                 free_irq
>                 __free_irq
>                 irq_shutdown
>                 irq_domain_deactivate_irq
>                 __irq_domain_deactivate_irq
>                 __irq_domain_deactivate_irq
>                 msi_domain_deactivate
>                 platform_msi_write_msg
>                 mbigen_write_msg
> 
> Signed-off-by: Jianguo Chen <chenjianguo3@huawei.com>
> ---
>   drivers/irqchip/irq-mbigen.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 567b29c..fad7291 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -161,6 +161,9 @@ static void mbigen_write_msg(struct msi_desc *desc,
> struct msi_msg *msg)
>         void __iomem *base = d->chip_data;
>         u32 val;
> 
> +       if (!msg->address_lo && !msg->address_hi)
> +               return;
> +
>         base += get_mbigen_vec_reg(d->hwirq);
>         val = readl_relaxed(base);
> 

For whatever reason, I couldn't apply this patch (even when fishing a
copy of this email from the archives). It seems to be corrupted is
various ways, so I had to write the patch from scratch, which is not the
most reliable way to work. Good thing this was something trivial, I
wouldn't do it for something more complicated.

In the future, please make sure to use 'git send-email' to send your
patches, as it is known to work correctly.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
