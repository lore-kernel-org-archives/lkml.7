Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D1BC46460
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C312173C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KhdjRbMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEFXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:30:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15239 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:30:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd0c3880000>; Mon, 06 May 2019 16:30:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 16:30:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 May 2019 16:30:50 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 23:30:50 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] mm/hmm: Use mm_get_hmm() in hmm_range_register()
Date:   Mon, 6 May 2019 16:29:40 -0700
Message-ID: <20190506232942.12623-4-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506232942.12623-1-rcampbell@nvidia.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557185416; bh=5WlIjBgfvDyvCsXkm0NjNZ11WXFUwiQ4B+j31tyLuKg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         X-Originating-IP:X-ClientProxiedBy:Content-Transfer-Encoding:
         Content-Type;
        b=KhdjRbMYg4rMUz7KfK9xJEDf8RwHRFmHw5yW1h4Jhf0lnVFlVigwpaMNLfTtjfrFx
         FSIoT52YDf6KQSTBJdQfBl0Y1SP60r51yon4cBXYK9TZYAcpO2GqaSkcFKpR3kteJr
         9827Jc7XMXh9Mj3Brr3ZtP217RpbYYz1SQ0Nq9ZoiNGBmos3CU60FFaGS+avEFFpb5
         cMxwubKqGavAbg5bTZ6Ioa2/Ov1aLGeAmVmwfEtyYXUDolypmiKZUxu+hA+nRIz0U8
         jFTgs+iYsHmsF6Cr3/i1vWvMvEF6Q0erFwpi0nglHSYFRtvywldCLt2OpEHi64nDss
         c7GjIKJjQXBCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

In hmm_range_register(), the call to hmm_get_or_create() implies that
hmm_range_register() could be called before hmm_mirror_register() when
in fact, that would violate the HMM API.

Use mm_get_hmm() instead of hmm_get_or_create() to get the HMM structure.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f6c4c8633db9..2aa75dbed04a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -936,7 +936,7 @@ int hmm_range_register(struct hmm_range *range,
 	range->start =3D start;
 	range->end =3D end;
=20
-	range->hmm =3D hmm_get_or_create(mm);
+	range->hmm =3D mm_get_hmm(mm);
 	if (!range->hmm)
 		return -EFAULT;
=20
--=20
2.20.1

