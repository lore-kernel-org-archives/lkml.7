Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE89CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146CE205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfJ3Pd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJ3Pd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:33:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D251FB;
        Wed, 30 Oct 2019 08:33:28 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD6F23F6C4;
        Wed, 30 Oct 2019 08:33:27 -0700 (PDT)
Subject: Re: [PATCH 7/7] iommu/arm-smmu: Allow building as a module
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-8-will@kernel.org>
 <20191030152212.ifzhl2w3knapc367@bogus>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ffbf469-83a7-4ebb-504c-ac17c2f526cc@arm.com>
Date:   Wed, 30 Oct 2019 15:33:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191030152212.ifzhl2w3knapc367@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 15:22, Rob Herring wrote:
> On Wed, Oct 30, 2019 at 02:51:12PM +0000, Will Deacon wrote:
>> By conditionally dropping support for the legacy binding and exporting
>> the newly introduced 'arm_smmu_impl_init()' function we can allow the
>> ARM SMMU driver to be built as a module.
>>
>> Signed-off-by: Will Deacon <will@kernel.org>
>> ---
>>   drivers/iommu/Kconfig         | 14 ++++++++-
>>   drivers/iommu/arm-smmu-impl.c |  6 ++++
>>   drivers/iommu/arm-smmu.c      | 54 +++++++++++++++++++++--------------
>>   3 files changed, 51 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 7583d47fc4d5..02703f51e533 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -350,7 +350,7 @@ config SPAPR_TCE_IOMMU
>>   
>>   # ARM IOMMU support
>>   config ARM_SMMU
>> -	bool "ARM Ltd. System MMU (SMMU) Support"
>> +	tristate "ARM Ltd. System MMU (SMMU) Support"
>>   	depends on (ARM64 || ARM) && MMU
>>   	select IOMMU_API
>>   	select IOMMU_IO_PGTABLE_LPAE
>> @@ -362,6 +362,18 @@ config ARM_SMMU
>>   	  Say Y here if your SoC includes an IOMMU device implementing
>>   	  the ARM SMMU architecture.
>>   
>> +config ARM_SMMU_LEGACY_DT_BINDINGS
>> +	bool "Support the legacy \"mmu-masters\" devicetree bindings"
> 
> Can't we just remove this now? The only user is Seattle. Is anyone still
> using Seattle AND DT? There's been no real dts change since Feb '16.
> There's a bit of clean-up needed in the Seattle dts files, so I'd like
> to remove them if there's not users.
> 
> If there are users, can't we just make them move to the new binding?
> Yes compatibility, but that really depends on the users caring.

Apparently it's also in the wild on Cavium ThunderX/OcteonTX machines as 
well :(

> I though Calxeda was using this too, but I guess we didn't get that
> finished. We should probably remove that secure mode flag as well.

FWIW the secure quirk still comes in useful every now and then when 
people prototype stuff on 32-bit VExpress, where it turns out an SMMU is 
about the only thing which cares whether you're running Linux in Secure 
mode or not.

Robin.
