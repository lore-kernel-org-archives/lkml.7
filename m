Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5E32075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715093;
	bh=bkvAwSRW2kdTBz6wEtsCEVuLtCU6WmdZ3q5g1mqKhYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdY11W8jswtCLprU3Tu5ixegToa6XN27/K7HCE8c/iwOAuQZKqrQlAV/MJ+B6jwg2
	 K8h1lbjdirPkutRL9Iwgwgue+xQiTlIZC/22/saEgPBbjUCvfjpasMZ8j3OEd8Glko
	 S9WSS4DnTGy2PEHwYt7CFUABs0wyqBJiySfT9DjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfC0Tbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbfC0SDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1328C217D9;
        Wed, 27 Mar 2019 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709794;
        bh=bkvAwSRW2kdTBz6wEtsCEVuLtCU6WmdZ3q5g1mqKhYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5VRgT48xVKd/HrywgW0QAcHDO3yur8EAdz8UVM8gu+BY9S1WRW9j0uNPGZb7QCHY
         Ym976fxPZlu46cx7GgE7JbT6RlVSTU6UgTAcyjGMLs/rjRT9nZHN+54flHsvL6ammF
         pNYFeHMR7iC9Nb/WguAo1jC/MqBLtusSiSThZCYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia Guo <guojia12@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 040/262] ocfs2: fix a panic problem caused by o2cb_ctl
Date:   Wed, 27 Mar 2019 13:58:15 -0400
Message-Id: <20190327180158.10245-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 0e4166cc23a0..4ac775e32240 100644
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

