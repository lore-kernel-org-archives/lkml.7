Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443FDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4821726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH2Pqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:46:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36818 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfH2Pqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:46:53 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i3MdF-0003si-By; Thu, 29 Aug 2019 09:46:46 -0600
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Michael Clark <michaeljclark@mac.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190828214054.3562-1-logang@deltatee.com>
 <20190829062123.GA16471@rapoport-lnx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <80a6c33f-6914-ee5f-7456-e1bf3d8801e0@deltatee.com>
Date:   Thu, 29 Aug 2019 09:46:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829062123.GA16471@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, sbates@raithlin.com, linux-riscv@lists.infradead.org, greentime.hu@sifive.com, olof@lixom.net, zong@andestech.com, michaeljclark@mac.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, rppt@linux.ibm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-29 12:21 a.m., Mike Rapoport wrote:
> On Wed, Aug 28, 2019 at 03:40:54PM -0600, Logan Gunthorpe wrote:
>> Implement sparsemem support for Risc-v which helps pave the
>> way for memory hotplug and eventually P2P support.
>>
>> Introduce Kconfig options for virtual and physical address bits which
>> are used to calculate the size of the vmemmap and set the
>> MAX_PHYSMEM_BITS.
>>
>> The vmemmap is located directly before the VMALLOC region and sized
>> such that we can allocate enough pages to populate all the virtual
>> address space in the system (similar to the way it's done in arm64).
>>
>> During initialization, call memblocks_present() and sparse_init(),
>> and provide a stub for vmemmap_populate() (all of which is similar to
>> arm64).
>>
>> [greentime.hu@sifive.com:
>>   fixed pfn_valid, FIXADDR_TOP and fixed a bug rebasing onto v5.3]
>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: Andrew Waterman <andrew@sifive.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Michael Clark <michaeljclark@mac.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Zong Li <zong@andestech.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks!

Logan
