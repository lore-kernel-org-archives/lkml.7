Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD5CC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE9E2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EHV8pR7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfIKW2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:28:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1596 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfIKW2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:28:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7975230000>; Wed, 11 Sep 2019 15:28:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Sep 2019 15:28:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Sep 2019 15:28:49 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Sep
 2019 22:28:46 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Sep 2019 22:28:46 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d79751e0002>; Wed, 11 Sep 2019 15:28:46 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 3/4] mm/hmm: allow hmm_range_fault() of mmap(PROT_NONE)
Date:   Wed, 11 Sep 2019 15:28:28 -0700
Message-ID: <20190911222829.28874-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911222829.28874-1-rcampbell@nvidia.com>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568240931; bh=F20+CtE96DKxf8E9hC0a2S8wRPS9i4pdaXNv/ANnE1k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=EHV8pR7Vx2o54VOBe9IiUlPWtdqX1Bc/1/UKUEx3gpEMFs7hfOIwd/89RCnmdNqV/
         JxxnSfJKv+Lv+A9hv5TtPCiEQ7UeRyHgPP165+7aebwpPZ/iuE5m1lagJtleznsAgb
         RHcAoxNlxawV83OHZC8z8vwpSD7eV3fSD9HWbJry61FPhtIbRFOvFpre4bIrcVubvC
         GxD2YwE9TkX0WYagYzw0Ma0JO1W415YxmhSJPW4Tmhkep2I5j2pnJF1VDhbJCdi4RH
         Y6nNbO/Sh8DurJ3DJPCtvHqf0hRlvIlYyO3ePZLlK2KWMZB9DFAUWRK0HXg3ozACcV
         KiOoYgiwY9dHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow hmm_range_fault() to return success (0) when the range has no access
(!(vma->vm_flags & VM_READ)). The range->pfns[] array will be filled with
range->values[HMM_PFN_NONE] in this case.
This allows the caller to get a snapshot of a range without having to
lookup the vma before calling hmm_range_fault().
If the call to hmm_range_fault() is not a snapshot, the caller can still
check that pfns have the desired access permissions.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 7217912bef13..16c834e5d1c0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -795,7 +795,9 @@ static int hmm_vma_walk_test(unsigned long start,
 	 */
 	if (!(vma->vm_flags & VM_READ)) {
 		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
-		return -EPERM;
+
+		/* Skip this vma and continue processing the next vma. */
+		return 1;
 	}
=20
 	return 0;
--=20
2.20.1

