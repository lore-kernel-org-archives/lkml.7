Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ABCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0FA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414069;
	bh=Oc1AI/MOGh+muM5Gbr/GXlnWNl13yyGRN/B+0I9xRAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=avipzaCvkDwZPzFn03wJytxLBPaRnm7X5MDx7UPoCUnRdeCLNSZLNjdUNlMjJAURv
	 wSd/atkZ0bOe2h2swJ71W55c08YZHlS7c5RghKOBbV//mdI0jHbMsl+/cMrzALicsA
	 myA8Jvbl/bKL7MKqmkdRMZdEKYx5W2N7uP/Szi+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCLRMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfCLRMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:03 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5434F214AE;
        Tue, 12 Mar 2019 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410722;
        bh=Oc1AI/MOGh+muM5Gbr/GXlnWNl13yyGRN/B+0I9xRAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Elvo+jpih8X3KWrIwJRK4CmPay4rvPIVFtOUlcQA7JKbCvnQ2hKp8wqcPnN212rHJ
         lQLRO2KmwkhmRDWMqtRKSBIjrj520fHwjv5zmCy5ndzQ1wq0tcJPuh1LfjIyHOt7VF
         +9QdpwHejCNPUKg99WtopcnZaDvlr7d8McTzvf+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 021/171] RDMA/umem: Add missing initialization of owning_mm
Date:   Tue, 12 Mar 2019 10:06:41 -0700
Message-Id: <20190312170349.769129057@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a2093dd35f8cfb28dd7c878ccbd020c1bb20d0d7 ]

When allocating a umem leaf for implicit ODP MR during page fault the
field owning_mm was not set.

Initialize and take a reference on this field to avoid kernel panic when
trying to access this field.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
 PGD 800000022dfed067 P4D 800000022dfed067 PUD 22dfcf067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 0 PID: 634 Comm: kworker/u33:0 Not tainted 4.20.0-rc6+ #89
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action [mlx5_ib]
 RIP: 0010:ib_umem_odp_map_dma_pages+0xf3/0x710 [ib_core]
 Code: 45 c0 48 21 f3 48 89 75 b0 31 f6 4a 8d 04 33 48 89 45 a8 49 8b 44 24 60 48 8b 78 10 e8 66 16 a8 c5 49 8b 54 24 08 48 89 45 98 <8b> 42 58 85 c0 0f 84 8e 05 00 00 8d 48 01 48 8d 72 58 f0 0f b1 4a
 RSP: 0000:ffffb610813a7c20 EFLAGS: 00010202
 RAX: ffff95ace6e8ac80 RBX: 0000000000000000 RCX: 000000000000000c
 RDX: 0000000000000000 RSI: 0000000000000850 RDI: ffff95aceaadae80
 RBP: ffffb610813a7ce0 R08: 0000000000000000 R09: 0000000000080c77
 R10: ffff95acfffdbd00 R11: 0000000000000000 R12: ffff95aceaa20a00
 R13: 0000000000001000 R14: 0000000000001000 R15: 000000000000000c
 FS:  0000000000000000(0000) GS:ffff95acf7800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000058 CR3: 000000022c834001 CR4: 00000000001606f0
 Call Trace:
  pagefault_single_data_segment+0x1df/0xc60 [mlx5_ib]
  mlx5_ib_eqe_pf_action+0x7bc/0xa70 [mlx5_ib]
  ? __switch_to+0xe1/0x470
  process_one_work+0x174/0x390
  worker_thread+0x4f/0x3e0
  kthread+0x102/0x140
  ? drain_workqueue+0x130/0x130
  ? kthread_stop+0x110/0x110
  ret_from_fork+0x1f/0x30

Fixes: f27a0d50a4bc ("RDMA/umem: Use umem->owning_mm inside ODP")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_odp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 676c1fd1119d..7ef385db52c3 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -356,6 +356,8 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_ucontext_per_mm *per_mm,
 	umem->writable   = 1;
 	umem->is_odp = 1;
 	odp_data->per_mm = per_mm;
+	umem->owning_mm  = per_mm->mm;
+	mmgrab(umem->owning_mm);
 
 	mutex_init(&odp_data->umem_mutex);
 	init_completion(&odp_data->notifier_completion);
@@ -388,6 +390,7 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_ucontext_per_mm *per_mm,
 out_page_list:
 	vfree(odp_data->page_list);
 out_odp_data:
+	mmdrop(umem->owning_mm);
 	kfree(odp_data);
 	return ERR_PTR(ret);
 }
-- 
2.19.1



