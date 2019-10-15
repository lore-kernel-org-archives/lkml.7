Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53DECE595
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8BA2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfJONhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:37:52 -0400
Received: from 8bytes.org ([81.169.241.247]:47568 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbfJONhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:37:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CAC062DF; Tue, 15 Oct 2019 15:37:49 +0200 (CEST)
Date:   Tue, 15 Oct 2019 15:37:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH 3/3] iommu/amd: Support multiple PCI DMA aliases in IRQ
 Remapping
Message-ID: <20191015133748.GC17570@8bytes.org>
References: <20191008221837.13067-1-logang@deltatee.com>
 <20191008221837.13067-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008221837.13067-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:18:37PM -0600, Logan Gunthorpe wrote:
> -static struct irq_remap_table *alloc_irq_table(u16 devid)
> +static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
> +				       void *data)
> +{
> +	struct irq_remap_table *table = data;
> +
> +	irq_lookup_table[alias] = table;
> +	set_dte_irq_entry(alias, table);
> +
> +	return 0;
> +}
> +
> +static int iommu_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct amd_iommu *iommu = data;
> +
> +	iommu_flush_dte(iommu, alias);
> +
> +	return 0;
> +}

I think these two functions can be merged into one, saving one
pci_for_each_dma_alias() call below. You can lookup the iommu using the
amd_iommu_rlookup_table[alias] in the first function and issue the flush
there.


Regards,

	Joerg

