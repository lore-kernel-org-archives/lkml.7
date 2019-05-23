Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DE221850
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639513;
	bh=KvXjtvUyIqiq47OFUXTPY2eRziVggsyoJzbZ9WaMZj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fIayUNF0rSsrcc/wrcfteCIvtaEVe9/COL3xAp+gxZKEa2P+bPk91pQjvYX+dbkIN
	 ZdNdMDjP7l8+v24rbz0Ll6ciFxpetTklRefbQnM1GHNXXOMP0SGBhG7gIMgaX4W0OQ
	 eYpGO8Uc584bd2PYtPQLb+o71cAjmQCNNGOjpS6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfEWTZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391049AbfEWTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABFF2054F;
        Thu, 23 May 2019 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639505;
        bh=KvXjtvUyIqiq47OFUXTPY2eRziVggsyoJzbZ9WaMZj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwQhmTyrzuh5ssJW91+43k31vzup2FlVYID2AANxsWXFwX5J3mzd6DlemFKdURDUc
         u93H3nf0vaOjQmwLnCfDltz6RwpvS7ijQ5p3RAHyBBxPRw5cF0SVVtfDgRV5N05Fri
         MSukywUWjx7V94SCOBlivBIOSBRR2X/d6rktyHP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 113/139] securityfs: fix use-after-free on symlink traversal
Date:   Thu, 23 May 2019 21:06:41 +0200
Message-Id: <20190523181734.655054133@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 46c874419652bbefdfed17420fd6e88d8a31d9ec ]

symlink body shouldn't be freed without an RCU delay.  Switch securityfs
to ->destroy_inode() and use of call_rcu(); free both the inode and symlink
body in the callback.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315ee..421dd72b58767 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -27,17 +27,22 @@
 static struct vfsmount *mount;
 static int mount_count;
 
-static void securityfs_evict_inode(struct inode *inode)
+static void securityfs_i_callback(struct rcu_head *head)
 {
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
+	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	free_inode_nonrcu(inode);
+}
+
+static void securityfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, securityfs_i_callback);
 }
 
 static const struct super_operations securityfs_super_operations = {
 	.statfs		= simple_statfs,
-	.evict_inode	= securityfs_evict_inode,
+	.destroy_inode	= securityfs_destroy_inode,
 };
 
 static int fill_super(struct super_block *sb, void *data, int silent)
-- 
2.20.1



