Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C673C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9E520643
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962655;
	bh=7eGJNN2Vw6ksdo41dqTC3G+17TCl0ZYpnH5QQTLu64I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R07uhPcWbhA/AzL3NtFLN3OzTtRDopLxMnyJaUXfTqGaYYD/gjn6B9P2ViW5Bqmn9
	 KKKjL9/ehLhLzKQN+HqnUQLooYEOgMPfucpsy68f0EqiymwiI4+Jrx4IdkCK8NkIp7
	 YupxI1YvQOMuKPcIHw8U3t95YhOAFOnAxpPXOgKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfDVTux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731199AbfDVTut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291472177B;
        Mon, 22 Apr 2019 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962648;
        bh=7eGJNN2Vw6ksdo41dqTC3G+17TCl0ZYpnH5QQTLu64I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK9CVBoz6ajge0RH8zRaQTJlw3QCGNlx0FQHy07mD+kWZBRKYhRvBLhao14svIoYt
         LEExoGtfWDhMJQChuYdseFi6qiUGnomK+sE408Yt3zE9JiVhsl8rj9gTbFivtqS7IA
         dM7c4OiDGdgwkDNKa+JY/ziZ54mquSrC1qkf7BZ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 12/15] ceph: fix use-after-free on symlink traversal
Date:   Mon, 22 Apr 2019 15:50:19 -0400
Message-Id: <20190422195022.13760-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422195022.13760-1-sashal@kernel.org>
References: <20190422195022.13760-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit daf5cc27eed99afdea8d96e71b89ba41f5406ef6 ]

free the symlink body after the same RCU delay we have for freeing the
struct inode itself, so that traversal during RCU pathwalk wouldn't step
into freed memory.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7a1df90c7771..7641fcf83ac8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -472,6 +472,7 @@ static void ceph_i_callback(struct rcu_head *head)
 	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	kfree(ci->i_symlink);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -503,7 +504,6 @@ void ceph_destroy_inode(struct inode *inode)
 		ceph_put_snap_realm(mdsc, realm);
 	}
 
-	kfree(ci->i_symlink);
 	while ((n = rb_first(&ci->i_fragtree)) != NULL) {
 		frag = rb_entry(n, struct ceph_inode_frag, node);
 		rb_erase(n, &ci->i_fragtree);
-- 
2.19.1

