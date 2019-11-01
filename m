Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F4721734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfKALGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:06:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfKALGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:06:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE556712A63643A18BCD;
        Fri,  1 Nov 2019 19:06:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:05:57 +0800
Subject: Re: [PATCH v2 13/36] irqchip/gic-v4.1: Don't use the VPE proxy if
 RVPEID is set
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-14-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8514ccbe-814a-5bdd-3791-bdd65510ce68@huawei.com>
Date:   Fri, 1 Nov 2019 19:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-14-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/27 22:42, Marc Zyngier wrote:
> The infamous VPE proxy device isn't used with GICv4.1 because:
> - we can invalidate any LPI from the DirectLPI MMIO interface
> - the ITS and redistributors understand the life cycle of
>    the doorbell, so we don't need to enable/disable it all
>    the time
> 
> So let's escape early from the proxy related functions.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> ---
>   drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 220d490d516e..999e61a9b2c3 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3069,7 +3069,7 @@ static const struct irq_domain_ops its_domain_ops = {
>   /*
>    * This is insane.
>    *
> - * If a GICv4 doesn't implement Direct LPIs (which is extremely
> + * If a GICv4.0 doesn't implement Direct LPIs (which is extremely
>    * likely), the only way to perform an invalidate is to use a fake
>    * device to issue an INV command, implying that the LPI has first
>    * been mapped to some event on that device. Since this is not exactly
> @@ -3077,9 +3077,18 @@ static const struct irq_domain_ops its_domain_ops = {
>    * only issue an UNMAP if we're short on available slots.
>    *
>    * Broken by design(tm).
> + *
> + * GICv4.1 actually mandates that we're able to invalidate by writing to a
> + * MMIO register. It doesn't implement the whole of DirectLPI, but that's
> + * good enough. And most of the time, we don't even have to invalidate
> + * anything, so that's actually pretty good!

I can't understand the meaning of this last sentence. May I ask for an
explanation? :)


Thanks,
Zenghui

>    */
>   static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
>   {
> +	/* GICv4.1 doesn't use a proxy, so nothing to do here */
> +	if (gic_rdists->has_rvpeid)
> +		return;
> +
>   	/* Already unmapped? */
>   	if (vpe->vpe_proxy_event == -1)
>   		return;
> @@ -3102,6 +3111,10 @@ static void its_vpe_db_proxy_unmap_locked(struct its_vpe *vpe)
>   
>   static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
>   {
> +	/* GICv4.1 doesn't use a proxy, so nothing to do here */
> +	if (gic_rdists->has_rvpeid)
> +		return;
> +
>   	if (!gic_rdists->has_direct_lpi) {
>   		unsigned long flags;
>   
> @@ -3113,6 +3126,10 @@ static void its_vpe_db_proxy_unmap(struct its_vpe *vpe)
>   
>   static void its_vpe_db_proxy_map_locked(struct its_vpe *vpe)
>   {
> +	/* GICv4.1 doesn't use a proxy, so nothing to do here */
> +	if (gic_rdists->has_rvpeid)
> +		return;
> +
>   	/* Already mapped? */
>   	if (vpe->vpe_proxy_event != -1)
>   		return;
> @@ -3135,6 +3152,10 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
>   	unsigned long flags;
>   	struct its_collection *target_col;
>   
> +	/* GICv4.1 doesn't use a proxy, so nothing to do here */
> +	if (gic_rdists->has_rvpeid)
> +		return;
> +
>   	if (gic_rdists->has_direct_lpi) {
>   		void __iomem *rdbase;
>   
> 

