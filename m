Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF501C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B13D24680
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SYYgamLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLIJtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:49:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52836 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLIJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:49:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99n4q5034636;
        Mon, 9 Dec 2019 03:49:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575884944;
        bh=gXkmhjcxW2shpp8IuTFNOznIZj9QdXL4AF01PfYwrZs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SYYgamLftGLE21WsTvUWXHazxF6KK9Nl/WMmoZpwc+TEXlxwlCMZ+bb2l2wa4CnLr
         eF3FFlHUZvop/NM3nb7zZ4lvUehYeS9T7PVAxndbLI+MjUeu0wuFwXF7f1LbRdXVpS
         dk/g2SyoymsGKedhL1Xm1CF6KXICte7T/ebUoncU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99n4na050489
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:49:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:49:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:49:04 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99n28p009818;
        Mon, 9 Dec 2019 03:49:02 -0600
Subject: Re: [PATCH v4 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip
 support
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191028102153.24866-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d9f3af03-b9a6-d5b9-dce6-e573ceef7348@ti.com>
Date:   Mon, 9 Dec 2019 11:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191028102153.24866-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 28/10/2019 12:21, Roger Quadros wrote:
> Hi,
> 
> On J721e platform, the 2 lanes of SERDES PHY are used to achieve
> USB Type-C plug flip support without any additional MUX component
> by using a lane swap feature.
> 
> However, the driver needs to know the Type-C plug orientation before
> it can decide whether to swap the lanes or not. This is achieved via a
> GPIO named DIR.
> 
> Another constraint is that the lane swap must happen only when the PHY
> is in inactive state. This is achieved by sampling the GPIO and
> programming the lane swap before bringing the PHY out of reset.
> 
> This series adds support to read the GPIO and accordingly program
> the Lane swap for Type-C plug flip support.
> 
> Series must be applied on top of
> https://lkml.org/lkml/2019/10/23/589

I just tested this on top of Sierra PHY patches v3
https://lkml.org/lkml/2019/11/28/186
on v5.5-rc1

USB3 works fine on J7ES.

Please queue this along with the Sierra PHY patches for -next. Thanks.

cheers,
-roger

> 
> cheers,
> -roger
> 
> Changelog:
> v4
> - fixes in dt-binding document
>    - fix typo
>    - change to typec-dir-debounce-ms and add min/max/default values
>    - drop reference to uint32 type
> - fixes in driver
>    - change to updated typec-dir-debounce-ms property
>    - add limit checks and use default value if not specified
> 
> v3
> - Rebase on v2 of PHY series and update DT binding to yaml
> 
> v2
> - revise commit log of patch 1
> - use regmap_field in patch 3
> 
> Roger Quadros (3):
>    phy: cadence: Sierra: add phy_reset hook
>    dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
>    phy: ti: j721e-wiz: Manage typec-gpio-dir
> 
>   .../bindings/phy/ti,phy-j721e-wiz.yaml        | 17 ++++++
>   drivers/phy/cadence/phy-cadence-sierra.c      | 10 +++
>   drivers/phy/ti/phy-j721e-wiz.c                | 61 +++++++++++++++++++
>   3 files changed, 88 insertions(+)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
