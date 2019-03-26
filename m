Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6934E2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DmrsHUeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfCZHaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:30:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfCZHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:30:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7U93F129039;
        Tue, 26 Mar 2019 02:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553585409;
        bh=jwL7Cz9BeFMyoI6ixuedj2xZ3alTOxzKakeqri8mXn4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=DmrsHUeU7ydumkZ/bnSq4nmS0kKgC6t9btJcLR61n14xQ9Ta3n5zxB6UwMsLM7JbW
         YyZxtuvZyOUptAO82mWTanmgHA3NuKeZQDvKCbIUDC47ue3Xo2H+auUtJL5+I8iU4+
         /ROPFFDsW+2o+EYzpF7abUf7tIG6LhvNAI1AfIfA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2Q7U9xo020902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 02:30:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 02:30:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 02:30:08 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2Q7U3is055197;
        Tue, 26 Mar 2019 02:30:05 -0500
Subject: Re: [PATCH v6 0/3] Stingray USB PHY driver support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
 <7490f894-3c0b-c7cd-5ff0-4eea6ea2c199@broadcom.com>
 <1f910861-7d3b-63ad-da79-9515eae2b230@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <90db2ec9-c960-8cf5-c5d3-1e8e85d6ad60@ti.com>
Date:   Tue, 26 Mar 2019 12:59:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1f910861-7d3b-63ad-da79-9515eae2b230@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/19 10:12 PM, Florian Fainelli wrote:
> On 3/19/19 11:38 AM, Scott Branden wrote:
>> Thanks Srinath and Rob - patch series looks good now.
>>
>> patch series,
>>
>> Acked-by: Scott Branden <scott.branden@broadcom.com>
>>
> 
> Kishon, can you let me know when you apply patches 1 and 2 so I can
> queue up patch 3 for inclusion the 5.2 ARM SoC pull request? Thanks!

merged the dt-binding and sr-usb driver, thanks.

-Kishon
> 
>>
>> On 2019-03-19 2:15 a.m., Srinath Mannam wrote:
>>> These patches add Stingray USB PHY driver and its corresponding
>>> DT nodes with documentation.
>>>
>>> This patch set is based on Linux-5.0-rc2.
>>>
>>> Changes from v5:
>>>    - Removed redundant address and size cells in DT nodes.
>>>
>>> Changes from v4:
>>>    - Addressed Rob Herring review comments
>>>       - Removed child nodes and added #phy-cells 1
>>>       - Added xlate function to get phy using phandle argument.
>>>
>>> Changes from v3:
>>>    - Addressed Rob Herring review comments
>>>       - Changed compatible strings.
>>>       - updated driver based on new compatible strings.
>>>
>>> Changes from v2:
>>>    - Addressed Kishon review comments
>>>    - Updated patchset to Linux-5.0-rc2
>>>
>>> Changes from v1:
>>>    - Addressed Kishon review comments
>>>    - phy init call return value handle
>>>    Srinath Mannam (3):
>>>    dt-bindings: phy: Add Stingray USB PHY binding document
>>>    phy: sr-usb: Add Stingray USB PHY driver
>>>    arm64: dts: Add USB DT nodes for Stingray SoC
>>>
>>>   .../bindings/phy/brcm,stingray-usb-phy.txt         |  32 ++
>>>   .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  72 ++++
>>>   .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
>>>   drivers/phy/broadcom/Kconfig                       |  11 +
>>>   drivers/phy/broadcom/Makefile                      |   1 +
>>>   drivers/phy/broadcom/phy-bcm-sr-usb.c              | 393
>>> +++++++++++++++++++++
>>>   6 files changed, 510 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
>>>   create mode 100644
>>> arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
>>>   create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
>>>
> 
> 
