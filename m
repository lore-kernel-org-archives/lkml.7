Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45741205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054436;
	bh=IxqxiMlvpXKFP286NRjzeIqo26A/KytFVKH6GK7ag1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5W3Fi0bkudTTnyPe8maDXVGNMNDDiNAWxrL5EjPhv8bTXunNaKpS11tau/vLvdM3
	 fWBlnJnc40hmlIb54LloucnqH+03QfiU6m+Tq4ZIC80OY+DM12iVR5JW6H+w5eHNcr
	 V4mi09yVVoH690IcHGwxgtfDxDRIyqI2/DUJZx1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfFTSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbfFTSNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:13:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA6121530;
        Thu, 20 Jun 2019 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054431;
        bh=IxqxiMlvpXKFP286NRjzeIqo26A/KytFVKH6GK7ag1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnN8CemNH3ctTsbjRcM5Vx4TMnTe+ZcNfS+5qyFAgcSzDfBNz/O8kWzW2d7ppLOWQ
         ffcxij1e+qSHbYReyM65YkJoQLPTzLYugbLWyItUUElHtO0IYNDA4EtyDUEQqbMh6+
         jFKizYzxNFy99+ItxGjr1/0w8SDfBeiDV/Ze/jAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 27/98] net/mlx5e: Fix source port matching in fdb peer flow rule
Date:   Thu, 20 Jun 2019 19:56:54 +0200
Message-Id: <20190620174350.374992630@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raed Salem <raeds@mellanox.com>

The cited commit changed the initialization placement of the eswitch
attributes so it is done prior to parse tc actions function call,
including among others the in_rep and in_mdev fields which are mistakenly
reassigned inside the parse actions function.

This breaks the source port matching criteria of the peer redirect rule.

Fix by removing the now redundant reassignment of the already initialized
fields.

Fixes: 988ab9c7363a ("net/mlx5e: Introduce mlx5e_flow_esw_attr_init() helper")
Signed-off-by: Raed Salem <raeds@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2572,9 +2572,6 @@ static int parse_tc_fdb_actions(struct m
 	if (!flow_action_has_entries(flow_action))
 		return -EINVAL;
 
-	attr->in_rep = rpriv->rep;
-	attr->in_mdev = priv->mdev;
-
 	flow_action_for_each(i, act, flow_action) {
 		switch (act->id) {
 		case FLOW_ACTION_DROP:


