Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B9C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72938217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909725;
	bh=oe+ZfcGvJIw8zMjRfFdbCMILhxTn44s5HlUfJDfTUhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+xDmdk2zBVLY6H39zdvEr4cYCoL7OjnMAc2UvsmNXSYyqRzBNmdZymfndSoZwOwc
	 h5K/4+aK34z1RlrSSDq4nK7IxFyMN783AErg/GAo8u0i4AgeP7gC1REnT/1b9vS/qG
	 ev2X1PIRwC/GrtXTZqH5GY75ElFGZ9K2tBZJ8JWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfC3BfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbfC3Bbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2502184C;
        Sat, 30 Mar 2019 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909502;
        bh=oe+ZfcGvJIw8zMjRfFdbCMILhxTn44s5HlUfJDfTUhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v7wYWGalhvSIw0zr/xcD4Y22ZNKu4ROGTYevUoL+Ll8mwAeXemxUIZ5jDUPNjQCX8
         IxOoE8wqPn+5QiyaZViG/WOMKVl084FHFHkoWsz7npkW2BuSw0c0aPUdNWTrHDd+A8
         wrkq9AOcjrqSEAW6zj4YAzzGes8i2ctPXEMgYotM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Cartwright <julia@ni.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 14/21] iommu/dmar: Fix buffer overflow during PCI bus notification
Date:   Fri, 29 Mar 2019 21:31:05 -0400
Message-Id: <20190330013112.784-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013112.784-1-sashal@kernel.org>
References: <20190330013112.784-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Cartwright <julia@ni.com>

[ Upstream commit cffaaf0c816238c45cd2d06913476c83eb50f682 ]

Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
device path") changed the type of the path data, however, the change in
path type was not reflected in size calculations.  Update to use the
correct type and prevent a buffer overflow.

This bug manifests in systems with deep PCI hierarchies, and can lead to
an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
or can lead to overflow of slab-allocated data.

   BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0x2e0
   Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-02406-gd0a0e96 #1
   Call Trace:
    ? dump_stack+0x46/0x59
    ? print_address_description+0x1df/0x290
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? kasan_report+0x256/0x340
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? e820__memblock_setup+0xb0/0xb0
    ? dmar_dev_scope_init+0x424/0x48f
    ? __down_write_common+0x1ec/0x230
    ? dmar_dev_scope_init+0x48f/0x48f
    ? dmar_free_unused_resources+0x109/0x109
    ? cpumask_next+0x16/0x20
    ? __kmem_cache_create+0x392/0x430
    ? kmem_cache_create+0x135/0x2f0
    ? e820__memblock_setup+0xb0/0xb0
    ? intel_iommu_init+0x170/0x1848
    ? _raw_spin_unlock_irqrestore+0x32/0x60
    ? migrate_enable+0x27a/0x5b0
    ? sched_setattr+0x20/0x20
    ? migrate_disable+0x1fc/0x380
    ? task_rq_lock+0x170/0x170
    ? try_to_run_init_process+0x40/0x40
    ? locks_remove_file+0x85/0x2f0
    ? dev_prepare_static_identity_mapping+0x78/0x78
    ? rt_spin_unlock+0x39/0x50
    ? lockref_put_or_lock+0x2a/0x40
    ? dput+0x128/0x2f0
    ? __rcu_read_unlock+0x66/0x80
    ? __fput+0x250/0x300
    ? __rcu_read_lock+0x1b/0x30
    ? mntput_no_expire+0x38/0x290
    ? e820__memblock_setup+0xb0/0xb0
    ? pci_iommu_init+0x25/0x63
    ? pci_iommu_init+0x25/0x63
    ? do_one_initcall+0x7e/0x1c0
    ? initcall_blacklisted+0x120/0x120
    ? kernel_init_freeable+0x27b/0x307
    ? rest_init+0xd0/0xd0
    ? kernel_init+0xf/0x120
    ? rest_init+0xd0/0xd0
    ? ret_from_fork+0x1f/0x40
   The buggy address belongs to the variable:
    dmar_pci_notify_info_buf+0x40/0x60

Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI device path")
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 63110fbbb410..d51734e0c350 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -143,7 +143,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 		for (tmp = dev; tmp; tmp = tmp->bus->self)
 			level++;
 
-	size = sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
+	size = sizeof(*info) + level * sizeof(info->path[0]);
 	if (size <= sizeof(dmar_pci_notify_info_buf)) {
 		info = (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
 	} else {
-- 
2.19.1

