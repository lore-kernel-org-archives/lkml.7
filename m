Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DFBC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE6D207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569425258;
	bh=RN5wVLlMpJNOGijXXi6kilgRmOiZSWkv0T1NVin+lJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Teij6GVO7+sfmURD9PcanIoX4MN2O13ol/RkiR4B5oVdaWBGvf7Z/VqubV2mf1p5l
	 0qX8ovDGVjhCdxiFP0rEccm/Y9LpeavJmGYFpntfUzOj0Cv9oS/av3TR1uo6AHObRq
	 7HtR+Ps0mc0jO0mM8rP3AMTLE/PkVKp06B9Mzpao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIYP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbfIYP1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:27:37 -0400
Received: from [10.33.87.18] (twin.jikos.cz [91.219.245.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970B5205F4;
        Wed, 25 Sep 2019 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569425255;
        bh=RN5wVLlMpJNOGijXXi6kilgRmOiZSWkv0T1NVin+lJI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YTA3HY+9XLzueupE0pMcnqhHjYxsEb569hYytX4ymuP29ASuMFyXJd72vo+ajsvDb
         y2rKwC527JgaCxBRB2NNpqc+vdbMv7VWe/mVneUrG1dznGzmO9HDwifRzE/6cQ5y8u
         lCf0oxaZxcaJULTHSpeokqtB0qLKrXeDB1+LCZr4=
Date:   Wed, 25 Sep 2019 17:27:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kurt Garloff <kurt@garloff.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
In-Reply-To: <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
Message-ID: <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de> <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2019, Kurt Garloff wrote:

> Hi,
> 
>     
> enabling the IOMMU on my Ryzen v1605b (UDOO Bolt v8) does result in a
> non-working EMMC driver.
> Without enabling IOMMU, it works like a charm.
> From my POV this needs fixing, and I consider this a bug.

[ CCing Joerg ]

> I looked into sdhci to see whether the right dma_map_sg() calls are 
> missing, but they are there. The sdhci driver appears to do the right 
> thing. It seems that the EMMC controller is not considered and reported 
> as PCI device while it still goes through the PCI IOMMU :-O
> 
> Here is what happens on loading the sdhci-acpi driver on kernel 5.3:
> 
> [12916.740148] mmc0: ADMA error
> [12916.740154] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [12916.740163] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> [12916.740170] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
> [12916.740179] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [12916.740184] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1
> domain=0x0000 address=0x6f2163200 flags=0x0050]
> [12916.740193] mmc0: sdhci: Present:   0xf1ff0000 | Host ctl: 0x00000019
> [12916.740202] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [12916.740211] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000f447
> [12916.740219] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> [12916.740226] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> [12916.740232] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [12916.740239] mmc0: sdhci: Caps:      0x71fec8b2 | Caps_1:   0x00000577
> [12916.740246] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00c80064
> [12916.740253] mmc0: sdhci: Resp[0]:   0x00000700 | Resp[1]:  0xffffffff
> [12916.740259] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d00f00
> [12916.740264] mmc0: sdhci: Host ctl2: 0x00000000
> [12916.740273] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr:
> 0x00000006f2163200
> [12916.740274] mmc0: sdhci: ============================================
> [12916.740337] mmc0: error -5 whilst initialising MMC card

Do you have BAR memory allocation failures in dmesg with IOMMU on? 
Actually, sharing both working and non-working dmesg, as well as 
/proc/iomem contents, would be helpful.

Keeping the rest of mail below untouched for reference.

> 
> As you can see, from an IOMMU perspective, this is PCI device 00:13.1.
> However, from a kernel perspective, it's not on the PCI bus and does not
> require IOMMU translation, but rather just direct DMA mapping.
> 
> 
> linux@udookurt(/):~/linux-53/drivers/mmc/host [0]$ sudo /sbin/lspci
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Root
> Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge
> 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP
> Bridge [6:0]
> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP
> Bridge [6:0]
> 00:01.6 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP
> Bridge [6:0]
> 00:01.7 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP
> Bridge [6:0]
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Internal
> PCIe GPP Bridge 0 to Bus A
> 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Internal
> PCIe GPP Bridge 0 to Bus B
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev
> 61)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 5
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 6
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device
> 24: Function 7
> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
> Controller SM981/PM981/PM983
> 03:00.0 Network controller: Intel Corporation Dual Band Wireless-AC 3168NGW
> [Stone Peak] (rev 10)
> 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411
> PCI Express Gigabit Ethernet Controller (rev 0c)
> 05:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev 83)
> 05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
> Raven/Raven2/Fenghuang HDMI/DP Audio Controller
> 05:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h
> (Models 10h-1fh) Platform Security Processor
> 05:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
> 05:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
> 05:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
> Raven/Raven2/FireFlight/Renoir Audio Processor
> 05:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 10h-1fh) HD Audio Controller
> 05:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD]
> Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
> 06:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] (rev 61)
> 
> Looks like we'd need some quirks to actually create a pci_device handle for
> the embedded AMD eMMC controller?
> Thoughts?
> 
> PS: Please copy me on responses, I'm off LKML for half a decade now :-O
> 
> -- 
> Kurt Garloff<kurt@garloff.de>
> Cologne, Germany
> 

-- 
Jiri Kosina
SUSE Labs
