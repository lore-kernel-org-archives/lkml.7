Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FAF20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780641;
	bh=43saCZAc0s4ncF9r0XGHpoXWpMn26EU8d9AjHPHuwdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IO0T5iyFKhaCqzHNHvTUX2UOMltteHuzV0aKUKWCdVtrCdqOb05iLVTx4V8XU4dX4
	 +tIHARCzp8Cu8xw/CMmbNFWzTsISzfdu7Sa7se4thfdEtxAN0R/rVAuaETZb7qFSqk
	 QNITl/9Kx7m8jzcjPpyr3O2//qAFQEIVSsTw1Z1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLSShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfLSShP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:37:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624AA20716;
        Thu, 19 Dec 2019 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780634;
        bh=43saCZAc0s4ncF9r0XGHpoXWpMn26EU8d9AjHPHuwdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3PT/XZChQd+KEPVoDWVOytvz2oo9aAc/QmJedPxgAsClieJcw1ASblJfNiMDYoFf
         M93REmmXDkGN15ZBT2XYuv2xE7GUGoy9IHDYdQuXy5JnF4BLn9QUneDk59+T0A9At8
         2/GoVryL5pCWi5ZO2TWhJ84AGv+M0RYH9lFYCQi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 054/162] fuse: verify nlink
Date:   Thu, 19 Dec 2019 19:32:42 +0100
Message-Id: <20191219183211.169480687@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit c634da718db9b2fac201df2ae1b1b095344ce5eb upstream.

When adding a new hard link, make sure that i_nlink doesn't overflow.

Fixes: ac45d61357e8 ("fuse: fix nlink after unlink")
Cc: <stable@vger.kernel.org> # v3.4
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dir.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -812,7 +812,8 @@ static int fuse_link(struct dentry *entr
 
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		inc_nlink(inode);
+		if (likely(inode->i_nlink < UINT_MAX))
+			inc_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);


