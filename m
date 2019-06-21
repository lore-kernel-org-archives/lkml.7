Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C2C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8D2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFUNUW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:20:22 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51996 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbfFUNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:20:22 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16979502-1500050 
        for multiple; Fri, 21 Jun 2019 14:19:12 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Peter Xu <peterx@redhat.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190621023205.12936-1-peterx@redhat.com>
Cc:     joro@8bytes.org, peterx@redhat.com,
        Lu Baolu <baolu.lu@linux.intel.com>, dave.jiang@intel.com
References: <20190621023205.12936-1-peterx@redhat.com>
Message-ID: <156112315020.2401.16873297513079645766@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] Revert "iommu/vt-d: Fix lock inversion between iommu->lock and
 device_domain_lock"
Date:   Fri, 21 Jun 2019 14:19:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Xu (2019-06-21 03:32:05)
> This reverts commit 7560cc3ca7d9d11555f80c830544e463fcdb28b8.
> 
> With 5.2.0-rc5 I can easily trigger this with lockdep and iommu=pt:
> 
>     ======================================================
>     WARNING: possible circular locking dependency detected
>     5.2.0-rc5 #78 Not tainted
>     ------------------------------------------------------
>     swapper/0/1 is trying to acquire lock:
>     00000000ea2b3beb (&(&iommu->lock)->rlock){+.+.}, at: domain_context_mapping_one+0xa5/0x4e0
>     but task is already holding lock:
>     00000000a681907b (device_domain_lock){....}, at: domain_context_mapping_one+0x8d/0x4e0
>     which lock already depends on the new lock.
>     the existing dependency chain (in reverse order) is:
>     -> #1 (device_domain_lock){....}:
>            _raw_spin_lock_irqsave+0x3c/0x50
>            dmar_insert_one_dev_info+0xbb/0x510
>            domain_add_dev_info+0x50/0x90
>            dev_prepare_static_identity_mapping+0x30/0x68
>            intel_iommu_init+0xddd/0x1422
>            pci_iommu_init+0x16/0x3f
>            do_one_initcall+0x5d/0x2b4
>            kernel_init_freeable+0x218/0x2c1
>            kernel_init+0xa/0x100
>            ret_from_fork+0x3a/0x50
>     -> #0 (&(&iommu->lock)->rlock){+.+.}:
>            lock_acquire+0x9e/0x170
>            _raw_spin_lock+0x25/0x30
>            domain_context_mapping_one+0xa5/0x4e0
>            pci_for_each_dma_alias+0x30/0x140
>            dmar_insert_one_dev_info+0x3b2/0x510
>            domain_add_dev_info+0x50/0x90
>            dev_prepare_static_identity_mapping+0x30/0x68
>            intel_iommu_init+0xddd/0x1422
>            pci_iommu_init+0x16/0x3f
>            do_one_initcall+0x5d/0x2b4
>            kernel_init_freeable+0x218/0x2c1
>            kernel_init+0xa/0x100
>            ret_from_fork+0x3a/0x50
> 
>     other info that might help us debug this:
>      Possible unsafe locking scenario:
>            CPU0                    CPU1
>            ----                    ----
>       lock(device_domain_lock);
>                                    lock(&(&iommu->lock)->rlock);
>                                    lock(device_domain_lock);
>       lock(&(&iommu->lock)->rlock);
> 
>      *** DEADLOCK ***
>     2 locks held by swapper/0/1:
>      #0: 00000000033eb13d (dmar_global_lock){++++}, at: intel_iommu_init+0x1e0/0x1422
>      #1: 00000000a681907b (device_domain_lock){....}, at: domain_context_mapping_one+0x8d/0x4e0
> 
>     stack backtrace:
>     CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc5 #78
>     Hardware name: LENOVO 20KGS35G01/20KGS35G01, BIOS N23ET50W (1.25 ) 06/25/2018
>     Call Trace:
>      dump_stack+0x85/0xc0
>      print_circular_bug.cold.57+0x15c/0x195
>      __lock_acquire+0x152a/0x1710
>      lock_acquire+0x9e/0x170
>      ? domain_context_mapping_one+0xa5/0x4e0
>      _raw_spin_lock+0x25/0x30
>      ? domain_context_mapping_one+0xa5/0x4e0
>      domain_context_mapping_one+0xa5/0x4e0
>      ? domain_context_mapping_one+0x4e0/0x4e0
>      pci_for_each_dma_alias+0x30/0x140
>      dmar_insert_one_dev_info+0x3b2/0x510
>      domain_add_dev_info+0x50/0x90
>      dev_prepare_static_identity_mapping+0x30/0x68
>      intel_iommu_init+0xddd/0x1422
>      ? printk+0x58/0x6f
>      ? lockdep_hardirqs_on+0xf0/0x180
>      ? do_early_param+0x8e/0x8e
>      ? e820__memblock_setup+0x63/0x63
>      pci_iommu_init+0x16/0x3f
>      do_one_initcall+0x5d/0x2b4
>      ? do_early_param+0x8e/0x8e
>      ? rcu_read_lock_sched_held+0x55/0x60
>      ? do_early_param+0x8e/0x8e
>      kernel_init_freeable+0x218/0x2c1
>      ? rest_init+0x230/0x230
>      kernel_init+0xa/0x100
>      ret_from_fork+0x3a/0x50
> 
> domain_context_mapping_one() is taking device_domain_lock first then
> iommu lock, while dmar_insert_one_dev_info() is doing the reverse.
> 
> That should be introduced by commit:
> 
> 7560cc3ca7d9 ("iommu/vt-d: Fix lock inversion between iommu->lock and
>               device_domain_lock", 2019-05-27)
> 
> So far I still cannot figure out how the previous deadlock was
> triggered (I cannot find iommu lock taken before calling of
> iommu_flush_dev_iotlb()), however I'm pretty sure that that change
> should be incomplete at least because it does not fix all the places
> so we're still taking the locks in different orders, while reverting
> that commit is very clean to me so far that we should always take
> device_domain_lock first then the iommu lock.
> 
> We can continue to try to find the real culprit mentioned in
> 7560cc3ca7d9, but for now I think we should revert it to fix current
> breakage.
> 
> CC: Joerg Roedel <joro@8bytes.org>
> CC: Lu Baolu <baolu.lu@linux.intel.com>
> CC: dave.jiang@intel.com
> Signed-off-by: Peter Xu <peterx@redhat.com>

I've run this through our CI which was also reporting the inversion, so
Tested-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
