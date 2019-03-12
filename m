Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAA8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B71206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412376;
	bh=enDXOaDASJgw6FXTis/ccT470vw4wD6559Ss+nuuCIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/v2lZiqslKTwr/XdYxwdJ5Y0Xvvxx3drF40osgcVJzdSJLBHlrRwVx9XbahqtL6a
	 xJN8uBJTr17Lx25IemMjr1ASxPOHnlh7wjxjZlERkzv4H0ivFsKhA8TICNWlPkTezn
	 haXB2WWmopOUhWIPhlRT9xh4P/5fvWd7zSqFjHoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfCLRQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbfCLRPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:21 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3B1217D4;
        Tue, 12 Mar 2019 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410920;
        bh=enDXOaDASJgw6FXTis/ccT470vw4wD6559Ss+nuuCIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4m70DgoIf5zZHESjXSgVVedndg/qHrYoK0z+KuyfxHsOg/LchqYeWUiV20ghPJKj
         462as0qZvulN6E8EqThIcLa2RB83zqOz4N5fCbYXci6eWMXmmOJU7I1+Cjq7IU7wCU
         0ddlu2kuKGBfAh7sFdOAG8oFa0vjVOeiT6CBKv/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sheng Yong <shengyong1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 140/149] staging: erofs: fix memleak of inodes shared xattr array
Date:   Tue, 12 Mar 2019 10:09:18 -0700
Message-Id: <20190312170401.043164728@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

From: Sheng Yong <shengyong1@huawei.com>

commit 3b1b5291f79d040d549d7c746669fc30e8045b9b upstream.

If it fails to read a shared xattr page, the inode's shared xattr array
is not freed. The next time the inode's xattr is accessed, the previously
allocated array is leaked.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Fixes: b17500a0fdba ("staging: erofs: introduce xattr & acl support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/xattr.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -109,8 +109,11 @@ static int init_inode_xattrs(struct inod
 
 			it.page = erofs_get_meta_page(inode->i_sb,
 				++it.blkaddr, S_ISDIR(inode->i_mode));
-			if (IS_ERR(it.page))
+			if (IS_ERR(it.page)) {
+				kfree(vi->xattr_shared_xattrs);
+				vi->xattr_shared_xattrs = NULL;
 				return PTR_ERR(it.page);
+			}
 
 			it.kaddr = kmap_atomic(it.page);
 			atomic_map = true;


