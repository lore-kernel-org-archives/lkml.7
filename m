Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF136C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9083C208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049709;
	bh=D27b/adAnZIWwGf3UXx/4cZaksE5PqiOLuChOLwHpwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pv1Dxd/Fs2MOSzGhAzMLJjxI90ZTq+WmB9L+aC9V62P5JYSMg0SUuieVl/hFqq/b9
	 6af0Coczh0bEv36+7ZUeDwglvF+jgWqz0tbCuTvN/R1L3rGstdHV9yVjfiE+QOzj4U
	 TX3NAQqz9na4oc0cXlGPf4YE85b9cdBjibYB2c64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfCHMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfCHMzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2062085A;
        Fri,  8 Mar 2019 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049700;
        bh=D27b/adAnZIWwGf3UXx/4cZaksE5PqiOLuChOLwHpwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4ruRrsXYLxmhbjy8HvaFzw1JvvcPBMFb8t56QUKvea/FHRFuPy6CYUF2Rq6U83GZ
         hARzIyBeLO74o96v6XdD778zgDy7Npus23cdAY/BRqcQs17b2F9oFA+yZu2nvpaMEF
         91Wo6x7Esd46c1tt/JcCWaxdoLlEAkag0BTZqxBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 09/76] staging: erofs: fix memleak of inodes shared xattr array
Date:   Fri,  8 Mar 2019 13:49:21 +0100
Message-Id: <20190308124915.114823190@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


