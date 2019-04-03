Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9ABC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B1821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554279279;
	bh=NjzXhV8B4d4khp9HSWu9AlaIUG8DfMNk7Jn/ox0oZ5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V6lZsjWikzujXBOBZBdfhIStsCHuYZQ6BfQaVSgHJHO4HrqWAkFcl7yIlp9QykcEO
	 btZ2Pc+fo0Pm1P9To0CeANE6TeWHKHYqqvtBdYvxxG8EelHHNEE1RnQLhl+NShFoqJ
	 ch6mwYaCihQlEElED9CvhcBvuhB02qsLz/pyQOus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfDCIOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCIOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:14:37 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42EB2084C;
        Wed,  3 Apr 2019 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554279276;
        bh=NjzXhV8B4d4khp9HSWu9AlaIUG8DfMNk7Jn/ox0oZ5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8lhENZXa8FnQcUv1zJJIPVdpivTGh6g4OgCO/Y4nKrpng9NTWkBX8XCuq08tCOfN
         cGxThNXMQL7mpb++ovBxMgUG2jdr1/j8d0F6yVh01M0gxDR9sM62mdZwT2mWfzSDTR
         BkstukOHVlOCuY/fhdQA7WAJoN+KmkEBJbeXyfgQ=
Date:   Wed, 3 Apr 2019 10:14:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Garry <john.garry@huawei.com>
Cc:     rafael@kernel.org, linuxarm@huawei.com, chenxiang66@hisilicon.com,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, robh@kernel.org, hch@lst.de
Subject: Re: [PATCH] driver core: Postpone DMA tear-down until after devres
 release for probe failure
Message-ID: <20190403081433.GA13222@kroah.com>
References: <1553767685-27077-1-git-send-email-john.garry@huawei.com>
 <703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703aca1f-9475-b50d-624a-5f1ceea2c3b2@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:02:36AM +0100, John Garry wrote:
> On 28/03/2019 10:08, John Garry wrote:
> > In commit 376991db4b64 ("driver core: Postpone DMA tear-down until after
> > devres release"), we changed the ordering of tearing down the device DMA
> > ops and releasing all the device's resources; this was because the DMA ops
> > should be maintained until we release the device's managed DMA memories.
> > 
> 
> Hi all,
> 
> A friendly reminder on this patch... I didn't see any update.
> 
> I thought that it had some importance.
> 
> Thanks,
> John
> 
> > However, we have seen another crash on an arm64 system when a
> > device driver probe fails:
> > 
> >   hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 2
> >   scsi host1: hisi_sas_v3_hw
> >   BUG: Bad page state in process swapper/0  pfn:313f5
> >   page:ffff7e0000c4fd40 count:1 mapcount:0
> >   mapping:0000000000000000 index:0x0
> >   flags: 0xfffe00000001000(reserved)
> >   raw: 0fffe00000001000 ffff7e0000c4fd48 ffff7e0000c4fd48
> > 0000000000000000
> >   raw: 0000000000000000 0000000000000000 00000001ffffffff
> > 0000000000000000
> >   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> >   bad because of flags: 0x1000(reserved)
> >   Modules linked in:
> >   CPU: 49 PID: 1 Comm: swapper/0 Not tainted
> > 5.1.0-rc1-43081-g22d97fd-dirty #1433
> >   Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
> > RC0 - V1.12.01 01/29/2019
> >   Call trace:
> >   dump_backtrace+0x0/0x118
> >   show_stack+0x14/0x1c
> >   dump_stack+0xa4/0xc8
> >   bad_page+0xe4/0x13c
> >   free_pages_check_bad+0x4c/0xc0
> >   __free_pages_ok+0x30c/0x340
> >   __free_pages+0x30/0x44
> >   __dma_direct_free_pages+0x30/0x38
> >   dma_direct_free+0x24/0x38
> >   dma_free_attrs+0x9c/0xd8
> >   dmam_release+0x20/0x28
> >   release_nodes+0x17c/0x220
> >   devres_release_all+0x34/0x54
> >   really_probe+0xc4/0x2c8
> >   driver_probe_device+0x58/0xfc
> >   device_driver_attach+0x68/0x70
> >   __driver_attach+0x94/0xdc
> >   bus_for_each_dev+0x5c/0xb4
> >   driver_attach+0x20/0x28
> >   bus_add_driver+0x14c/0x200
> >   driver_register+0x6c/0x124
> >   __pci_register_driver+0x48/0x50
> >   sas_v3_pci_driver_init+0x20/0x28
> >   do_one_initcall+0x40/0x25c
> >   kernel_init_freeable+0x2b8/0x3c0
> >   kernel_init+0x10/0x100
> >   ret_from_fork+0x10/0x18
> >   Disabling lock debugging due to kernel taint
> >   BUG: Bad page state in process swapper/0  pfn:313f6
> >   page:ffff7e0000c4fd80 count:1 mapcount:0
> > mapping:0000000000000000 index:0x0
> > [   89.322983] flags: 0xfffe00000001000(reserved)
> >   raw: 0fffe00000001000 ffff7e0000c4fd88 ffff7e0000c4fd88
> > 0000000000000000
> >   raw: 0000000000000000 0000000000000000 00000001ffffffff
> > 0000000000000000
> > 
> > The crash occurs for the same reason.
> > 
> > In this case, on the really_probe() failure path, we are still clearing
> > the DMA ops prior to releasing the device's managed memories.
> > 
> > This patch fixes this issue by reordering the DMA ops teardown and the
> > call to devres_release_all() on the failure path.
> > 
> > Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
> > Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
> > Signed-off-by: John Garry <john.garry@huawei.com>

So does this "fix" 376991db4b64?  If so, should this be added to the
patch and also backported to the stable trees?

thanks,

greg k-h
