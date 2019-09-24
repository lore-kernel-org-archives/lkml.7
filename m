Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D0C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FA921655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfIXI67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:58:59 -0400
Received: from foss.arm.com ([217.140.110.172]:55982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfIXI67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:58:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F87142F;
        Tue, 24 Sep 2019 01:58:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF0E23F59C;
        Tue, 24 Sep 2019 01:58:57 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:58:56 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 02/35] irqchip/gic-v3-its: Factor out wait_for_syncr
 primitive
Message-ID: <20190924085855.GM9720@e119886-lin.cambridge.arm.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923182606.32100-3-maz@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:25:33PM +0100, Marc Zyngier wrote:
> Waiting for a redistributor to have performed an operation is a
> common thing to do, and the idiom is already spread around.
> As we're going to make even more use of this, let's have a primitive
> that does just that.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 62e54f1a248b..58cb233cf138 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1075,6 +1075,12 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>  		dsb(ishst);
>  }
>  
> +static void wait_for_syncr(void __iomem *rdbase)
> +{
> +	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
> +		cpu_relax();
> +}
> +
>  static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> @@ -2757,8 +2763,7 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
>  
>  		rdbase = per_cpu_ptr(gic_rdists->rdist, from)->rd_base;
>  		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
> -		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
> -			cpu_relax();
> +		wait_for_syncr(rdbase);
>  
>  		return;
>  	}
> @@ -2914,8 +2919,7 @@ static void its_vpe_send_inv(struct irq_data *d)
>  
>  		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>  		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
> -		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
> -			cpu_relax();
> +		wait_for_syncr(rdbase);
>  	} else {
>  		its_vpe_send_cmd(vpe, its_send_inv);
>  	}
> @@ -2957,8 +2961,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
>  			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_SETLPIR);
>  		} else {
>  			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
> -			while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
> -				cpu_relax();
> +			wait_for_syncr(rdbase);
>  		}
>  	} else {
>  		if (state)
> -- 
> 2.20.1
> 
