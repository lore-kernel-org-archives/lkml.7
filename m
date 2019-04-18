Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F5220643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612484;
	bh=cAzw+rpkJ+nZdw/frzGvio78VOyi6qJ6U2nD7+K9s80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SrPXdEBkOmv4oRZ0noWNLKuT4k33Tap8r8ZaetacM/jRoeL7AyUSQsYkjQ/t+hFun
	 3ZK+cfzDlqop4Ax2jmABi9y5wTBHQHUn+yJJhVPkDf45lSc40JqXF/Mk3UEI2YlLr6
	 EtCdQi5GW41Vo/gxBU+tFmiWIJka5WdXWqztFjaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbfDRR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389865AbfDRR6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39EE206B6;
        Thu, 18 Apr 2019 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610313;
        bh=cAzw+rpkJ+nZdw/frzGvio78VOyi6qJ6U2nD7+K9s80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZftQPCxoBwqzR3sE9E/8bz66nai+nuqzvONjN1DZkUzMfEOVzxy17RE+ft0YPO9hb
         GT4taggQUynyl4ZqTVYVPeK4p7CA5PUMud/IP70jTlsz54dZq477fRBCjRQ7dNXvnF
         cBDDoeBRnaU5nqI+xsMwX1qoUPXoxj7g1O+HJQ34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/110] IB/mlx4: Fix race condition between catas error reset and aliasguid flows
Date:   Thu, 18 Apr 2019 19:56:02 +0200
Message-Id: <20190418160438.642662789@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 587443e7773e150ae29e643ee8f41a1eed226565 ]

Code review revealed a race condition which could allow the catas error
flow to interrupt the alias guid query post mechanism at random points.
Thiis is fixed by doing cancel_delayed_work_sync() instead of
cancel_delayed_work() during the alias guid mechanism destroy flow.

Fixes: a0c64a17aba8 ("mlx4: Add alias_guid mechanism")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 155b4dfc0ae8..baab9afa9174 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -804,8 +804,8 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 	unsigned long flags;
 
 	for (i = 0 ; i < dev->num_ports; i++) {
-		cancel_delayed_work(&dev->sriov.alias_guid.ports_guid[i].alias_guid_work);
 		det = &sriov->alias_guid.ports_guid[i];
+		cancel_delayed_work_sync(&det->alias_guid_work);
 		spin_lock_irqsave(&sriov->alias_guid.ag_work_lock, flags);
 		while (!list_empty(&det->cb_list)) {
 			cb_ctx = list_entry(det->cb_list.next,
-- 
2.19.1



