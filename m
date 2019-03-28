Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559A020823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfC1SYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:24:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39754 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfC1SYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:24:42 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9Zha-0006cz-4x; Thu, 28 Mar 2019 12:24:35 -0600
To:     Anup Patel <anup@brainfault.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Zong Li <zongbox@gmail.com>
References: <20190327213643.23789-1-logang@deltatee.com>
 <20190327213643.23789-5-logang@deltatee.com>
 <CAAhSdy0rZCNG4582gCd2wJ9zWwRZJ8uohPLs91=Ww=+=JnG4=w@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f6a31d1b-d122-12d7-767a-e5ec767b1929@deltatee.com>
Date:   Thu, 28 Mar 2019 12:24:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0rZCNG4582gCd2wJ9zWwRZJ8uohPLs91=Ww=+=JnG4=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: zongbox@gmail.com, hch@lst.de, rppt@linux.ibm.com, linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, anup.patel@wdc.com, atish.patra@wdc.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, aou@eecs.berkeley.edu, anup@brainfault.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 4/7] RISC-V: Update page tables to cover the whole linear
 mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-28 4:03 a.m., Anup Patel wrote:
> I understand that this patch is inline with your virtual memory layout cleanup
> but the way we map virtual memory in swapper_pg_dir is bound to change.
> 
> We should not be mapping complete virtual memory in swapper_pd_dir()
> rather we should only map based on amount of RAM available.
> 
> Refer, https://www.lkml.org/lkml/2019/3/24/3
> 
> The setup_vm() should only map vmlinux_start to vmlinux_end plus the
> FDT. Complete virtual memory mapping should be done after we have
> done early parsing of FDT when we know available memory banks in
> setup_vm_final() (called from paging_init())

That makes sense, but I think a lot of it sounds a out of the scope of
what I'm doing in this patch set.

I could attempt to update my patchset so instead of expanding the linear
region on boot, we add the page tables in arch_add_memory. That would
make more sense when considering the direction you want to head with
setup_vm.

Logan
