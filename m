Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC2FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD7F2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jCmiY+Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbfJPO7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:59:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39928 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390099AbfJPO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:59:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so23023387qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBM1MDzfvFXt68GtSYTRDIM3XJiGOICXtlA0kKClo4A=;
        b=jCmiY+BpDzADxx9KTocdsLUfNHkMdYftSZxk0whxN+5FLZLuW+YYL1UEVlkEe/FE7C
         uqbzVHXrDTeMI6aCygU414g63/wSzKlf6H+5dmzypAw+I4eoApQQVUumrKEc13YFh0fa
         CpPx3D+JUE0lXHTpEMpAsVeJxrx/5UB9HI26NDeUa3O6qGx6xjZKrk04vJhxleoxLLUO
         Fu8W8PnVqR5r77Ey/G615wmfRCvb7YJc6dHb/bU8HkD93nizb1eZQYy+uaMtxs7eic8D
         l1dPKp8sBtifCritL8FJFArfWKuBfIo7nXGXSWT7dDC44TlC7fExq/JD9d4CTCLJkbGQ
         tnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBM1MDzfvFXt68GtSYTRDIM3XJiGOICXtlA0kKClo4A=;
        b=ojeBPmoIZrgls6K2uuoKfjNfUagNWH2RaAN2J5xmdEBRY/nAYJ1deFEo5MzbvJYglK
         n9hXcYOGb1WK/M/bqZCe8q70o95IoMUaU/0/jzCJXWMh7tgfO3KTzRVCCp6TcDQgICz0
         kTTgCco51hj29K6FeCTbc6hKuujO3xtOQryMhNhodqy24jrRbeqtYx6C2NDmF9YEX8uo
         sBRPoiA+EUzXZCYbsDB21ukkaSOW+m8V3SZW5AQZciN7VJWpYR52LOBoFLcFUAug5gNQ
         GCVGLhEx5J241U4zfhFILsQhJynwH3nddc0wT4wy1zUPJQcfGhYCJRTbJD3UOr8NvMj1
         PEfw==
X-Gm-Message-State: APjAAAXwVWkV4Wm5CyoNmciTDk4DudEHpGqg4QGF/0hyicKYaG6ec9//
        vvPdPVuLuQqfnZ2vtXbnCmPHrQszhRI=
X-Google-Smtp-Source: APXvYqz9n9zmXI/SSgjpekY59K1n9bvBnegNzWGU1kq558TCq2sytE5WbqdrtH2gLbomxJ8jmHv53A==
X-Received: by 2002:a37:4cd5:: with SMTP id z204mr40203987qka.153.1571237984345;
        Wed, 16 Oct 2019 07:59:44 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l7sm12298006qke.67.2019.10.16.07.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:59:43 -0700 (PDT)
Message-ID: <1571237982.5937.60.camel@lca.pw>
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From:   Qian Cai <cai@lca.pw>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 10:59:42 -0400
In-Reply-To: <1571237707.5937.58.camel@lca.pw>
References: <1571237707.5937.58.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-16 at 10:55 -0400, Qian Cai wrote:
> Today's linux-next generates a lot of warnings on multiple servers during boot
> due to the series "iommu/amd: Convert the AMD iommu driver to the dma-iommu api"
> [1]. Reverted the whole things fixed them.
> 
> [1] https://lore.kernel.org/lkml/20190908165642.22253-1-murphyt7@tcd.ie/
> 

BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
correct warning.

