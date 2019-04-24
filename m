Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfDXJHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:07:19 -0400
Received: from foss.arm.com ([217.140.101.70]:40032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfDXJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:07:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3027780D;
        Wed, 24 Apr 2019 02:07:18 -0700 (PDT)
Received: from [10.163.1.68] (unknown [10.163.1.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4323F5AF;
        Wed, 24 Apr 2019 02:07:08 -0700 (PDT)
Subject: Re: [PATCH] arm64: configurable sparsemem section size
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        keith.busch@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, thomas.lendacky@amd.com,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        jglisse@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        andrew.murray@arm.com, james.morse@arm.com, marc.zyngier@arm.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190423203843.2898-1-pasha.tatashin@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7f7499bd-8d48-945b-6d69-60685a02c8da@arm.com>
Date:   Wed, 24 Apr 2019 14:37:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190423203843.2898-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2019 02:08 AM, Pavel Tatashin wrote:
> sparsemem section size determines the maximum size and alignment that
> is allowed to offline/online memory block. The bigger the size the less
> the clutter in /sys/devices/system/memory/*. On the other hand, however,
> there is less flexability in what granules of memory can be added and
> removed.

Is there any scenario where less than a 1GB needs to be added on arm64 ?

> 
> Recently, it was enabled in Linux to hotadd persistent memory that
> can be either real NV device, or reserved from regular System RAM
> and has identity of devdax.

devdax (even ZONE_DEVICE) support has not been enabled on arm64 yet.

> 
> The problem is that because ARM64's section size is 1G, and devdax must
> have 2M label section, the first 1G is always missed when device is
> attached, because it is not 1G aligned.

devdax has to be 2M aligned ? Does Linux enforce that right now ?

> 
> Allow, better flexibility by making section size configurable.

Unless 2M is being enforced from Linux not sure why this is necessary at
the moment.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/Kconfig                 | 10 ++++++++++
>  arch/arm64/include/asm/sparsemem.h |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5d8cf57e220..a0c5b9d13a7f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -801,6 +801,16 @@ config ARM64_PA_BITS
>  	default 48 if ARM64_PA_BITS_48
>  	default 52 if ARM64_PA_BITS_52
>  
> +config ARM64_SECTION_SIZE_BITS
> +	int "sparsemem section size shift"
> +	range 27 30

27 and 28 do not even compile for ARM64_64_PAGES because of MAX_ORDER and
SECTION_SIZE mismatch.
