Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54492070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142241;
	bh=us4Nj+9dtFwj9PlRB3x0nW0aBqmZvsSlbgRM/Pbvgyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYaumfeCIHlcC4/VO2RClu8geuIG9VeDfK56Gl7x6bAQgjpBu8fdL0KK5MBNRPvQm
	 YfgsEIxbUUjycGXyhlD+GuaTMw/pg+9weIeOQpi/U1lkQplCaFISZdkcaHq0KxHhlg
	 AlyMNzgJ3L9DZ6yFw/8Vi5fOe2yh9htYTAMpCAPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfDARHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfDARHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1102321934;
        Mon,  1 Apr 2019 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138459;
        bh=us4Nj+9dtFwj9PlRB3x0nW0aBqmZvsSlbgRM/Pbvgyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcQcuLt801kEZSHTPDU2ZihWY8SSvGGoooQd6FB8WNnxahTwIFfemHQW/NALhDzat
         EXZaiW0nu2aTDitqx6ugSzSKZpZIV1rrH4nEzEEoOHgdoUMiSrriwcfHsxoG1jcm+A
         dwU5BZxmtzoZULsAEbz2AYibYBHo/qlzCO9m2udU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Schneider <asn@redhat.com>,
        Neil Brown <neilb@suse.com>, Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.0 045/146] locks: wake any locks blocked on request before deadlock check
Date:   Mon,  1 Apr 2019 19:00:57 +0200
Message-Id: <20190401170052.385151385@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@kernel.org>

commit 945ab8f6de94430c23a82f3cf2e3f6d6f2945ff7 upstream.

Andreas reported that he was seeing the tdbtorture test fail in some
cases with -EDEADLCK when it wasn't before. Some debugging showed that
deadlock detection was sometimes discovering the caller's lock request
itself in a dependency chain.

While we remove the request from the blocked_lock_hash prior to
reattempting to acquire it, any locks that are blocked on that request
will still be present in the hash and will still have their fl_blocker
pointer set to the current request.

This causes posix_locks_deadlock to find a deadlock dependency chain
when it shouldn't, as a lock request cannot block itself.

We are going to end up waking all of those blocked locks anyway when we
go to reinsert the request back into the blocked_lock_hash, so just do
it prior to checking for deadlocks. This ensures that any lock blocked
on the current request will no longer be part of any blocked request
chain.

URL: https://bugzilla.kernel.org/show_bug.cgi?id=202975
Fixes: 5946c4319ebb ("fs/locks: allow a lock request to block other requests.")
Cc: stable@vger.kernel.org
Reported-by: Andreas Schneider <asn@redhat.com>
Signed-off-by: Neil Brown <neilb@suse.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/locks.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1160,6 +1160,11 @@ static int posix_lock_inode(struct inode
 			 */
 			error = -EDEADLK;
 			spin_lock(&blocked_lock_lock);
+			/*
+			 * Ensure that we don't find any locks blocked on this
+			 * request during deadlock detection.
+			 */
+			__locks_wake_up_blocks(request);
 			if (likely(!posix_locks_deadlock(request, fl))) {
 				error = FILE_LOCK_DEFERRED;
 				__locks_insert_block(fl, request,


