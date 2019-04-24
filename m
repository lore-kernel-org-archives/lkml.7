Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A77C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF59721902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116487;
	bh=888zvxrjA7XOcy1VzeEiGB+h0t4AqJ63Z5hDuQ3W0II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hFEDq9+xo8SnXRkiOSP4k2mvW3L/MJYDKKv2NBd0No7xnpknkcvxqN0Km2vMktouH
	 fUJxOuFBgGZLPrQGRrNdGY6aWzuq8+eNWmCDKr/WK+MdOI7Wt7XuI/G4lUcNsnXAb9
	 43xCbnkBun16uEBYmXBs0/FHrtQEj8YyEY+eG5Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfDXOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbfDXOeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784142089F;
        Wed, 24 Apr 2019 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116484;
        bh=888zvxrjA7XOcy1VzeEiGB+h0t4AqJ63Z5hDuQ3W0II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7VEImkxQoytfXRetviqOQF0z8fGecYKvrUDCz7ow730YRQm2Q5xN5/oa2+n5kys9
         qCwqm3Z9egf7O/B6eenE0cjEOB+KXBxwNUQXQ0OR9aMC4aGHG3rWD+mN+Azq++2Fvd
         npZBTNROgHrlo/lE7Xb4vz1/EsXgBNZiE7TEABsE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 24/66] net/mlx5: E-Switch, Protect from invalid memory access in offload fdb table
Date:   Wed, 24 Apr 2019 10:32:58 -0400
Message-Id: <20190424143341.27665-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit 5c1d260ed10cf08dd7a0299c103ad0a3f9a9f7a1 ]

The esw offloads structures share a union with the legacy mode structs.
Reset the offloads struct to zero in init to protect from null
assumptions made by the legacy mode code.

Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d4e6fe5b9300..ce5766a26baa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1402,6 +1402,7 @@ int esw_offloads_init(struct mlx5_eswitch *esw, int nvports)
 {
 	int err;
 
+	memset(&esw->fdb_table.offloads, 0, sizeof(struct offloads_fdb));
 	mutex_init(&esw->fdb_table.offloads.fdb_prio_lock);
 
 	err = esw_create_offloads_fdb_tables(esw, nvports);
-- 
2.19.1

