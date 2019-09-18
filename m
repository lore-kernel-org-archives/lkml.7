Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21E921920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfIRNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:22:46 -0400
Received: from verein.lst.de ([213.95.11.211]:33283 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfIRNWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:22:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC48268B05; Wed, 18 Sep 2019 15:22:42 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:22:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Message-ID: <20190918132242.GA16133@lst.de>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com> <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com> <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 06:41:02PM +0000, Lendacky, Thomas wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
> >  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
> >  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> >  		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
> > -		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
> > +		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
> > +					  BLK_MQ_F_BLOCKING;
> 
> I think you want to only set the BLK_MQ_F_BLOCKING if the DMA is required
> to be unencrypted. Unfortunately, force_dma_unencrypted() can't be called
> from a module. Is there a DMA API that could be called to get that info?

The DMA API must support non-blocking calls, and various drivers rely
on that.  So we need to provide that even for the SEV case.  If the
actual blocking can't be made to work we'll need to wire up the DMA
pool in kernel/dma/remap.c for it (and probably move it to separate
file).
