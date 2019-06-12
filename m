Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12620C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12E208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wb2slfVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408860AbfFLKXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:23:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43282 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408847AbfFLKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:23:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5CAN8tl038317;
        Wed, 12 Jun 2019 05:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560334988;
        bh=gXlPsskpiWFKuL3pKSUlET3jukGcKHstSsj3yxbC3+Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Wb2slfVJ1rQBhaKZ4ASf+uNopTTbp4J3NtShek+8YU8hnDPfLVoKpkPI0xFCoYnGf
         hCDRzscN825i8jiPk9pQKlxs4+5fu06BNgQ1OTUCPeMQGeub6fXRsYaFvGU/A2EJik
         uIXd8WlYKqa26C7J51TcNR4cgsTG8+bwOpNAU1bA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5CAN8vC078071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jun 2019 05:23:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 12
 Jun 2019 05:23:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 12 Jun 2019 05:23:08 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5CAN5sd016514;
        Wed, 12 Jun 2019 05:23:07 -0500
Subject: Re: [GIT PULL] PHY: for 5.2-rc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190611140122.9429-1-kishon@ti.com>
 <20190611170401.GA23216@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1f381f69-ca3f-05d4-d183-91bd59c3a26b@ti.com>
Date:   Wed, 12 Jun 2019 15:51:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611170401.GA23216@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/06/19 10:34 PM, Greg Kroah-Hartman wrote:
> On Tue, Jun 11, 2019 at 07:31:22PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Greg,
>>
>> Please find the pull request for 5.2 -rc cycle.
>>
>> The major fix being moving supplies powering PLLs used by USB, SATA,
>> PCIe to tegra-xusb driver fixing initialization failure.
>>
>> Others are minor fixes. Please see the tag message below for more
>> details.
>>
>> Consider merging it in this -rc cycle and let me know if you want me
>> to make any changes.
>>
>> Thanks
>> Kishon
>>
>> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>>
>>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2-rc
>>
>> for you to fetch changes up to ada28f7b3a97fa720864c86504a7c426ee6f91c1:
>>
>>   phy: tegra: xusb: Add Tegra210 PLL power supplies (2019-06-07 15:58:34 +0530)
>>
>> ----------------------------------------------------------------
>> phy: for 5.2-rc
>>
>>   *) Move Tegra124 PLL power supplies to be enabled by xusb-tegra124
>>   *) Move Tegra210 PLL power supplies to be enabled by xusb-tegra210
>>   *) Minor fixes: fix memory leaks at error path, fix sparse warnings
>>      and addresses coverity.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> ----------------------------------------------------------------
>> Colin Ian King (1):
>>       phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable
>>
>> Florian Fainelli (1):
>>       phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal
>>
>> Thierry Reding (3):
>>       dt-bindings: phy: tegra-xusb: List PLL power supplies
>>       phy: tegra: xusb: Add Tegra124 PLL power supplies
>>       phy: tegra: xusb: Add Tegra210 PLL power supplies
>>
>> Yoshihiro Shimoda (1):
>>       phy: renesas: rcar-gen2: Fix memory leak at error paths
>>
>> YueHaibing (1):
>>       phy: ti: am654-serdes: Make serdes_am654_xlate() static
> 
> sparse fixes are not for the -rc cycle, unless they fix an actual bug.
> 
> Care to send these as a patch series and I can queue up the real
> bugfixes for -final and take the others for 5.3-rc1?

Sure, I'll send the patches with an updated pull request.

Thanks
Kishon
