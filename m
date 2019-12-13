Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7737C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5634822527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl1wMdxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfLMFhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:37:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfLMFhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576215421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KrRJhXbPmYzxHbKKDmxeVwb2dFiex77QA0exnu3ANOQ=;
        b=Zl1wMdxLnAK8dQf807kbL5V7VcPqbK/g0M0oxMp2a6F3NDPlI5LkUQOrvZ6Nh/o7n/REgy
        0xNGRedluK7iSVjInqMT0QgK0s0Feew/yAR24D5HWNmagJy9+ArYiYoiswLdUxDj2+YZjZ
        fH0NG7ko/Q+uXq/iOV2wpIqJ0F96OEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-KmzpGEOENaKFrOMYeuCQ3w-1; Fri, 13 Dec 2019 00:36:58 -0500
X-MC-Unique: KmzpGEOENaKFrOMYeuCQ3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27A361800D63;
        Fri, 13 Dec 2019 05:36:57 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-67.phx2.redhat.com [10.3.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 073F646E77;
        Fri, 13 Dec 2019 05:36:49 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, stable@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Allocate reserved region for ISA with correct permission
Date:   Thu, 12 Dec 2019 22:36:42 -0700
Message-Id: <20191213053642.5696-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the reserved region for ISA is allocated with no
permissions. If a dma domain is being used, mapping this region will
fail. Set the permissions to DMA_PTE_READ|DMA_PTE_WRITE.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Lu Baolu <baolu.lu@linux.intel.com>=20
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org # v5.3+
Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via io=
mmu_get_resv_regions")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..998529cebcf2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5736,7 +5736,7 @@ static void intel_iommu_get_resv_regions(struct dev=
ice *device,
 		struct pci_dev *pdev =3D to_pci_dev(device);
=20
 		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
-			reg =3D iommu_alloc_resv_region(0, 1UL << 24, 0,
+			reg =3D iommu_alloc_resv_region(0, 1UL << 24, prot,
 						      IOMMU_RESV_DIRECT);
 			if (reg)
 				list_add_tail(&reg->list, head);
--=20
2.24.0