[  564.365768][ T6222] BUG: sleeping function called from invalid context at
mm/page_alloc.c:4692
[  564.374447][ T6222] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
6222, name: git
[  564.382969][ T6222] INFO: lockdep is turned off.
[  564.387644][ T6222] CPU: 25 PID: 6222 Comm: git Tainted:
G        W         5.4.0-rc3-next-20191016 #6
[  564.397011][ T6222] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019
[  564.406291][ T6222] Call Trace:
[  564.409470][ T6222]  dump_stack+0x86/0xca
[  564.413517][ T6222]  ___might_sleep.cold.92+0xd2/0x122
[  564.418694][ T6222]  __might_sleep+0x73/0xe0
[  564.422999][ T6222]  __alloc_pages_nodemask+0x442/0x720
[  564.428265][ T6222]  ? __alloc_pages_slowpath+0x18d0/0x18d0
[  564.433883][ T6222]  ? arch_stack_walk+0x7f/0xf0
[  564.438534][ T6222]  ? create_object+0x4a2/0x540
[  564.443188][ T6222]  alloc_pages_current+0x9c/0x110
[  564.448098][ T6222]  __get_free_pages+0x12/0x60
[  564.452659][ T6222]  get_zeroed_page+0x16/0x20
[  564.457137][ T6222]  amd_iommu_map+0x504/0x850
[  564.461612][ T6222]  ? amd_iommu_domain_direct_map+0x60/0x60
[  564.467312][ T6222]  ? lockdep_hardirqs_on+0x16/0x2a0
[  564.472400][ T6222]  ? alloc_iova+0x189/0x210
[  564.476790][ T6222]  __iommu_map+0x1c1/0x4e0
[  564.481090][ T6222]  ? iommu_get_dma_domain+0x40/0x40
[  564.486181][ T6222]  ? alloc_iova_fast+0x258/0x3d1
[  564.491009][ T6222]  ? create_object+0x4a2/0x540
[  564.495656][ T6222]  __iommu_map_sg+0xa5/0x130
[  564.500135][ T6222]  iommu_map_sg_atomic+0x14/0x20
[  564.504958][ T6222]  iommu_dma_map_sg+0x2c3/0x450
[  564.509699][ T6222]  scsi_dma_map+0xd7/0x160
[  564.514010][ T6222]  pqi_raid_submit_scsi_cmd_with_io_request+0x392/0x420
[smartpqi]
[  564.521811][ T6222]  ? pqi_alloc_io_request+0x127/0x140 [smartpqi]
[  564.528037][ T6222]  pqi_scsi_queue_command+0x8ab/0xe00 [smartpqi]
[  564.534264][ T6222]  ? pqi_eh_device_reset_handler+0x9c0/0x9c0 [smartpqi]
[  564.541100][ T6222]  ? sd_init_command+0xa25/0x1346 [sd_mod]
[  564.546802][ T6222]  scsi_queue_rq+0xd19/0x1360
[  564.551372][ T6222]  __blk_mq_try_issue_directly+0x295/0x3f0
[  564.557071][ T6222]  ? blk_mq_request_bypass_insert+0xd0/0xd0
[  564.562860][ T6222]  ? debug_lockdep_rcu_enabled+0x27/0x60
[  564.568384][ T6222]  blk_mq_try_issue_directly+0xad/0x130
[  564.573821][ T6222]  ? __blk_mq_try_issue_directly+0x3f0/0x3f0
[  564.579693][ T6222]  ? blk_add_rq_to_plug+0xcd/0x110
[  564.584693][ T6222]  blk_mq_make_request+0xcee/0x1120
[  564.589777][ T6222]  ? lock_downgrade+0x3c0/0x3c0
[  564.594517][ T6222]  ? blk_mq_try_issue_directly+0x130/0x130
[  564.600218][ T6222]  ? blk_queue_enter+0x78d/0x810
[  564.605041][ T6222]  ? generic_make_request_checks+0xf30/0xf30
[  564.610915][ T6222]  ? lock_downgrade+0x3c0/0x3c0
[  564.615655][ T6222]  ? __srcu_read_unlock+0x24/0x50
[  564.620565][ T6222]  ? generic_make_request+0x150/0x650
[  564.625833][ T6222]  generic_make_request+0x196/0x650
[  564.630921][ T6222]  ? blk_queue_enter+0x810/0x810
[  564.635747][ T6222]  submit_bio+0xaa/0x270
[  564.639873][ T6222]  ? submit_bio+0xaa/0x270
[  564.644172][ T6222]  ? generic_make_request+0x650/0x650
[  564.649437][ T6222]  ? iomap_readpage+0x260/0x260
[  564.654173][ T6222]  iomap_readpages+0x154/0x3d0
[  564.658823][ T6222]  ? iomap_zero_range_actor+0x330/0x330
[  564.664257][ T6222]  ? __might_sleep+0x73/0xe0
[  564.668836][ T6222]  xfs_vm_readpages+0xaf/0x1f0 [xfs]
[  564.674016][ T6222]  read_pages+0xe2/0x3b0
[  564.678142][ T6222]  ? read_cache_pages+0x350/0x350
[  564.683057][ T6222]  ? __page_cache_alloc+0x12c/0x230
[  564.688148][ T6222]  __do_page_cache_readahead+0x346/0x3a0
[  564.693670][ T6222]  ? read_pages+0x3b0/0x3b0
[  564.698059][ T6222]  ? lockdep_hardirqs_on+0x16/0x2a0
[  564.703247][ T6222]  ? __xfs_filemap_fault+0x167/0x4a0 [xfs]
[  564.708947][ T6222]  filemap_fault+0xa13/0xe70
[  564.713528][ T6222]  __xfs_filemap_fault+0x167/0x4a0 [xfs]
[  564.719059][ T6222]  ? kmemleak_alloc+0x57/0x90
[  564.723724][ T6222]  ? xfs_file_read_iter+0x3c0/0x3c0 [xfs]
[  564.729337][ T6222]  ? debug_check_no_locks_freed+0x2c/0xe0
[  564.734946][ T6222]  ? lockdep_init_map+0x8b/0x2b0
[  564.739872][ T6222]  xfs_filemap_fault+0x68/0x70 [xfs]
[  564.745046][ T6222]  __do_fault+0x83/0x220
[  564.749172][ T6222]  __handle_mm_fault+0xd76/0x1f40
[  564.754084][ T6222]  ? __pmd_alloc+0x280/0x280
[  564.758559][ T6222]  ? debug_lockdep_rcu_enabled+0x27/0x60

