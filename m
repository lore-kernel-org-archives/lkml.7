Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8788C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA99920854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfJORpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:45:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50014 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfJORpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:45:14 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iKQsZ-0000Ix-0T; Tue, 15 Oct 2019 11:45:04 -0600
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        Christoph Hellwig <hch@infradead.org>
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
 <CABEDWGwayE1aW26zfTqkYUVY-i=bTdM_Vm3htVB-x-AZQNvw2Q@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <268fdc04-f471-7869-1e1f-cb9f30b85066@deltatee.com>
Date:   Tue, 15 Oct 2019 11:45:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABEDWGwayE1aW26zfTqkYUVY-i=bTdM_Vm3htVB-x-AZQNvw2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: paul.walmsley@sifive.com, palmer@sifive.com, christophe.leroy@c-s.fr, jgg@ziepe.ca, tglx@linutronix.de, gregkh@linuxfoundation.org, ming.lei@redhat.com, alexios.zavras@intel.com, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, hch@infradead.org, alan.mikhak@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-15 11:40 a.m., Alan Mikhak wrote:
> On Tue, Oct 15, 2019 at 2:55 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
>>>> My goal is to not modify the Linux NVMe target code at all. The NVMe
>>>> endpoint function driver currently does the work that is required.
>>
>> You will have to do some modifications, as for example in PCIe you can
>> have a n:1 relationship between SQs and CQs.  And you need to handle
>> the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
>> modifying subsystems in Linux is perfectly acceptable, that is how they
>> improve.
> 
> The NVMe endpoint function driver currently creates the admin ACQ and
> ASQ on startup. When the NVMe host connects over PCIe, NVMe endpoint
> function driver handles the Create/Delete SQ/CQ commands and any other
> commands that cannot go to the NVMe target on behalf of the host. For
> example, it creates a pair of I/O CQ and SQ as requested by the Linux
> host kernel nvme.ko driver. The NVMe endpoint function driver supports
> Controller Memory Buffer (CMB). The I/O SQ is therefore located in CMB
> as requested by host nvme.ko.
> 
> As for n:1 relationship between SQs and CQs, I have not implemented that
> yet since I didn't get such a request from the host nvme.ko yet. I agree. It
> needs to be implemented at some point. It is doable. I appreciate your
> comment and took note of it.
> 
>>
>> Do you have a pointer to your code?
> 
> The code is still work in progress. It is not stable yet for reliable use or
> upstream patch submission. It is stable enough for me to see it work from
> my Debian host desktop to capture screenshots of NVMe partition
> benchmarking, formatting, mounting, file storage and retrieval activity
> such as I mentioned. I could look into possibly submitting an RFC patch
> upstream for early review and feedback to improve it but it is not in a
> polished state yet.
> 
>>
>>>> In my current platform, there are no page struct backing for the PCIe
>>>> memory address space.
>>
>> In Linux there aren't struct pages for physical memory remapped using
>> ioremap().  But if you want to feed them to the I/O subsystem you have
>> to use devm_memremap_pages to create a page backing.  Assuming you are
>> on a RISC-V platform given your affiliation you'll need to ensure your
>> kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
>> working on.  I don't remember what the current status is.
> 
> Thanks for this suggestion. I will try using devm_memremap_pages() to
> create a page backing. I will also look for Logan's work regarding
> ZONE_DEVICE pages.

The nvme driver already creates struct pages for the CMB with
devm_memremap_pages(). At least since v4.20. Though, it probably won't
do anything with the CMB on platforms that don't yet support ZONE_DEVICE
(ie riscv).

Logan
