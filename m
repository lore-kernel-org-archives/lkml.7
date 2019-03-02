Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD59C00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAAF2087E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 20:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4YA8t1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfCBUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:25:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43363 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCBUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 15:25:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so564013pfh.10;
        Sat, 02 Mar 2019 12:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAstCI9WUM1BZ9yvnnEDKypv2TcIjD9mYfs4G8Ype8w=;
        b=I4YA8t1jCSWhFsenJgtBcCq+YIK854Gn2iZM/3QvyIQ8jwaWEXMMZcPJCMJVs343gx
         yZOVlKsKSAuBMEPjk9YCPKmH2TRHvXMnQs86Bvv0ZjonZkhqInGempHqSf3gfsfNNkTH
         yVdOkkDtUi6yWsbvZ1eb5CTbjlKGg5GGGnm+BwYNoEK9qgzKg6raz/7uF+ssV4r78bXf
         5la40mAOZgljqBewBIGp6QCI1W8jG706RIWwxckVC/jNfrwLM0F75aQIvANTCuaigVF+
         I2wwSPXhdklyI1r0Mc2yZ3mOxXrAY5738QRX6JlPQ2Suf5whh9c44IEe/lFiAhd8xU0I
         dcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAstCI9WUM1BZ9yvnnEDKypv2TcIjD9mYfs4G8Ype8w=;
        b=EEII6LkBcTkdBpNothNAoAyVwnRKUYiiy3eQZYrZ9wfWk+/GZT9ZPCbZ//ti8qcdta
         xrVWoS/TcHJdufU7Lo5X8Pl1stV9PMSGBrxQTHyzqx0iFasuPbR0RVOKlFUZhdCnECkQ
         qeft9b6PnfhyJouHGyMSbTRYfR5FShvlG/fskJvxI0K6tgBxkUZ42Q74wtfmEEtRgSau
         NBkqYPHTvL0MKkAh5Hkx1+5JaNPDKBT4YxgvOSEC93T+lywy/v439NPjOgxeVo6tx6RJ
         3idKLhSVmWT50vsqFGUosOfHUXPazD3mmBBBjuI15VzUgSUoC4X4x+j0LJBJDXXJqT6v
         g1Cw==
X-Gm-Message-State: APjAAAWOlezYf0mC0+d5K30vM4KSBoaAra/bmjeIN0CZAO36NgNpPXiZ
        WrHQ7WgFJH9Iz5x+B/FIzDU=
X-Google-Smtp-Source: APXvYqwwXbu391RmebamDrgmsn+pVrn+KR8N08pQ8ggt54fsIW+jDiM/bzSALjIO1rvNX1hosvu2RA==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr10935545pgi.135.1551558319010;
        Sat, 02 Mar 2019 12:25:19 -0800 (PST)
Received: from sandstorm.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id p11sm6045568pfi.10.2019.03.02.12.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 12:25:18 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling paths
Date:   Sat,  2 Mar 2019 12:24:35 -0800
Message-Id: <20190302202435.31889-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190302032726.11769-2-jhubbard@nvidia.com>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

1. Bug fix: the error handling release pages starting
at the first page that experienced an error.

2. Refinement: release_pages() is better than put_page()
in a loop.

3. Dead code removal: the check for (user_virt & ~page_mask)
is checking for a condition that can never happen,
because earlier:

    user_virt = user_virt & page_mask;

...so, remove that entire phrase.

4. Minor: As long as I'm here, shorten up a couple of long lines
in the same function, without harming the ability to
grep for the printed error message.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

v2: Fixes a kbuild test robot reported build failure, by directly
    including pagemap.h

 drivers/infiniband/core/umem_odp.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index acb882f279cb..83872c1f3f2c 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -40,6 +40,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/pagemap.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_umem.h>
@@ -648,25 +649,17 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 
 		if (npages < 0) {
 			if (npages != -EAGAIN)
-				pr_warn("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
+				pr_warn("fail to get %zu user pages with error %d\n",
+					gup_num_pages, npages);
 			else
-				pr_debug("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
+				pr_debug("fail to get %zu user pages with error %d\n",
+					 gup_num_pages, npages);
 			break;
 		}
 
 		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
 		mutex_lock(&umem_odp->umem_mutex);
 		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
-			if (user_virt & ~page_mask) {
-				p += PAGE_SIZE;
-				if (page_to_phys(local_page_list[j]) != p) {
-					ret = -EFAULT;
-					break;
-				}
-				put_page(local_page_list[j]);
-				continue;
-			}
-
 			ret = ib_umem_odp_map_dma_single_page(
 					umem_odp, k, local_page_list[j],
 					access_mask, current_seq);
@@ -684,9 +677,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
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

