Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A610AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719B22133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120663;
	bh=TJDCL/OzCzUm1R6VioSOIvxqDHPnNF2nC0aYF3S27Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMN581QgJUADkwJbn66rYXdbzmXlB5dBFrbS4BWFMl7J5ryA2H4wcm7XzRUGsWgka
	 vfEAYAGH4bCdw5KByKuJYVHBIfv4tTtQ6f9CgvSKsing88REyI8XuCpvlaV50sHUq3
	 4Oi3QYIEgZTrT/4WV8gkCwfWIYKmqFUMdKdncjSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404632AbfJCQhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392063AbfJCQhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:37:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A787B21783;
        Thu,  3 Oct 2019 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120659;
        bh=TJDCL/OzCzUm1R6VioSOIvxqDHPnNF2nC0aYF3S27Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSJ3Cg5U9EoOjN5gCKk/ZMeRw/wcd8BpYrF6r3o6usqljBCrqKsZsDMOiNwg1QqMz
         5iVvYIO0QvIRytdrmHUn/92iEfmrnrQ7FYZbvAf4mEOaCDU3f7zUIz7zQldO7LwdvL
         xmV20YCgXS+o7K3jkVYKONcGbdLwqNxwdNWwbbp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.2 304/313] quota: fix wrong condition in is_quota_modification()
Date:   Thu,  3 Oct 2019 17:54:42 +0200
Message-Id: <20191003154603.127383955@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

commit 6565c182094f69e4ffdece337d395eb7ec760efc upstream.

Quoted from
commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <= isize")

" At LSF we decided that if we truncate up from isize we shouldn't trim
  fallocated blocks that were fallocated with KEEP_SIZE and are past the
 new i_size.  This patch fixes ext4 to do this. "

And generic/092 of fstest have covered this case for long time, however
is_quota_modification() didn't adjust based on that rule, so that in
below condition, we will lose to quota block change:
- fallocate blocks beyond EOF
- remount
- truncate(file_path, file_size)

Fix it.

Link: https://lore.kernel.org/r/20190911093650.35329-1-yuchao0@huawei.com
Fixes: 3da40c7b0898 ("ext4: only call ext4_truncate when size <= isize")
CC: stable@vger.kernel.org
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/quotaops.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -22,7 +22,7 @@ static inline struct quota_info *sb_dqop
 /* i_mutex must being held */
 static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
 {
-	return (ia->ia_valid & ATTR_SIZE && ia->ia_size != inode->i_size) ||
+	return (ia->ia_valid & ATTR_SIZE) ||
 		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
 		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
 }


