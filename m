Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84010FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3282168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JtpuA57/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbfJPOzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:55:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44816 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404814AbfJPOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:55:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so36473315qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=6hGS+UV0Kn8pFLpRVD/+mt3VBTqrlYZ2I5xPU55myZ4=;
        b=JtpuA57/gkOgQxJH5xgPCfnwf4cLO/5VGf2sM0OiGVD1xyVMPTnuupzDBdy3edJRHU
         bxPUzbGNWLvUjau4pPXmXhyK2p6K4mG4be8byvWS9ltYUWKhvHVobyYiCl5C9HYLT3AQ
         UPXPusa/+BDlv2Vn7hwCsE1ZQQcrCKQALkc2nq7bINZYsBUsoiQ5L6yJNgSHbQG4eLVf
         7cokIt/Whznq4PLbes3NSJetQZzqdk9yoL9T05Q/5XP+6Z7GQW9nTeGufqfn19GkWz0J
         h0KIolxSo1GBdUUqDNCa+hldydDe1Cax7U/whhpSjck6lBSOqCufcFiTtDIfyDC+iEwf
         zUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=6hGS+UV0Kn8pFLpRVD/+mt3VBTqrlYZ2I5xPU55myZ4=;
        b=n+KVYKwlCUn/8NiUqQuUS+4PxyhRl3ws7/yP9Hw0udPSvxOTXIiJDsiiWj52AqPsL8
         S9oDgvx1vSAIAj42JazZazLw8C5cb5sdFSq8UGgFVF4v50Dce2LQ5aTfDunBjgExZSpY
         ir1qU2Y1h2ozkAEuag0SXDl6iXOBiRR7yWLeE+aFRPxGn49UB24cx+/tb7ieGMinu31w
         o17eV1CCKKI+MJ2A6ZafRjPEDEleR4ZlAq08+0oYfCFzjRWF5FfGLJKMEu2tyyuIHeoL
         NXeA3lJwjkackrn4is3jpGff04HUJSJSX5LtQJFmW0VewuIVaKCAYWWeOXXGviHqgkJU
         vlzw==
X-Gm-Message-State: APjAAAUsAlbr1aSnv0Rmk2LZNlaBynhUZLw3uCwxdPV+CjGRRXr36pF/
        rvswyRHRNGXbOgC85plZWU4f2C9rmts=
X-Google-Smtp-Source: APXvYqxgl2n27DMtvjvWjkEaY+O0vwkaUjx3G4C7sWU4RY6L2P73mSFc71rQzhKcwvrZkzTZLWVLBA==
X-Received: by 2002:a0c:d1dd:: with SMTP id k29mr11074570qvh.110.1571237709699;
        Wed, 16 Oct 2019 07:55:09 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n17sm12316324qke.103.2019.10.16.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 07:55:09 -0700 (PDT)
Message-ID: <1571237707.5937.58.camel@lca.pw>
Subject: "Convert the AMD iommu driver to the dma-iommu api" is buggy
From:   Qian Cai <cai@lca.pw>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 10:55:07 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's linux-next generates a lot of warnings on multiple servers during boot
due to the series "iommu/amd: Convert the AMD iommu driver to the dma-iommu api"
[1]. Reverted the whole things fixed them.

[1] https://lore.kernel.org/lkml/20190908165642.22253-1-murphyt7@tcd.ie/

