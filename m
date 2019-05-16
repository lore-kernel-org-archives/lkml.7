Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE55C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68122084A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfEPXAe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 19:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfEPXAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 19:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71D033082E46;
        Thu, 16 May 2019 23:00:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C18A95E1A2;
        Thu, 16 May 2019 23:00:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Colin Ian King <colin.king@canonical.com>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellaneous fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14410.1558047621.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 17 May 2019 00:00:21 +0100
Message-ID: <14411.1558047621@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 16 May 2019 23:00:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you pull this series please?  It fixes a set of miscellaneous issues
in the afs filesystem, including:

 (1) Leak of keys on file close.

 (2) Broken error handling in xattr functions.

 (3) Missing locking when updating VL server list.

 (4) Volume location server DNS lookup whereby preloaded cells may not ever
     get a lookup and regular DNS lookups to maintain server lists consume
     power unnecessarily.

 (5) Incorrect error propagation and handling in the fileserver iteration
     code causes operations to sometimes apparently succeed.

 (6) Interruption of server record check/update side op during fileserver
     iteration causes uninterruptible main operations to fail unexpectedly.

 (7) Callback promise expiry time miscalculation.

 (8) Over invalidation of the callback promise on directories.

 (9) Double locking on callback break waking up file locking waiters.

(10) Double increment of the vnode callback break counter.

Note that it makes some changes outside of the afs code, including:

 (A) Adding an extra parameter to dns_query() to allow the dns_resolver key
     just accessed to be immediately invalidated.  AFS is caching the
     results itself, so the key can be discarded.

 (B) Adding an interruptible version of wait_var_event().

 (C) Adding an rxrpc function to allow the maximum lifespan to be set on a
     call.

 (D) Adding a way for an rxrpc call to be marked as non-interruptible.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
---
The following changes since commit 80f232121b69cc69a31ccb2b38c1665d770b0710:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2019-05-07 22:03:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190516

for you to fetch changes up to fd711586bb7d63f257da5eff234e68c446ac35ea:

  afs: Fix double inc of vnode->cb_break (2019-05-16 16:25:21 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (19):
      afs: Fix key leak in afs_release() and afs_evict_inode()
      afs: Fix incorrect error handling in afs_xattr_get_acl()
      afs: Fix afs_xattr_get_yfs() to not try freeing an error value
      afs: Fix missing lock when replacing VL server list
      afs: Fix afs_cell records to always have a VL server list record
      dns_resolver: Allow used keys to be invalidated
      Add wait_var_event_interruptible()
      afs: Fix cell DNS lookup
      afs: Fix "kAFS: AFS vnode with undefined type 0"
      rxrpc: Provide kernel interface to set max lifespan on a call
      afs: Fix the maximum lifespan of VL and probe calls
      afs: Fix error propagation from server record check/update
      rxrpc: Allow the kernel to mark a call as being non-interruptible
      afs: Make some RPC operations non-interruptible
      afs: Make dynamic root population wait uninterruptibly for proc_cells_lock
      afs: Fix calculation of callback expiry time
      afs: Don't invalidate callback if AFS_VNODE_DIR_VALID not set
      afs: Fix lock-wait/callback-break double locking
      afs: Fix double inc of vnode->cb_break

 Documentation/networking/rxrpc.txt |  21 ++++-
 fs/afs/addr_list.c                 |   2 +-
 fs/afs/afs.h                       |   3 +
 fs/afs/callback.c                  |   8 +-
 fs/afs/cell.c                      | 187 ++++++++++++++++++++++---------------
 fs/afs/dir.c                       |  18 ++--
 fs/afs/dir_silly.c                 |   4 +-
 fs/afs/dynroot.c                   |   5 +-
 fs/afs/file.c                      |   9 +-
 fs/afs/flock.c                     |   9 +-
 fs/afs/fsclient.c                  |  77 +++++++++------
 fs/afs/inode.c                     |  12 +--
 fs/afs/internal.h                  |  22 +++--
 fs/afs/proc.c                      |   8 +-
 fs/afs/rotate.c                    |  29 ++++--
 fs/afs/rxrpc.c                     |   7 +-
 fs/afs/security.c                  |   4 +-
 fs/afs/server.c                    |  17 +++-
 fs/afs/super.c                     |   2 +-
 fs/afs/vl_list.c                   |  20 ++--
 fs/afs/vl_rotate.c                 |  28 +++++-
 fs/afs/vlclient.c                  |   4 +
 fs/afs/write.c                     |   2 +-
 fs/afs/xattr.c                     | 103 ++++++++++----------
 fs/afs/yfsclient.c                 |  98 +++++++++----------
 fs/cifs/dns_resolve.c              |   2 +-
 fs/nfs/dns_resolve.c               |   2 +-
 include/linux/dns_resolver.h       |   3 +-
 include/linux/wait_bit.h           |  13 +++
 include/net/af_rxrpc.h             |   3 +
 net/ceph/messenger.c               |   2 +-
 net/dns_resolver/dns_query.c       |   6 +-
 net/rxrpc/af_rxrpc.c               |  28 ++++++
 net/rxrpc/ar-internal.h            |   2 +
 net/rxrpc/call_object.c            |   2 +
 net/rxrpc/conn_client.c            |   8 +-
 net/rxrpc/sendmsg.c                |   4 +-
 37 files changed, 478 insertions(+), 296 deletions(-)

