Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F9C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B0620880
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431107;
	bh=lEY/zFf0tyWfGy/nxIHf5jfmXXYqHFoUkKhKAbPKaZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/2+g7CIsStSoFHGfVx/C10rkjiuWyy4xD4RheW1f93Rxh/cwwDVH92ShdrrHPR0N
	 O7LU9j5z8MWoIV/knRHFID0FGYyfWlSJ/CGeOIr5XhSZyvYHC9HUdp6bAWniuZ52pK
	 AvEmDE7OFKAbEugTSfJ8Fhcl08UpHmGaIKphy7DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAGVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgAGVEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22524214D8;
        Tue,  7 Jan 2020 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431092;
        bh=lEY/zFf0tyWfGy/nxIHf5jfmXXYqHFoUkKhKAbPKaZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCVKnuExa+0qclsvjjcPuQHCZYAMbAYch5Ju52+FzNhhyHDfMoo/I9xaHNjAj2yfL
         aSL86NkrOOspzWQII3cIlniv5HuhshKkGYtHEupVauTImNgFvTTAali7Hrd3ivvEkw
         2AgAagO1FSHuZBGa9rq1eMFAOuZ9ekonl0Wb9tIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/115] IB/mlx4: Follow mirror sequence of device add during device removal
Date:   Tue,  7 Jan 2020 21:54:00 +0100
Message-Id: <20200107205301.127959222@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 89f988d93c62384758b19323c886db917a80c371 ]

Current code device add sequence is:

ib_register_device()
ib_mad_init()
init_sriov_init()
register_netdev_notifier()

Therefore, the remove sequence should be,

unregister_netdev_notifier()
close_sriov()
mad_cleanup()
ib_unregister_device()

However it is not above.
Hence, make do above remove sequence.

Fixes: fa417f7b520ee ("IB/mlx4: Add support for IBoE")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Link: https://lore.kernel.org/r/20191212091214.315005-3-leon@kernel.org
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 0bbeaaae47e0..9386bb57b3d7 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3069,16 +3069,17 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
 	ibdev->ib_active = false;
 	flush_workqueue(wq);
 
-	mlx4_ib_close_sriov(ibdev);
-	mlx4_ib_mad_cleanup(ibdev);
-	ib_unregister_device(&ibdev->ib_dev);
-	mlx4_ib_diag_cleanup(ibdev);
 	if (ibdev->iboe.nb.notifier_call) {
 		if (unregister_netdevice_notifier(&ibdev->iboe.nb))
 			pr_warn("failure unregistering notifier\n");
 		ibdev->iboe.nb.notifier_call = NULL;
 	}
 
+	mlx4_ib_close_sriov(ibdev);
+	mlx4_ib_mad_cleanup(ibdev);
+	ib_unregister_device(&ibdev->ib_dev);
+	mlx4_ib_diag_cleanup(ibdev);
+
 	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
 			      ibdev->steer_qpn_count);
 	kfree(ibdev->ib_uc_qpns_bitmap);
-- 
2.20.1