[  257.785749][ T6184] BUG: sleeping function called from invalid context at
mm/page_alloc.c:4692
[  257.794886][ T6184] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
6184, name: readelf
[  257.803574][ T6184] INFO: lockdep is turned off.
[  257.808233][ T6184] CPU: 86 PID: 6184 Comm: readelf Tainted:
G        W         5.4.0-rc3-next-20191016+ #7
[  257.818035][ T6184] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019
[  257.827313][ T6184] Call Trace:
[  257.830487][ T6184]  dump_stack+0x86/0xca
[  257.834530][ T6184]  ___might_sleep.cold.92+0xd2/0x122
[  257.839708][ T6184]  __might_sleep+0x73/0xe0
[  257.844011][ T6184]  __alloc_pages_nodemask+0x442/0x720
[  257.849274][ T6184]  ? __alloc_pages_slowpath+0x18d0/0x18d0
[  257.854886][ T6184]  ? debug_lockdep_rcu_enabled+0x27/0x60
[  257.860415][ T6184]  ? lock_downgrade+0x3c0/0x3c0
[  257.865156][ T6184]  alloc_pages_current+0x9c/0x110
[  257.870071][ T6184]  __get_free_pages+0x12/0x60
[  257.874634][ T6184]  get_zeroed_page+0x16/0x20
[  257.879112][ T6184]  amd_iommu_map+0x504/0x850
[  257.883588][ T6184]  ? amd_iommu_domain_direct_map+0x60/0x60
[  257.889286][ T6184]  ? lockdep_hardirqs_on+0x16/0x2a0
[  257.894373][ T6184]  ? alloc_iova+0x189/0x210
[  257.898765][ T6184]  ? trace_hardirqs_on+0x3a/0x160
[  257.903677][ T6184]  iommu_map+0x1b3/0x4d0
[  257.907802][ T6184]  ? iommu_unmap+0xf0/0xf0
[  257.912104][ T6184]  ? alloc_iova_fast+0x258/0x3d1
[  257.916929][ T6184]  ? create_object+0x4a2/0x540
[  257.921579][ T6184]  iommu_map_sg+0x9d/0x120
[  257.925882][ T6184]  iommu_dma_map_sg+0x2c3/0x450
[  257.930627][ T6184]  scsi_dma_map+0xd7/0x160
[  257.934936][ T6184]  pqi_raid_submit_scsi_cmd_with_io_request+0x392/0x420
[smartpqi]
[  257.942735][ T6184]  ? pqi_alloc_io_request+0x127/0x140 [smartpqi]
[  257.948962][ T6184]  pqi_scsi_queue_command+0x8ab/0xe00 [smartpqi]
[  257.955192][ T6184]  ? pqi_eh_device_reset_handler+0x9c0/0x9c0 [smartpqi]
[  257.962029][ T6184]  ? sd_init_command+0xa25/0x1346 [sd_mod]
[  257.967730][ T6184]  scsi_queue_rq+0xd19/0x1360
[  257.972298][ T6184]  __blk_mq_try_issue_directly+0x295/0x3f0
[  257.977999][ T6184]  ? blk_mq_request_bypass_insert+0xd0/0xd0
[  257.983787][ T6184]  ? debug_lockdep_rcu_enabled+0x27/0x60
[  257.989312][ T6184]  blk_mq_request_issue_directly+0xb5/0x100
[  257.995098][ T6184]  ? blk_mq_flush_plug_list+0x7e0/0x7e0
[  258.000537][ T6184]  ? blk_mq_sched_insert_requests+0xd6/0x380
[  258.006409][ T6184]  ? lock_downgrade+0x3c0/0x3c0
[  258.011147][ T6184]  blk_mq_try_issue_list_directly+0xa9/0x160
[  258.017023][ T6184]  blk_mq_sched_insert_requests+0x228/0x380
[  258.022810][ T6184]  blk_mq_flush_plug_list+0x448/0x7e0
[  258.028073][ T6184]  ? blk_mq_insert_requests+0x380/0x380
[  258.033516][ T6184]  blk_flush_plug_list+0x1eb/0x230
[  258.038515][ T6184]  ? blk_insert_cloned_request+0x1b0/0x1b0
[  258.044215][ T6184]  blk_finish_plug+0x43/0x5d
[  258.048695][ T6184]  read_pages+0xf6/0x3b0
[  258.052823][ T6184]  ? read_cache_pages+0x350/0x350
[  258.057737][ T6184]  ? __page_cache_alloc+0x12c/0x230
[  258.062826][ T6184]  __do_page_cache_readahead+0x346/0x3a0
[  258.068348][ T6184]  ? read_pages+0x3b0/0x3b0
[  258.072738][ T6184]  ? lockdep_hardirqs_on+0x16/0x2a0
[  258.077928][ T6184]  ? __xfs_filemap_fault+0x167/0x4a0 [xfs]
[  258.083625][ T6184]  filemap_fault+0xa13/0xe70
[  258.088201][ T6184]  __xfs_filemap_fault+0x167/0x4a0 [xfs]
[  258.093731][ T6184]  ? kmemleak_alloc+0x57/0x90
[  258.098397][ T6184]  ? xfs_file_read_iter+0x3c0/0x3c0 [xfs]
[  258.104009][ T6184]  ? debug_check_no_locks_freed+0x2c/0xe0
[  258.109618][ T6184]  ? lockdep_init_map+0x8b/0x2b0
[  258.114543][ T6184]  xfs_filemap_fault+0x68/0x70 [xfs]
[  258.119720][ T6184]  __do_fault+0x83/0x220
[  258.123847][ T6184]  __handle_mm_fault+0xd76/0x1f40
[  258.128757][ T6184]  ? __pmd_alloc+0x280/0x280
[  258.133231][ T6184]  ? debug_lockdep_rcu_enabled+0x27/0x60
[  258.138755][ T6184]  ? handle_mm_fault+0x178/0x4c0
[  258.143581][ T6184]  ? lockdep_hardirqs_on+0x16/0x2a0
[  258.148674][ T6184]  ? __do_page_fault+0x29c/0x640
[  258.153501][ T6184]  handle_mm_fault+0x205/0x4c0
[  258.158151][ T6184]  __do_page_fault+0x29c/0x640
[  258.162800][ T6184]  do_page_fault+0x50/0x37f
[  258.167189][ T6184]  page_fault+0x34/0x40
[  258.171228][ T6184] RIP: 0010:__clear_user+0x3b/0x70

