Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6854C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841320873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fV0+GFJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbfJDQIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:08:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16297 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbfJDQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:08:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d976e950000>; Fri, 04 Oct 2019 09:08:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 09:08:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Oct 2019 09:08:44 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 16:08:44 +0000
Received: from [10.19.101.223] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct 2019
 16:08:41 +0000
Subject: Re: [PATCH v2 0/7] add Tegra194 XUSB host and pad controller support
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>
References: <20191004081941.4831-1-jckuo@nvidia.com>
 <20191004122322.GB422178@kroah.com>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <1a52dc83-3342-0cbf-c345-5c7be9602fd4@nvidia.com>
Date:   Sat, 5 Oct 2019 00:08:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004122322.GB422178@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570205333; bh=Fp5l3Rnhu/ep2kIL29WMWx8dC8CilaUaeX7BmNyBlrI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fV0+GFJ5kuxCS8QagayZv6eOGl2Wj7+zcazsktGNzZofxX/jdy37mx3SsdoWDDBt9
         BwOiSxcrjObHNSxwQgLZoJgMd7G0i036mT/xoeldnSTJ4EiJk9Peq/h0hrKHPELNZf
         tRQ8YashKCI1ErwW+CYsgNXoNElqK7Bvwy9npuwld0b/MI2f8+YO8Cf4chBKGjshaw
         Ok3KxVdFx94VAxYL+wYPxBuBTNRpfXZQzscAZWRHfKx4gUUD3JAW4kCw12vX+Q03BO
         aJuEpjJpjmg2/lZLAHTK2m04oELbT9X1uRlGUSwAGEN5V5NlbsEpucj52Gyl3BH85g
         5H53DKu8XcPDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 8:23 PM, Greg KH wrote:
> On Fri, Oct 04, 2019 at 04:19:34PM +0800, JC Kuo wrote:
>> Hi,
>>
>> This series introduces support for Tegra194 XUSB host and pad
>> controller. Tegra194 XUSB host and pad controller are highly
>> similar to the controllers found on Tegra186. Therefore, it's
>> possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.
>>
>> JC Kuo (7):
>>   xhci: tegra: Parameterize mailbox register addresses
>>   usb: host: xhci-tegra: Add Tegra194 XHCI support
>>   phy: tegra: xusb: Protect Tegra186 soc with config
>>   phy: tegra: xusb: Add Tegra194 support
>>   dt-bindings: phy: tegra: Add Tegra194 support
>>   arm64: tegra: Add XUSB and pad controller on Tegra194
>>   arm64: tegra: Enable XUSB host in P2972-0000 board
> 
> What changed from v1?  You need to put that somewhere, usually in the
> patches themselves, below the --- line.
> 
> Or at the very least, in the cover letter.
> 
> Given that I can't find it anywhere here, I'll expect a v3 with that
> information to be sent soon :(
> 
For the first two patches, v2 is identical to v1, sorry that I didn't describe
in patches. For the patches 3 to 7, the individual patch has "Changes in v2:"
session to describe.
I will submit v3 with patch 1 and 2 updated.

Thanks for the guidance,
JC

