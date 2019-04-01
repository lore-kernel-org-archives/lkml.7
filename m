Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1593D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbfDARh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:9814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387914AbfDARhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 10:37:53 -0700
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="130525269"
Received: from unknown (HELO [10.232.112.189]) ([10.232.112.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 01 Apr 2019 10:37:53 -0700
Subject: Re: [PATCH AUTOSEL 4.14 18/37] nvme-pci: fix conflicting p2p resource
 adds
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190330013020.379-1-sashal@kernel.org>
 <20190330013020.379-18-sashal@kernel.org>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <225c0c91-dd78-9cd9-7b16-5ef3bf394895@intel.com>
Date:   Mon, 1 Apr 2019 11:37:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330013020.379-18-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2019 7:30 PM, Sasha Levin wrote:
> From: Keith Busch <keith.busch@intel.com>
> 
> [ Upstream commit 9fe5c59ff6a1e5e26a39b75489a1420e7eaaf0b1 ]
> 
> The nvme pci driver had been adding its CMB resource to the P2P DMA
> subsystem everytime on on a controller reset. This results in the
> following warning:
> 
>      ------------[ cut here ]------------
>      nvme 0000:00:03.0: Conflicting mapping in same section
>      WARNING: CPU: 7 PID: 81 at kernel/memremap.c:155 devm_memremap_pages+0xa6/0x380
>      ...
>      Call Trace:
>       pci_p2pdma_add_resource+0x153/0x370
>       nvme_reset_work+0x28c/0x17b1 [nvme]
>       ? add_timer+0x107/0x1e0
>       ? dequeue_entity+0x81/0x660
>       ? dequeue_entity+0x3b0/0x660
>       ? pick_next_task_fair+0xaf/0x610
>       ? __switch_to+0xbc/0x410
>       process_one_work+0x1cf/0x350
>       worker_thread+0x215/0x3d0
>       ? process_one_work+0x350/0x350
>       kthread+0x107/0x120
>       ? kthread_park+0x80/0x80
>       ret_from_fork+0x1f/0x30
>      ---[ end trace f7ea76ac6ee72727 ]---
>      nvme nvme0: failed to register the CMB
> 
> This patch fixes this by registering the CMB with P2P only once.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/nvme/host/pci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 06355ca832db..ae03a5b70324 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1546,6 +1546,9 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>   	void __iomem *cmb;
>   	int bar;
>   
> +	if (dev->cmb_size)
> +		return;
> +
>   	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>   	if (!(NVME_CMB_SZ(dev->cmbsz)))
>   		return NULL;
> @@ -2034,7 +2037,6 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>   
> -	nvme_release_cmb(dev);
>   	pci_free_irq_vectors(pdev);
>   
>   	if (pci_is_enabled(pdev)) {
> @@ -2434,6 +2436,7 @@ static void nvme_remove(struct pci_dev *pdev)
>   	nvme_stop_ctrl(&dev->ctrl);
>   	nvme_remove_namespaces(&dev->ctrl);
>   	nvme_dev_disable(dev, true);
> +	nvme_release_cmb(dev);
>   	nvme_free_host_mem(dev);
>   	nvme_dev_remove_admin(dev);
>   	nvme_free_queues(dev, 0);
> 

There is no P2P support in the 4.14 kernel so I'm not sure this change
is necessary. I would also worry that it might break things if the BARs
need to be remapped after a controller reset.