[  183.553150] BUG: sleeping function called from invalid context at
drivers/iommu/iommu.c:1950
[  183.562306] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1486,
name: kworker/0:3
[  183.571450] 5 locks held by kworker/0:3/1486:
[  183.576510]  #0: 44ff0008000ce128 ((wq_completion)events){+.+.}, at:
process_one_work+0x25c/0x948
[  183.586110]  #1: 43ff00081fb2fcf8 ((work_completion)(&wfc.work)){+.+.}, at:
process_one_work+0x280/0x948
[  183.596310]  #2: ffff000a2c661a08 (&dev->intf_state_mutex){+.+.}, at:
mlx5_load_one+0x68/0x12e0 [mlx5_core]
[  183.606916]  #3: ffff9000127e4560 (irq_domain_mutex){+.+.}, at:
__irq_domain_alloc_irqs+0x1f8/0x430
[  183.616683]  #4: 02ff0095ca0ed8f0 (&(&cookie->msi_lock)->rlock){....}, at:
iommu_dma_prepare_msi+0x70/0x210
[  183.627146] irq event stamp: 378872
[  183.631345] hardirqs last  enabled at (378871): [<ffff9000109d0230>]
_raw_write_unlock_irqrestore+0x4c/0x84
[  183.641791] hardirqs last disabled at (378872): [<ffff9000109cf7a0>]
_raw_spin_lock_irqsave+0x38/0x9c
[  183.651717] softirqs last  enabled at (377854): [<ffff9000100824f4>]
__do_softirq+0x864/0x900
[  183.660951] softirqs last disabled at (377841): [<ffff900010118768>]
irq_exit+0x1c8/0x238
[  183.669836] CPU: 0 PID: 1486 Comm: kworker/0:3 Tainted:
G        W    L    5.4.0-rc3-next-20191016+ #8
[  183.679845] Hardware name: HPE Apollo 70             /C01_APACHE_MB         ,
BIOS L50_5.13_1.11 06/18/2019
[  183.690292] Workqueue: events work_for_cpu_fn
[  183.695357] Call trace:
[  183.698510]  dump_backtrace+0x0/0x248
[  183.702878]  show_stack+0x20/0x2c
[  183.706900]  dump_stack+0xc8/0x130
[  183.711009]  ___might_sleep+0x314/0x328
[  183.715551]  __might_sleep+0x7c/0xe0
[  183.719832]  iommu_map+0x40/0x70
[  183.723766]  iommu_dma_prepare_msi+0x16c/0x210
[  183.728916]  its_irq_domain_alloc+0x100/0x254
[  183.733979]  irq_domain_alloc_irqs_parent+0x74/0x90
[  183.739562]  msi_domain_alloc+0xa0/0x170
[  183.744190]  __irq_domain_alloc_irqs+0x228/0x430
[  183.749512]  msi_domain_alloc_irqs+0x130/0x548
[  183.754663]  pci_msi_setup_msi_irqs+0x64/0x74
[  183.759726]  __pci_enable_msix_range+0x52c/0x878
[  183.765049]  pci_alloc_irq_vectors_affinity+0x94/0x168
[  183.771028]  mlx5_irq_table_create+0x178/0x748 [mlx5_core]
[  183.777353]  mlx5_load_one+0x710/0x12e0 [mlx5_core]
[  183.783069]  init_one+0x514/0x898 [mlx5_core]
[  183.788134]  local_pci_probe+0x74/0xcc
[  183.792589]  work_for_cpu_fn+0x30/0x4c
[  183.797045]  process_one_work+0x4f4/0x948
[  183.801760]  process_scheduled_works+0x34/0x54
[  183.806909]  worker_thread+0x348/0x4bc
[  183.811364]  kthread+0x1cc/0x1e8
[  183.815299]  ret_from_fork+0x10/0x18
[  184.621631] mlx5_core 0000:0b:00.1: Port module event: module 1, Cable
unplugged
[  184.867367] mlx5_core 0000:0b:00.0: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256)
RxCqeCmprss(0)
[  186.181802] mlx5_core 0000:0b:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(256)
RxCqeCmprss(0)
