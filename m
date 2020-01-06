Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B8C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21C721775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z8VCJpO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgAFFXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:23:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:23:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0065NTJd030572;
        Sun, 5 Jan 2020 23:23:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578288209;
        bh=rTz3tg0hukG6B7Zkj7d+S6fA37E2Q8Ph5uLJXD8dxww=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z8VCJpO4Wx34j08zAwzjmyhePKALEpr4bj3GwgpRjcRFPVp76bd559eS49h8VZxmS
         4U1Ho4mtD6bMRORY1fxKDFpheE9ys9SEpOCSR1Hha/WVIWU7zMJdDnnXKILPuPH6pM
         41CKR/CFZ7kNK1wEh+Fct/bmbHghJNsdH+2xFZ94=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0065NT2p076205;
        Sun, 5 Jan 2020 23:23:29 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 5 Jan
 2020 23:23:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 5 Jan 2020 23:23:28 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0065NPAk105709;
        Sun, 5 Jan 2020 23:23:26 -0600
Subject: Re: [PATCH v4 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
To:     Al Cooper <alcooperx@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200103181811.22939-1-alcooperx@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <76cf24f1-4d72-2dec-ef80-36d6d3744ebe@ti.com>
Date:   Mon, 6 Jan 2020 10:55:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/20 11:47 PM, Al Cooper wrote:
> This patchset contains various updates to the Broadcom STB USB Driver.
> The updates include:
> - Add support for 7216 and 7211 Broadcom SoCs which use the new
>   Synopsys USB Controller.
> - Add support for USB Wake
> - Add various bug fixes.

merged, thanks!

-Kishon
> 
> 
> v4 - Fix mispelling, change Synopsis to Synopsys. Also add
>      "Reviewed-by: Rob Herring" to bindings patch. There are no
>      functional code changes in v4.
> 
> v3 - Rebase to v5.5-rc1
> 
> v2 - Changes based on review feedback
>    - Add vendor prefix to DT property "syscon-piarbctl"
>    - Use standard "wakeup" instead of "wake" for DT "interrupt-names"
> 
> Al Cooper (13):
>   phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
>   phy: usb: Get all drivers that use USB clks using correct
>     enable/disable
>   phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
>   phy: usb: Add "wake on" functionality
>   phy: usb: Restructure in preparation for adding 7216 USB support
>   dt-bindings: Add Broadcom STB USB PHY binding document
>   phy: usb: Add support for new Synopsys USB controller on the 7216
>   phy: usb: Add support for new Synopsys USB controller on the 7211b0
>   phy: usb: fix driver to defer on clk_get defer
>   phy: usb: PHY's MDIO registers not accessible without device installed
>   phy: usb: bdc: Fix occasional failure with BDC on 7211
>   phy: usb: USB driver is crashing during S3 resume on 7216
>   phy: usb: Add support for wake and USB low power mode for 7211 S2/S5
> 
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  69 ++-
>  drivers/phy/broadcom/Makefile                 |   2 +-
>  .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 414 ++++++++++++++++++
>  drivers/phy/broadcom/phy-brcm-usb-init.c      | 226 +++++-----
>  drivers/phy/broadcom/phy-brcm-usb-init.h      | 148 ++++++-
>  drivers/phy/broadcom/phy-brcm-usb.c           | 269 ++++++++++--
>  6 files changed, 943 insertions(+), 185 deletions(-)
>  create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
> 
