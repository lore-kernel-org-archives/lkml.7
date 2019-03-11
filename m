Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F050206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="osfwyC+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCKGeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:34:02 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47334 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:34:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 46CEA98E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U_x31AY2hxov for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 01:34:00 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1D4A693A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 01:34:00 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id n15so3468696ioc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HC/jRjq2phMSTGGfJQP8OUUC/tIZ0jS+Ie8QCGCbJJI=;
        b=osfwyC+OhFdcJQ+zllgvpJo6IXVSuwBO3tCffNA00sHPH1xyrKHnzSF2tPjLfS7xci
         +FZTFDjDbPfPS9zvpI7qo2zY9zL9XaAewhDYO7wGOX/91FA8Rai9I/bLIBTputhe2DWB
         30mK6boCHHfxVQnvrNT3G2rZ1jarFcD/Ym+K2inHxjjDNkZjsOpmn4GULLz83lDItYAv
         fMHoVJR1YmMocGfNAbxaKvv26vOLrhtAPT/pgmDXL+yWTRjOiZwXu+xANJZ0jp34MKR0
         H3dUIyiv3X5PdoCiwrhgEZHib1YxLlcC7/9Fdtqp6jJLAb53SJbyJvDiW30MzQw57dgg
         rbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HC/jRjq2phMSTGGfJQP8OUUC/tIZ0jS+Ie8QCGCbJJI=;
        b=Viy2zA3U9f7fR7wBJnHLIWlyTizUz/+DPFHnI+/JWF3g67B87Ca14PFWzQxjN/kD01
         HPzzT4elisnb+MbcquxdlEKPHZq4hFujoUOl4jUrii9W5G8dZBRSG0cgmpnBzdaZE3+p
         rNErB2VEROYDN8KRSNnD0q08y7dHRssXd+xhB8a8VTL4skYastr17rgyvlBdaqp+GicI
         fg4qL87cQioEDDtBpxUjoTo1Yu1Ae23ySuF5a1Fi7UfNuHb7lxFfACQtxeJ9HtrAjwPA
         1ZP2ezAvOY6YGGMcSD9+ZXKB7oI2F7Dy7eIXKTXWDlYP8U88soYUfiUTZnsVsx6itEwh
         NtrA==
X-Gm-Message-State: APjAAAWKLVB2B6Y/uV3o9BiO/dNC0qQ5/wxFk3/cEM8PUAx0tKcemYif
        Ao8Qs0mwhbt9xMblLiXBefv92BUq4+56RetSWxnZZPBca7b0nU3pXQjFAMeCeHV/Iej1oJvXrz0
        wQEk8W+X7XtruJ2BCxg3X0MPbIt77
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr14782588iol.50.1552286039700;
        Sun, 10 Mar 2019 23:33:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzr/Rg1zh4+eFaHfHbyRmVOCARD9GFSy4CPROBMLP2f45wOEt2PgBJj/YeY75Oi4O+z2qCmXA==
X-Received: by 2002:a5d:88c1:: with SMTP id i1mr14782578iol.50.1552286039428;
        Sun, 10 Mar 2019 23:33:59 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id u196sm9342507itu.34.2019.03.10.23.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:33:58 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: mlx5: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 01:33:43 -0500
Message-Id: <20190311063343.20188-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case skb_header_pointer fails, the fix issues a warning.

A better fix requires modifying the signature of mlx5e_get_fcs to
pass an error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index be396e5e4e39..6ec1c110e4be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -719,6 +719,8 @@ static u32 mlx5e_get_fcs(const struct sk_buff *skb)
 
 	fcs_bytes = skb_header_pointer(skb, skb->len - ETH_FCS_LEN,
 				       ETH_FCS_LEN, &_fcs_bytes);
+	if (unlikely(!fcs_bytes))
+		pr_warn_once("skb_header_pointer returns NULL\n");
 
 	return __get_unaligned_cpu32(fcs_bytes);
 }
-- 
2.17.1

