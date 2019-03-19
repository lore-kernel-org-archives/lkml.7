Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686472085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YhMPNTI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfCSPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:55:31 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44038 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:55:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id BD88DCF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dXiBHsRaUFqI for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 10:55:29 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 63518CDE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:55:29 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id z6so16052666ioh.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B1QWfeXYOX77KfMW/kAokzeu80UhNz+WjOFEKWzCLx8=;
        b=YhMPNTI4nsTmhGrb/SqkRcW/ergOzpf35r33GQjEkHH463SZcpWdg98CoM3mmiZyRJ
         yn+2OcdbfdR0zOO6mym2zMmlLF7ImYPNRNzhGo0tg4H5zzNUi7rAjH4rP3ok4XdyeAG+
         bDbtDbTj3q1A3vd1BagbgxEqxgE+6pICuuRLCxVgGxSkwkNA/aF64KiuNa/bavi/CWNm
         T/xzdg+P1eY9yJaG3cglVe2Q1J9EqMi6JPiMzkQBVE7rNpszEQ9d365ciRPjFtBjjePj
         F/bq4wQTdgga7I3gxK/YwDqvt3m+WdEYI14MlyvZpJ50Ls+8nNMmc1dGzqStBVYenkyq
         PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1QWfeXYOX77KfMW/kAokzeu80UhNz+WjOFEKWzCLx8=;
        b=NpPY9f4YHBZPsooKh7FP+DwYStFAy6Hm+PtgPqy5KsRw8ate4YiCRncyIbC4vcGeqG
         swAjk9rPdw7uqEfycMLoEJVgifIwm6KvWJRj/5ZXJeEP7+ufIranIPWhmZidHXo7QUfv
         uxPlQQh2hpjzn4zcoP4G9Cg/qWyIptkufNfIR9LFbm8PLaCw1uARx3a47yFRGEIZWL4D
         1rKTlPpJg+kvWR/fZPILurjxdg0P1SJ6AAOqUeFE80Dp7FUocY7/F9T1kB0lE5JPOxfX
         ytCUryhfp+5iiJJYT5vOG/cYYdoe5GGSQC6GARnionIhyKsOtXLNvcXhcZTyUTMBfPOh
         ZzmA==
X-Gm-Message-State: APjAAAWhH0oTdPdsvWfsN4ci4BPi+nAxoU2PC7fXb1pGCNfyuGbCexyw
        XgLI1zkA0LEhhzk8CajfIZyMARZACOFc56sEfMGPTwpQSvofLQ/MnpgwKUczApERERBS2uiQF1+
        WplZ1uIa73WXxb0R4i/dU3C7SSRL1
X-Received: by 2002:a6b:6b1a:: with SMTP id g26mr1968403ioc.211.1553010929050;
        Tue, 19 Mar 2019 08:55:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyydj0F7FjgYooEasAGDRHy9aG3wyUnhGKY5M5oy0g7647fCPLa5mYeBN6okyAIUxbB3k6hDQ==
X-Received: by 2002:a6b:6b1a:: with SMTP id g26mr1968382ioc.211.1553010928884;
        Tue, 19 Mar 2019 08:55:28 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id k2sm6187954ion.11.2019.03.19.08.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 08:55:28 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: mlx5: Add a missing check on idr_find, free buf
Date:   Tue, 19 Mar 2019 10:55:20 -0500
Message-Id: <20190319155524.6978-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_find() can return a NULL value to 'flow' which is used without a check.
The patch adds a check to avoid potential NULL pointer dereference.
In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
using kzalloc.

---
v2: failure to return in case of flow failure.
v1: Failed to free buf in case of flow failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 5cf5f2a9d51f..224e0d7f6489 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -226,6 +226,11 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	rcu_read_lock();
 	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
 	rcu_read_unlock();
+	if (!flow) {
+		WARN_ONCE(1, "Received NULL pointer for handle\n");
+		kfree(buf);
+		return -EINVAL;
+	}
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
 
 	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
@@ -238,6 +243,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	buf->complete = mlx_tls_kfree_complete;
 
 	ret = mlx5_fpga_sbu_conn_sendmsg(mdev->fpga->tls->conn, buf);
+	if (ret < 0)
+		kfree(buf);
 
 	return ret;
 }
-- 
2.17.1

