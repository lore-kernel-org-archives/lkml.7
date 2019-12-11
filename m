Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28066C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074722527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077961;
	bh=11YfEesQ22zjzVX7b1esNFekBN6+1CBi/OhlK+DC5tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xFtBZXPvR6xDl154YQdVRbtDYbf470M0IobWQ98AjxPQsTYrHvvUWm+Ce3EUM2A5a
	 QMn9eTqRFt2TvmVR5gKO0FOK1tvA9aP9cgnOPXmaP8xbsBix7y4cgskoio955yjRq+
	 R29rty5KpiXXQctiqJqCAfCLCMh82qUb05s2bs88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbfLKPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbfLKPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:25:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77068222C4;
        Wed, 11 Dec 2019 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077954;
        bh=11YfEesQ22zjzVX7b1esNFekBN6+1CBi/OhlK+DC5tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt+EiS21PKDFeCbafjyeilspj+7WkVPSFL77DY3ZA3h926L+kje14qEhMzOzZChfL
         QBfh+U57VBIyHM7v8VQiJLH+tXs8asq4OxzsQ+Og7C1rPlPFISS35JLBmZ31fvA1f9
         hTtiZbkC4tTgD/U0OacRSUU3bbSgmNU91GkQYZqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 197/243] fuse: verify nlink
Date:   Wed, 11 Dec 2019 16:05:59 +0100
Message-Id: <20191211150352.477406642@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
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
@@ -837,7 +837,8 @@ static int fuse_link(struct dentry *entr
 
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		inc_nlink(inode);
+		if (likely(inode->i_nlink < UINT_MAX))
+			inc_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);


