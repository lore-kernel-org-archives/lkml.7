Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C01C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235042077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Nq9cz4aO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgAGVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5713 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgAGVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:12:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14f4120000>; Tue, 07 Jan 2020 13:11:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 13:12:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 13:12:34 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 21:12:32 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e14f4400004>; Tue, 07 Jan 2020 13:12:32 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/3] mm/migrate: remove useless mask of start address
Date:   Tue, 7 Jan 2020 13:12:06 -0800
Message-ID: <20200107211208.24595-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107211208.24595-1-rcampbell@nvidia.com>
References: <20200107211208.24595-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578431506; bh=X07NHQHfINZSy9Ul0OISn+znOiJPanChRLHVsYFl+U8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Nq9cz4aO8SlJFu4Dhi6OI2sNInBftzuKYW9D0C77YmHu/geUOmbzDsQbWL8aHMI8C
         21prDhIirty2yL6j7H18KUn0N2jDChCqAcRAXZqmWWJlloXQ53FpdOhFoJ8oyvzEPz
         /G/2D4d+cLmXSjFS00xucZcSDJuWmth12V0JErBHKEp7gta2I7b0waKPNV0gjh2QSg
         vs77sD7XRLZmXGTFZJIYr8EzVfWfTnEKSxkX6fcVmUdLo7khEb7kPbS9M3scinmfAW
         rLqbNkHRoLt1rC36zsYywxYzo4Q4sxeqCGXpTHX1xaoQcy7/ppoi0jNZdQ3SZ6V/CF
         IpOLYguY2ZJ1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses passed to walk_page_range() callback functions are already page
aligned and don't need to be masked with PAGE_MASK.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ebe2bf070653..b7f5d9ada429 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2136,7 +2136,7 @@ static int migrate_vma_collect_hole(unsigned long sta=
rt,
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
=20
-	for (addr =3D start & PAGE_MASK; addr < end; addr +=3D PAGE_SIZE) {
+	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
 		migrate->src[migrate->npages] =3D MIGRATE_PFN_MIGRATE;
 		migrate->dst[migrate->npages] =3D 0;
 		migrate->npages++;
@@ -2153,7 +2153,7 @@ static int migrate_vma_collect_skip(unsigned long sta=
rt,
 	struct migrate_vma *migrate =3D walk->private;
 	unsigned long addr;
=20
-	for (addr =3D start & PAGE_MASK; addr < end; addr +=3D PAGE_SIZE) {
+	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
 		migrate->dst[migrate->npages] =3D 0;
 		migrate->src[migrate->npages++] =3D 0;
 	}
--=20
2.20.1

