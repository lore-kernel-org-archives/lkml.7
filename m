Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB21C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D9E2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011158;
	bh=5Fvmeto4Q4TETBnbb6tYOnCTlGCuLXZav0d5e9FSikw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVSHH6eruFNfTuig137Aqsr8bCRybFoB4Jw3FBz6Xd5Gs75K1VMxAl/qWFV/x0koY
	 z7GRLXcIQ0BPsapPisdXF4IL9xFLuN/rXTZsj29PsIbHEqYW/BE64TE5F91slw6kwg
	 8uRciXeuO/Tkxyz1d9TgpvYB+lRKbYyGeEZoxkus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfHENTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfHENTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:19:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CBF2067D;
        Mon,  5 Aug 2019 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011155;
        bh=5Fvmeto4Q4TETBnbb6tYOnCTlGCuLXZav0d5e9FSikw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkkyQQ8jR1O/Zwcy9B+3vhyvjawAwIxoMhewmFiuIlg8W7cAFOyAX6xIs+J7TmhqS
         U3h8VL5B+gkNtxsgi+KFMwpGRIk+cB/wevUHQfde3fdkhVnLRVkGakLuci79sGcQi/
         ofhBsL/HOOIA8HVJHRl0WkOwEYvv8M8dkyMIXhUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 65/74] IB/mlx5: Fix clean_mr() to work in the expected order
Date:   Mon,  5 Aug 2019 15:03:18 +0200
Message-Id: <20190805124941.066916939@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

commit b9332dad987018745a0c0bb718d12dacfa760489 upstream.

Any dma map underlying the MR should only be freed once the MR is fenced
at the hardware.

As of the above we first destroy the MKEY and just after that can safely
call to dma_unmap_single().

Link: https://lore.kernel.org/r/20190723065733.4899-6-leon@kernel.org
Cc: <stable@vger.kernel.org> # 4.3
Fixes: 8a187ee52b04 ("IB/mlx5: Support the new memory registration API")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1620,10 +1620,10 @@ static void clean_mr(struct mlx5_ib_dev
 		mr->sig = NULL;
 	}
 
-	mlx5_free_priv_descs(mr);
-
-	if (!allocated_from_cache)
+	if (!allocated_from_cache) {
 		destroy_mkey(dev, mr);
+		mlx5_free_priv_descs(mr);
+	}
 }
 
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)


