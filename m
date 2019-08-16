Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C20C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CA1206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfHPCfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:35:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfHPCfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:35:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0A6014AB6A60EF9B3FD;
        Fri, 16 Aug 2019 10:35:20 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 10:35:12 +0800
Subject: Re: [PATCH v4 0/5] Fixes for HiSilicon LPC driver and logical PIO
 code
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>
References: <1564493396-92195-1-git-send-email-john.garry@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <stable@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5D561660.1080003@hisilicon.com>
Date:   Fri, 16 Aug 2019 10:35:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1564493396-92195-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2019/7/30 21:29, John Garry wrote:
> As reported in [1], the hisi-lpc driver has certain issues in handling
> logical PIO regions, specifically unregistering regions.
>
> This series add a method to unregister a logical PIO region, and fixes up
> the driver to use them.
>
> RCU usage in logical PIO code looks to always have been broken, so that
> is fixed also. This is not a major fix as the list which RCU protects
> would be rarely modified.
>
> At this point, there are still separate ongoing discussions about how to
> stop the logical PIO and PCI host bridge code leaking ranges, as in [2],
> which I haven't had a chance to look at recently.
>
> Hopefully this series can go through the arm soc tree and the maintainers
> have no issue with that. I'm talking specifically about the logical PIO
> code, which went through PCI tree on only previous upstreaming.
>
>
> [1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
> [2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/

Thanks!
Series applied to the hisilicon fixes tree.

Best Regards,
Wei

> Changes since v3:
> https://lore.kernel.org/lkml/1561566418-22714-1-git-send-email-john.garry@huawei.com/
> - drop optimisation patch (lib: logic_pio: Enforce LOGIC_PIO_INDIRECT
>    region ops are set at registration)
>    Not a fix
> - rebase to v5.3-rc2
> - cc stable
>
> Change since v2:
> - Add hisi_lpc_acpi_remove() stub to fix build for !CONFIG_ACPI
>
> Changes since v1:
> - Add more reasoning in RCU fix patch
> - Create separate patch to change LOGIC_PIO_CPU_MMIO registration to
>    accomodate unregistration
>
> John Garry (5):
>    lib: logic_pio: Fix RCU usage
>    lib: logic_pio: Avoid possible overlap for unregistering regions
>    lib: logic_pio: Add logic_pio_unregister_range()
>    bus: hisi_lpc: Unregister logical PIO range to avoid potential
>      use-after-free
>    bus: hisi_lpc: Add .remove method to avoid driver unbind crash
>
>   drivers/bus/hisi_lpc.c    | 47 +++++++++++++++++++++----
>   include/linux/logic_pio.h |  1 +
>   lib/logic_pio.c           | 73 +++++++++++++++++++++++++++++----------
>   3 files changed, 96 insertions(+), 25 deletions(-)
>


