Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD17C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5592412A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfE2ULL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:11:11 -0400
Received: from www17.your-server.de ([213.133.104.17]:54172 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfE2ULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:11:10 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW4uj-0004YF-4J; Wed, 29 May 2019 22:11:09 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW4uh-0003T5-Vl; Wed, 29 May 2019 22:11:08 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:11:06 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:11:06 +0200
Subject: [PATCH] vfio-pci/nvlink2: Use vma_pages function instead of explicit
 computation
To:     alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559160524648-1049343203-1-diffsplit-thomas@m3y3r.de>
References: <1559160524618-2047588593-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1559160524618-2047588593-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_pages function on vma object instead of explicit computation.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -161,7 +161,7 @@ static int vfio_pci_nvgpu_mmap(struct vf
 
 	atomic_inc(&data->mm->mm_count);
 	ret = (int) mm_iommu_newdev(data->mm, data->useraddr,
-			(vma->vm_end - vma->vm_start) >> PAGE_SHIFT,
+			vma_pages(vma),
 			data->gpu_hpa, &data->mem);
 
 	trace_vfio_pci_nvgpu_mmap(vdev->pdev, data->gpu_hpa, data->useraddr,
