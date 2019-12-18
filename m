Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA73C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A6D2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576680540;
	bh=1LKAjLQiNaDsS+MXflzt2GCAh1AK1xsfyPvTPUC/MDs=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=qP5GXur4UWMDHKu3ZTCm5QmqG5adWbZwdplFiuNFIKH99VQwsSkqSBr+VYN8ty4cz
	 WI8Xh/cB34ZbPl7KTpTfX8iOVR70aecRqLtdHo8Vo1VKyZ/qGPdOE1QCR8/DX0LZel
	 dcDR/cwMImQI8C1OOJspLUbnXR/0OC2aIu1w5Oe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLROs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:48:59 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44000 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfLROs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:48:58 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihadC-0002xn-Ku; Wed, 18 Dec 2019 15:48:54 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 22/36] irqchip/gic-v4.1: Advertise support v4.1 to KVM
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 14:48:54 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
In-Reply-To: <14462a79-fc0b-b8e5-115a-dfb505351acb@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-23-maz@kernel.org>
 <14462a79-fc0b-b8e5-115a-dfb505351acb@huawei.com>
Message-ID: <c9f8f2590662cfe9e28e90cf8f79e708@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, jnair@marvell.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-01 12:55, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> Tell KVM that we support v4.1. Nothing uses this information so far.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c       | 9 ++++++++-
>>   drivers/irqchip/irq-gic-v3.c           | 1 +
>>   include/linux/irqchip/arm-gic-common.h | 2 ++
>>   3 files changed, 11 insertions(+), 1 deletion(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index df259e202482..6483f8051b3e 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -4580,6 +4580,7 @@ int __init its_init(struct fwnode_handle 
>> *handle, struct rdists *rdists,
>>   	struct device_node *of_node;
>>   	struct its_node *its;
>>   	bool has_v4 = false;
>> +	bool has_v4_1 = false;
>>   	int err;
>>
>>   	gic_rdists = rdists;
>> @@ -4600,8 +4601,14 @@ int __init its_init(struct fwnode_handle 
>> *handle, struct rdists *rdists,
>>   	if (err)
>>   		return err;
>>   -	list_for_each_entry(its, &its_nodes, entry)
>> +	list_for_each_entry(its, &its_nodes, entry) {
>>   		has_v4 |= is_v4(its);
>> +		has_v4_1 |= is_v4_1(its);
>> +	}
>> +
>> +	/* Don't bother with inconsistent systems */
>> +	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
>> +		rdists->has_rvpeid = false;
>>
>>   	if (has_v4 & rdists->has_vlpis) {
>>   		if (its_init_vpe_domain() ||
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index f0d33ac64a99..94dddfb21076 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1758,6 +1758,7 @@ static void __init 
>> gic_of_setup_kvm_info(struct device_node *node)
>>   		gic_v3_kvm_info.vcpu = r;
>>
>>   	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>> +	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
>
> Also set gic_v3_kvm_info.has_v4_1 in gic_acpi_setup_kvm_info().

Indeed. Now fixed.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
