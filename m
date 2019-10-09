Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CE5C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C362070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ez12gg+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfJICXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:23:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9155 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfJICXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:23:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9d44990000>; Tue, 08 Oct 2019 19:23:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Oct 2019 19:23:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Oct 2019 19:23:17 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Oct
 2019 02:23:16 +0000
Received: from [10.19.101.249] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Oct 2019
 02:23:13 +0000
Subject: Re: [PATCH v3 0/7] add Tegra194 XUSB host and pad controller support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nkristam@nvidia.com>,
        <skomatineni@nvidia.com>
References: <20191004162906.4818-1-jckuo@nvidia.com>
 <20191007110311.GA614644@kroah.com> <20191008112907.GC228118@ulmo>
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <454e29a6-bf31-c75c-0f29-abd18a4ae071@nvidia.com>
Date:   Wed, 9 Oct 2019 10:23:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008112907.GC228118@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570587801; bh=vnyW6vcYjvIgUWxen6TD2VOhh0h48/42kmnZQsDavJA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ez12gg+le8K5PmWmR8YWC3VmIeWSmk35/9k5fY9ASesDIKMbncNvPGPoJEGRfdthe
         1/H2cq2Mngi83sb65hai4L+ksuGs2YwIpJa4Pq4dfIA5cx9/Zw85jEPP+eXCZt/E/v
         jAPV8AmzoBggSvN8Ub9LcHQ29KqawE9sv02x8gRR4MvgOl/1En7C/q/fk+v9tTby3/
         8oFnp6Qh7Yqs9yLtExGoulqFTTqOaBuf7OP2rqPhOZjgE5ZbYVm1oLN9Tn07NuLM24
         fwKF2yVodh4R4fDfeYZQpIAU825y7+UXL2bHyHl62k2mHWmOlzYEXO81EdZLPrf9Bs
         /4bzHxzCp+8HA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/19 7:29 PM, Thierry Reding wrote:
> On Mon, Oct 07, 2019 at 01:03:11PM +0200, Greg KH wrote:
>> On Sat, Oct 05, 2019 at 12:28:59AM +0800, JC Kuo wrote:
>>> Hi,
>>>
>>> This series introduces support for Tegra194 XUSB host and pad
>>> controller. Tegra194 XUSB host and pad controller are highly
>>> similar to the controllers found on Tegra186. Therefore, it's
>>> possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.
>>
>> I've taken patches 1 and 2 through my USB tree.  If you want/need me to
>> take the others, please get acks from those maintainers on them so I can
>> do so.
> 
> I can pick up patches 6 and 7 into the Tegra tree. There are a few
> patches in there already that conflict with the DT changes in this
> series and those will be easier to resolve in the Tegra tree.
> 
> JC, I noticed that you didn't Cc Kishon as the PHY subsystem maintainer.
> Please resend the series with Kishon added in the To: line to make sure
> he sees them and can apply or ack them.
> 
> Given that Greg's already applied patches 1 and 2, maybe leave them out
> of the series.
Thanks Thierry. I will send v4 accordingly.
> 
> Thierry
> 
