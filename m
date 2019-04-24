Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8BDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3153C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127283;
	bh=cLZ7lztzulA87sf+3wEBoKC8pACp6BZjerJWJI7YXaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QSYc5qiVdeQAjBJgSSib21hpKYA2tmHbeYvzT/tvBwuyqJe/TwZJ/fiyCzhrtRSSS
	 OPNF8gQIvRUht19Za/p5+UzFqYYAA8XhRQkDL4TDg4vw8uIuMDFFyWZMtw/X/rhJpH
	 2oSdG1RoU5dqLWyDLelbc/9h/cmLehh2BV4hD1Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbfDXRel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391737AbfDXReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:37 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34715218B0;
        Wed, 24 Apr 2019 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127276;
        bh=cLZ7lztzulA87sf+3wEBoKC8pACp6BZjerJWJI7YXaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMROf+n2UtBJY+y+vDh5QrL8sKnyzCNdQN7mFhY4wBkXODgG2O+KBLIMb0DaRwq7X
         jP8xwJd0l4uATdiAFUabcwgf/o+NTbIy1ItKr0GNXYBN8N7GCgTHan7k5j69fPYP6S
         j/ekGWVVpa58GceVxOxw9EYk69eoL7i7n2xePW+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 033/115] net/mlx5: FPGA, tls, hold rcu read lock a bit longer
Date:   Wed, 24 Apr 2019 19:09:29 +0200
Message-Id: <20190424170926.991315576@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 31634bf5dcc418b5b2cacd954394c0c4620db6a2 ]

To avoid use-after-free, hold the rcu read lock until we are done copying
flow data into the command buffer.

Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -217,22 +217,22 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_
 	void *cmd;
 	int ret;
 
-	rcu_read_lock();
-	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
-	rcu_read_unlock();
-
-	if (!flow) {
-		WARN_ONCE(1, "Received NULL pointer for handle\n");
-		return -EINVAL;
-	}
-
 	buf = kzalloc(size, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
 	cmd = (buf + 1);
 
+	rcu_read_lock();
+	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
+	if (unlikely(!flow)) {
+		rcu_read_unlock();
+		WARN_ONCE(1, "Received NULL pointer for handle\n");
+		kfree(buf);
+		return -EINVAL;
+	}
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
+	rcu_read_unlock();
 
 	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
 	MLX5_SET64(tls_cmd, cmd, tls_rcd_sn, be64_to_cpu(rcd_sn));


