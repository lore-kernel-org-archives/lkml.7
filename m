Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mRApKRn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCSPq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:46:26 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:56958 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfCSPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:46:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 0DCD9C72
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IjKPTtztzb5P for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 10:46:20 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id C8385BD3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:46:20 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id m70so4138085ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MekAe9CILrGQzmYPhd+9JNOlm+z9QLwaY/ziY8uJYWo=;
        b=mRApKRn39wkTElkjVWcmR1X98kEQbJQrTJLemjf/cNaYi0z4uiLwRjY8JkzPi2OYGt
         NXwZ8bR61WnJeUvgR6jbA9H6yDGGgmP4Zqmre4yf0fPwCY7b1ZpRGdB3u0heenVlOUl3
         fUIBRwQ36LRhYsmCAaNqbnLd2zF1mCVsQyQ2vVXO9mFdVEqBB5RIsjQ5MlLoofDTsJas
         mOchAm4DC9Qo8NbCcLxBDNHMzdzTQAh1YQbwXBAcr9Do/UppJtohHlkYbDUOetcGf3Ki
         vizNkPr4VGbiq2IEdFhzg3gIEBxx56uReT8jjgF08hD7Ox3rHmcx/ZloauWkFBaxW34a
         EbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MekAe9CILrGQzmYPhd+9JNOlm+z9QLwaY/ziY8uJYWo=;
        b=ZB2CMRonRVtX7xT/e/jJ0oCdQ3m6lAVA6HD4pvWCalVaxwOoGfu0/OOohHZCwZ2V2T
         ki4ii2lZtm26j9laYvkZpqXY6IzrJiOC/I5bc5Q+en5pLZ4iYTZvsw5px+XmGzk3S4MZ
         ABEDXFo0wa+0WWtWyiLwLqN5ZZ9PS0b6rYP7uph++hrw7rAdaNVENEAz3nuGfiF02+/u
         JYQxX4rOriZbYg+7T5LM6Xf6a6QX/MTlRkKu5b4ikh8ASDT7+TfDj2wcWzxrLIH0COYh
         +1BVisqQ3fVduvNJb27GQgqLgWYp9OlA0/aL8300vrbd9LMcn/MMKU9L2vLYtrNnzj4C
         q23Q==
X-Gm-Message-State: APjAAAWTYqSacUSgNfVxQyFDXvajsaXbvbipE+yU5OPLb7puWb85dH2w
        dVxGESaQQnebs0dfgzribuz/JDHw3urtTgrN6KpZwxSkFOZ/mDBtu06LxO1Oy0txUVr4LyQDe5j
        oqctU9k61KtPp0PePIR30EBDcMbi5
X-Received: by 2002:a5d:8893:: with SMTP id d19mr1857933ioo.277.1553010380449;
        Tue, 19 Mar 2019 08:46:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyK1HdoThl4ep9ZvcDhitSF4pWoc14cJiQdLTb2CErZWKX9mH9oGQjjxP+6bZ+BeOfxuaKTtw==
X-Received: by 2002:a5d:8893:: with SMTP id d19mr1857904ioo.277.1553010380122;
        Tue, 19 Mar 2019 08:46:20 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id t74sm1846829itt.29.2019.03.19.08.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 08:46:19 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: mlx5: Add a missing check on idr_find, free buf
Date:   Tue, 19 Mar 2019 10:46:06 -0500
Message-Id: <20190319154611.6615-1-pakki001@umn.edu>
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
v1: Failed to free buf in case of flow failure.
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 5cf5f2a9d51f..1b4e4cb1c082 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -226,6 +226,10 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	rcu_read_lock();
 	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
 	rcu_read_unlock();
+	if (!flow) {
+		WARN_ONCE(1, "Received NULL pointer for handle\n");
+		kfree(buf);
+	}
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
 
 	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
@@ -238,6 +242,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	buf->complete = mlx_tls_kfree_complete;
 
 	ret = mlx5_fpga_sbu_conn_sendmsg(mdev->fpga->tls->conn, buf);
+	if (ret < 0)
+		kfree(buf);
 
 	return ret;
 }
-- 
2.17.1

