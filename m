Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98762213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TykP1apy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCSVmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:42:50 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:42792 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCSVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:42:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4FF2ACDE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wgVUtEURjOz2 for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 16:42:48 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1F63FCAF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:42:48 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id k5so132838ioh.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V5vdRUOMTzyVp4ECrS0AB5gyBJ7sCUPHuwXXx+dSqDo=;
        b=TykP1apyox9zAtmDdTXPECynaDG5eASTOCQTnvnSFH6sPpbdsE4VhBervN1poV2UQm
         o115hKiwpoeExx/hYRK6h3Bg8E+B37B3F1Nhz7bXUYRIOreO+Q6DP2C7BqBWSDdPKevj
         248qKO0L4zxnpsj92yBC3l0ILr6pdJqaudvNq39pi8nTTQH3qeag1PFE2NoclaRUfbcK
         GoNnNRnk+31aITJHWo++7igvE/E0PHZCBM6ckmNxmWniXBiLn7XRedFQ/E9OOVZZwMrT
         rH3Zg1YSFuuL+52Ad3tnYnUEPdlaSo7UkSPImbQ2FViGDuP0dK7+96Pzv+50Dy1/Xn8v
         Hntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V5vdRUOMTzyVp4ECrS0AB5gyBJ7sCUPHuwXXx+dSqDo=;
        b=OG2MuCYb58XuZipa3OJbfdDmExlroU8mlLpE29T1PEWMDNN//zpo7bBzVdprUpU0Ic
         fm+2ftB+KUx6B2z4GEthEI1CceGJFdCl1CIBAEhSdLDApxqoe9vIS8T/91wf00v6Bcvo
         trGIekNiYU+f2pI1pNvSGIYFoslxHt/DX0+krJrHI3ZWW30jwEt8wAzGIbrUEJsLfZsJ
         WzNtjqGGgci2Qefk9Si7jIQKPwCmWdTsqY3q5cHE0J0uJO9Ukx8NK99ah6d6QU132N5a
         noZ971lHSCmvtHRTMjlXKSnDZ50+tMZukbpboe2K5LzbB2lkoRvQAtwOUBl2TaQslWey
         vmYQ==
X-Gm-Message-State: APjAAAVIIq1ykW/HLP34RLUAaOKxC49XeNRMD/dinonzmNmVkmUST9cs
        m/B390BNW6k4Q3Dt16dnoji/uabYsHC8oe1Jds69tFPJgl640XO+uX/Ty/ssJinAZ3IHDRxEFiQ
        C5nMgPr1r4kQAdcmH+uoDPeh0Wl5z
X-Received: by 2002:a24:7908:: with SMTP id z8mr3012329itc.16.1553031767786;
        Tue, 19 Mar 2019 14:42:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytLDfBw66AbJUy5GqZFHF/b2HfAyebvOM5JpUohVLeZNvvyrNPigDNI8oGi9hRdBDA170XCA==
X-Received: by 2002:a24:7908:: with SMTP id z8mr3012318itc.16.1553031767566;
        Tue, 19 Mar 2019 14:42:47 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i14sm132892itc.34.2019.03.19.14.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:42:46 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Date:   Tue, 19 Mar 2019 16:42:40 -0500
Message-Id: <20190319214244.20212-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_find() can return a NULL value to 'flow' which is used without a
check. The patch adds a check to avoid potential NULL pointer dereference.

In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
using kzalloc.

Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
---
v3: Reorder buf allocations and flow check.
v2: failure to return in case of flow failure.
v1: Failed to free buf in case of flow failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
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
2.17.1

