Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C60620818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfEOQZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfEOQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:25:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1ADE18830A;
        Wed, 15 May 2019 16:25:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4164A60F81;
        Wed, 15 May 2019 16:25:38 +0000 (UTC)
Subject: [PATCH 00/15] AFS fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:25:37 +0100
Message-ID: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 16:25:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of patches for AFS that fix the following issues:

 (1) Leak of keys on file close.

 (2) Broken error handling in xattr functions.

 (3) Missing locking when updating VL server list.

 (4) Volume location server DNS lookup whereby preloaded cells may not ever
     get a lookup and regular DNS lookups to maintain server lists consume
     power unnecessarily.

 (5) Callback promise expiry time miscalculation.

 (6) Over invalidation of the callback promise on directories.

 (7) Double locking on callback break waking up file locking waiters.

 (8) Double increment of the vnode callback break counter.

The patches can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
	tag afs-fixes-20190515

David
---
David Howells (15):
      afs: Fix key leak in afs_release() and afs_evict_inode()
      afs: Fix incorrect error handling in afs_xattr_get_acl()
      afs: Fix afs_xattr_get_yfs() to not try freeing an error value
      afs: Fix missing lock when replacing VL server list
      afs: Fix afs_cell records to always have a VL server list record
      dns_resolver: Allow used keys to be invalidated
      Add wait_var_event_interruptible()
      afs: Fix cell DNS lookup
      rxrpc: Allow the kernel to mark a call as being non-interruptible
      afs: Make some RPC operations non-interruptible
      afs: Make dynamic root population wait uninterruptibly for proc_cells_lock
      afs: Fix calculation of callback expiry time
      afs: Don't invalidate callback if AFS_VNODE_DIR_VALID not set
      afs: Fix lock-wait/callback-break double locking
      afs: Fix double inc of vnode->cb_break


 Documentation/networking/rxrpc.txt |   11 ++
 fs/afs/addr_list.c                 |    2 
 fs/afs/callback.c                  |    8 --
 fs/afs/cell.c                      |  187 ++++++++++++++++++++++--------------
 fs/afs/dir.c                       |   18 ++-
 fs/afs/dir_silly.c                 |    4 -
 fs/afs/dynroot.c                   |    5 -
 fs/afs/file.c                      |    9 +-
 fs/afs/flock.c                     |    9 +-
 fs/afs/fsclient.c                  |   76 +++++++++------
 fs/afs/inode.c                     |   12 +-
 fs/afs/internal.h                  |   21 +++-
 fs/afs/proc.c                      |    8 +-
 fs/afs/rotate.c                    |   27 +++--
 fs/afs/rxrpc.c                     |    3 -
 fs/afs/security.c                  |    4 -
 fs/afs/super.c                     |    2 
 fs/afs/vl_list.c                   |   20 ++--
 fs/afs/vl_rotate.c                 |   28 ++++-
 fs/afs/write.c                     |    2 
 fs/afs/xattr.c                     |  103 ++++++++++----------
 fs/afs/yfsclient.c                 |   98 +++++++++----------
 fs/cifs/dns_resolve.c              |    2 
 fs/nfs/dns_resolve.c               |    2 
 include/linux/dns_resolver.h       |    3 -
 include/linux/wait_bit.h           |   13 +++
 include/net/af_rxrpc.h             |    1 
 net/ceph/messenger.c               |    2 
 net/dns_resolver/dns_query.c       |    6 +
 net/rxrpc/af_rxrpc.c               |    3 +
 net/rxrpc/ar-internal.h            |    2 
 net/rxrpc/call_object.c            |    2 
 net/rxrpc/conn_client.c            |    8 +-
 net/rxrpc/sendmsg.c                |    4 +
 34 files changed, 412 insertions(+), 293 deletions(-)

