Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50613C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C33A2085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 14:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKJOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 09:46:12 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:37061 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbfKJOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 09:46:12 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@misterjones.org>)
        id 1iToTf-0002oJ-JP; Sun, 10 Nov 2019 15:46:07 +0100
Date:   Sun, 10 Nov 2019 14:46:06 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 07/11] irqchip/gic-v3-its: Add its_vlpi_map helpers
Message-ID: <20191110144606.61a1f537@why>
In-Reply-To: <20191108165805.3071-8-maz@kernel.org>
References: <20191108165805.3071-1-maz@kernel.org>
        <20191108165805.3071-8-maz@kernel.org>
Organization: Metropolis
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 16:58:01 +0000
Marc Zyngier <maz@kernel.org> wrote:

> Obtaining the mapping information for a VLPI is something quite common,
> and the GICv4.1 code is going to make even more use of it. Expose it as
> a separate set of helpers.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> Link: https://lore.kernel.org/r/20191027144234.8395-8-maz@kernel.org
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 47 ++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 94f13d6b8400..cad8fd18bab7 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -207,6 +207,15 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
>  	return its->collections + its_dev->event_map.col_map[event];
>  }
>  
> +static struct its_vlpi_map *dev_event_to_vlpi_map(struct its_device *its_dev,
> +					       u32 event)
> +{
> +	if (WARN_ON_ONCE(event >= its_dev->event_map.nr_lpis))
> +		return NULL;
> +
> +	return its_dev->event_map.vlpi_maps[event];

As pointed out by our dear friend the 01 bot, the above line lacks a
'&'. It happened to work because this was later reworked, but this
patch on its own breaks the build.

I've now fixed it, and verified that the whole series correctly bisects.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
