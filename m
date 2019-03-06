Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DAC10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvtbdvTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfCFCA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:00:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfCFCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:00:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so7009264pgo.7;
        Tue, 05 Mar 2019 18:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+PN8m2YVa0N7XL/TnONPCDNFSnqtW8ebbB1OmsGckw=;
        b=FvtbdvTgpfHdFkdX+WLO6Xd1lowrxw9s511yqqKq3fjBBj0S+s9nrJ9h1JuplPqGhD
         Rzn2CfpE+zP50Q2jzZG+rYevfwsRK0dYn8jRsyqpDBm/9JodrPtqybI7z5WGggyAZzI6
         v7DcJGIkyCTz4+GA79e8SDbQwv8o3rlAVSmodpCnzqNzwsc+xhPN/RDU9JRfNkdYxGo3
         zSpY5QDQG/yP2ebvnAQyDm5Zk5nSi+ZM7bIg+zmFDByETCdHvcVqLLXop1GAJU5/96/z
         0vmVBEBdtSt+OLE3MVrI6ZvLK+W1NUT6L1dVKWEfSr0IyF1MOfeJCROLVagSt4sOsyel
         MPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+PN8m2YVa0N7XL/TnONPCDNFSnqtW8ebbB1OmsGckw=;
        b=LXGY90dK1Xs4PyAOim0fp4LrQbc1OpMhaHgl/uhrLS63+fzC5IVYS9s55+3DQnszHp
         eslgao/9cRod3nJyA3j3ECrbYLMcSmouTYzGInh0S09ra9d7B7Z19wNMcM+Haa4Z3es7
         0ynbv3ELlAmuLWog10FFNdTR4V2xhCFhtgMrzUs+DFDm33fv5MbNSOZ4zNjCm0SE8ZIk
         OGeXyRX+JwXox8QFUKGp05+DrrdWs5VTXR90HLtP5DZj1CMDePpGtvzUZGCIcrlbAC2u
         gGt+2ZfEoog72BiVBL8awQ0+tjTclhbAy1ci+Gy2mavthPm9HnWZkyvVm2DxnOUvz9s8
         bQ/g==
X-Gm-Message-State: APjAAAU+VfxFWOxZLxynWXUASxRpuJ5cmR2joX06giv7yX6vC4Aiv8j1
        0xFAoj9C3Fb53D+fb/o6/5g=
X-Google-Smtp-Source: APXvYqzoNlzJO9Bizk5jNh2RcZ/nitsPFjEhzbR/xZKiQYe4ghH7GVIM8KSBW/LjKo7U87AhO2EeeA==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr4128904pgv.244.1551837626253;
        Tue, 05 Mar 2019 18:00:26 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c10sm396882pfo.19.2019.03.05.18.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 18:00:25 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/umem: updated bug fix in error handling path
Date:   Tue,  5 Mar 2019 18:00:22 -0800
Message-Id: <20190306020022.21828-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

The previous attempted bug fix overlooked the fact that
ib_umem_odp_map_dma_single_page() was doing a put_page()
upon hitting an error. So there was not really a bug there.

Therefore, this reverts the off-by-one change, but
keeps the change to use release_pages() in the error path.

Fixes: commit xxxxxxxxxxxx ("RDMA/umem: minor bug fix in error handling path")
Suggested-by: Artemy Kovalyov <artemyko@mellanox.com>

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
index d45735b02e07..c9cafaa080e7 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -686,10 +686,13 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 
 		if (ret < 0) {
 			/*
-			 * Release pages, starting at the the first page
-			 * that experienced an error.
+			 * Release pages, remembering that the first page
+			 * to hit an error was already released by
+			 * ib_umem_odp_map_dma_single_page().
 			 */
-			release_pages(&local_page_list[j], npages - j);
+			if (npages - (j + 1) > 0)
+				release_pages(&local_page_list[j+1],
+					      npages - (j + 1));
 			break;
 		}
 	}
-- 
2.21.0

