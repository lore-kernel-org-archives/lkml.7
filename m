Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159ABC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13C820700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519446;
	bh=CeBwiQdcuprVkYH3v/InYP1u7hVzUfhzPzQkTL2H7Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgrs3Fr4JhBbL8rfQpXqeL/h+RPTk7s2cZKM9Lz5SS5tPKfKTKE2e/v8eDR6wgHzi
	 Zb2GwG0pin+B2JPDFnsTyz2EvYmrkwuQJTwvV4cynTCuItSrfOkJ5rdtUaItW0iHMa
	 b/fcShC/Jz/1uSTDNuiCguXkDqK3Pkv8D5RxWt0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfLPSEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfLPSEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:04:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96C920726;
        Mon, 16 Dec 2019 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519441;
        bh=CeBwiQdcuprVkYH3v/InYP1u7hVzUfhzPzQkTL2H7Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuUAuUnZ3rXHpf5YGJfOPRQTwVx+VsPLbK6UfzV1iX98b2f8vrpCivLijzNiHifMy
         0HjL5dO6O4ZYKa82co/3oNGBPZn9c/PCOrulCbzoPWj6IezEd0Ka2fT+ORyqa/qjHR
         vnK5T1h0EfBeS2qxzrtmB9Ln3K1Ctkwa9zw2nANU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 067/140] erofs: zero out when listxattr is called with no xattr
Date:   Mon, 16 Dec 2019 18:48:55 +0100
Message-Id: <20191216174806.072963258@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

commit 926d1650176448d7684b991fbe1a5b1a8289e97c upstream.

As David reported [1], ENODATA returns when attempting
to modify files by using EROFS as an overlayfs lower layer.

The root cause is that listxattr could return unexpected
-ENODATA by mistake for inodes without xattr. That breaks
listxattr return value convention and it can cause copy
up failure when used with overlayfs.

Resolve by zeroing out if no xattr is found for listxattr.

[1] https://lore.kernel.org/r/CAEvUa7nxnby+rxK-KRMA46=exeOMApkDMAV08AjMkkPnTPV4CQ@mail.gmail.com
Link: https://lore.kernel.org/r/20191201084040.29275-1-hsiangkao@aol.com
Fixes: cadf1ccf1b00 ("staging: erofs: add error handling for xattr submodule")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/xattr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -638,6 +638,8 @@ ssize_t erofs_listxattr(struct dentry *d
 	struct listxattr_iter it;
 
 	ret = init_inode_xattrs(d_inode(dentry));
+	if (ret == -ENOATTR)
+		return 0;
 	if (ret)
 		return ret;
 


