Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159F9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E322171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DjzbQywx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfIQSXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:23:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42950 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfIQSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so2624678pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N+ZvW5XGZPlKGoWdD6lQLoORQOVvTeBoK7Mquxm8Mos=;
        b=DjzbQywxFH7fD+3bt5IqiSsQVUCbjqXB+I60sfjSk/EfG9e3ii1X1mx/WPlGJa5p7a
         4cLinS9ljquEiFVPO9VHp6n2HEbyMHVfactLBezhvUtTsTs2m4eO9BhahGuVt6D0i2U7
         dv/n92xSw2SsI2qt8jgaJ/F39/7kPn+9KPaAulNegpOwgtAjurrSGB9b3M9ZXj5XXUn6
         ioVkxAD54oYmSnxuB0E4ZEB8/JXeTe8hDpgDtd7iEQx9XfZunGXkRlK5SJxwJDj10cuy
         lJyAbtoLBV6gzip4nzF49wOwL63nDnj16cJErgUFx2iCNevjldP4YHXHc8fRMQNb2DZw
         KPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N+ZvW5XGZPlKGoWdD6lQLoORQOVvTeBoK7Mquxm8Mos=;
        b=dPigVftXbkj/iwuRNQ9pFsOKdNKz1J5afEYCwM1rG78isaDcp/aQJVZqHaKoD9IZcS
         frpAncahFBOetExbYv44I8WBnXlJP4kOGdz+hxoAB4JqJGjc1qC7alquOZSGehDiBh/n
         XOuGF/GOpC+ZxO8UGTveP0y469KGW0nZklJ/QOQjF87NyeSoVUblym/SSd/s8+FY76aS
         gJEItSp3NhsgYCuROQx49OE0+fdQwnaLKuHvem97ZBKCKS2rl06u84b7AIaxYoMeRhGX
         oJFYg9yiRV4xv/Ev5gicMA2IfdeF8+MZKD5AwQCdv3SM4FAAkAKvh64h+5EXDDMTqkZn
         6PXw==
X-Gm-Message-State: APjAAAWxhacEukvv528W1Q+mAXLGzByXmcCAWFqKJweViWJF8LKjAibo
        fTB2mQWSnO4G6NcG9RfR/JS/Jg==
X-Google-Smtp-Source: APXvYqx2KDzDaitTwku3JFa1UCEMfkpT0dPM41Q9FIaSsoOK23XkEzPeudmDOZYYF8r5xDdrW60fJA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr212852pgt.30.1568744592123;
        Tue, 17 Sep 2019 11:23:12 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e21sm3021514pgr.43.2019.09.17.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:23:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 11:23:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, David Rientjes wrote:

> Brijesh and Tom, we currently hit this any time we boot an SEV enabled 
> Ubuntu 18.04 guest; I assume that guest kernels, especially those of such 
> major distributions, are expected to work with warnings and BUGs when 
> certain drivers are enabled.
> 
> If the vmap purge lock is to remain a mutex (any other reason that 
> unmapping aliases can block?) then it appears that allocating a dmapool 
> is the only alternative.  Is this something that you'll be addressing 
> generically or do we need to get buy-in from the maintainers of this 
> specific driver?
> 

We've found that the following applied on top of 5.2.14 suppresses the 
warnings.

Christoph, Keith, Jens, is this something that we could do for the nvme 
driver?  I'll happily propose it formally if it would be acceptable.

Thanks!


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
+		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
+					  BLK_MQ_F_BLOCKING;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
@@ -2262,7 +2263,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE |
+				    BLK_MQ_F_BLOCKING;
 		dev->tagset.driver_data = dev;
 
 		ret = blk_mq_alloc_tag_set(&dev->tagset);
