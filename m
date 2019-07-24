Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19AC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C159B2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999018;
	bh=A45PPdG0K5lcUwzKPWqe5D+7FGktQY11iKQZXNwbnQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOfECgoKhk8KbPGxzmQE8JHkbaDjLOSXWn5sm2YXuTRTzqIkVmaBVU0InYefU9/14
	 T2gzNEODMlQmBRdmQ5qXsfDzF/wpeY2KB7QIWBaKXZYKFtHWuTIXbYU6QBCy6X0Arx
	 LuqKVsZEyyD1iH2j1mQHLd5iVrejrtULH6mqs6/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbfGXT71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392215AbfGXT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:59:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56764206BA;
        Wed, 24 Jul 2019 19:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998360;
        bh=A45PPdG0K5lcUwzKPWqe5D+7FGktQY11iKQZXNwbnQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFnxIYn81rixHHztGyINZNYD9Y1AtrukmmKGGe5e8PnE4dfpMlJb6Gainq37ZxLS7
         zRj994vy51cvzn3xQjJKCSf4wY9h0wYGWrzfMmxwFnNMJPHwCTED6Q9lf4cIqFXm/5
         OET5i6JkPY/fMp9UfJBuSQ04paR5bSIwYudgepy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.1 336/371] IB/mlx5: Report correctly tag matching rendezvous capability
Date:   Wed, 24 Jul 2019 21:21:28 +0200
Message-Id: <20190724191749.007812384@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

commit 89705e92700170888236555fe91b45e4c1bb0985 upstream.

Userspace expects the IB_TM_CAP_RC bit to indicate that the device
supports RC transport tag matching with rendezvous offload. However the
firmware splits this into two capabilities for eager and rendezvous tag
matching.

Only if the FW supports both modes should userspace be told the tag
matching capability is available.

Cc: <stable@vger.kernel.org> # 4.13
Fixes: eb761894351d ("IB/mlx5: Fill XRQ capabilities")
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c |    8 ++++++--
 include/rdma/ib_verbs.h           |    4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1041,15 +1041,19 @@ static int mlx5_ib_query_device(struct i
 	}
 
 	if (MLX5_CAP_GEN(mdev, tag_matching)) {
-		props->tm_caps.max_rndv_hdr_size = MLX5_TM_MAX_RNDV_MSG_SIZE;
 		props->tm_caps.max_num_tags =
 			(1 << MLX5_CAP_GEN(mdev, log_tag_matching_list_sz)) - 1;
-		props->tm_caps.flags = IB_TM_CAP_RC;
 		props->tm_caps.max_ops =
 			1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
 		props->tm_caps.max_sge = MLX5_TM_MAX_SGE;
 	}
 
+	if (MLX5_CAP_GEN(mdev, tag_matching) &&
+	    MLX5_CAP_GEN(mdev, rndv_offload_rc)) {
+		props->tm_caps.flags = IB_TM_CAP_RNDV_RC;
+		props->tm_caps.max_rndv_hdr_size = MLX5_TM_MAX_RNDV_MSG_SIZE;
+	}
+
 	if (MLX5_CAP_GEN(dev->mdev, cq_moderation)) {
 		props->cq_caps.max_cq_moderation_count =
 						MLX5_MAX_CQ_COUNT;
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -293,8 +293,8 @@ struct ib_rss_caps {
 };
 
 enum ib_tm_cap_flags {
-	/*  Support tag matching on RC transport */
-	IB_TM_CAP_RC		    = 1 << 0,
+	/*  Support tag matching with rendezvous offload for RC transport */
+	IB_TM_CAP_RNDV_RC = 1 << 0,
 };
 
 struct ib_tm_caps {


