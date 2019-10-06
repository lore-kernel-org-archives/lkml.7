Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF752C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB1D2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383218;
	bh=lzf4NezQwvnIwgsemkILbMCirg6UhvXpkxXQMME+7bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V9Q9G9rOFH4aCZZinxE6HtpAUVOvQFW7rl5oHwiTwBMaFvI1XYyaiZhAJAbxeohW2
	 6Mr9RgpUB2+TGnKgz3EQ7ee9eD7Oa7q9L/NeBoGNMinIC7lWbUpN0UQxGfc/PGIxvp
	 pzkH4OEo4NCfNfpgqE38HsHrGFRx7+aKzs7VNRfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfJFRdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbfJFRde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:33:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609952133F;
        Sun,  6 Oct 2019 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383213;
        bh=lzf4NezQwvnIwgsemkILbMCirg6UhvXpkxXQMME+7bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY+U/XRJXTKq12C52l06bIzz3/s0dBB6sbkeoeFFVvvq4sjag7CFNq/O3tqsc7kU7
         h00Mo5oE+bleE6Y7Nma+Dh077rOWBU4gR6yRld+pot5EU6eFukq6S2FNpFQDi+bDdH
         DX6aTMP25r1nV4Q9HI3bUyHe3xLsgMWjO1JC+mZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dotan Barak <dotanb@dev.mellanox.co.il>,
        Sudhakar Dindukurti <sudhakar.dindukurti@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 021/137] net/rds: Fix error handling in rds_ib_add_one()
Date:   Sun,  6 Oct 2019 19:20:05 +0200
Message-Id: <20191006171211.070959061@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dotan Barak <dotanb@dev.mellanox.co.il>

[ Upstream commit d64bf89a75b65f83f06be9fb8f978e60d53752db ]

rds_ibdev:ipaddr_list and rds_ibdev:conn_list are initialized
after allocation some resources such as protection domain.
If allocation of such resources fail, then these uninitialized
variables are accessed in rds_ib_dev_free() in failure path. This
can potentially crash the system. The code has been updated to
initialize these variables very early in the function.

Signed-off-by: Dotan Barak <dotanb@dev.mellanox.co.il>
Signed-off-by: Sudhakar Dindukurti <sudhakar.dindukurti@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/ib.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -143,6 +143,9 @@ static void rds_ib_add_one(struct ib_dev
 	refcount_set(&rds_ibdev->refcount, 1);
 	INIT_WORK(&rds_ibdev->free_work, rds_ib_dev_free);
 
+	INIT_LIST_HEAD(&rds_ibdev->ipaddr_list);
+	INIT_LIST_HEAD(&rds_ibdev->conn_list);
+
 	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
 	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
 
@@ -203,9 +206,6 @@ static void rds_ib_add_one(struct ib_dev
 		device->name,
 		rds_ibdev->use_fastreg ? "FRMR" : "FMR");
 
-	INIT_LIST_HEAD(&rds_ibdev->ipaddr_list);
-	INIT_LIST_HEAD(&rds_ibdev->conn_list);
-
 	down_write(&rds_ib_devices_lock);
 	list_add_tail_rcu(&rds_ibdev->list, &rds_ib_devices);
 	up_write(&rds_ib_devices_lock);


