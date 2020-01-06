Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B8C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838D2071A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="STrhbIBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgAFNHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:07:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44454 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFNHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:07:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006D7Yn9077362;
        Mon, 6 Jan 2020 07:07:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578316054;
        bh=2FPkOHiFuw/3/5ZGEe10aNDQIAJ+xq/iTHCqalfTlKc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=STrhbIBz+g6kjPb4Wn6hEgD+iT+uMkw6lIak+vqr+Js9KfeSOSPZVtSEx0Jwdb7Vv
         Gw1EnOsdYVu0phCCci9UcpJ0MjNiJNQgQdy/it/Sk/k8NzTsZXQYCWXuM/75hig0Zo
         GbrqgcFGS1sCM1kStkhFaBmC0W02VdBlFyMDRRf0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D7YXZ021571;
        Mon, 6 Jan 2020 07:07:34 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 07:07:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 07:07:33 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006D7WHZ020291;
        Mon, 6 Jan 2020 07:07:32 -0600
Subject: Re: [PATCH v5 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip
 support
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200106130622.29703-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6390dd78-92bd-711b-f153-ae73c959a665@ti.com>
Date:   Mon, 6 Jan 2020 15:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106130622.29703-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/01/2020 15:06, Roger Quadros wrote:
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
> https://patchwork.kernel.org/cover/11293671/
> 
> cheers,
> -roger
> 
> Changelog:
v5
  - rebased on phy/next

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
