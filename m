Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9705521736
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rk3/E/zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK0WLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:11:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34623 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0WLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:11:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id bo14so10772512pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=B5LqWF3rYDR89Yh3BXrMDS+UXYNZjHzn7pTz6vzOHlY=;
        b=rk3/E/zffHsy8rz63sYN92yC6wWOr9BEwOQrb0DBNMRIVHSNUsagH6qMud3IIp3iBQ
         K81EH++9mhuZaeBiaC566bAbrNPfSUxK4HznlqvK6p/q6NhRjHuV3kTmszjaPq8aS78y
         Zq5lNx9maFh2os9tmgXOznf+4ilhdWlIYpXfp+gc2SHTX2ShpNuvz3EsWJd/LcMnqX5Q
         63L5SiWS7u+Z0xF578Q9n1Z/Vq0Z8gI81DovTK8aVPhOPg6ZiiRvkjERrdrguTixDRbE
         iXIO0BjOVgIlRFgSqFIYxlwj3nGD5BpCnxEXw5e7wqwshBBCrKCoBc99XgU6uPl8RLP6
         EHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=B5LqWF3rYDR89Yh3BXrMDS+UXYNZjHzn7pTz6vzOHlY=;
        b=ln/0tyIm85R/9gCXg4/zMhur+l98MwESbj1XFHZFSv6roQYg9vO345fnRFWlk1VQAl
         WhKZuoXMmnG1EHNNJM+ftSJmLRdG5MiE6mgoLA5C/j4syu9SAWaTQiGBuF7aZPrx2ks2
         BOfldHVJMSoifSCoBXBgckaP0DLExBGG8RACx1Hnek8fJBZPEp7FHcsMFwRj8cIXSdmb
         b+2LL15MTht/LtIVQf3O1trOTS3SI6FE7TH4hM6csdtoXd64f/W2CkxLN/Ty7AXylzNP
         fDodbEsXkHXYCHXZuajiohqDN3VAkTalISh0Zw5MYbdey4MOlPJeLYUYDcC6c7puzyT4
         9oGg==
X-Gm-Message-State: APjAAAW902I0EeBYINiYtVrmfvXJReN8hCkPB0BgFDottpPMCaUvcs99
        rbQZdkaSvo93FMkAw/QYgKx8lg==
X-Google-Smtp-Source: APXvYqy8/zn33Ofgd+uyq7QIQadaZYFdnkrUQTrzDDCOnkS+RZCfAzYTFN3HsvKXPHxBVLC+LLRdig==
X-Received: by 2002:a17:902:7089:: with SMTP id z9mr6367022plk.292.1574892691057;
        Wed, 27 Nov 2019 14:11:31 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a21sm7818948pjv.20.2019.11.27.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:11:29 -0800 (PST)
Date:   Wed, 27 Nov 2019 14:11:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <20190918132242.GA16133@lst.de>
Message-ID: <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com> <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com> <20190918132242.GA16133@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Christoph Hellwig wrote:

> On Tue, Sep 17, 2019 at 06:41:02PM +0000, Lendacky, Thomas wrote:
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
> > >  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
> > >  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> > >  		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
> > > -		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
> > > +		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
> > > +					  BLK_MQ_F_BLOCKING;
> > 
> > I think you want to only set the BLK_MQ_F_BLOCKING if the DMA is required
> > to be unencrypted. Unfortunately, force_dma_unencrypted() can't be called
> > from a module. Is there a DMA API that could be called to get that info?
> 
> The DMA API must support non-blocking calls, and various drivers rely
> on that.  So we need to provide that even for the SEV case.  If the
> actual blocking can't be made to work we'll need to wire up the DMA
> pool in kernel/dma/remap.c for it (and probably move it to separate
> file).
> 

Resurrecting this thread from a couple months ago because it appears that 
this is still an issue with 5.4 guests.

dma_pool_alloc(), regardless of whether mem_flags allows blocking or not, 
can always sleep if the device's DMA must be unencrypted and 
mem_encrypt_active() == true.  We know this because vm_unmap_aliases() can 
always block.

NVMe's setup of PRPs and SGLs uses dma_pool_alloc(GFP_ATOMIC) but when 
this is a SEV-enabled guest this allocation may block due to the 
possibility of allocating DMA coherent memory through dma_direct_alloc().

It seems like one solution would be to add significant latency by doing 
BLK_MQ_F_BLOCKING if force_dma_unencrypted() is true for the device but 
this comes with significant downsides.

So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
can we do it within the DMA API itself so it's transparent to the driver?

Thomas/Brijesh: separately, it seems the use of set_memory_encrypted() or 
set_memory_decrypted() must be possible without blocking; is this only an 
issue from the DMA API point of view or can it be done elsewhere?
