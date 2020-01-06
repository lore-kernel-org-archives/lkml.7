Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33886C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0748C24670
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SwUxVCk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgAFGaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:30:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFGaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:30:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0066Twd3058392;
        Mon, 6 Jan 2020 00:29:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578292198;
        bh=5W0rKJu0XtdYnxnW8BrYFVS8xjJz8MYgse/qdgZRWLg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SwUxVCk0+CdxCZ4ImRcknP+52vhb2XKld42U4cy6yqZaABJFGJST5o1TUMKKCs+aV
         4YYbKFRWXmW7rOuG3P9uTvXWaSO/0Vy6WQ1/+7KegL+BX9Hqf+o0yKZ8Upm9DbbYFH
         8ErQWgsUmOUkWSZ9WYv0Uxl9Den9NCPhDyKyd0po=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0066TwJl054027;
        Mon, 6 Jan 2020 00:29:58 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 00:29:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 00:29:58 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0066Tt7g006074;
        Mon, 6 Jan 2020 00:29:56 -0600
Subject: Re: [PATCH v4 00/14] PHY: Add support for SERDES in TI's J721E SoC
To:     Rob Herring <robh+dt@kernel.org>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191216095712.13266-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5e2e9bb7-5d9a-b0bb-7057-ed1fbdfb11f7@ti.com>
Date:   Mon, 6 Jan 2020 12:02:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/12/19 3:26 PM, Kishon Vijay Abraham I wrote:
> TI's J721E SoC uses Cadence Sierra SERDES for USB, PCIe and SGMII.
> TI has a wrapper named WIZ to control input signals to Sierra and
> Torrent SERDES.

Merged this series.

Thanks
Kishon

> 
> This patch series:
>  1) Add support to WIZ module present in TI's J721E SoC
>  2) Adapt Cadence Sierra PHY driver to be used for J721E SoC
> 
> Changes from v3:
>  *) Fix Rob's comments on dt bindings
>         -> Add properties to be added in WIZ child nodes to binding
>         -> Use '-' rather than '_' in node names
> 
> Changes from v2:
>  *) Deprecate "phy_clk" binding
>  *) Fix Rob's comment on dt bindings
>         -> Include BSD-2-Clause license identifier
>         -> drop "oneOf" and "items" for compatible
>         -> Fixed "num-lanes" to include only scalar keywords
>         -> Change to 32-bit address space for child nodes
> *) Rename cmn_refclk/cmn_refclk1 to cmn_refclk_dig_div/
>    cmn_refclk1_dig_div
> 
> Changes from v1:
>  *) Change the dt binding Documentation of WIZ wrapper to YAML format
>  *) Fix an issue in Sierra while doimg rmmod
> 
> The series has also been pushed to
> https://github.com/kishon/linux-wip.git j7_serdes_v4
> 
> Anil Varughese (1):
>   phy: cadence: Sierra: Configure both lane cdb and common cdb registers
>     for external SSC
> 
> Kishon Vijay Abraham I (13):
>   dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
>   phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional
>     resources
>   phy: cadence: Sierra: Use "regmap" for read and write to Sierra
>     registers
>   phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
>   phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
>   phy: cadence: Sierra: Modify register macro names to be in sync with
>     Sierra user guide
>   phy: cadence: Sierra: Get reset control "array" for each link
>   phy: cadence: Sierra: Check for PLL lock during PHY power on
>   phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
>   phy: cadence: Sierra: Set cmn_refclk_dig_div/cmn_refclk1_dig_div
>     frequency to 25MHz
>   phy: cadence: Sierra: Use correct dev pointer in
>     cdns_sierra_phy_remove()
>   dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
>   phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC
> 
>  .../bindings/phy/phy-cadence-sierra.txt       |  13 +-
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++
>  drivers/phy/cadence/phy-cadence-sierra.c      | 699 +++++++++++---
>  drivers/phy/ti/Kconfig                        |  15 +
>  drivers/phy/ti/Makefile                       |   1 +
>  drivers/phy/ti/phy-j721e-wiz.c                | 898 ++++++++++++++++++
>  6 files changed, 1691 insertions(+), 139 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>  create mode 100644 drivers/phy/ti/phy-j721e-wiz.c
> 
