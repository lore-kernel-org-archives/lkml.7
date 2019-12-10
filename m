Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C65C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5172520637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014597;
	bh=7XAFeYdjzdaDWxzc/x4+K8Fg4Yzq7/2lj8NDwkqvElI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7iT23N91ztP5z/0wqUYaJ4gkk6PiOKONik+KYiKDQC508OXEb3XZziHdO+mRbCGE
	 NO7dZzQ2bJOiYceLTaV2gVlvmSi/OW37ZlAFiN/HsT2xOKCYI+BDoRSOThfMwMg6y1
	 L5LPQPuAupxprJa4m0ykOxoHcU/JIRayZ6K8xOqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfLJVt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfLJVIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7281624684;
        Tue, 10 Dec 2019 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012110;
        bh=7XAFeYdjzdaDWxzc/x4+K8Fg4Yzq7/2lj8NDwkqvElI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8ih1pJ+6XNd3kyHiThAUiAKrg5pNnhqFGdcWKAmtHC0QdVC66Xvu4n7/r6swppsu
         yMZ1g83shuLhmTXOV/Pqe5uTyzHKZCKnMpBnZmstZFMI6nLGw0/CPjjLOsIpi9+rpG
         MTAo4FrwWDCg6cnOq1xW+7qWsL3cJuOFzP0OPE3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 083/350] team: call RCU read lock when walking the port_list
Date:   Tue, 10 Dec 2019 16:03:08 -0500
Message-Id: <20191210210735.9077-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit c17e26ddc79596230834345be80fcad6c619e9ec ]

Before reading the team port list, we need to acquire the RCU read lock.
Also change list_for_each_entry() to list_for_each_entry_rcu().

v2:
repost the patch to net-next and remove fixes flag as this is a cosmetic
change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 8156b33ee3e79..ca70a1d840eb3 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2074,7 +2074,8 @@ static int team_ethtool_get_link_ksettings(struct net_device *dev,
 	cmd->base.duplex = DUPLEX_UNKNOWN;
 	cmd->base.port = PORT_OTHER;
 
-	list_for_each_entry(port, &team->port_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &team->port_list, list) {
 		if (team_port_txable(port)) {
 			if (port->state.speed != SPEED_UNKNOWN)
 				speed += port->state.speed;
@@ -2083,6 +2084,8 @@ static int team_ethtool_get_link_ksettings(struct net_device *dev,
 				cmd->base.duplex = port->state.duplex;
 		}
 	}
+	rcu_read_unlock();
+
 	cmd->base.speed = speed ? : SPEED_UNKNOWN;
 
 	return 0;
-- 
2.20.1

