Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C802082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711030;
	bh=z2bgDMYsfSSOtTV9lNCXx2RL7qLIoqbqdo+WiUe2WGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vk9BTk07oPRXail5z+LiJhoXOq5YdVniYS9bGyYAuj31M9MXEKzJPqLG69W4CcrTj
	 Mlp1GfUlssTnN20cbutf/ylhY4JO/IERnU0/+KyRVQM2irYOyHPxyspjDq91nqRLK4
	 MeP3iHPq9nCi7bpsQBejSe7KFzZcUje02g8phBQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbfC0SXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403866AbfC0SXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D69720651;
        Wed, 27 Mar 2019 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711027;
        bh=z2bgDMYsfSSOtTV9lNCXx2RL7qLIoqbqdo+WiUe2WGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCqJZTEwl/xsJEoYk6MUlTnmsWjv3zD9v89tQrsVYmuJ2oZZ7pxv+gbQNrVbQ+Cre
         lOnTKZoXg+e9QaUI0amuLNh0eG4s8BOIYmVHHLLMuuJt9y8AwXH44EjhnsQw24saYT
         J20eQniMd5w10dX0nK1T9q81Rcgz3XsETCis+ahc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia Guo <guojia12@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 12/63] ocfs2: fix a panic problem caused by o2cb_ctl
Date:   Wed, 27 Mar 2019 14:22:32 -0400
Message-Id: <20190327182323.18577-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia Guo <guojia12@huawei.com>

[ Upstream commit cc725ef3cb202ef2019a3c67c8913efa05c3cce6 ]

In the process of creating a node, it will cause NULL pointer
dereference in kernel if o2cb_ctl failed in the interval (mkdir,
o2cb_set_node_attribute(node_num)] in function o2cb_add_node.

The node num is initialized to 0 in function o2nm_node_group_make_item,
o2nm_node_group_drop_item will mistake the node number 0 for a valid
node number when we delete the node before the node number is set
correctly.  If the local node number of the current host happens to be
0, cluster->cl_local_node will be set to O2NM_INVALID_NODE_NUM while
o2hb_thread still running.  The panic stack is generated as follows:

  o2hb_thread
      \-o2hb_do_disk_heartbeat
          \-o2hb_check_own_slot
              |-slot = &reg->hr_slots[o2nm_this_node()];
              //o2nm_this_node() return O2NM_INVALID_NODE_NUM

We need to check whether the node number is set when we delete the node.

Link: http://lkml.kernel.org/r/133d8045-72cc-863e-8eae-5013f9f6bc51@huawei.com
Signed-off-by: Jia Guo <guojia12@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Acked-by: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/cluster/nodemanager.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index 3c45a9301a09..a87a08e1bfab 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -621,13 +621,15 @@ static void o2nm_node_group_drop_item(struct config_group *group,
 	struct o2nm_node *node = to_o2nm_node(item);
 	struct o2nm_cluster *cluster = to_o2nm_cluster(group->cg_item.ci_parent);
 
-	o2net_disconnect_node(node);
+	if (cluster->cl_nodes[node->nd_num] == node) {
+		o2net_disconnect_node(node);
 
-	if (cluster->cl_has_local &&
-	    (cluster->cl_local_node == node->nd_num)) {
-		cluster->cl_has_local = 0;
-		cluster->cl_local_node = O2NM_INVALID_NODE_NUM;
-		o2net_stop_listening(node);
+		if (cluster->cl_has_local &&
+		    (cluster->cl_local_node == node->nd_num)) {
+			cluster->cl_has_local = 0;
+			cluster->cl_local_node = O2NM_INVALID_NODE_NUM;
+			o2net_stop_listening(node);
+		}
 	}
 
 	/* XXX call into net to stop this node from trading messages */
-- 
2.19.1

