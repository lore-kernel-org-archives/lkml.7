Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0AFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D1F2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hi1wi0TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfDJIlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:41:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50788 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:41:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3A8fCuM039010;
        Wed, 10 Apr 2019 03:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554885672;
        bh=eRsdKzNK/STv6PAB9KBJaS+OtSDsBtusGNDI77/gcoM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hi1wi0TDU+EAavVWQunv6hWttGqlWXqH6S6D8o+DqUolPaCXglFcu5B/EGsdvFwxj
         1uQGrcf4u8+RNuM4my7hdWOANpRyZu4g8MHHbiar6qoSB4Zy9bhjIplEPb0Jmovf+i
         ItIwDTGu4exA9gIKKszXNfkLlkwkGE8t0Zhu6bMg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3A8fCjm091786
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Apr 2019 03:41:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 10
 Apr 2019 03:41:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 10 Apr 2019 03:41:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3A8f8G0067436;
        Wed, 10 Apr 2019 03:41:08 -0500
Subject: Re: [PATCH v4 0/5] PHY: Add support for SERDES in TI's AM654 platform
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20190405110834.13083-1-kishon@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3cd1371d-36fd-c907-b532-3a6f46f4eabf@ti.com>
Date:   Wed, 10 Apr 2019 11:41:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405110834.13083-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon,

On 05/04/2019 14:08, Kishon Vijay Abraham I wrote:
> This patch series
>   *) adds support for SERDES module in am654
>   *) modifies phy_reset API to invoke pm_runtime_get/pm_runtime_put since
> the reset callback can access registers.
>   *) Add *release* phy_ops to be invoked when the consumer relinquishes
> PHY
> 
> Changes from v3:
>   *) Moved SERDES driver to use regfield
>   *) Removed reg-names binding and updated Documentation for
>      power-domains
> 
> Changes from v2:
>   *) Fix typos pointed out by Roger
>   *) Add dt-binding Documentation in a new file ti,phy-am654-serdes.txt
>   *) Add Roger's patch to support all CLKSEL values.
> 
> Changes from v1:
>   *) Add *release* phy ops
>   *) Populate release phy_ops in phy-am654-serdes to cleanup
> initializations done in of_xlate
> 
> Kishon Vijay Abraham I (4):
>   phy: core: Add *release* phy_ops invoked when the consumer
>     relinquishes PHY
>   phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
>     reset callback
>   dt-bindings: phy: ti: Add dt binding documentation for SERDES in
>     AM654x SoC
>   phy: ti: Add a new SERDES driver for TI's AM654x SoC

For these patches,

Reviewed-by: Roger Quadros <rogerq@ti.com>

> 
> Roger Quadros (1):
>   phy: ti: am654-serdes: Support all clksel values
> 
>  .../bindings/phy/ti,phy-am654-serdes.txt      |  82 +++
>  drivers/phy/phy-core.c                        |  11 +
>  drivers/phy/ti/Kconfig                        |  12 +
>  drivers/phy/ti/Makefile                       |   1 +
>  drivers/phy/ti/phy-am654-serdes.c             | 658 ++++++++++++++++++
>  include/dt-bindings/phy/phy-am654-serdes.h    |  13 +
>  include/linux/phy/phy.h                       |   2 +
>  7 files changed, 779 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>  create mode 100644 drivers/phy/ti/phy-am654-serdes.c
>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
