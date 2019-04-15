Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C8C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA52073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355734;
	bh=rVewmkx04ahBSpKUTuBEDDoDQ+WPXAPGgGJbxNjoKaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1JH4tmNRhRkGaCo/nwdqt8ZpOtbMR18ES1gdjWhi6HcBlqmnWZWvO7BwGV4VgXUYB
	 7cWlyl08bQCjkjSsP+eOLa2w6ymM6SCQv/8kDbD+W2ELRwPs6J9EYfBMVWlSrRKa46
	 tQQdjhYasLfBgY3bGQWANlUbSjg5SHZYCC3/Py5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfDOTOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbfDOTN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7712075B;
        Mon, 15 Apr 2019 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355637;
        bh=rVewmkx04ahBSpKUTuBEDDoDQ+WPXAPGgGJbxNjoKaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9WbrbZYLzzlFLJD/zanlKYtkgHGihKwnFB4nBVCm0LpDH5E0t6entiOc8leX0u9P
         B3/2iPoG403mI4QrAr5QCK/UGWKfxVtK5rsmj5UMsdRapa+0xgNshqiZtzKRwwfWOD
         ulRj6SyJdmXavXvLSKTcCJ/VaIPwQcjWlfxHrnuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 096/117] IB/mlx5: Reset access mask when looping inside page fault handler
Date:   Mon, 15 Apr 2019 21:01:06 +0200
Message-Id: <20190415183749.707841279@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

commit 1abe186ed8a6593069bc122da55fc684383fdc1c upstream.

If page-fault handler spans multiple MRs then the access mask needs to
be reset before each MR handling or otherwise write access will be
granted to mapped pages instead of read-only.

Cc: <stable@vger.kernel.org> # 3.19
Fixes: 7bdf65d411c1 ("IB/mlx5: Handle page faults")
Reported-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/odp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -560,7 +560,7 @@ static int pagefault_mr(struct mlx5_ib_d
 	struct ib_umem_odp *odp_mr = to_ib_umem_odp(mr->umem);
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
 	bool prefetch = flags & MLX5_PF_FLAGS_PREFETCH;
-	u64 access_mask = ODP_READ_ALLOWED_BIT;
+	u64 access_mask;
 	u64 start_idx, page_mask;
 	struct ib_umem_odp *odp;
 	size_t size;
@@ -582,6 +582,7 @@ next_mr:
 	page_shift = mr->umem->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
+	access_mask = ODP_READ_ALLOWED_BIT;
 
 	if (prefetch && !downgrade && !mr->umem->writable) {
 		/* prefetch with write-access must


