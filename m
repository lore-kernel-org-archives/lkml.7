Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9453D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfHSO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:28:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfHSO2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:28:23 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A941860674E86CE3D077;
        Mon, 19 Aug 2019 22:28:19 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 22:28:09 +0800
Subject: Re: [PATCH v2 04/12] irqchip/gic-v3: Add ESPI range support
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-5-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9cbd6fc8-3fe9-39fc-10ca-724a1ec06e8d@huawei.com>
Date:   Mon, 19 Aug 2019 22:25:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-5-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/8/6 18:01, Marc Zyngier wrote:
> Add the required support for the ESPI range, which behave exactly like
> the SPIs of old, only with new funky INTIDs.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/irqchip/irq-gic-v3.c       | 85 ++++++++++++++++++++++++------
>   include/linux/irqchip/arm-gic-v3.h | 17 +++++-
>   2 files changed, 85 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index db3bdedd7241..1ca4dde32034 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -51,13 +51,16 @@ struct gic_chip_data {
>   	u32			nr_redist_regions;
>   	u64			flags;
>   	bool			has_rss;
> -	unsigned int		irq_nr;
>   	struct partition_desc	*ppi_descs[16];
>   };
>   
>   static struct gic_chip_data gic_data __read_mostly;
>   static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>   
> +#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
> +#define GIC_LINE_NR	GICD_TYPER_SPIS(gic_data.rdists.gicd_typer)

This indicates the maximum SPI INTID that the GIC implementation
supports, should we restrict it to no more than 1020?

ITLinesNumber can be '11111', and I saw the following info on my host:
     "GICv3: 992 SPIs implemented"


Thanks,
zenghui

