Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F322C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d6w7dMoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCRI5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:57:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50652 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2I8v4He076572;
        Mon, 18 Mar 2019 03:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552899425;
        bh=f2EHUtP8Zv/DVMIf/VLf2beEfJ8CRTpPymtgzx1nFyI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d6w7dMoZ2I14hxHVB3zEwSlGsqG3rFtYSP9jY1RH2RFSsqBFNFeKIhMM9AasyHluW
         bVKtCdao/hlqlou4BwA4LxjETBatd/6IFIh+vwJc+l5/fZpfjXt/rd6yfD0x9+uFSo
         1cYxWw8Kvo1GxT4WRb1P57fcuX93zgZCBG/jby/8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2I8v45w031476
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Mar 2019 03:57:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 18
 Mar 2019 03:57:04 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 18 Mar 2019 03:57:04 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2I8v2Sa001370;
        Mon, 18 Mar 2019 03:57:02 -0500
Subject: Re: [PATCH v2 0/5] phy: tegra: xusb: Add Tegra186 support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5dbaa0ad-9567-621d-9836-9cdb6ed366b0@ti.com>
Date:   Mon, 18 Mar 2019 14:26:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221154634.10684-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 21/02/19 9:16 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This series adds support for Tegra186 to the XUSB pad controller driver.
> Patch 1 extends the device tree bindings with support for Tegra186 while
> patches 2-4 are preparatory work for the final patch 5 that adds the
> Tegra186 specific programming for the UPHY blocks.
> 
> Changes in v2:
> - address review comments from Kishon
> - added Reviewed-by tags from JC

I've merged this series.
However I'd like to see if we can add the features of xusb.c to phy-core.c and
remove xusb.c. This will be useful if there are other PHY vendors with similar
design as Tegra.

Thanks
Kishon

> 
> Thierry
> 
> JC Kuo (2):
>   phy: tegra: xusb: Skip single function lane programming
>   phy: tegra: xusb: Add Tegra186 support
> 
> Thierry Reding (3):
>   dt-bindings: phy: tegra: Add Tegra186 support
>   phy: tegra: xusb: Parse dual-role mode property
>   phy: tegra: xusb: Add support for power supplies
> 
>  .../phy/nvidia,tegra124-xusb-padctl.txt       |   9 +
>  MAINTAINERS                                   |   5 +
>  drivers/phy/tegra/Makefile                    |   1 +
>  drivers/phy/tegra/xusb-tegra186.c             | 899 ++++++++++++++++++
>  drivers/phy/tegra/xusb.c                      |  67 +-
>  drivers/phy/tegra/xusb.h                      |  35 +
>  6 files changed, 1014 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/tegra/xusb-tegra186.c
> 
