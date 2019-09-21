Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF21C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5D62073F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437644AbfIUG6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:58:30 -0400
Received: from cc-smtpout1.netcologne.de ([89.1.8.211]:55772 "EHLO
        cc-smtpout1.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfIUG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:58:29 -0400
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id 0B712133F8;
        Sat, 21 Sep 2019 08:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin1.netcologne.de (Postfix) with ESMTP id F1C5411E87;
        Sat, 21 Sep 2019 08:58:24 +0200 (CEST)
Received: from [87.78.146.192] (helo=cc-smtpin1.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.6.0)
        (envelope-from <kurt@garloff.de>)
        id 5d85ca10-5e31-7f0000012729-7f000001c64a-1
        for <multiple-recipients>; Sat, 21 Sep 2019 08:58:24 +0200
Received: from nas2.garloff.de (xdsl-87-78-146-192.nc.de [87.78.146.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA;
        Sat, 21 Sep 2019 08:58:23 +0200 (CEST)
Received: from [192.168.155.202] (ap3.garloff.de [192.168.155.14])
        by nas2.garloff.de (Postfix) with ESMTPSA id 5E7F2B3B0C79;
        Sat, 21 Sep 2019 08:58:22 +0200 (CEST)
Subject: IOMMU vs Ryzen embedded EMMC controller
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
To:     LKML <linux-kernel@vger.kernel.org>,
        Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
From:   Kurt Garloff <kurt@garloff.de>
X-Forwarded-Message-Id: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
Message-ID: <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
Date:   Sat, 21 Sep 2019 08:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     

enabling the IOMMU on my Ryzen v1605b (UDOO Bolt v8) does result in a non-working EMMC driver.
Without enabling IOMMU, it works like a charm.
 From my POV this needs fixing, and I consider this a bug.

I looked into sdhci to see whether the right dma_map_sg() calls are missing, but they are there. The sdhci driver appears to do the right thing.
It seems that the EMMC controller is not considered and reported as PCI device while it still goes through the PCI IOMMU :-O

Here is what happens on loading the sdhci-acpi driver on kernel 5.3:

[12916.740148] mmc0: ADMA error
[12916.740154] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[12916.740163] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
[12916.740170] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
[12916.740179] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[12916.740184] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1 domain=0x0000 address=0x6f2163200 flags=0x0050]
[12916.740193] mmc0: sdhci: Present:   0xf1ff0000 | Host ctl: 0x00000019
[12916.740202] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[12916.740211] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000f447
[12916.740219] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[12916.740226] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[12916.740232] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[12916.740239] mmc0: sdhci: Caps:      0x71fec8b2 | Caps_1:   0x00000577
[12916.740246] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00c80064
[12916.740253] mmc0: sdhci: Resp[0]:   0x00000700 | Resp[1]:  0xffffffff
[12916.740259] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d00f00
[12916.740264] mmc0: sdhci: Host ctl2: 0x00000000
[12916.740273] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x00000006f2163200
[12916.740274] mmc0: sdhci: ============================================
[12916.740337] mmc0: error -5 whilst initialising MMC card

As you can see, from an IOMMU perspective, this is PCI device 00:13.1.
However, from a kernel perspective, it's not on the PCI bus and does not require IOMMU translation, but rather just direct DMA mapping.


linux@udookurt(/):~/linux-53/drivers/mmc/host [0]$ sudo /sbin/lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP Bridge [6:0]
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP Bridge [6:0]
00:01.6 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP Bridge [6:0]
00:01.7 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 PCIe GPP Bridge [6:0]
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-1fh) PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus A
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Internal PCIe GPP Bridge 0 to Bus B
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 61)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raven/Raven2 Device 24: Function 7
01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
03:00.0 Network controller: Intel Corporation Dual Band Wireless-AC 3168NGW [Stone Peak] (rev 10)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
05:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series] (rev 83)
05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Raven/Raven2/Fenghuang HDMI/DP Audio Controller
05:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
05:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
05:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
05:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Raven/Raven2/FireFlight/Renoir Audio Processor
05:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
05:00.7 Non-VGA unclassified device: Advanced Micro Devices, Inc. [AMD] Raven/Raven2/Renoir Non-Sensor Fusion Hub KMDF driver
06:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 61)

Looks like we'd need some quirks to actually create a pci_device handle for the embedded AMD eMMC controller?
Thoughts?

PS: Please copy me on responses, I'm off LKML for half a decade now :-O

-- 
Kurt Garloff<kurt@garloff.de>
Cologne, Germany

