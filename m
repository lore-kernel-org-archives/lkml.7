Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A1D2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403046;
	bh=kqpzJnTxRpyBYOpXv54CkIzJJid5vTn2KtSckSJ5ySM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cF5wR1tEUQaC95TN+tO79Mn9JkjLyVroIc172g0O0yhPdMIYj/eJJZut3eV5U7St
	 H/Jc4wNV3M+o+s07vf0AFZ6VJdGEOTEiU9FjcmDre9LG88kl2tDe+n75q7Asz5P8B5
	 xTx2OSYk/YJQCMdrxd3l8gH6i7JdvAwiv9aCVbL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKVGKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbfKVF4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C731020717;
        Fri, 22 Nov 2019 05:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402203;
        bh=kqpzJnTxRpyBYOpXv54CkIzJJid5vTn2KtSckSJ5ySM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfWndtXbE7g4b9bTBIx3U2cVoDNBLmYiPPGFn8mH9fHgCn+uEayVeKgrzFnvK/6IQ
         YGq8t+nd9/I/R1J1DvplSpodb1NcuK8sPfuww4COsAH9E862NM0hJLjY3djXJNRQMW
         FdnDH9uHzsZhS/v1A2tajweBO7VhGtY8iX76hUtA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Machata <petrm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 052/127] vxlan: Fix error path in __vxlan_dev_create()
Date:   Fri, 22 Nov 2019 00:54:30 -0500
Message-Id: <20191122055544.3299-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 6db9246871394b3a136cd52001a0763676563840 ]

When a failure occurs in rtnl_configure_link(), the current code
calls unregister_netdevice() to roll back the earlier call to
register_netdevice(), and jumps to errout, which calls
vxlan_fdb_destroy().

However unregister_netdevice() calls transitively ndo_uninit, which is
vxlan_uninit(), and that already takes care of deleting the default FDB
entry by calling vxlan_fdb_delete_default(). Since the entry added
earlier in __vxlan_dev_create() is exactly the default entry, the
cleanup code in the errout block always leads to double free and thus a
panic.

Besides, since vxlan_fdb_delete_default() always destroys the FDB entry
with notification enabled, the deletion of the default entry is notified
even before the addition was notified.

Instead, move the unregister_netdevice() call after the manual destroy,
which solves both problems.

Fixes: 0241b836732f ("vxlan: fix default fdb entry netlink notify ordering during netdev create")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 6d26bbd190dd6..153a81ece9fe4 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3217,6 +3217,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f = NULL;
+	bool unregister = false;
 	int err;
 
 	err = vxlan_dev_configure(net, dev, conf, false, extack);
@@ -3242,12 +3243,11 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	err = register_netdevice(dev);
 	if (err)
 		goto errout;
+	unregister = true;
 
 	err = rtnl_configure_link(dev, NULL);
-	if (err) {
-		unregister_netdevice(dev);
+	if (err)
 		goto errout;
-	}
 
 	/* notify default fdb entry */
 	if (f)
@@ -3255,9 +3255,16 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 
 	list_add(&vxlan->next, &vn->vxlan_list);
 	return 0;
+
 errout:
+	/* unregister_netdevice() destroys the default FDB entry with deletion
+	 * notification. But the addition notification was not sent yet, so
+	 * destroy the entry by hand here.
+	 */
 	if (f)
 		vxlan_fdb_destroy(vxlan, f, false);
+	if (unregister)
+		unregister_netdevice(dev);
 	return err;
 }
 
-- 
2.20.1

