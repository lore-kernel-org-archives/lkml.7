Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988752184E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558552883;
	bh=lOAMxzkToxe3qagEy8KPYQKMxFkKtyRzcd+10Z2xQgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgcGegreGQxx6Tx+5iN78oJv02pm0d/buJYVQptsajV1H+nkSoelKdaQ+xAbM5aZa
	 cONjz6yAMak2oNNh6pkAjaCIQJ2cfLFxUVZQbEfpInX37Tx5Mon/KzXAWyIfWf14aq
	 yJKb3nepK0TxcV2r4sv6Aa6snGGXF7JHJVetxXGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfEVTVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbfEVTVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:21:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E990E2177E;
        Wed, 22 May 2019 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558552879;
        bh=lOAMxzkToxe3qagEy8KPYQKMxFkKtyRzcd+10Z2xQgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFiTou4wcoDQcW5rlRKSf8TWdm5cGvqGpCsAS1+LNvLYs4B9YoHL85q9iSgmtyzAc
         z6DgDvOo4+ulAyKZ2zuSt00yoTpLhd5IQDCW6ztGBQ90Qx36elD7eM2w4tBtmNCDnY
         NIhSyni9gJlH7hZFd9IooX9vpaNwHv91joUl1O80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 003/375] afs: Fix getting the afs.fid xattr
Date:   Wed, 22 May 2019 15:15:03 -0400
Message-Id: <20190522192115.22666-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192115.22666-1-sashal@kernel.org>
References: <20190522192115.22666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit a2f611a3dc317d8ea1c98ad6c54b911cf7f93193 ]

The AFS3 FID is three 32-bit unsigned numbers and is represented as three
up-to-8-hex-digit numbers separated by colons to the afs.fid xattr.
However, with the advent of support for YFS, the FID is now a 64-bit volume
number, a 96-bit vnode/inode number and a 32-bit uniquifier (as before).
Whilst the sprintf in afs_xattr_get_fid() has been partially updated (it
currently ignores the upper 32 bits of the 96-bit vnode number), the size
of the stack-based buffer has not been increased to match, thereby allowing
stack corruption to occur.

Fix this by increasing the buffer size appropriately and conditionally
including the upper part of the vnode number if it is non-zero.  The latter
requires the lower part to be zero-padded if the upper part is non-zero.

Fixes: 3b6492df4153 ("afs: Increase to 64-bit volume ID and 96-bit vnode ID for YFS")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/xattr.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index a2cdf25573e24..706801c6c4c4c 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -69,11 +69,20 @@ static int afs_xattr_get_fid(const struct xattr_handler *handler,
 			     void *buffer, size_t size)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	char text[8 + 1 + 8 + 1 + 8 + 1];
+	char text[16 + 1 + 24 + 1 + 8 + 1];
 	size_t len;
 
-	len = sprintf(text, "%llx:%llx:%x",
-		      vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
+	/* The volume ID is 64-bit, the vnode ID is 96-bit and the
+	 * uniquifier is 32-bit.
+	 */
+	len = sprintf(text, "%llx:", vnode->fid.vid);
+	if (vnode->fid.vnode_hi)
+		len += sprintf(text + len, "%x%016llx",
+			       vnode->fid.vnode_hi, vnode->fid.vnode);
+	else
+		len += sprintf(text + len, "%llx", vnode->fid.vnode);
+	len += sprintf(text + len, ":%x", vnode->fid.unique);
+
 	if (size == 0)
 		return len;
 	if (len > size)
-- 
2.20.1

