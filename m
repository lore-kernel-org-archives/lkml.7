Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A500C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD95421880
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033640;
	bh=S0t3sC77Tgfik/F+fYwdHpd5/+/LozTQp1zITTY+whg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pJDkcOHpu5zvYTJ0VzrDzNxGljaTYL9nr4cNwNglBQLix8sT0NxXEycfkv7aeViue
	 kMdQlsTLgKzh68iKuacB0gESfcapYMym4BZHr+F2w1CtT685uVQd5N0K+KGRmz3dAF
	 Jo26a2R1+FMRD+fEBIwDsq802WZqKZmAkc6eS3sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391552AbfGYFrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391525AbfGYFrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026082075C;
        Thu, 25 Jul 2019 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033636;
        bh=S0t3sC77Tgfik/F+fYwdHpd5/+/LozTQp1zITTY+whg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wziZLSch4UEIhxiM5lRX9uMdnk1Kl1GOBWhYhB5Rhgz08U02E6/T0XCN9kNGtwQCw
         s8d6QgEr1rrMXelqkWykJxN8VkQo3xN8vvRFvftl8qHA9UWP9kay4GbEDhyUVh1EJv
         NhzWpAB/0/lYPkU/OqKw0lThU8g95YDnG+FgKbCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.19 260/271] eCryptfs: fix a couple type promotion bugs
Date:   Wed, 24 Jul 2019 21:22:09 +0200
Message-Id: <20190724191717.478612234@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 0bdf8a8245fdea6f075a5fede833a5fcf1b3466c upstream.

ECRYPTFS_SIZE_AND_MARKER_BYTES is type size_t, so if "rc" is negative
that gets type promoted to a high positive value and treated as success.

Fixes: 778aeb42a708 ("eCryptfs: Cleanup and optimize ecryptfs_lookup_interpose()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
[tyhicks: Use "if/else if" rather than "if/if"]
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/crypto.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1018,8 +1018,10 @@ int ecryptfs_read_and_validate_header_re
 
 	rc = ecryptfs_read_lower(file_size, 0, ECRYPTFS_SIZE_AND_MARKER_BYTES,
 				 inode);
-	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
-		return rc >= 0 ? -EINVAL : rc;
+	if (rc < 0)
+		return rc;
+	else if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
+		return -EINVAL;
 	rc = ecryptfs_validate_marker(marker);
 	if (!rc)
 		ecryptfs_i_size_init(file_size, inode);
@@ -1381,8 +1383,10 @@ int ecryptfs_read_and_validate_xattr_reg
 				     ecryptfs_inode_to_lower(inode),
 				     ECRYPTFS_XATTR_NAME, file_size,
 				     ECRYPTFS_SIZE_AND_MARKER_BYTES);
-	if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
-		return rc >= 0 ? -EINVAL : rc;
+	if (rc < 0)
+		return rc;
+	else if (rc < ECRYPTFS_SIZE_AND_MARKER_BYTES)
+		return -EINVAL;
 	rc = ecryptfs_validate_marker(marker);
 	if (!rc)
 		ecryptfs_i_size_init(file_size, inode);


