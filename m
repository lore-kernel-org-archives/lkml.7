Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FAC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAF82147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554296255;
	bh=gt3d+lSFz3AJBz5Hwm71/3by3kFEWNG8lmd3dZ0Ozc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b/Y139ze6ABnpgXEN7ognmNvq0+sFt78dr1qT3wIp+bTesmU+yfIZ4f2JNIn+xsA7
	 thd0qpONYcsgCzTvocJhQjgk0cAZivbK+//6TIAe4Ccs3pOwlmmA5qfJ+Av+RP4cao
	 9m8AwbrT+TvkWr2QA63+ejYrnRXh4XhJNMrzAwFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDCM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfDCM5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:57:34 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2092084B;
        Wed,  3 Apr 2019 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554296253;
        bh=gt3d+lSFz3AJBz5Hwm71/3by3kFEWNG8lmd3dZ0Ozc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoGykfmZkqjFjc63N4+2ee7NrJN4Lx/mO5Wi7fYjg/20Ao0ztQOtB9gy/YqGSASPa
         rT4ucWiSMr8U9+hm0nNzg4IXYilP9HDtafwT0HQdDKQJvuF+44WdXJvXyJnuCWeB3X
         ejh1JG2Vp2K28SHV5jHgwtYH2klav16LVHrYCKDM=
Date:   Wed, 3 Apr 2019 08:57:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.14 18/37] nvme-pci: fix conflicting p2p
 resource adds
Message-ID: <20190403125730.GA16241@sasha-vm>
References: <20190330013020.379-1-sashal@kernel.org>
 <20190330013020.379-18-sashal@kernel.org>
 <225c0c91-dd78-9cd9-7b16-5ef3bf394895@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <225c0c91-dd78-9cd9-7b16-5ef3bf394895@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:37:52AM -0600, Heitke, Kenneth wrote:
>
>On 3/29/2019 7:30 PM, Sasha Levin wrote:
>>From: Keith Busch <keith.busch@intel.com>
>>
>>[ Upstream commit 9fe5c59ff6a1e5e26a39b75489a1420e7eaaf0b1 ]
>>
>>The nvme pci driver had been adding its CMB resource to the P2P DMA
>>subsystem everytime on on a controller reset. This results in the
>>following warning:
>>
>>     ------------[ cut here ]------------
>>     nvme 0000:00:03.0: Conflicting mapping in same section
>>     WARNING: CPU: 7 PID: 81 at kernel/memremap.c:155 devm_memremap_pages+0xa6/0x380
>>     ...
>>     Call Trace:
>>      pci_p2pdma_add_resource+0x153/0x370
>>      nvme_reset_work+0x28c/0x17b1 [nvme]
>>      ? add_timer+0x107/0x1e0
>>      ? dequeue_entity+0x81/0x660
>>      ? dequeue_entity+0x3b0/0x660
>>      ? pick_next_task_fair+0xaf/0x610
>>      ? __switch_to+0xbc/0x410
>>      process_one_work+0x1cf/0x350
>>      worker_thread+0x215/0x3d0
>>      ? process_one_work+0x350/0x350
>>      kthread+0x107/0x120
>>      ? kthread_park+0x80/0x80
>>      ret_from_fork+0x1f/0x30
>>     ---[ end trace f7ea76ac6ee72727 ]---
>>     nvme nvme0: failed to register the CMB
>>
>>This patch fixes this by registering the CMB with P2P only once.
>>
>>Signed-off-by: Keith Busch <keith.busch@intel.com>
>>Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>Signed-off-by: Christoph Hellwig <hch@lst.de>
>>Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  drivers/nvme/host/pci.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>index 06355ca832db..ae03a5b70324 100644
>>--- a/drivers/nvme/host/pci.c
>>+++ b/drivers/nvme/host/pci.c
>>@@ -1546,6 +1546,9 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>>  	void __iomem *cmb;
>>  	int bar;
>>+	if (dev->cmb_size)
>>+		return;
>>+
>>  	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>>  	if (!(NVME_CMB_SZ(dev->cmbsz)))
>>  		return NULL;
>>@@ -2034,7 +2037,6 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>-	nvme_release_cmb(dev);
>>  	pci_free_irq_vectors(pdev);
>>  	if (pci_is_enabled(pdev)) {
>>@@ -2434,6 +2436,7 @@ static void nvme_remove(struct pci_dev *pdev)
>>  	nvme_stop_ctrl(&dev->ctrl);
>>  	nvme_remove_namespaces(&dev->ctrl);
>>  	nvme_dev_disable(dev, true);
>>+	nvme_release_cmb(dev);
>>  	nvme_free_host_mem(dev);
>>  	nvme_dev_remove_admin(dev);
>>  	nvme_free_queues(dev, 0);
>>
>
>There is no P2P support in the 4.14 kernel so I'm not sure this change
>is necessary. I would also worry that it might break things if the BARs
>need to be remapped after a controller reset.

I've removed it, thanks!

--
Thanks,
Sasha
