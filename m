Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1966CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEF12173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gIIv2Upj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCRWT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:19:29 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33494 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfCRWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:19:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 287EF524
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 22:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id peqDPUFLzLmI for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 17:19:27 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id EE4A6B17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:19:26 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id w11so14639114iom.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hRZ1sYQ0o5RGIzymeAm+tmQiWPzBx0kEDvgHgHiWiAc=;
        b=gIIv2Upjb0iI8ZtBRLute9B7B0Y5xQUhZSE8M16l2DGA6ba8LYAn1SpRkw+q5T7Lwa
         3lt4nXNoW0OTq5HDSzd9RD+OosvU1BSlsfeIJNuFsXudFWyUqw2CXGTJrBHNR/FX2o2a
         witm4VyC/MSpvlsbHZqyPlO1JsGbK4tJkJJ8iluY24gUmQRDiJlowhNLn1zmw5ZjSIbf
         6dm8djA8XNO8IdeOieBZIFSByV28EIFnqSwd4L4dDmERXkWilrIsnH0DtzyQuO13cBa+
         40iddYTvwE3OrQFAuC4Ry3jU0TANTYY2VlXh65/yUJiB16o+9x6uP6tl5SMzXdOoywEl
         d2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRZ1sYQ0o5RGIzymeAm+tmQiWPzBx0kEDvgHgHiWiAc=;
        b=XAYEERtWMnaNAm7bbnh7CqEuXRaFzhlGVYQ3MDYWke/nLXrcDYoAcKd1AxDQZsA9cK
         I6k/OJvChl4K5B6meo3+II6S48Mm4wnV5soGEK5hGouCedBckCTay53WQkaQ3KDV4YJq
         4t7c8JD5wQC1JlOsTWVzKgF6VAiqOej71pppMLSKbTsZrEAXJnh0wz0XCcBalBHmWtCD
         qXOnrJQcogaGWYTbeX8RgcgWyALxUaHrGaE42T8VJXMp7lpnlXgirZUXhIbciP2CbuD6
         vNkloSpFHVz6zlScCzLI563SbFVCJ6TS90BPH9J0gFOBT2jIiypq6sKsybVUoR68LRsq
         D8Bw==
X-Gm-Message-State: APjAAAUHJ6yGrSMiotsn1wMr5V6fxTw7z1IEQluZ5Hg25K4PSO+srN+L
        hWOvbjtFZbUObiDoTgb3bGUvH+L02R9lAX/XhTkDTY+CgSlZg+pgaCGeB1b3oiotGoqMNX24W2p
        5Qe6uhECOqNfvsHznxRUqsLeH+2pf
X-Received: by 2002:a6b:7108:: with SMTP id q8mr13553353iog.85.1552947566503;
        Mon, 18 Mar 2019 15:19:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+gV7/W+0h6glBnmrfqjjjQRn3rnITundgQeyBhtfDNzDmJgONXPQbkBSBcuL4/ZazU7MSXA==
X-Received: by 2002:a6b:7108:: with SMTP id q8mr13553334iog.85.1552947566307;
        Mon, 18 Mar 2019 15:19:26 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id o129sm592920ito.0.2019.03.18.15.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:19:25 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: mlx5: Add a missing check on idr_find
Date:   Mon, 18 Mar 2019 17:18:51 -0500
Message-Id: <20190318221924.7034-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_find() can return a NULL value to 'flow' which is used without a check.
The patch adds a check to avoid potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 5cf5f2a9d51f..3df468acdffc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -226,6 +226,8 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_core_dev *mdev, u32 handle, u32 seq,
 	rcu_read_lock();
 	flow = idr_find(&mdev->fpga->tls->rx_idr, ntohl(handle));
 	rcu_read_unlock();
+	if (!flow)
+		return -EINVAL;
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
 
 	MLX5_SET(tls_cmd, cmd, swid, ntohl(handle));
-- 
2.17.1

