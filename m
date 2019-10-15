Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEEAECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C25F20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfJOQMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:12:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48756 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJOQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:12:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iKPQn-0007OY-LU; Tue, 15 Oct 2019 10:12:18 -0600
To:     Christoph Hellwig <hch@infradead.org>,
        Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>, christophe.leroy@c-s.fr,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org>
 <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
 <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
 <20191015095522.GA22551@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a218d5bd-93cd-2332-de95-195ccbe41995@deltatee.com>
Date:   Tue, 15 Oct 2019 10:12:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015095522.GA22551@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: paul.walmsley@sifive.com, palmer@sifive.com, christophe.leroy@c-s.fr, jgg@ziepe.ca, tglx@linutronix.de, gregkh@linuxfoundation.org, ming.lei@redhat.com, alexios.zavras@intel.com, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, alan.mikhak@sifive.com, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-15 3:55 a.m., Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
>>> My goal is to not modify the Linux NVMe target code at all. The NVMe
>>> endpoint function driver currently does the work that is required.
> 
> You will have to do some modifications, as for example in PCIe you can
> have a n:1 relationship between SQs and CQs.  And you need to handle
> the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
> modifying subsystems in Linux is perfectly acceptable, that is how they
> improve.
> 
> Do you have a pointer to your code?
> 
>>> In my current platform, there are no page struct backing for the PCIe
>>> memory address space.
> 
> In Linux there aren't struct pages for physical memory remapped using
> ioremap().  But if you want to feed them to the I/O subsystem you have
> to use devm_memremap_pages to create a page backing.  Assuming you are
> on a RISC-V platform given your affiliation you'll need to ensure your
> kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
> working on.  I don't remember what the current status is.

The last patchset submission was here [1]. It had some issues but the
main one was that they wanted the page tables to be created and removed
dynamically. I took a crack at it and ran into some issues and haven't
had time to touch it since. I was waiting to see how arm64[2] solves
similar problems and then maybe it can be made common.

It's also a bit of a PITA because the RISC-V hardware we have with hacky
PCI support is fragile and stopped working on recent kernels, last I
tried. So this hasn't been a priority for us.

>> Please consider the following information and cost estimate in
>> bytes for requiring page structs for PCI memory if used with
>> scatterlists. For example, a 128GB PCI memory address space
>> could require as much as 256MB of system memory just for
>> page struct backing. In a 1GB 64-bit system with flat memory
>> model, that consumes 25% of available memory. However,
>> not all of the 128GB PCI memory may be mapped for use at
>> a given time depending on the application. The cost of PCI
>> page structs is an upfront cost to be paid at system start.
> 
> I know the pages are costly.  But once you want to feed them through
> subsystems that do expect pages you'll have to do that.  And anything
> using scatterlists currently does.  A little hack here and there isn't
> going to solve that.
> 

Agreed. I tried expanding the SG-list to allow for page-less entries and
it was a much bigger mess than what you describe.

Also, I think your analysis is a bit unfair, we don't need to create
pages for the entire 128GB of PCI memory space, we typically only need
the BARs of a subset of devices which is far less. If a system has only
1GB of memory it probably doesn't actually have 128GB of PCI bar spaces
that are sensibly usable.

Yes, it would be nice to get rid of this overhead, but that's a much
bigger long-term project.

Logan


[1]
https://lore.kernel.org/linux-riscv/20190327213643.23789-1-logang@deltatee.com/
[2]
https://lore.kernel.org/linux-arm-kernel/1570788852-12402-1-git-send-email-anshuman.khandual@arm.com/
