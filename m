Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF906C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FE420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECnGDtm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCDTqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:46:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35631 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:46:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so3763958pfa.2;
        Mon, 04 Mar 2019 11:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWPRKNbSliuixUwjxdom69EEKs5phLvSHf5FsoV2aEo=;
        b=ECnGDtm9cT/1TS0hga7uq1dImBkB33/g5+7V1GOXCCs/Yt+K4CqbeFR0maB0yAWfmx
         OGvTGBlvqHzJdo6kne4anwU3a0JczgPqPNgOg4gKDfmhFFUEotESymMSQyJfbg/UfTSf
         l4cOObIj/5hvWKYLS/pAibqGoIYL6rOWMBzGChGZFVuHr5J78wmzDeIuY3fkm/t0zpIp
         GHIq22p2TtNsZcxskMnXP2L2Nc9gATr4p0vzqKwE8TZIATUO1JvW7CLGDNLGCfBgERbk
         n33OEotkzz2iw8dZTCUYkkj4teFKAtTlwwGsjg376QodkL9GxL0Sn2xcoMBaCWcVF4GQ
         NYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWPRKNbSliuixUwjxdom69EEKs5phLvSHf5FsoV2aEo=;
        b=sURSKY4yJCQUnHQpuJT/71lf/ku+bT5lWzxNsh+/96FI5HRVGeOqSa06sN0GxnNTtH
         iwuAelbp2mKpjBhagNqSIYJfMuTA2mwhfd0I88CUa8bUOVOJRO+h5k9eGHRV2pgkvhWr
         X43OhaJ4Jfr2yY93SIGhvnMdwXI67YoHSQxccA0YgfOxsWLM83sp29A7RgOuCTBaOwEu
         dTUYUqA6eaVsdccTOj5NQBlbuyfsYugSxaW9An8iR3O6L/r9QCYc9X+wHELG91B8m2Ur
         2+NNsHNve88o8TfzRgPz62AsYX97TKhNlw2J07Q16LdaivQHytkFpc6ZJKNFUTvgF4a/
         6IPA==
X-Gm-Message-State: AHQUAuY8dNJ2NjWqMAk54w4r/S75nJ+YoVuuOKOaFRyaDjZs+qxvH+2J
        7dOMjwDAO0p8mvSnyVW5szM=
X-Google-Smtp-Source: AHgI3IZSNVVgZkq3mua2IfnTVSH5c4pymivIQDquRL4FBmKmT/1O2mVsk1WF6COcf+CmMvOOA6e+aQ==
X-Received: by 2002:a62:41cc:: with SMTP id g73mr21187821pfd.145.1551728811727;
        Mon, 04 Mar 2019 11:46:51 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v15sm13499604pfa.75.2019.03.04.11.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 11:46:51 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH v3] RDMA/umem: minor bug fix in error handling path
Date:   Mon,  4 Mar 2019 11:46:45 -0800
Message-Id: <20190304194645.10422-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304194645.10422-1-jhubbard@nvidia.com>
References: <20190304194645.10422-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

1. Bug fix: fix an off by one error in the code that
cleans up if it fails to dma-map a page, after having
done a get_user_pages_remote() on a range of pages.

2. Refinement: for that same cleanup code, release_pages()
is better than put_page() in a loop.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index acb882f279cb..d45735b02e07 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -40,6 +40,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/pagemap.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_umem.h>
@@ -684,9 +685,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 		mutex_unlock(&umem_odp->umem_mutex);
 
 		if (ret < 0) {
-			/* Release left over pages when handling errors. */
-			for (++j; j < npages; ++j)
-				put_page(local_page_list[j]);
+			/*
+			 * Release pages, starting at the the first page
+			 * that experienced an error.
+			 */
+			release_pages(&local_page_list[j], npages - j);
 			break;
 		}
 	}
-- 
2.21.0

