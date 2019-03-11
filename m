Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B09321738
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCKQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:31:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKQbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:31:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 405269064B4B43CFC3F3;
        Tue, 12 Mar 2019 00:31:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 00:31:29 +0800
To:     <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <suzuki.poulose@arm.com>, <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        <lious.lilei@hisilicon.com>, <lishuo1@hisilicon.com>
From:   Zheng Xiang <zhengxiang9@huawei.com>
Subject: [RFC] Question about TLB flush while set Stage-2 huge pages
Message-ID: <5f712cc6-0874-adbe-add6-46f5de24f36f@huawei.com>
Date:   Tue, 12 Mar 2019 00:31:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While a page is merged into a transparent huge page, KVM will invalidate Stage-2 for
the base address of the huge page and the whole of Stage-1.
However, this just only invalidates the first page within the huge page and the other
pages are not invalidated, see bellow:

    +---------------+--------------+
    |abcde       2MB-Page          |
    +---------------+--------------+

    TLB before setting new pmd:
    +---------------+--------------+
    |      VA       |    PAGESIZE  |
    +---------------+--------------+
    |      a        |      4KB     |
    +---------------+--------------+
    |      b        |      4KB     |
    +---------------+--------------+
    |      c        |      4KB     |
    +---------------+--------------+
    |      d        |      4KB     |
    +---------------+--------------+

    TLB after setting new pmd:
    +---------------+--------------+
    |      VA       |    PAGESIZE  |
    +---------------+--------------+
    |      a        |      2MB     |
    +---------------+--------------+
    |      b        |      4KB     |
    +---------------+--------------+
    |      c        |      4KB     |
    +---------------+--------------+
    |      d        |      4KB     |
    +---------------+--------------+

When VM access *b* address, it will hit the TLB and result in TLB conflict aborts or other potential exceptions.

For example, we need to keep tracking of the VM memory dirty pages when VM is in live migration.
KVM will set the memslot READONLY and split the huge pages.
After live migration is canceled and abort, the pages will be merged into THP.
The later access to these pages which are READONLY will cause level-3 Permission Fault until they are invalidated.

So should we invalidate the tlb entries for all relative pages(e.g a,b,c,d), like __flush_tlb_range()?
Or we can call __kvm_tlb_flush_vmid() to invalidate all tlb entries.



-- 

Thanks,
Xiang

