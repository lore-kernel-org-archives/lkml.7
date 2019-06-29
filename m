Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E6C5B579
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53306215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfF2CIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 22:08:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbfF2CIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 22:08:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03EA9AD12CCE9E729E1A;
        Sat, 29 Jun 2019 10:08:40 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Jun 2019
 10:08:34 +0800
Subject: Re: [PATCH RFC 0/3] Support CPU hotplug for ARM64
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <74bda3c2-e706-aa3b-441a-fb85e2a5c778@huawei.com>
Date:   Sat, 29 Jun 2019 10:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the third patch can't be applied to the lastest kernel. I will send another
version and attach the method to test this patchset.

On 2019/6/28 19:13, Xiongfeng Wang wrote:
> This patchset mark all the GICC node in MADT as possible CPUs even though it
> is disabled. But only those enabled GICC node are marked as present CPUs.
> So that kernel will initialize some CPU related data structure in advance before
> the CPU is actually hot added into the system. This patchset also implement 
> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
> needed to enable CPU hotplug.
> 
> To support CPU hotplug, we need to add all the possible GICC node in MADT
> including those CPUs that are not present but may be hot added later. Those
> CPUs are marked as disabled in GICC nodes.
> 
> Xiongfeng Wang (3):
>   ACPI / scan: evaluate _STA for processors declared via ASL Device
>     statement
>   arm64: mark all the GICC nodes in MADT as possible cpu
>   arm64: Add CPU hotplug support
> 
>  arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
>  arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
>  arch/arm64/kernel/smp.c   | 11 +++++------
>  drivers/acpi/scan.c       | 12 ++++++++++++
>  4 files changed, 57 insertions(+), 7 deletions(-)
> 

