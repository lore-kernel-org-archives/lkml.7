Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44BC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFB521721
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569835444;
	bh=/uXpEjGnULjrZNRk1SpA7hhcW31UPyAaen3yVQNjdB0=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=156MUwEIgTmWy7y4yK1fXST6qJUL52Eq/ZisedFfXjPQQLR6L+61aAUIQ2qvBiJhf
	 hGWQwDfTUAU+AUzKiFmVWYzkUewE498Qz5TkQ2Ztb0weXzmBfxIHwgnRfjvhlqeo7z
	 bqNzfMgfkPCx1A1UVKsCovYDrMf8wj4rcfIyca9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfI3JYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:24:03 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:58711 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730421AbfI3JX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:58 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iEruN-0001uK-8b; Mon, 30 Sep 2019 11:23:55 +0200
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 31/35] irqchip/gic-v4.1: Eagerly vmap vPEs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Sep 2019 10:23:55 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <82576f6e-3736-8069-bbf2-7744fbea9ed2@huawei.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-32-maz@kernel.org>
 <82576f6e-3736-8069-bbf2-7744fbea9ed2@huawei.com>
Message-ID: <ce8d5af19b6c62985bdfc9d57ac659f2@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-28 04:11, Zenghui Yu wrote:
> On 2019/9/24 2:26, Marc Zyngier wrote:
>> Now that we have HW-accelerated SGIs being delivered to VPEs, it
>> becomes required to map the VPEs on all ITSs instead of relying
>> on the lazy approach that we would use when using the ITS-list
>> mechanism.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 39 
>> +++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 4aae9582182b..a1e8c4c2598a 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -1417,12 +1417,31 @@ static int its_irq_set_irqchip_state(struct 
>> irq_data *d,
>>   	return 0;
>>   }
>>   +/*
>> + * Two favourable cases:
>> + *
>> + * (a) Either we have a GICv4.1, and all vPEs have to be mapped at 
>> all times
>> + *     for vSGI delivery
>> + *
>> + * (b) Or the ITSs do not use a list map, meaning that VMOVP is 
>> cheap enough
>> + *     and we're better off mapping all VPEs always
>> + *
>> + * If neither (a) nor (b) is true, then we map VLPIs on demand.
>                                                  ^^^^^
> vPEs

Yes, well caught.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
