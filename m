Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DBC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 08:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FAC206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 08:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEDIos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 04:44:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfEDIor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 04:44:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EAB0F5D52CC2EA261151;
        Sat,  4 May 2019 16:44:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 16:44:39 +0800
Subject: Re: [PATCH v6 0/1] iommu: enhance IOMMU dma mode build options
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190418135701.24668-1-thunder.leizhen@huawei.com>
CC:     Hanjun Guo <guohanjun@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CCD50E7.3070505@huawei.com>
Date:   Sat, 4 May 2019 16:44:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190418135701.24668-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  Can anybody review or comment?


On 2019/4/18 21:57, Zhen Lei wrote:
> v5 --> v6:
> 1. give up adding boot option iommu.dma_mode
> 
> v4 --> v5:
> As Hanjun and Thomas Gleixner's suggestion:
> 1. Keep the old ARCH specific boot options no change.
> 2. Keep build option CONFIG_IOMMU_DEFAULT_PASSTHROUGH no change.
> 
> v4:
> As Robin Murphy's suggestion:
> "It's also not necessarily obvious to the user how this interacts with
> IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
> would be better to refactor the whole lot into a single selection of something
> like IOMMU_DEFAULT_MODE anyway."
> 
> In this version, I tried to normalize the IOMMU dma mode boot options for all
> ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
> lazy(mapping but defer the IOTLB invalidation), strict. But currently each
> ARCHs defined their private boot options, different with each other. For
> example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
> X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.
> 
> Zhen Lei (1):
>   iommu: enhance IOMMU dma mode build options
> 
>  arch/ia64/kernel/pci-dma.c                |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
>  arch/s390/pci/pci_dma.c                   |  2 +-
>  arch/x86/kernel/pci-dma.c                 |  7 ++---
>  drivers/iommu/Kconfig                     | 44 ++++++++++++++++++++++++++-----
>  drivers/iommu/amd_iommu_init.c            |  3 ++-
>  drivers/iommu/intel-iommu.c               |  2 +-
>  drivers/iommu/iommu.c                     |  3 ++-
>  8 files changed, 48 insertions(+), 18 deletions(-)
> 

-- 
Thanks!
BestRegards

