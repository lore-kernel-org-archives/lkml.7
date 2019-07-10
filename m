Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A185C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED88B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfGJLfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:35:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:8416 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJLfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:35:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 04:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="189143865"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2019 04:35:05 -0700
Subject: Re: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap Delays
 Handling
To:     Manish Narani <manish.narani@xilinx.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        michal.simek@xilinx.com, christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d4a733c4-9760-a790-5752-be3f14c53bec@intel.com>
Date:   Wed, 10 Jul 2019 14:33:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/07/19 8:29 AM, Manish Narani wrote:
> This patch series does the following:
>  - Reorganize the Clock Handling in Arasan SD driver
>  - Adds new sampling clock in Arasan SD driver
>  - Adds support to set Clock Delays in SD Arasan Driver
>  - Add SDIO Tap Delay handling in ZynqMP firmware driver
>  - Add support for ZynqMP Tap Delays setting in Arasan SD driver
> 
> Changes in v2:
> 	- Replaced the deprecated calls to clock framework APIs
> 	- Added support for dev_clk_get() call to work for SD card clock
> 	- Separated the clock data struct
> 	- Fragmented the patch series in smaller patches to make it more
> 	  readable
> 
> This patch series contains a DT patch, which I think should be there to
> maintain the order of commits.
> 
> Manish Narani (11):
>   dt-bindings: mmc: arasan: Update documentation for SD Card Clock
>   arm64: dts: rockchip: Add optional clock property indicating sdcard
>     clock
>   mmc: sdhci-of-arasan: Replace deprecated clk API calls
>   mmc: sdhci-of-arasan: Separate out clk related data to another
>     structure
>   dt-bindings: mmc: arasan: Update Documentation for the input clock
>   mmc: sdhci-of-arasan: Add sampling clock for a phy to use
>   dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
>   mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
>   firmware: xilinx: Add SDIO Tap Delay APIs
>   dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
>   mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
> 
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  49 ++-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +-
>  drivers/firmware/xilinx/zynqmp.c                   |  48 +++
>  drivers/mmc/host/sdhci-of-arasan.c                 | 453 ++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h               |  15 +-
>  5 files changed, 540 insertions(+), 29 deletions(-)
> 

For SDHCI:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
