Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12708C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27362184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1PyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:54:07 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38284 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfC1PyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:54:07 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9XLw-0004Sx-2z; Thu, 28 Mar 2019 09:54:04 -0600
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     sorear2@gmail.com, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        sbates@raithlin.com, antonynpavlov@gmail.com,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20190327213643.23789-4-logang@deltatee.com>
 <mhng-fca98e1a-ad61-40b6-abd8-60b0e752dcf2@palmer-si-x1c4>
 <CAAhSdy1UoiGaAph3MnmnBfxhTpscjd5jYrrzr0ES6ZPcz8tH4w@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f4c13d5-6a5c-472a-4a7b-5fd184ffe7c6@deltatee.com>
Date:   Thu, 28 Mar 2019 09:54:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1UoiGaAph3MnmnBfxhTpscjd5jYrrzr0ES6ZPcz8tH4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, linux-riscv@lists.infradead.org, antonynpavlov@gmail.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, anup.patel@wdc.com, aou@eecs.berkeley.edu, sorear2@gmail.com, palmer@sifive.com, anup@brainfault.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/7] RISC-V: Rework kernel's virtual address space mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-28 12:28 a.m., Anup Patel wrote:
>>> For the MAXPHYSMEM_2GB case, the physical memory must be in the highest
>>> 2GB of address space, so we cannot cover the any of the I/O regions
>>> that are higher than it but we do cover the lower I/O TileLink range.
>>
>> IIRC there was another patch floating around to fix an issue with overlapping
>> regions in the 32-bit port, did you also fix that issue?  It's somewhere in my
>> email queue...
> 
> That was a patch I submitted to fix overlapping FIXMAP and VMALLOC
> regions.
> 
> This patch does not consider FIXMAP region.

Correct.

> I suggest we introduce asm/memory.h where we have all critical defines
> related to virtual memory layout. Also, this header should have detailed
> comments about virtual memory layout.

Seems like a sensible cleanup. It did seem like the defines for this
stuff were all over the place. I'm not really clear on all the stuff
that would belong in asm/memory.h so I think I'll leave such a cleanup
to you.

The second patch in this series added documentation to describe the
virtual memory layout which matches how it was done in x86.

Logan
