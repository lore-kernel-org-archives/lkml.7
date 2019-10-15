Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB16C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CED020659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQ8LlaEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJOJzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:55:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hr+RREDY0gkDQuh1EXg6I88ldv6MsMnbJyp3fbrjZ9c=; b=XQ8LlaEG49W9Hba6vY1gJ743n
        sBLmbC6uC+DcTc6D7WwOIh0CoGlU4x8kvKpDrrYtbSNJpvAsycrdpyHUAziC8LDS3H6rZcAfymbK5
        qyO/p4d6OGRu6n5uYHYW5DJuVaPjOtkgwnzCPLPgA6vJ9PLhq5Bipvwcmg/JGXQX0BEVuu/kPNBWy
        WgFnG9rYzY+hAfX6nRhxyJnywde/75ndGqV2/THaiKTkunFlj6XXBSj5859SkzA3Ae/+NGbSmR3QO
        wOxH6uPF1xcfckQdJYaGIRmqfJPTj46FkH+T8BTAM59O7tar2it6ux5SAT2Gjg9m1iCXNSzJ9jVBd
        rRGhWZ1iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKJY2-0001Z9-LB; Tue, 15 Oct 2019 09:55:22 +0000
Date:   Tue, 15 Oct 2019 02:55:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        alexios.zavras@intel.com, ming.lei@redhat.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jason Gunthorpe <jgg@ziepe.ca>, christophe.leroy@c-s.fr,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] scatterlist: Validate page before calling PageSlab()
Message-ID: <20191015095522.GA22551@infradead.org>
References: <1569885755-10947-1-git-send-email-alan.mikhak@sifive.com>
 <20191007061324.GB17978@infradead.org>
 <CABEDWGyovfKuXsNpfhsSCJ0sryg3EpAsaqRTHxBGC9LFM+=dww@mail.gmail.com>
 <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABEDWGxZaJp17jhd-CPqc+n9ZjYzvp63PymfMo0JVd=jzQEizQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:13:51PM -0700, Alan Mikhak wrote:
> > My goal is to not modify the Linux NVMe target code at all. The NVMe
> > endpoint function driver currently does the work that is required.

You will have to do some modifications, as for example in PCIe you can
have a n:1 relationship between SQs and CQs.  And you need to handle
the Create/Delete SQ/CQ commands, but not the fabrics commands.  And
modifying subsystems in Linux is perfectly acceptable, that is how they
improve.

Do you have a pointer to your code?

> > In my current platform, there are no page struct backing for the PCIe
> > memory address space.

In Linux there aren't struct pages for physical memory remapped using
ioremap().  But if you want to feed them to the I/O subsystem you have
to use devm_memremap_pages to create a page backing.  Assuming you are
on a RISC-V platform given your affiliation you'll need to ensure your
kernel allows for ZONE_DEVICE pages, which Logan (added to Cc) has been
working on.  I don't remember what the current status is.

> Please consider the following information and cost estimate in
> bytes for requiring page structs for PCI memory if used with
> scatterlists. For example, a 128GB PCI memory address space
> could require as much as 256MB of system memory just for
> page struct backing. In a 1GB 64-bit system with flat memory
> model, that consumes 25% of available memory. However,
> not all of the 128GB PCI memory may be mapped for use at
> a given time depending on the application. The cost of PCI
> page structs is an upfront cost to be paid at system start.

I know the pages are costly.  But once you want to feed them through
subsystems that do expect pages you'll have to do that.  And anything
using scatterlists currently does.  A little hack here and there isn't
going to solve that.
