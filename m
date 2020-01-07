Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5759D2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432356;
	bh=3jIM06pqXH85l3EYy8aFBlykGlLXVSm4DTRFl+qGYFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DX9LDUHf2ISCaes/6Gtg2uZUoSmRbhgtdGHbMtYOoc325DY/YUKL6sV8YO79gR2Qp
	 2fsGhQtHfEe9sH5Aq1FIZwe71KkfQFFWC5TReRvZPnjUYh3DI47usHtv9jgprDSY0r
	 ITG0sLd1ePU8E5vILb6q4dTkYrpZxkOv4c5goxUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgAGU7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgAGU7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEC021744;
        Tue,  7 Jan 2020 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430758;
        bh=3jIM06pqXH85l3EYy8aFBlykGlLXVSm4DTRFl+qGYFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrIGr/dTgzN2hswKwQJ7SzjlX55hxahJ1YmzJJV8o7XpkGtRFx5pRFLwGT5TQ1WIl
         21iI1k9bvMN6JrTcADpm7d33vjhtGICYdHSXhVqzpFzql9G49SQE7pzJMDQ/JO9Arv
         oLlG3np/A0w1Jipm8Unr2Z5A2aqzT+VNrQbMlnqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 048/191] IB/mlx4: Follow mirror sequence of device add during device removal
Date:   Tue,  7 Jan 2020 21:52:48 +0100
Message-Id: <20200107205335.565991846@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
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
index 8d2f1e38b891..907d99822bf0 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3008,16 +3008,17 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
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



