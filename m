Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB53C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D212133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049569;
	bh=4+89F1E7YuZD8PHOI7nwwOxWBUVwD6AkHzwMo0v+z28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fab2upQyk3jad83ukCg1w1xAEvK2G7hrK9ph3w9K1Q8ZIzrP+d39JTf/AHDESefv8
	 lfzJtXoJHD7opFTAIXNvoWHru+jiawtWD3XRlIqUES7PlLOtnOjFEO1lHc9UtVisvS
	 VBJO8almX2MkbHvUcTKL72F4Kt+rH9fM3/jkHsHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfCHMwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfCHMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B892087C;
        Fri,  8 Mar 2019 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049561;
        bh=4+89F1E7YuZD8PHOI7nwwOxWBUVwD6AkHzwMo0v+z28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmviQsK1RkC0GmaALPTRaf7u6WLxxEr9oloIC+PUjqqUVue47X3d/0BirzQAiWyRh
         PjANf2mWh9WZMWE+NLnhm5+9afrctGTT3qiNiTRNyPLnyrnBeKj9N1MbvrGlv4wTej
         7pDFY8qQoWJZ6MDj5bBmg9evuhRfHgUKd+tLi3mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 5.0 09/46] staging: erofs: fix memleak of inodes shared xattr array
Date:   Fri,  8 Mar 2019 13:49:42 +0100
Message-Id: <20190308124902.840712758@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

From: Sheng Yong <shengyong1@huawei.com>

commit 3b1b5291f79d040d549d7c746669fc30e8045b9b upstream.

If it fails to read a shared xattr page, the inode's shared xattr array
is not freed. The next time the inode's xattr is accessed, the previously
allocated array is leaked.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Fixes: b17500a0fdba ("staging: erofs: introduce xattr & acl support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/xattr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -111,8 +111,11 @@ static int init_inode_xattrs(struct inod
 
 			it.page = erofs_get_meta_page(sb,
 				++it.blkaddr, S_ISDIR(inode->i_mode));
-			if (IS_ERR(it.page))
+			if (IS_ERR(it.page)) {
+				kfree(vi->xattr_shared_xattrs);
+				vi->xattr_shared_xattrs = NULL;
 				return PTR_ERR(it.page);
+			}
 
 			it.kaddr = kmap_atomic(it.page);
 			atomic_map = true;


