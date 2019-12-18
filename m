Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED18FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBB4218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576681595;
	bh=Amod16U8L+1OdsOws5ze8g2fh6aSpFILslWv8V9uRzs=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=qkxYNQMfZa2MrsTLUMGAIUTLZU7JXMEAJClo+ly5ssK4UXMcPwORlUFYM0JAFi5tw
	 siuMnI9zP6fAoTdMj6jt+c3asimw12vJev+xG5ry2mN2XCd+Zia/zYUzEnFt5DvRpb
	 ll5B0w71czU/0edCDJ6qpj5j/dSi9JI4rejZpqpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLRPGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:06:34 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:56844 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbfLRPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:06:34 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihauE-0003Jx-Cx; Wed, 18 Dec 2019 16:06:30 +0100
To:     Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 16/36] irqchip/gic-v4.1: Add mask/unmask doorbell  callbacks
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Dec 2019 15:06:30 +0000
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
In-Reply-To: <7c94be43-e1b0-625a-762c-ec8589f16b2d@huawei.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-17-maz@kernel.org>
 <7c94be43-e1b0-625a-762c-ec8589f16b2d@huawei.com>
Message-ID: <115f732eec1d960e69ee2b544a0e39b0@www.loen.fr>
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

On 2019-11-01 11:23, Zenghui Yu wrote:
> Hi Marc,
>
> On 2019/10/27 22:42, Marc Zyngier wrote:
>> masking/unmasking doorbells on GICv4.1 relies on a new INVDB 
>> command,
>> which broadcasts the invalidation to all RDs.
>> Implement the new command as well as the masking callbacks, and plug
>> the whole thing into the v4.1 VPE irqchip.
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c   | 60 
>> ++++++++++++++++++++++++++++++
>>   include/linux/irqchip/arm-gic-v3.h |  3 +-
>>   2 files changed, 62 insertions(+), 1 deletion(-)
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index dcc7227af5f1..3c34bef70bdd 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -309,6 +309,10 @@ struct its_cmd_desc {
>>   			u16 seq_num;
>>   			u16 its_list;
>>   		} its_vmovp_cmd;
>> +
>> +		struct {
>> +			struct its_vpe *vpe;
>> +		} its_invdb_cmd;
>>   	};
>>   };
>>   @@ -750,6 +754,21 @@ static struct its_vpe 
>> *its_build_vmovp_cmd(struct its_node *its,
>>   	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
>>   }
>>   +static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
>> +					   struct its_cmd_block *cmd,
>> +					   struct its_cmd_desc *desc)
>> +{
>> +	if (WARN_ON(!is_v4_1(its)))
>> +		return NULL;
>> +
>> +	its_encode_cmd(cmd, GITS_CMD_INVDB);
>> +	its_encode_vpeid(cmd, desc->its_invdb_cmd.vpe->vpe_id);
>> +
>> +	its_fixup_cmd(cmd);
>> +
>> +	return valid_vpe(its, desc->its_invdb_cmd.vpe);
>> +}
>> +
>>   static u64 its_cmd_ptr_to_offset(struct its_node *its,
>>   				 struct its_cmd_block *ptr)
>>   {
>> @@ -1117,6 +1136,14 @@ static void its_send_vinvall(struct its_node 
>> *its, struct its_vpe *vpe)
>>   	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
>>   }
>>   +static void its_send_invdb(struct its_node *its, struct its_vpe 
>> *vpe)
>> +{
>> +	struct its_cmd_desc desc;
>> +
>> +	desc.its_invdb_cmd.vpe = vpe;
>> +	its_send_single_vcommand(its, its_build_invdb_cmd, &desc);
>> +}
>> +
>>   /*
>>    * irqchip functions - assumes MSI, mostly.
>>    */
>> @@ -3408,6 +3435,37 @@ static struct irq_chip its_vpe_irq_chip = {
>>   	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
>>   };
>>   +static void its_vpe_4_1_send_inv(struct irq_data *d)
>> +{
>> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> +	struct its_node *its;
>> +
>> +	/*
>> +	 * GICv4.1 wants doorbells to be invalidated using the
>> +	 * INVDB command in order to be broadcast to all RDs. Send
>> +	 * it to the first valid ITS, and let the HW do its magic.
>> +	 */
>> +	list_for_each_entry(its, &its_nodes, entry) {
>> +		if (!is_v4_1(its))
>> +			continue;
>> +
>> +		its_send_invdb(its, vpe);
>> +		break;
>> +	}
>
> Maybe use find_4_1_its() helper instead?

Yes, good point. I've moved it up in the series, and it is now added
to this patch.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
