Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7545620850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCTSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:35:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfCTSfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:35:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45F16168F;
        Wed, 20 Mar 2019 11:35:13 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946A63F59C;
        Wed, 20 Mar 2019 11:35:11 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
 bypass by default
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Will Deacon <will.deacon@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190301192017.39770-1-dianders@chromium.org>
 <9d697122-50db-ea20-faf7-119214a96de1@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ae02a8e-c639-d380-3fed-edcc11600984@arm.com>
Date:   Wed, 20 Mar 2019 18:35:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9d697122-50db-ea20-faf7-119214a96de1@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2019 15:48, Marc Gonzalez wrote:
> On 01/03/2019 20:20, Douglas Anderson wrote:
> 
>> If you're bisecting why your peripherals stopped working, it's
>> probably this CL.  Specifically if you see this in your dmesg:
>>    Unexpected global fault, this could be serious
>> ...then it's almost certainly this CL.
>>
>> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
>> is insecure and effectively disables the protection they provide.
>> There are few reasons to allow unmatched stream bypass, and even fewer
>> good ones.
>>
>> This patch starts the transition over to make it much harder to run
>> your system insecurely.  Expected steps:
>>
>> 1. By default disable bypass (so anyone insecure will notice) but make
>>     it easy for someone to re-enable bypass with just a KConfig change.
>>     That's this patch.
>>
>> 2. After people have had a little time to come to grips with the fact
>>     that they need to set their IOMMUs properly and have had time to
>>     dig into how to do this, the KConfig will be eliminated and bypass
>>     will simply be disabled.  Folks who are truly upset and still
>>     haven't fixed their system can either figure out how to add
>>     'arm-smmu.disable_bypass=n' to their command line or revert the
>>     patch in their own private kernel.  Of course these folks will be
>>     less secure.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Flipped default to 'yes' and changed comments a lot.
>>
>>   drivers/iommu/Kconfig    | 25 +++++++++++++++++++++++++
>>   drivers/iommu/arm-smmu.c |  3 ++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 1ca1fa107b21..a4210672804a 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -359,6 +359,31 @@ config ARM_SMMU
>>   	  Say Y here if your SoC includes an IOMMU device implementing
>>   	  the ARM SMMU architecture.
>>   
>> +config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>> +	bool "Default to disabling bypass on ARM SMMU v1 and v2"
>> +	depends on ARM_SMMU
>> +	default y
>> +	help
>> +	  Say Y here to (by default) disable bypass streams such that
>> +	  incoming transactions from devices that are not attached to
>> +	  an iommu domain will report an abort back to the device and
>> +	  will not be allowed to pass through the SMMU.
>> +
>> +	  Any old kernels that existed before this KConfig was
>> +	  introduced would default to _allowing_ bypass (AKA the
>> +	  equivalent of NO for this config).  However the default for
>> +	  this option is YES because the old behavior is insecure.
>> +
>> +	  There are few reasons to allow unmatched stream bypass, and
>> +	  even fewer good ones.  If saying YES here breaks your board
>> +	  you should work on fixing your board.  This KConfig option
>> +	  is expected to be removed in the future and we'll simply
>> +	  hardcode the bypass disable in the code.
>> +
>> +	  NOTE: the kernel command line parameter
>> +	  'arm-smmu.disable_bypass' will continue to override this
>> +	  config.
>> +
>>   config ARM_SMMU_V3
>>   	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>>   	depends on ARM64
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 045d93884164..930c07635956 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -110,7 +110,8 @@ static int force_stage;
>>   module_param(force_stage, int, S_IRUGO);
>>   MODULE_PARM_DESC(force_stage,
>>   	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
>> -static bool disable_bypass;
>> +static bool disable_bypass =
>> +	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
>>   module_param(disable_bypass, bool, S_IRUGO);
>>   MODULE_PARM_DESC(disable_bypass,
>>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> 
> I'm hoping someone can clear my confusion:
> 
> drivers/iommu/arm-smmu.c
> defines a boolean module_param: disable_bypass
> It is used to select the s2cr_init_val, and whether sCR0_USFCFG is set.
> 
> drivers/iommu/iommu.c
> defines iommu_def_domain_type differently, based on CONFIG_IOMMU_DEFAULT_PASSTHROUGH
> 
> How do these two similar concepts interact? (bypass vs passthrough)

Bypass in this case mostly refers to unmatched stream bypass, i.e. 
whether Stream IDs that the kernel doesn't know about are blocked or not 
once the SMMU is enabled. The s2cr_init_val thing is less important 
since default domain support got finished, as the window in which 
streams can be known but not assigned to anything is now pretty minimal. 
The only real reasons for allowing bypass are bringup situations where 
you'd rather focus on more important things than SMMU configuration in 
the short term, and poor system topologies where either a DMA master 
controlled by some other agent (firmware/hypervisor/etc.) is routed 
through an SMMU exposed to the kernel, or there are simply so many 
devices with so many Stream IDs that the firmware has to pretend only a 
subset of them use the SMMU to avoid the kernel hitting problems from 
running out of SMRs/S2CRs.

Passthrough, on the other hand, refers to the behaviour of default DMA 
API domains for streams which *are* known and controlled by the kernel. 
It's mostly about the performance/trust tradeoff of DMA API isolation, 
but can also be swayed by the resource constraints inherent in the 
architecture (e.g. if you want your limited number of context banks to 
be available for VMs and not consumed by host DMA ops).

Robin.
