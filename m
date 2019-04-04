Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F485C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1F020693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368978;
	bh=S0Jhg+Kb7bm3BjMjvtxzbvA33Gq7twDhPDljqUIlbMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTxNk4qQpgBi6MtchdcXva9VudXBpeEtOCYEBplkRB39FOVAnZBXO++MeTJdWplAh
	 nmiMUDo/g5nwgPXASf72DgymJ20c5KLTl02CDj+5TAydManaCo8WVxwjg/fTx4/w0y
	 7oU74NoLrNr0oaXKFOJnZkYw63g4ez5j/NHqqwhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfDDJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732851AbfDDJJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86252183E;
        Thu,  4 Apr 2019 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368972;
        bh=S0Jhg+Kb7bm3BjMjvtxzbvA33Gq7twDhPDljqUIlbMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8IYytCL8JX4Ds4SLEyG7yj+ZF+QGocwaoB2GrWNw2d/JRcJ5nFDt+OYfSd2jqULR
         y+9iVzZFgPkx2d9wy4cZTTSmImT/j0z42dqoyD+pp1wi1o1r7TiCyDDfQaAwf8yiNl
         0iSmhSA8UXQTfS6MeX4/bsCNDKSP3jm3hjCM60gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia Guo <guojia12@huawei.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 036/246] ocfs2: fix a panic problem caused by o2cb_ctl
Date:   Thu,  4 Apr 2019 10:45:36 +0200
Message-Id: <20190404084620.320686550@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



