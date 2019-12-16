Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22720C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2CB218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522051;
	bh=3Jr3asvrNskAxqWkPJ2PRJglhyuOHOISyuAJUre/cJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=noLDVnDtgEeB+R2Q6N8bgVrBXVP4C5IgfWkPgJxNl6eoUQ0s1L1Maksl6SEriPu8H
	 3wISwOVZbR4ihaeDpnFX5MsmdKjNpYkr7K1go7byKTk39x6E1xMZw7fMYUspweb3Ye
	 mIMt0tILBbcZiT4w9oJcHliY/8TKmdA98+aqEfWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfLPSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfLPRzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:55:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E717720663;
        Mon, 16 Dec 2019 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518920;
        bh=3Jr3asvrNskAxqWkPJ2PRJglhyuOHOISyuAJUre/cJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWzbA1t3A+IoTiWKhRwl0hxuMvnvNCyvWxX7ts2JtAx4aMpFlibYRPdmvvgP2VPlT
         FwDZhe5ZCaji7Jl5pcDqaMHgAeJgB1WiW+uHciYzP1C+cS/WwmM8z0HSziz1aCcwkM
         PgFuAnC0xZm+WcaVT8dKlLfaoQAB0NcBnbGOCBCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 121/267] fuse: verify nlink
Date:   Mon, 16 Dec 2019 18:47:27 +0100
Message-Id: <20191216174903.344559322@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
@@ -830,7 +830,8 @@ static int fuse_link(struct dentry *entr
 
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		inc_nlink(inode);
+		if (likely(inode->i_nlink < UINT_MAX))
+			inc_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);


