Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87007C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CCF22CBB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y+Fdrsy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGZA5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:57:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11338 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfGZA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:57:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fe90000>; Thu, 25 Jul 2019 17:57:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:57:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:57:13 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:57:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:57:11 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fe70000>; Thu, 25 Jul 2019 17:57:11 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 7/7] mm/hmm: remove hmm_range vma
Date:   Thu, 25 Jul 2019 17:56:50 -0700
Message-ID: <20190726005650.2566-8-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726005650.2566-1-rcampbell@nvidia.com>
References: <20190726005650.2566-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102634; bh=NZUo+DqUJdY6mTpO9a6/Oba2m7JMCHGUDDnmqd09n1Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=Y+Fdrsy5YTiGjTNAPneWU7N67hB8atyhiYSL7w1D9fRjSIU0CfPzTBs1+TJzPLeRd
         lZg+U+KeM5lIDv23Uued3ANTxSgkBOSMlBDcqTqFQrMZetgu7wTZJ/18nJTgFUlQH7
         9M9bqjlekVURUgBu+xXY9uNZnDjVOHAMuds+n9WmwMP9IafFxNItlvDkk5+7xf168C
         /jBL6ulVlFTzr3sEKhNy9uO7sVIGou26UW/rn8gdQOF2MPV5eBWbEIWuUlRjHkUVyb
         MyIizWpUTiSts0J7sLQ9gk5Raxzo7iAUIw4fsLk+jXjvBR9uvF6CPcFSA49r+/WBWC
         ev8fK2+UEnDJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since hmm_range_fault() doesn't use the struct hmm_range vma field,
remove it.

Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 7 +++----
 include/linux/hmm.h                   | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 49b520c60fc5..a74530b5a523 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -496,12 +496,12 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct=
 hmm_range *range)
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret) {
-		up_read(&range->vma->vm_mm->mmap_sem);
+		up_read(&range->hmm->mm->mmap_sem);
 		return (int)ret;
 	}
=20
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		up_read(&range->vma->vm_mm->mmap_sem);
+		up_read(&range->hmm->mm->mmap_sem);
 		return -EBUSY;
 	}
=20
@@ -509,7 +509,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct h=
mm_range *range)
 	if (ret <=3D 0) {
 		if (ret =3D=3D 0)
 			ret =3D -EBUSY;
-		up_read(&range->vma->vm_mm->mmap_sem);
+		up_read(&range->hmm->mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -682,7 +682,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 args.i.p.addr + args.i.p.size, fn - fi);
=20
 		/* Have HMM fault pages within the fault window to the GPU. */
-		range.vma =3D vma;
 		range.start =3D args.i.p.addr;
 		range.end =3D args.i.p.addr + args.i.p.size;
 		range.pfns =3D args.phys;
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index f3693dcc8b98..68949cf815f9 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -164,7 +164,6 @@ enum hmm_pfn_value_e {
  */
 struct hmm_range {
 	struct hmm		*hmm;
-	struct vm_area_struct	*vma;
 	struct list_head	list;
 	unsigned long		start;
 	unsigned long		end;
--=20
2.20.1

