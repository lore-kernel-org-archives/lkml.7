Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FCCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15C7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfJ3Pf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:35:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfJ3Pf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:35:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EE0A1FB;
        Wed, 30 Oct 2019 08:35:57 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F03D3F6C4;
        Wed, 30 Oct 2019 08:35:56 -0700 (PDT)
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191030145112.19738-1-will@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
Date:   Wed, 30 Oct 2019 15:35:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2019 14:51, Will Deacon wrote:
> Hi all,
> 
> As part of the work to enable a "Generic Kernel Image" across multiple
> Android devices, there is a need to seperate shared, core kernel code
> from modular driver code that may not be needed by all SoCs. This means
> building IOMMU drivers as modules.
> 
> It turns out that most of the groundwork has already been done to enable
> the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
> with a few symbols exported from the IOMMU/PCI core, everything builds
> nicely out of the box. The one exception is support for the legacy SMMU
> DT binding, which is not in widespread use and has never worked with
> modules, so we can simply remove that when building as a module rather
> than try to paper over it with even more hacks.
> 
> Obviously you need to be careful about using IOMMU drivers as modules,
> since late loading of the driver for an IOMMU serving active DMA masters
> is going to end badly in many cases. On Android, we're using device links
> to ensure that the IOMMU probes first.

Out of curiosity, which device links are those? Clearly not the RPM 
links created by the IOMMU drivers themselves... Is this some special 
Android magic, or is there actually a chance of replacing all the 
of_iommu_configure() machinery with something more generic?

Robin.

> 
> Comments welcome,
> 
> Will
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> --->8
> 
> Will Deacon (7):
>    drivers/iommu: Export core IOMMU API symbols to permit modular drivers
>    iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
>    PCI: Export pci_ats_disabled() as a GPL symbol to modules
>    Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
>    iommu/arm-smmu-v3: Allow building as a module
>    Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
>    iommu/arm-smmu: Allow building as a module
> 
>   drivers/iommu/Kconfig         | 16 ++++++-
>   drivers/iommu/arm-smmu-impl.c |  6 +++
>   drivers/iommu/arm-smmu-v3.c   | 26 +++++++----
>   drivers/iommu/arm-smmu.c      | 86 +++++++++++++++++++++--------------
>   drivers/iommu/iommu-sysfs.c   |  5 ++
>   drivers/iommu/iommu.c         |  8 ++++
>   drivers/iommu/of_iommu.c      |  1 +
>   drivers/pci/pci.c             |  1 +
>   8 files changed, 102 insertions(+), 47 deletions(-)
> 
