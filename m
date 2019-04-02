Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA518C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F372082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfDBJaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:30:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfDBJav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:30:51 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [10.3.19.208])
        by Forcepoint Email with ESMTP id 8184764F2A690FF38AF8;
        Tue,  2 Apr 2019 17:30:47 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 17:30:36 +0800
Subject: Re: MSI number limit for PCI hotplug under PCI bridge on ARM platform
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <327ba551-2cbd-08bb-d4c1-107c3ff7d45d@huawei.com>
 <86ef6l57d0.wl-marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <f351d94f-a694-af12-37d7-ac5b52ea1ac4@huawei.com>
Date:   Tue, 2 Apr 2019 17:30:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <86ef6l57d0.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/2 13:00, Marc Zyngier wrote:
> On Mon, 01 Apr 2019 14:55:52 +0100,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Hi folks,
>>
>> In current kernel implementation for ARM platform, all devices under
>> one PCI bridge share a same device ID and the total number of MSI
>> interrupts is fixed at the first time any child device is allocating
>> MSI. However, this may cause failure of allocating MSI if the system
>> supports device hot-plug under the PCI bridge, which is possible for
>> ARM virtual machine with generic pcie-to-pci-bridge and kernel
>> config HOTPLUG_PCI_SHPC enabled.
>>
>> Does it make sense to add support for the above scenario? If it
>> does, any suggestion for how to do that?
> I don't think it makes much sense. You have the flexibility not to add
> such a broken setup to your guests, and instead have enough pcie ports
> so that you can always have an exact allocation and no DevID aliasing.
>
> The alternative is to dynamically grow the ITT for a given DevID,
> which cannot be done without unmapping it first. This in turn will
> result in interrupts being lost while the DevID was unmapped, and
> they'd need to be pessimistically reinjected. This also involves a
> substantial amount of data structure repainting, as you're pretty much
> guaranteed not to be able to reuse the same LPI range.
>
> Given that this is arbitrarily self-inflicted, I'm not overly keen on
> even trying to support this.
SHPC hot plug under PCI-bridge for virtual machine is attracting us for its larger capacity, i.e. one bridge can have up to hot-plugable 31 devices, while each PCIe root port or downstream port can only have one.

Anyway, the reason for not supporting this also makes sense to me.

Thanks for your advice,

Heyi

>
> Thanks,
>
> 	M.
>


