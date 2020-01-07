Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D31C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876902077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IBWoKXwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgAGVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:12:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18204 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgAGVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:12:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14f4310000>; Tue, 07 Jan 2020 13:12:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 13:12:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 13:12:34 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:34 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 21:12:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 7 Jan 2020 21:12:30 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e14f43e0002>; Tue, 07 Jan 2020 13:12:30 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Bharata B Rao" <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/3] mm/migrate: add missing check for stable
Date:   Tue, 7 Jan 2020 13:12:05 -0800
Message-ID: <20200107211208.24595-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578431537; bh=sWUpJL5MFKaYeBJeJiXe/oIRHU9XHyTRTvIePM/v+vI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=IBWoKXwFy2kG6cADzIn7SJLzRaH0FFSO4YcvGPP14hoM9tY+4dra7tQ+nYO7jE6u8
         /yldNSHoAYY1xzEGG8PiYtY8JQjwONdBb+lpTxZo3Ur1xtrofgcmI59S/YREtXt6KU
         3Z1UiyPGF+ViTbhpfBAxa+f1iYg/7nipcjafS+IE8dkmpoB2uUwP99xVdZp3irk8CJ
         QgMC29iYnBKUFVZEHtHVFqCIzNT8ApbPEx35VyD+v8m3f11fhkZlkAE9AxoEYKWG2d
         NUeq6R4yHRKHUFxWPfVIyOC5Saqi/+9+WRve67s6H7FSr4iA5b87tbf7+DMRo/WTG/
         rdDNKcO/VKD8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches are preparation for the third patch which fixes a
potential bug. This is for Andrew's tree since I don't think it will
conflict with any of Jason Gunthorpe's patches for mmu interval
notifiers.

Ralph Campbell (3):
  mm/migrate: remove useless mask of start address
  mm/migrate: clean up some minor coding style
  mm/migrate: add stable check in migrate_vma_insert_page()

 mm/migrate.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

--=20
2.20.1

