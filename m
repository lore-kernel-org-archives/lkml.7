Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048FC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436630AbfJXRH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:07:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39816 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405931AbfJXRH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:07:28 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iNgZv-0005cq-D7; Thu, 24 Oct 2019 11:07:16 -0600
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will@kernel.org" <will@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>
References: <1571908438-4802-1-git-send-email-yash.shah@sifive.com>
 <c4817ec1-4e50-5646-68f0-caeb0ab6f0bf@deltatee.com>
 <alpine.DEB.2.21.9999.1910240937350.20010@viisi.sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0684fa31-1dfd-9f6c-762e-5811e6e9d5b9@deltatee.com>
Date:   Thu, 24 Oct 2019 11:07:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1910240937350.20010@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: allison@lohutok.net, will@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org, greentime.hu@g.sifive.com, sachin.ghadi@sifive.com, rppt@linux.ibm.com, Anup.Patel@wdc.com, catalin.marinas@arm.com, alex@ghiti.fr, aou@eecs.berkeley.edu, sorear2@gmail.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, palmer@g.sifive.com, paul.walmsley@g.sifive.com, yash.shah@sifive.com, paul.walmsley@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] RISC-V: Add PCIe I/O BAR memory mapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-24 10:51 a.m., Paul Walmsley wrote:
> On Thu, 24 Oct 2019, Logan Gunthorpe wrote:
> 
>> On 2019-10-24 3:14 a.m., Yash Shah wrote:
>>> For I/O BARs to work correctly on RISC-V Linux, we need to establish a
>>> reserved memory region for them, so that drivers that wish to use I/O BARs
>>> can issue reads and writes against a memory region that is mapped to the
>>> host PCIe controller's I/O BAR MMIO mapping.
>>
>> I don't think other arches do this. 
> 
> $ git grep 'define PCI_IOBASE' arch/ 
> arch/arm/include/asm/io.h:#define PCI_IOBASE            ((void __iomem *)PCI_IO_VIRT_BASE)
> arch/arm64/include/asm/io.h:#define PCI_IOBASE          ((void __iomem *)PCI_IO_START)
> arch/m68k/include/asm/io_no.h:#define PCI_IOBASE        ((void __iomem *) PCI_IO_PA)
> arch/microblaze/include/asm/io.h:#define PCI_IOBASE     ((void __iomem *)_IO_BASE)
> arch/unicore32/include/asm/io.h:#define PCI_IOBASE      PKUNITY_PCILIO_BASE
> arch/xtensa/include/asm/io.h:#define PCI_IOBASE         ((void __iomem *)XCHAL_KIO_BYPASS_VADDR)
> $
> 
> This is for the old x86-style, non-memory mapped I/O address space the 
> legacy PCI stuff that one would use in{b,w,l}()/out{b,w,l}() for.
> 
> Yash, you might consider updating your patch description to note that this 
> is for "legacy I/O BARs (i.e., non-MMIO BARs)" or something similar.  That 
> might make things clearer.

Ah, right, yes, that would clear things up.

Logan
