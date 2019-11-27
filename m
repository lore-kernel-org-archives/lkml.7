Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D90C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E642154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889633;
	bh=Rq5DdZ8123CMC8hW6qHy+m29omraP1Rwc8iVyAMnxRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2sPvmo6GgjhiEmgk0GPw2v+jWhQaewW+HYvtS8S8Zw5wACptzpB4RAii9j8++ECxi
	 WK5CYj4ktRF7FuWuX19y2lI2tzkZ/TKmdUwSuq06lK2uKvM/8+Wu6xirdZadQHUhru
	 C73ev9ithnkoBqFy6uxhUeXjjdU2Y1nUc0SXcscM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfK0VIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732780AbfK0VIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDC7217BA;
        Wed, 27 Nov 2019 21:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888920;
        bh=Rq5DdZ8123CMC8hW6qHy+m29omraP1Rwc8iVyAMnxRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkdAtN3BGGQXqM1FfYZl+Ql9n2tUF1xx1uHuaPW9Qy96xqJZlAGg4OFDmyWAnv/UE
         bOZggQpToMhenqEc7/rkuRUNM5tGt0anlRe8cbOZdqeXFjSruNn+q+HXEc5xvB58i7
         zJrtMdxXeoc38GwsjS0rjVf1lIbVr6LhRVwir3zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 15/95] net/mlx5e: Fix error flow cleanup in mlx5e_tc_tun_create_header_ipv4/6
Date:   Wed, 27 Nov 2019 21:31:32 +0100
Message-Id: <20191127202850.194784009@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Cohen <eli@mellanox.com>

[ Upstream commit a86db2269fca8019074b720baf2e0a35cddac4e9 ]

Be sure to release the neighbour in case of failures after successful
route lookup.

Fixes: 101f4de9dd52 ("net/mlx5e: Move TC tunnel offloading code to separate source file")
Signed-off-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -232,12 +232,15 @@ int mlx5e_tc_tun_create_header_ipv4(stru
 	if (max_encap_size < ipv4_encap_size) {
 		mlx5_core_warn(priv->mdev, "encap size %d too big, max supported is %d\n",
 			       ipv4_encap_size, max_encap_size);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto out;
 	}
 
 	encap_header = kzalloc(ipv4_encap_size, GFP_KERNEL);
-	if (!encap_header)
-		return -ENOMEM;
+	if (!encap_header) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* used by mlx5e_detach_encap to lookup a neigh hash table
 	 * entry in the neigh hash table when a user deletes a rule
@@ -348,12 +351,15 @@ int mlx5e_tc_tun_create_header_ipv6(stru
 	if (max_encap_size < ipv6_encap_size) {
 		mlx5_core_warn(priv->mdev, "encap size %d too big, max supported is %d\n",
 			       ipv6_encap_size, max_encap_size);
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto out;
 	}
 
 	encap_header = kzalloc(ipv6_encap_size, GFP_KERNEL);
-	if (!encap_header)
-		return -ENOMEM;
+	if (!encap_header) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	/* used by mlx5e_detach_encap to lookup a neigh hash table
 	 * entry in the neigh hash table when a user deletes a rule


