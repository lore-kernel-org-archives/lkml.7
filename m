Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D5C20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfDZQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:37:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54016 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfDZQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:37:26 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.141])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hK3qf-000743-KJ; Fri, 26 Apr 2019 10:37:18 -0600
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sbates@raithlin.com, Christoph Hellwig <hch@lst.de>,
        aou@eecs.berkeley.edu
References: <mhng-8e27a4f1-db30-46cf-b987-51bba8cd96c7@palmer-si-x1e>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <479792a3-d049-9d93-8bd7-465156ce813d@deltatee.com>
Date:   Fri, 26 Apr 2019 10:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-8e27a4f1-db30-46cf-b987-51bba8cd96c7@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: aou@eecs.berkeley.edu, hch@lst.de, sbates@raithlin.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, palmer@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/7] RISC-V: Sparsmem, Memory Hotplug and pte_devmap for
 P2P
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-04-24 5:23 p.m., Palmer Dabbelt wrote:
> On Wed, 27 Mar 2019 14:36:36 PDT (-0700), logang@deltatee.com wrote:
>> Hi,
>>
>> This patchset enables P2P on the RISC-V architecture. To do this on the
>> current kernel, we only need to be able to back IO memory with struct
>> pages using devm_memremap_pages(). This requires ARCH_HAS_ZONE_DEVICE,
>> ARCH_ENABLE_MEMORY_HOTPLUG, and ARCH_ENABLE_MEMORY_HOTREMOVE; which in
>> turn requires ARCH_SPARSEMEM_ENABLE. We also need to ensure that the
>> IO memory regions in hardware can be covered by the linear region
>> so that there is a linear relation ship between the virtual address and
>> the struct page address in the vmemmap region.
>>
>> While our reason to do this work is for P2P, these features are all
>> useful, more generally, and also enable other kernel features.
>>
>> The first patch in the series implements sparse mem. It was already
>> submitted and reviewed last cycle, only forgotten. It has been rebased
>> onto v5.1-rc2.
>>
>> Patches 2 through 4 rework the architecture's virtual address space
>> mapping trying to get as much of the IO regions covered by the linear
>> mapping. With Sv39, we do not have enough address space to cover all the
>> typical hardware regions but we can get the majority of it.
>>
>> Patch 5 and 6 implement memory hotplug and remove. These are relatively
>> straight forward additions similar to other arches.
>>
>> Patch 7 implements pte_devmap which allows us to set
>> ARCH_HAS_ZONE_DEVICE.
>>
>> The patchset was tested in QEMU and on a HiFive Unleashed board.
>> However, we were unable to actually test P2P transactions with this
>> exact set because we have been unable to get PCI working with v5.1-rc2.
>> We were able to get it running on a 4.19 era kernel (with a bunch of
>> out-of-tree patches for PCI on a Microsemi PolarFire board).
>>
>> This series is based on v5.1-rc2 and a git tree is available here:
>>
>> https://github.com/sbates130272/linux-p2pmem riscv-p2p-v1
> 
> Looks like these don't build on rv32 when applied on top of 5.1-rc6.  We 
> now
> have rv32_defconfig, which should make it easier to tests these sorts of
> things.

Thanks for the note. I've queued up the fixes for this. However, I'm 
still a bit stuck on the memory hot remove stuff. I'm waiting for the 
similar work in arm64 to be done so I can reuse some of it[1].

The first patch of this series that implements sparsemem builds on rv32 
and was generally accepted in previous cycles; so I'd appreciate if you 
can pick that one up for v5.2.

Thanks.

Logan


[1] 
https://lore.kernel.org/lkml/1555221553-18845-1-git-send-email-anshuman.khandual@arm.com/T/#u