> 
> [  183.553150] BUG: sleeping function called from invalid context at
> drivers/iommu/iommu.c:1950
> [  183.562306] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1486,
> name: kworker/0:3
> [  183.571450] 5 locks held by kworker/0:3/1486:
> [  183.576510]  #0: 44ff0008000ce128 ((wq_completion)events){+.+.}, at:
> process_one_work+0x25c/0x948
> [  183.586110]  #1: 43ff00081fb2fcf8 ((work_completion)(&wfc.work)){+.+.}, at:
> process_one_work+0x280/0x948
> [  183.596310]  #2: ffff000a2c661a08 (&dev->intf_state_mutex){+.+.}, at:
> mlx5_load_one+0x68/0x12e0 [mlx5_core]
> [  183.606916]  #3: ffff9000127e4560 (irq_domain_mutex){+.+.}, at:
> __irq_domain_alloc_irqs+0x1f8/0x430
> [  183.616683]  #4: 02ff0095ca0ed8f0 (&(&cookie->msi_lock)->rlock){....}, at:
> iommu_dma_prepare_msi+0x70/0x210
> [  183.627146] irq event stamp: 378872
> [  183.631345] hardirqs last  enabled at (378871): [<ffff9000109d0230>]
> _raw_write_unlock_irqrestore+0x4c/0x84
> [  183.641791] hardirqs last disabled at (378872): [<ffff9000109cf7a0>]
> _raw_spin_lock_irqsave+0x38/0x9c
> [  183.651717] softirqs last  enabled at (377854): [<ffff9000100824f4>]
> __do_softirq+0x864/0x900
> [  183.660951] softirqs last disabled at (377841): [<ffff900010118768>]
> irq_exit+0x1c8/0x238
> [  183.669836] CPU: 0 PID: 1486 Comm: kworker/0:3 Tainted:
> G        W    L    5.4.0-rc3-next-20191016+ #8
> [  183.679845] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
> BIOS L50_5.13_1.11 06/18/2019
> [  183.690292] Workqueue: events work_for_cpu_fn
> [  183.695357] Call trace:
> [  183.698510]  dump_backtrace+0x0/0x248
> [  183.702878]  show_stack+0x20/0x2c
> [  183.706900]  dump_stack+0xc8/0x130
> [  183.711009]  ___might_sleep+0x314/0x328
> [  183.715551]  __might_sleep+0x7c/0xe0
> [  183.719832]  iommu_map+0x40/0x70
> [  183.723766]  iommu_dma_prepare_msi+0x16c/0x210
> [  183.728916]  its_irq_domain_alloc+0x100/0x254
> [  183.733979]  irq_domain_alloc_irqs_parent+0x74/0x90
> [  183.739562]  msi_domain_alloc+0xa0/0x170
> [  183.744190]  __irq_domain_alloc_irqs+0x228/0x430
> [  183.749512]  msi_domain_alloc_irqs+0x130/0x548
> [  183.754663]  pci_msi_setup_msi_irqs+0x64/0x74
> [  183.759726]  __pci_enable_msix_range+0x52c/0x878
> [  183.765049]  pci_alloc_irq_vectors_affinity+0x94/0x168
> [  183.771028]  mlx5_irq_table_create+0x178/0x748 [mlx5_core]
> [  183.777353]  mlx5_load_one+0x710/0x12e0 [mlx5_core]
> [  183.783069]  init_one+0x514/0x898 [mlx5_core]
> [  183.788134]  local_pci_probe+0x74/0xcc
> [  183.792589]  work_for_cpu_fn+0x30/0x4c
> [  183.797045]  process_one_work+0x4f4/0x948
> [  183.801760]  process_scheduled_works+0x34/0x54
> [  183.806909]  worker_thread+0x348/0x4bc
> [  183.811364]  kthread+0x1cc/0x1e8
> [  183.815299]  ret_from_fork+0x10/0x18
> [  184.621631] mlx5_core 0000:0b:00.1: Port module event: module 1, Cable
> unplugged
> [  184.867367] mlx5_core 0000:0b:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256)
> RxCqeCmprss(0)
> [  186.181802] mlx5_core 0000:0b:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256)
> RxCqeCmprss(0)
