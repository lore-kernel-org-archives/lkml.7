Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4800C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA320883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfFYRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:10:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:21632 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfFYRKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:10:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 10:10:22 -0700
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="155572110"
Received: from unknown (HELO [10.232.112.175]) ([10.232.112.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 25 Jun 2019 10:10:22 -0700
Subject: Re: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus() returns
 null
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
From:   "Heitke, Kenneth" <kenneth.heitke@intel.com>
Message-ID: <39cc44bb-28b8-0daf-b059-b78791c77eb1@intel.com>
Date:   Tue, 25 Jun 2019 11:10:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2019 5:57 PM, Alan Mikhak wrote:
> Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> to free the memory it allocated using pci_alloc_p2pmem()
> in case pci_p2pmem_virt_to_bus() returns null.
> 
> Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> returned null which can happen if CONFIG_PCI_P2PDMA is not
> configured.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>   drivers/nvme/host/pci.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 524d6bd6d095..5dfa067f6506 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
>   
>   	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
>   		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
> -		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> -						nvmeq->sq_cmds);
> -		if (nvmeq->sq_dma_addr) {
> -			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> -			return 0;
> +		if (nvmeq->sq_cmds) {
> +			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> +							nvmeq->sq_cmds);
> +			if (nvmeq->sq_dma_addr) {
> +				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> +				return 0;
> +			}
> +
> +			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));

Should the pointer be set to NULL here, just in case?

>   		}
>   	}
>   
> 
