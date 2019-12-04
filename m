Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB2C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57EE205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLDL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:26:04 -0500
Received: from foss.arm.com ([217.140.110.172]:54600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727445AbfLDL0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:26:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF1FB31B;
        Wed,  4 Dec 2019 03:26:03 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF4E73F68E;
        Wed,  4 Dec 2019 03:26:02 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:26:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] arm64: mm: Fix initialisation of DMA zones on non-NUMA
 systems
Message-ID: <20191204112600.GE13081@arrakis.emea.arm.com>
References: <20191203121013.9280-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203121013.9280-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 12:10:13PM +0000, Will Deacon wrote:
> John reports that the recently merged commit 1a8e1cef7603 ("arm64: use
> both ZONE_DMA and ZONE_DMA32") breaks the boot on his DB845C board:
> 
>   | Booting Linux on physical CPU 0x0000000000 [0x517f803c]
>   | Linux version 5.4.0-mainline-10675-g957a03b9e38f
>   | Machine model: Thundercomm Dragonboard 845c
>   | [...]
>   | Built 1 zonelists, mobility grouping on.  Total pages: -188245
>   | Kernel command line: earlycon
>   | firmware_class.path=/vendor/firmware/ androidboot.hardware=db845c
>   | init=/init androidboot.boot_devices=soc/1d84000.ufshc
>   | printk.devkmsg=on buildvariant=userdebug root=/dev/sda2
>   | androidboot.bootdevice=1d84000.ufshc androidboot.serialno=c4e1189c
>   | androidboot.baseband=sda
>   | msm_drm.dsi_display0=dsi_lt9611_1080_video_display:
>   | androidboot.slot_suffix=_a skip_initramfs rootwait ro init=/init
>   |
>   | <hangs indefinitely here>
> 
> This is because, when CONFIG_NUMA=n, zone_sizes_init() fails to handle
> memblocks that fall entirely within the ZONE_DMA region and erroneously ends up
> trying to add a negatively-sized region into the following ZONE_DMA32, which is
> later interpreted as a large unsigned region by the core MM code.
> 
> Rework the non-NUMA implementation of zone_sizes_init() so that the start
> address of the memblock being processed is adjusted according to the end of the
> previous zone, which is then range-checked before updating the hole information
> of subsequent zones.
> 
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Link: https://lore.kernel.org/lkml/CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com
> Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Queued for 5.5-rc1. Thanks.

-- 
Catalin
