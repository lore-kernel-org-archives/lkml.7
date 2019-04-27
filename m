Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19C9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8441221655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329319;
	bh=hlO/GXsybl7k9J/hNNdGMo5nfKDrfpPMdqy5bkh5csc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7xW2p87K8mttxpzB7feS0fZJWUT0zK+EhvqnOjV0bR29mz2NcWCEL3skfKathwCT
	 P6B6H/Qkt2PCVGNfzUE0Y1H1CcIajIqG/Sj4lD9e5TpItbKL0n+Nag0FcZshi56E2A
	 xDz2XA/inWrFgJr+X/nAbqXzD+MfYK/ctUrLGCH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfD0Bl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbfD0Blx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D51F216FD;
        Sat, 27 Apr 2019 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329313;
        bh=hlO/GXsybl7k9J/hNNdGMo5nfKDrfpPMdqy5bkh5csc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjT+qTszMVH9RZveW6tuT5NZxUyMLm4FSO80rISpz9J7JJsjoj9MQAJK7sOJbj8Rl
         vP46F0PVM8zxLhwauGRHEI6ylNOt2ym8aeJrA1CTfzdE55ppNvG8Hq3d7zVK+e+KJE
         qFUcK6Lk8iP1a539auGHBGZ6Pz5ZY+9nBBOoy0vU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Longpeng <longpeng2@huawei.com>, Gonglei <arei.gonglei@huawei.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 37/53] virtio_pci: fix a NULL pointer reference in vp_del_vqs
Date:   Fri, 26 Apr 2019 21:40:34 -0400
Message-Id: <20190427014051.7522-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

[ Upstream commit 6a8aae68c87349dbbcd46eac380bc43cdb98a13b ]

If the msix_affinity_masks is alloced failed, then we'll
try to free some resources in vp_free_vectors() that may
access it directly.

We met the following stack in our production:
[   29.296767] BUG: unable to handle kernel NULL pointer dereference at  (null)
[   29.311151] IP: [<ffffffffc04fe35a>] vp_free_vectors+0x6a/0x150 [virtio_pci]
[   29.324787] PGD 0
[   29.333224] Oops: 0000 [#1] SMP
[...]
[   29.425175] RIP: 0010:[<ffffffffc04fe35a>]  [<ffffffffc04fe35a>] vp_free_vectors+0x6a/0x150 [virtio_pci]
[   29.441405] RSP: 0018:ffff9a55c2dcfa10  EFLAGS: 00010206
[   29.453491] RAX: 0000000000000000 RBX: ffff9a55c322c400 RCX: 0000000000000000
[   29.467488] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a55c322c400
[   29.481461] RBP: ffff9a55c2dcfa20 R08: 0000000000000000 R09: ffffc1b6806ff020
[   29.495427] R10: 0000000000000e95 R11: 0000000000aaaaaa R12: 0000000000000000
[   29.509414] R13: 0000000000010000 R14: ffff9a55bd2d9e98 R15: ffff9a55c322c400
[   29.523407] FS:  00007fdcba69f8c0(0000) GS:ffff9a55c2840000(0000) knlGS:0000000000000000
[   29.538472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.551621] CR2: 0000000000000000 CR3: 000000003ce52000 CR4: 00000000003607a0
[   29.565886] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.580055] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.594122] Call Trace:
[   29.603446]  [<ffffffffc04fe8a2>] vp_request_msix_vectors+0xe2/0x260 [virtio_pci]
[   29.618017]  [<ffffffffc04fedc5>] vp_try_to_find_vqs+0x95/0x3b0 [virtio_pci]
[   29.632152]  [<ffffffffc04ff117>] vp_find_vqs+0x37/0xb0 [virtio_pci]
[   29.645582]  [<ffffffffc057bf63>] init_vq+0x153/0x260 [virtio_blk]
[   29.658831]  [<ffffffffc057c1e8>] virtblk_probe+0xe8/0x87f [virtio_blk]
[...]

Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng <longpeng2@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_pci_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 465a6f5142cc..45b04bc91f24 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -255,9 +255,11 @@ void vp_del_vqs(struct virtio_device *vdev)
 	for (i = 0; i < vp_dev->msix_used_vectors; ++i)
 		free_irq(pci_irq_vector(vp_dev->pci_dev, i), vp_dev);
 
-	for (i = 0; i < vp_dev->msix_vectors; i++)
-		if (vp_dev->msix_affinity_masks[i])
-			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
+	if (vp_dev->msix_affinity_masks) {
+		for (i = 0; i < vp_dev->msix_vectors; i++)
+			if (vp_dev->msix_affinity_masks[i])
+				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
+	}
 
 	if (vp_dev->msix_enabled) {
 		/* Disable the vector used for configuration */
-- 
2.19.1

