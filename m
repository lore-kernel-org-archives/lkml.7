Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0525C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABE120818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEOQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:25:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEOQZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9A5730018F6;
        Wed, 15 May 2019 16:25:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B91B419C7E;
        Wed, 15 May 2019 16:25:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/15] afs: Fix incorrect error handling in
 afs_xattr_get_acl()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Joe Perches <joe@perches.com>, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:25:51 +0100
Message-ID: <155793755188.31671.13175909085892285666.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 16:25:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect error handling in afs_xattr_get_acl() where there appears to
be a redundant assignment before return, but in fact the return should be a
goto to the error handling at the end of the function.

Fixes: 260f082bae6d ("afs: Get an AFS3 ACL as an xattr")
Addresses-Coverity: ("Unused Value")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Joe Perches <joe@perches.com>
---

 fs/afs/xattr.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index c81f85003fc7..b6c44e75b361 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -71,11 +71,10 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 	if (ret == 0) {
 		ret = acl->size;
 		if (size > 0) {
-			ret = -ERANGE;
-			if (acl->size > size)
-				return -ERANGE;
-			memcpy(buffer, acl->data, acl->size);
-			ret = acl->size;
+			if (acl->size <= size)
+				memcpy(buffer, acl->data, acl->size);
+			else
+				ret = -ERANGE;
 		}
 		kfree(acl);
 	}

