Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D122085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfCOXGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCOXGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:06:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9310C0669DE;
        Fri, 15 Mar 2019 22:59:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA9D9100194A;
        Fri, 15 Mar 2019 22:59:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/10] afs: Fix AFS file locking to allow fine grained locks
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Jonathan Billings <jsbillings@jsbillings.org>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 22:59:42 +0000
Message-ID: <155269078209.8537.15085378940532959137.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 15 Mar 2019 22:59:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix AFS file locking to allow fine grained locks as some applications, such
as firefox, won't work if they can't take such locks on certain state files
- thereby preventing the use of kAFS to distribute a home directory.

Note that this cannot be made completely functional as the protocol only
has provision for whole-file locks, so there exists the possibility of a
process deadlocking itself by getting a partial read-lock on a file first
and then trying to get a non-overlapping write-lock - but we got the
server's read lock with the first lock, so we're now stuck.

OpenAFS solves this by just granting any partial-range lock directly
without consulting the server - and hoping there's no remote collision.  I
want to implement that in a separate patch and it requires a bit more
thought.

Fixes: 8d6c554126b8 ("AFS: implement file locking")
Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 8b02f0056d54..6919f53ed4ad 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -458,10 +458,6 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
 
-	/* only whole-file locks are supported */
-	if (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX)
-		return -EINVAL;
-
 	fl->fl_ops = &afs_lock_ops;
 	INIT_LIST_HEAD(&fl->fl_u.afs.link);
 	fl->fl_u.afs.state = AFS_LOCK_PENDING;
@@ -613,10 +609,6 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	/* Flush all pending writes before doing anything with locks. */
 	vfs_fsync(file, 0);
 
-	/* only whole-file unlocks are supported */
-	if (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX)
-		return -EINVAL;
-
 	ret = posix_lock_file(file, fl, NULL);
 	_leave(" = %d [%u]", ret, vnode->lock_state);
 	return ret;
@@ -644,12 +636,15 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 			goto error;
 
 		lock_count = READ_ONCE(vnode->status.lock_count);
-		if (lock_count > 0)
-			fl->fl_type = F_RDLCK;
-		else
-			fl->fl_type = F_WRLCK;
-		fl->fl_start = 0;
-		fl->fl_end = OFFSET_MAX;
+		if (lock_count != 0) {
+			if (lock_count > 0)
+				fl->fl_type = F_RDLCK;
+			else
+				fl->fl_type = F_WRLCK;
+			fl->fl_start = 0;
+			fl->fl_end = OFFSET_MAX;
+			fl->fl_pid = 0;
+		}
 	}
 
 	ret = 0;

