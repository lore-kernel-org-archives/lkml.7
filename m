Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B96C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1BC22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dvMJ0Iyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfIDISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:18:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12476 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfIDISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:18:13 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f73450000>; Wed, 04 Sep 2019 01:18:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 01:18:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 04 Sep 2019 01:18:12 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 08:18:12 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 08:18:12 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f73420000>; Wed, 04 Sep 2019 01:18:12 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <dmitry.torokhov@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH] USB: usbfs: check cpu address range before remap
Date:   Wed, 4 Sep 2019 13:47:31 +0530
Message-ID: <1567585051-1354-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567585093; bh=rLBDoKvihGl0MovYYfBvU0HKJlYfWcLeQewj7Y0wtHk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=dvMJ0IyyvVeEh7H4G18ES1kXsBNgRYGZ55ae/oXrO+Q9FU+rIpTyItB+kztG2ZUcW
         ki1Hwj+Q28phiA/5q4cjVRM+vDMVF5c6ZtF4uC+sCkf9Jzvkmq9WVupyX64kj3KZTM
         U2t2tmeD0Ux0KA+/hlmnsNaIGlzoVdZ0kFb57GTkNt3vQCXJDq2mXHPnOrY2X6w1Vg
         e4mUsfbZnARktmbkh5jhDqanFQLyOi0Zm0yhlB092fEM6tE64AYVsAwabBis/76ryA
         WswQvZKnIEmOuyEy9ya38Xp3LfHwnnEIM8JS3mpnVbVz3njP/a601wGUnUmnVtuadu
         M5QRfxufc3wuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usbfs mmap, usb_alloc_coherent is used to allocate memory.
This Memory is then remapped to user space memory using remap_pfn_range.
remap_pfn_range needs phy address of memory, for which virt_to_phy API
is used. This API works only if memory is allocated using kmalloc. But
usb_alloc_coherent can allocate memory in vmalloc range and this causes
wrong remap of user memory.

Check if address returned by usb_alloc_coherent failed in vmalloc range
and if yes, use remap_vmalloc_range API, else use remap_pfn_range to remap
address to user space.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/usb/core/devio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index a945ad7..20999de 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -250,7 +250,12 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (remap_pfn_range(vma, vma->vm_start,
+	if (is_vmalloc_addr(usbm->mem)) {
+		if (remap_vmalloc_range(vma, usbm->mem, 0) < 0) {
+			dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
+			return -EAGAIN;
+		}
+	} else if (remap_pfn_range(vma, vma->vm_start,
 			virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 			size, vma->vm_page_prot) < 0) {
 		dec_usb_memory_use_count(usbm, &usbm->vma_use_count);
-- 
2.7.4

