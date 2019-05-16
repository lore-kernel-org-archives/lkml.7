Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE3C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F822084A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEPXCN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 19:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfEPXCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 19:02:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45C62305B16F;
        Thu, 16 May 2019 23:02:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB9C45D6A9;
        Thu, 16 May 2019 23:02:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fix callback promise handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14597.1558047724.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 17 May 2019 00:02:04 +0100
Message-ID: <14598.1558047724@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 16 May 2019 23:02:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you pull this series on top of the "afs: Miscellaneous fixes" series
please?  The two are consecutive on the same branch.

This series fixes a bunch of problems in callback promise handling, where a
callback promise indicates a promise on the part of the server to notify
the client in the event of some sort of change to a file or volume.  In the
event of a break, the client has to go and refetch the client status from
the server and discard any cached permission information as the ACL might
have changed.

The problem in the current code is that changes made by other clients
aren't always noticed, primarily because the file status information and
the callback information aren't updated in the same critical section, even
if these are carried in the same reply from an RPC operation, and so the
AFS_VNODE_CB_PROMISED flag is unreliable.

Arranging for them to be done in the same critical section during reply
decoding is tricky because of the FS.InlineBulkStatus op - which has all
the statuses in the reply arriving and then all the callbacks, so they have
to be buffered.  It simplifies things a lot to move the critical section
out of the decode phase and do it after the RPC function returns.

Also new inodes (either newly fetched or newly created) aren't properly
managed against a callback break happening before we get the local inode up
and running.

Fix this by:

 (1) There's now a combined file status and callback record (struct
     afs_status_cb) to carry both plus some flags.

 (2) Each operation wrapper function allocates sufficient afs_status_cb
     records for all the vnodes it is interested in and passes them into
     RPC operations to be filled in from the reply.

 (3) The FileStatus and CallBack record decoders no longer apply the
     new/revised status and callback information to the inode/vnode at the
     point of decoding and instead store the information into the record
     from (2).

 (4) afs_vnode_commit_status() then revises the file status, detects
     deletion and notes callback information inside of a single critical
     section.  It also checks the callback break counters and cancels the
     callback promise if they changed during the operation.

     [*] Note that "callback break counters" are counters of server events
     that cancel one or more callback promises that the client thinks it
     has.  The client counts the events and compares the counters before
     and after an operation to see if the callback promise it thinks it
     just got evaporated before it got recorded under lock.

 (5) Volume and server callback break counters are passed into afs_iget()
     allowing callback breaks concurrent with inode set up to be detected
     and the callback promise thence to be cancelled.

 (6) AFS validation checks are now done under RCU conditions using a read
     lock on cb_lock.  This requires vnode->cb_interest to be made RCU
     safe.

 (7) If the checks in (6) fail, the callback breaker is then called under
     write lock on the cb_lock - but only if the callback break counter
     didn't change from the value read before the checks were made.

 (8) Results from FS.InlineBulkStatus that correspond to inodes we
     currently have in memory are now used to update those inodes' status
     and callback information rather than being discarded.  This requires
     those inodes to be looked up before the RPC op is made and all their
     callback break values saved.

To aid in this, the following changes have also been made:

 (A) Don't pass the vnode into the reply delivery functions or the
     decoders.  The vnode shouldn't be altered anywhere in those paths.
     The only exception, for the moment, is for the call done hook for file
     lock ops that wants access to both the vnode and the call - this can
     be fixed at a later time.

 (B) Get rid of the call->reply[] void* array and replace it with named and
     typed members.  This avoids confusion since different ops were mapping
     different reply[] members to different things.

 (C) Fix an order-1 kmalloc allocation in afs_do_lookup() and replace it
     with kvcalloc().

 (D) Always get the reply time.  Since callback, lock and fileserver record
     expiry times are calculated for several RPCs, make this mandatory.

 (E) Call afs_pages_written_back() from the operation wrapper rather than
     from the delivery function.

 (F) Don't store the version and type from a callback promise in a reply as
     the information in them is of very limited use.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
---
The following changes since commit fd711586bb7d63f257da5eff234e68c446ac35ea:

  afs: Fix double inc of vnode->cb_break (2019-05-16 16:25:21 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-b-20190516

for you to fetch changes up to 39db9815da489b47b50b8e6e4fc7566a77bd18bf:

  afs: Fix application of the results of a inline bulk status fetch (2019-05-16 22:23:21 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (12):
      afs: Don't pass the vnode pointer through into the inline bulk status op
      afs: Get rid of afs_call::reply[]
      afs: Fix order-1 allocation in afs_do_lookup()
      afs: Always get the reply time
      afs: Fix application of status and callback to be under same lock
      afs: Don't save callback version and type fields
      afs: Split afs_validate() so first part can be used under LOOKUP_RCU
      afs: Make vnode->cb_interest RCU safe
      afs: Clear AFS_VNODE_CB_PROMISED if we detect callback expiry
      afs: Fix unlink to handle YFS.RemoveFile2 better
      afs: Pass pre-fetch server and volume break counts into afs_iget5_set()
      afs: Fix application of the results of a inline bulk status fetch

 fs/afs/afs.h       |  13 +-
 fs/afs/callback.c  |  21 +-
 fs/afs/cmservice.c |  14 +-
 fs/afs/dir.c       | 357 ++++++++++++++++++----------
 fs/afs/dir_silly.c |  31 ++-
 fs/afs/file.c      |  20 +-
 fs/afs/flock.c     |  40 +++-
 fs/afs/fs_probe.c  |   4 +-
 fs/afs/fsclient.c  | 673 ++++++++++++++++++-----------------------------------
 fs/afs/inode.c     | 445 ++++++++++++++++++++++++++---------
 fs/afs/internal.h  | 179 +++++++-------
 fs/afs/rotate.c    |  18 +-
 fs/afs/rxrpc.c     |  13 +-
 fs/afs/security.c  |  15 +-
 fs/afs/super.c     |  20 +-
 fs/afs/vl_probe.c  |   4 +-
 fs/afs/vlclient.c  |  34 ++-
 fs/afs/write.c     |  98 ++++----
 fs/afs/xattr.c     | 103 +++++---
 fs/afs/yfsclient.c | 662 ++++++++++++++++------------------------------------
 20 files changed, 1383 insertions(+), 1381 deletions(-)
