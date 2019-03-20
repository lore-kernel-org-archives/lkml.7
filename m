Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24622175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCTLYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:24:22 -0400
Received: from foss.arm.com ([217.140.101.70]:38292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfCTLYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:24:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835CF1650;
        Wed, 20 Mar 2019 04:24:21 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04B8E3F575;
        Wed, 20 Mar 2019 04:24:19 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: juno: Enable smmu_pcie for Juno r1/r2
To:     Leo Yan <leo.yan@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190320083105.8954-1-leo.yan@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2566ce76-a8b2-c8ac-9f3f-4b99101f7661@arm.com>
Date:   Wed, 20 Mar 2019 11:24:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320083105.8954-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 20/03/2019 08:31, Leo Yan wrote:
> Though PCIe controller has been enabled on Juno r1/r2, but it misses to
> enable its connected SMMU.  From the testing, even without set this SMMU
> status property to 'okay', the PCIe NIC device still works well.  Since
> the SMMU is not enabled in DT binding and its iommu_groups is not
> created properly, finally this prevents to enable vfio-pci for NIC
> device with KVM.

FWIW, whilst it might appear to be fine, there are still potential 
issues once the DMA API sees this SMMU and starts using it, which is why 
this particular change remains as one of my oldest local hacks that I've 
never yet considered upstreamable.

The IOMMU DMA ops happen to work for light usage now as a side-effect of 
122fac030e912 combined with the current top-down allocation behaviour, 
but as soon as IOVA usage/fragmentation leads to 32-bit DMA addresses 
below 0x8000000, or full 40-bit addresses, being allocated then data 
loss and other problems will happen (for the reasons explained on the 
other thread). Similarly, it's also going to be fragile to any internal 
changes in the IOVA allocator.

Until we have a decent solution for handling such 'windowed' DMA 
restrictions (there do exist other systems with similar behaviour) I'd 
be very wary of enabling the PCIe SMMU for all users who may not be 
aware of the caveats. Given that the lack of stream IDs and SR-IOV 
support prevents Juno from being a realistic virtualisation platform 
anyway, I'm not convinced there's enough benefit to justify the risk.

Thanks,
Robin.

> After reviewing the code in dts, Juno r1/r2 both have enabled PCIe
> controller but Juno r0 board (in juno.dts) doesn't contain PCIe
> controller; hence this patch only change SMMU status property to 'okay'
> for Juno r1/r2 dts files for the sake of only enabling it for Juno r1/r2
> and avoiding touching Juno r0.
> 
> Committer testing on Juno r2:
> 
> Before:
> 
>    root@debian:~# tree /sys/kernel/iommu_groups/
>    /sys/kernel/iommu_groups/
>    ├── 0
>    │   ├── devices
>    │   │   ├── 7ffb0000.ohci -> ../../../../devices/platform/7ffb0000.ohci
>    │   │   └── 7ffc0000.ehci -> ../../../../devices/platform/7ffc0000.ehci
>    │   ├── reserved_regions
>    │   └── type
>    └── 1
>        ├── devices
>        │   └── 20070000.etr -> ../../../../devices/platform/20070000.etr
>        ├── reserved_regions
>        └── type
> 
>    7 directories, 4 files
> 
> After:
> 
>    root@debian:~# tree /sys/kernel/iommu_groups/
>    /sys/kernel/iommu_groups/
>    ├── 0
>    │   ├── devices
>    │   │   ├── 0000:00:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0
>    │   │   ├── 0000:01:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0
>    │   │   ├── 0000:02:01.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0
>    │   │   ├── 0000:02:02.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:02.0
>    │   │   ├── 0000:02:03.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:03.0
>    │   │   ├── 0000:02:0c.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:0c.0
>    │   │   ├── 0000:02:10.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:10.0
>    │   │   ├── 0000:02:1f.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:1f.0
>    │   │   ├── 0000:03:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/0000:03:00.0
>    │   │   └── 0000:08:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:1f.0/0000:08:00.0
>    │   ├── reserved_regions
>    │   └── type
>    ├── 1
>    │   ├── devices
>    │   │   ├── 7ffb0000.ohci -> ../../../../devices/platform/7ffb0000.ohci
>    │   │   └── 7ffc0000.ehci -> ../../../../devices/platform/7ffc0000.ehci
>    │   ├── reserved_regions
>    │   └── type
>    └── 2
>        ├── devices
>        │   └── 20070000.etr -> ../../../../devices/platform/20070000.etr
>        ├── reserved_regions
>        └── type
> 
>    19 directories, 6 files
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   arch/arm64/boot/dts/arm/juno-r1.dts | 4 ++++
>   arch/arm64/boot/dts/arm/juno-r2.dts | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index b2b7ced633cf..67e161a6272a 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -226,6 +226,10 @@
>   	status = "okay";
>   };
>   
> +&smmu_pcie {
> +	status = "okay";
> +};
> +
>   &pcie_ctlr {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
> index ab77adb4f3c2..0e1c5c814b01 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2.dts
> @@ -226,6 +226,10 @@
>   	status = "okay";
>   };
>   
> +&smmu_pcie {
> +	status = "okay";
> +};
> +
>   &pcie_ctlr {
>   	status = "okay";
>   };
> 
