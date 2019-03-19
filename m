Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA82077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="HI+uK3Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfCSQYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:24:15 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34666 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfCSQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:24:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 263D0150
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nXEXkEGM6-ES for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 11:24:12 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id F265313D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 11:24:11 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id z6so16142180ioh.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0R6wmKmuCV/v68BfRZs1XhLMkHB4bEg8KvGWPZiRy/s=;
        b=HI+uK3Uej3cavH6sZzy2MyPaxX5RirHln3IcweIr6ct1TmoKvd+yW8ppLNgR+IAVVu
         BdPFrIU5K8foCNEBX3Vuaji4ZFpUN0GK4EjXsVoQCGcOp79sWvJSjnWG7bMP3XDEiOt9
         D7ycAQqYICY6eW0teK3/zEP9DXNkw1sAtMHS8clQHujt++EFAfYC6Jz1ChU4k1A29Sgn
         RcinQQGsn0EuyrD8LBHz0iez1WD9PZt2y+ewtuXnjaMwKs6PDU59xRpJkrJ2mVrbZoqO
         VRvwT17JiszwGqsDmwWPHluIJrseArWXrMwsHNda1mdfT51XU75L8WueFO7FERrqMrL8
         vInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0R6wmKmuCV/v68BfRZs1XhLMkHB4bEg8KvGWPZiRy/s=;
        b=gxTUJImbmU8ult1NvQHoYJQFmYo2OOqFoux4AKprnGHh91zf46+D55SqXPAiVQZFGz
         Gzp9+0Nth52hEWgKdLC+Nf75tOH08RMZVRbixlvATIjpZHG1tC6WJ+/9H3sk0qmnWj9F
         MMWkne8MC9pY94pArCZEShnbcFVLkWVGtpA7czYXlWwJRxJ8HPqSrXj5P+7kuV1d78FV
         c7oa73Qy9qRKPdCF/mkEpsWNi5vP9NZdRqg35LmpvWqsvs+UngPldYVSxUDE7dHp/TEd
         DgM9/DKqqWssYuwWY/Xw8AoPyVAivc7whzEvrUx1erT5x2Ey7Ksbz0NncJ7e50laYzcJ
         xVqQ==
X-Gm-Message-State: APjAAAXqwBFzTV3W6Du+CPLJZqhC2ojSTLz3/bptSKUyXlWks6+i+Gz8
        finW9670yoYky2a9suf5L91aaxtQ/hRORyANdq49olWMdC/WCCfTCqZPa5/lXH1zkhEvlri/vCH
        ShBjo1rJRG8mpzZwo9hwU5o7pY0bv
X-Received: by 2002:a24:678f:: with SMTP id u137mr1809098itc.126.1553012650823;
        Tue, 19 Mar 2019 09:24:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqmqST5Gpu2P4/fRa2MSCvyTeZdByPwNeiJoTYBFuO9tlvAXXI4xVRMTOeIh9FnfhrdKQvlQ==
X-Received: by 2002:a24:678f:: with SMTP id u137mr1809082itc.126.1553012650647;
        Tue, 19 Mar 2019 09:24:10 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id p79sm1707330itb.7.2019.03.19.09.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 09:24:09 -0700 (PDT)
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
Date:   Tue, 19 Mar 2019 11:24:02 -0500
Message-Id: <20190319162406.7525-1-pakki001@umn.edu>
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
Fixes: ab412e1dd7db ('net/mlx5: Accel, add TLS rx offload routines')
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

