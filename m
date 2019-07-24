Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F9C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8C229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGXIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:33:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXIdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:33:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5579585EAE5EF849C02;
        Wed, 24 Jul 2019 16:33:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 16:33:16 +0800
Subject: Re: [PATCH v12 2/2] mm: page_alloc: reduce unnecessary binary search
 in memblock_next_valid_pfn
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jia He <hejianet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1563861073-47071-1-git-send-email-guohanjun@huawei.com>
 <1563861073-47071-3-git-send-email-guohanjun@huawei.com>
 <20190723083353.GC4896@rapoport-lnx>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <868f90c7-a728-9eb3-7529-f5a8a501a76a@huawei.com>
Date:   Wed, 24 Jul 2019 16:33:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190723083353.GC4896@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/23 16:33, Mike Rapoport wrote:
> On Tue, Jul 23, 2019 at 01:51:13PM +0800, Hanjun Guo wrote:
>> From: Jia He <hejianet@gmail.com>
>>
>> After skipping some invalid pfns in memmap_init_zone(), there is still
>> some room for improvement.
>>
>> E.g. if pfn and pfn+1 are in the same memblock region, we can simply pfn++
>> instead of doing the binary search in memblock_next_valid_pfn.
>>
>> Furthermore, if the pfn is in a gap of two memory region, skip to next
>> region directly to speedup the binary search.
> How much speed up do you see with this improvements relatively to simple
> binary search in memblock_next_valid_pfn()?

The major speedup on my platform is the previous patch in this patch set,
not this one, I think it's related to sparse memory mode for different
platforms.

Thanks
Hanjun

>   

