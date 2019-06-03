Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E08C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6626F51
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553206;
	bh=R8DPWqvu8iCfeZPI7kR/OftjOwvZZ6W7KEvFFiZ9gVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wJ802IuOeedi1R2ek/xoIqUS1iNIr82y2xLMvscn5DBVOVquvagHXMTbktOqIKZUI
	 Vj2aidwDTT3PG4ojL1WuUerIjbcYlzRtVRXuwp9tIl7vofP/HDyBuASDr9Y3nKidqR
	 9AefbUNdTNuyYHaCKW3UtIndxQm7mEuKIh5ZYBQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfFCJNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfFCJNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:13:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5797327EB0;
        Mon,  3 Jun 2019 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553202;
        bh=R8DPWqvu8iCfeZPI7kR/OftjOwvZZ6W7KEvFFiZ9gVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqWeQDL66+XOWWw2Zu7m5w1+aWI/T2CUyGPMZW9V/sQmEYzqyM2Vo5pIWYea8gPw+
         onOpJvoENJo19YEsDMdOHKu2XmlZESsA0Jyuq/Or8IbcyJNFJD42F3lay6ohaMdMO8
         S5qJuV6Qb3WFLlgo644YAazfBzAP9AyAh7QXBK/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 21/40] net/mlx5: Avoid double free in fs init error unwinding path
Date:   Mon,  3 Jun 2019 11:09:14 +0200
Message-Id: <20190603090523.920086887@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 9414277a5df3669c67e818708c0f881597e0118e ]

In below code flow, for ingress acl table root ns memory leads
to double free.

mlx5_init_fs
  init_ingress_acls_root_ns()
    init_ingress_acl_root_ns
       kfree(steering->esw_ingress_root_ns);
       /* steering->esw_ingress_root_ns is not marked NULL */
  mlx5_cleanup_fs
    cleanup_ingress_acls_root_ns
       steering->esw_ingress_root_ns non NULL check passes.
       kfree(steering->esw_ingress_root_ns);
       /* double free */

Similar issue exist for other tables.

Hence zero out the pointers to not process the table again.

Fixes: 9b93ab981e3bf ("net/mlx5: Separate ingress/egress namespaces for each vport")
Fixes: 40c3eebb49e51 ("net/mlx5: Add support in RDMA RX steering")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2429,6 +2429,7 @@ static void cleanup_egress_acls_root_ns(
 		cleanup_root_ns(steering->esw_egress_root_ns[i]);
 
 	kfree(steering->esw_egress_root_ns);
+	steering->esw_egress_root_ns = NULL;
 }
 
 static void cleanup_ingress_acls_root_ns(struct mlx5_core_dev *dev)
@@ -2443,6 +2444,7 @@ static void cleanup_ingress_acls_root_ns
 		cleanup_root_ns(steering->esw_ingress_root_ns[i]);
 
 	kfree(steering->esw_ingress_root_ns);
+	steering->esw_ingress_root_ns = NULL;
 }
 
 void mlx5_cleanup_fs(struct mlx5_core_dev *dev)
@@ -2611,6 +2613,7 @@ cleanup_root_ns:
 	for (i--; i >= 0; i--)
 		cleanup_root_ns(steering->esw_egress_root_ns[i]);
 	kfree(steering->esw_egress_root_ns);
+	steering->esw_egress_root_ns = NULL;
 	return err;
 }
 
@@ -2638,6 +2641,7 @@ cleanup_root_ns:
 	for (i--; i >= 0; i--)
 		cleanup_root_ns(steering->esw_ingress_root_ns[i]);
 	kfree(steering->esw_ingress_root_ns);
+	steering->esw_ingress_root_ns = NULL;
 	return err;
 }
 


