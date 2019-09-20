Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C71217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568993869;
	bh=fp/YsKkeWnuNL1kJkIr/volpVr1JLJfsHgAwExRknOM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Mn72m8UEyDOzWrzBy2wa0egMEqe6o4l++CkZt8FEvHmmKvOGKecHwyRKqWLr+gsTm
	 VHc+JlGcgziNHzcFLZ7WLPBKLxVBaVs/IbxFvgDeCgpPmmest+V1kN4JJRAIr8UbCZ
	 0CRCCsCpXh+evkk1UXbF/qbmdHs1JBD5vRCCpRB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404144AbfITPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:37:49 -0400
Received: from foss.arm.com ([217.140.110.172]:46486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404128AbfITPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:37:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA7C337;
        Fri, 20 Sep 2019 08:37:47 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDB743F575;
        Fri, 20 Sep 2019 08:37:46 -0700 (PDT)
Subject: Re: [PATCH 1/3] genirq/irqdomain: Check for existing mapping in
 irq_domain_associate()
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
Cc:     Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Glavinic-Pecotic, Matija (EXT - DE/Ulm)" 
        <matija.glavinic-pecotic.ext@nokia.com>,
        "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20190912094343.5480-1-alexander.sverdlin@nokia.com>
 <20190912094343.5480-2-alexander.sverdlin@nokia.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <3f12b315-b7bf-e0c3-7105-4c9c9536f52f@kernel.org>
Date:   Fri, 20 Sep 2019 16:37:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912094343.5480-2-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2019 10:44, Sverdlin, Alexander (Nokia - DE/Ulm) wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> irq_domain_associate() is the only place where irq_find_mapping() can be
> used reliably (under irq_domain_mutex) to make a decision if the mapping
> shall be created or not. Other calls to irq_find_mapping() (not under
> any lock) cannot be used for this purpose and lead to race conditions in
> particular inside irq_create_mapping().
> 
> Give the callers of irq_domain_associate() an ability to detect existing
> domain reliably by examining the return value.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  kernel/irq/irqdomain.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 3078d0e..7bc07b6 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -532,6 +532,7 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>  			 irq_hw_number_t hwirq)
>  {
>  	struct irq_data *irq_data = irq_get_irq_data(virq);
> +	unsigned int eirq;
>  	int ret;
>  
>  	if (WARN(hwirq >= domain->hwirq_max,
> @@ -543,6 +544,16 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>  		return -EINVAL;
>  
>  	mutex_lock(&irq_domain_mutex);
> +
> +	/* Check if mapping already exists */
> +	eirq = irq_find_mapping(domain, hwirq);
> +	if (eirq) {

nit: Just have

	if (irq_find_mapping(...)) {

and get rid the extra variable, given that it's not used for anything.

> +		mutex_unlock(&irq_domain_mutex);
> +		pr_debug("%s: conflicting mapping for hwirq 0x%x\n",
> +			 domain->name, (int)hwirq);
> +		return -EBUSY;

I'm overall OK with this, although I'd rather we return -EEXIST rather
than -EBUSY.

> +	}
> +
>  	irq_data->hwirq = hwirq;
>  	irq_data->domain = domain;
>  	if (domain->ops->map) {
> 

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
