Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8561924B81
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187510;
	bh=kWmMwuPTRb+1T90BSCkgw5VI7OQpnESmY40S8zU9mM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nnnDSUtjsrHEhf+ym2pXoTof0uRS4aXnCUAlFnzeJQ6KDn9VB/vohEVxU4F6oZG4+
	 2Ugtk4fAxx56so1GZOEG9lqE4wQpKjcdyJpgBVmY+BZzT/cDPKLHzAd5FzEdXZrJMw
	 BDQp1F3AK79alXwAioaUK+MX9KpJqVfN04TukFcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbfE3DWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730932AbfE3DRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:08 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CA924674;
        Thu, 30 May 2019 03:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186227;
        bh=kWmMwuPTRb+1T90BSCkgw5VI7OQpnESmY40S8zU9mM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=013rvfmZIuKtZBphBGZ0vnQtlpgWeNf0KCKJVf8hZzH0gTFD8KOuexR3sf8IIDbmb
         c5DeRwelDWYaq9yH48XSyn7tbQeRUZTb3wM8IPgljL57xrzbYUZG0i0sHaIzqX4pZe
         Gi1EduZUpD7j9zHYveLyVzjOXrKONEh5eLFq8czE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/276] btrfs: Dont panic when we cant find a root key
Date:   Wed, 29 May 2019 20:04:00 -0700
Message-Id: <20190530030531.464521374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7ac1e464c4d473b517bb784f30d40da1f842482e ]

When we failed to find a root key in btrfs_update_root(), we just panic.

That's definitely not cool, fix it by outputting an unique error
message, aborting current transaction and return -EUCLEAN. This should
not normally happen as the root has been used by the callers in some
way.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/root-tree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index fb205ebeca391..3228d3b3084a4 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -135,11 +135,14 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	if (ret < 0)
 		goto out;
 
-	if (ret != 0) {
-		btrfs_print_leaf(path->nodes[0]);
-		btrfs_crit(fs_info, "unable to update root key %llu %u %llu",
-			   key->objectid, key->type, key->offset);
-		BUG_ON(1);
+	if (ret > 0) {
+		btrfs_crit(fs_info,
+			"unable to find root key (%llu %u %llu) in tree %llu",
+			key->objectid, key->type, key->offset,
+			root->root_key.objectid);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		goto out;
 	}
 
 	l = path->nodes[0];
-- 
2.20.1



