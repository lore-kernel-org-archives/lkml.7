Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3798C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A922722527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576076878;
	bh=gXARI7YL3GAncgeBJs6Fnde+C0qoulYIfCAepgl0a+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ARQNzmFpqYzwK5d/8+YjQ+1xWA45yQ5vqR4PzZ8wWVlPNueouEPZTiTFFseiDubk
	 RvxtJCvKATLse2RG8/F3iF6iMmASGfEcLTxyT2bGtS0ISg4XrqitW3C4YK/gZ6RCLd
	 pyGa7IJ5cjkgkF5muRdFhG+r6mKVzhWkVskV50og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfLKPH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfLKPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:07:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39AB24654;
        Wed, 11 Dec 2019 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076874;
        bh=gXARI7YL3GAncgeBJs6Fnde+C0qoulYIfCAepgl0a+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjN02p9d87S1TB63/SOGswWXArTm6HdrXcG2MdXKI7jdm03J/JgBDDIZ0tdHrX+aq
         Q0T5c2pVLfYGIwuCrnYHGnCDH+XQuZbmI+NCUmSrXwy5IOGVAlzfjsH7/LkYFIzYga
         ZAHpBbXeWSYL8cIAINsTHlsIgL4Oa8VheWikTdm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 23/92] fuse: verify nlink
Date:   Wed, 11 Dec 2019 16:05:14 +0100
Message-Id: <20191211150229.424302645@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
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
@@ -862,7 +862,8 @@ static int fuse_link(struct dentry *entr
 
 		spin_lock(&fi->lock);
 		fi->attr_version = atomic64_inc_return(&fc->attr_version);
-		inc_nlink(inode);
+		if (likely(inode->i_nlink < UINT_MAX))
+			inc_nlink(inode);
 		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);


