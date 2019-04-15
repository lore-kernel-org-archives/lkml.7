Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355215;
	bh=hOsCECJ07xbXv10S38bu15xNKvNguZNDQuM2QRopsNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tCujdFHthBUqsTiILtQsjNGDAZIxVWOLdCNF5jsOrGQCksdK9fdZsCdaDdWDvvvjQ
	 yH3Q89XL4vBwK+wXz4yQ2Y7Ms6SI2HWjvpS45HaEgmEEXWrwFc4spbVBwVuhIIcKtu
	 aeRfzeq2yJ5un3mnuVk6LIamaKB6Yz+BjWGOeVNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfDOTGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbfDOTGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9218B20880;
        Mon, 15 Apr 2019 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355209;
        bh=hOsCECJ07xbXv10S38bu15xNKvNguZNDQuM2QRopsNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBf9ifBm/V7BhgCYdYS8pxoiWiR6YLVh/i1VWnZ3I6wUfciQGDG65p07ewmpi5y5n
         w1hvjpwYiwGLlSCrrEgEOygvDXd1cauciF6guYwk4QxtxnHzF4MnfhpZnu2dJi4hm+
         53VoMeSjwTXl2XP8Vu6xrxh+PAdwyBBKplueF1uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/101] net: mlx5: Add a missing check on idr_find, free buf
Date:   Mon, 15 Apr 2019 20:58:32 +0200
Message-Id: <20190415183742.266383913@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8e949363f017e2011464812a714fb29710fb95b4 ]

idr_find() can return a NULL value to 'flow' which is used without a
check. The patch adds a check to avoid potential NULL pointer dereference.

In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
using kzalloc.

Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 5cf5f2a9d51f..8de64e88c670 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -217,15 +217,21 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	void *cmd;
 	int ret;
 
+	rcu_read_lock();
+	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
+	rcu_read_unlock();
+
+	if (!flow) {
+		WARN_ONCE(1, "Received NULL pointer for handle\n");
+		return -EINVAL;
+	}
+
 	buf = kzalloc(size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
 	cmd = (buf + 1);
 
-	rcu_read_lock();
-	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
-	rcu_read_unlock();
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
 
 	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
@@ -238,6 +244,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	buf->complete = mlx_tls_kfree_complete;
 
 	ret = mlx5_fpga_sbu_conn_sendmsg(mdev->fpga->tls->conn, buf);
+	if (ret < 0)
+		kfree(buf);
 
 	return ret;
 }
-- 
2.19.1



