Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B0521841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639582;
	bh=J41EuJLG+sXz2i4AKh/xVoeOsnYj33XSb3EDyOR4SOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hLnRs2HcLFrrCs9iofEq6wjCbjwJDN85Li0jBsWdXv7yVE3HDX4vlAzjYKBGkXGxo
	 WxPPOEigNZV2qs6X1PIBESQZJnfCyzrXC0eP7RBXwR4fAwVv7WUEOlZ7Jwrvecx7zY
	 IG7+ufQ2YmH3yCkjXaMFbHvSo6mXl9zvmBkz6Afo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfEWT0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390636AbfEWT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14C920868;
        Thu, 23 May 2019 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639578;
        bh=J41EuJLG+sXz2i4AKh/xVoeOsnYj33XSb3EDyOR4SOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjS7/piVzC6JoSPF4MeteIaG4LZWgT2nci9aXRLzPfieAgWwe5qsrFzl4CLoM40ac
         JvZElRO5Vvmg2VGQN3EtnIYLpIhK8Z8TmGq+VTLILBR6Up9ftkELcH8A2RaxBqFHkM
         edoTNwW7CVEH5LFFxWi0qUyoA/2Pr+W1bfNnZqo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianbo Liu <jianbol@mellanox.com>,
        Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 017/122] net/mlx5e: Fix calling wrong function to get inner vlan key and mask
Date:   Thu, 23 May 2019 21:05:39 +0200
Message-Id: <20190523181707.134169459@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianbo Liu <jianbol@mellanox.com>

[ Upstream commit 12d5cbf89a6599f6bbd7b373dba0e74b5bd9c505 ]

When flow_rule_match_XYZ() functions were first introduced,
flow_rule_match_cvlan() for inner vlan is missing.

In mlx5_core driver, to get inner vlan key and mask, flow_rule_match_vlan()
is just called, which is wrong because it obtains outer vlan information by
FLOW_DISSECTOR_KEY_VLAN.

This commit fixes this by changing to call flow_rule_match_cvlan() after
it's added.

Fixes: 8f2566225ae2 ("flow_offload: add flow_rule and flow_match structures and use them")
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1561,7 +1561,7 @@ static int __parse_cls_flower(struct mlx
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN)) {
 		struct flow_match_vlan match;
 
-		flow_rule_match_vlan(rule, &match);
+		flow_rule_match_cvlan(rule, &match);
 		if (match.mask->vlan_id ||
 		    match.mask->vlan_priority ||
 		    match.mask->vlan_tpid) {


