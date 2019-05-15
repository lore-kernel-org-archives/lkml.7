Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E38C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBBA20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEOU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOU6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:58:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B3CD30001EB;
        Wed, 15 May 2019 20:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0FF600C4;
        Wed, 15 May 2019 20:58:20 +0000 (UTC)
Subject: [PATCH 00/12] AFS callback handling fixes
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:58:19 +0100
Message-ID: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 15 May 2019 20:58:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a set of patches for AFS that fix callback handling, where a
callback indicates some sort of change to a file or volume.

The problem is that changes made by other clients aren't always noticed,
primarily because the file status information and the callback information
aren't updated in the same critical section, even if these are carried in
the same reply from an RPC operation, and so the AFS_VNODE_CB_PROMISED flag
is unreliable.

Arranging for them to be done in the same critical section for the
FS.InlineBulkStatus op is tricky as all the statuses in the reply arrive
and then all the callbacks.

Also new inodes (either newly fetched or newly created) aren't properly
managed against a callback break happening before we get the local inode up
and running.

[*] Note that callback break counters as mentioned here are counters of
    server events that cancel one or more callback promises that the client
    thinks it has.  A broken promise indicates that the client needs to
    refetch a vnode's status from the server.

    This client counts the events and compares the counters before and
    after the operation to see if the callback promise it thinks it just
    got evaporated before it got recorded.

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

 (4) afs_vnode_commit_status() then detects deletion, revises the file
     status and notes callback information inside of a single critical
     section.  It also checks the callback break counters and cancels the
     callback promise if they changed during the operation.

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


The patches can be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git
	tag afs-fixes-b-20190515

David
---
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


 fs/afs/afs.h       |   13 +
 fs/afs/callback.c  |   21 +-
 fs/afs/cmservice.c |   14 +
 fs/afs/dir.c       |  357 +++++++++++++++++++---------
 fs/afs/dir_silly.c |   31 ++
 fs/afs/file.c      |   20 +-
 fs/afs/flock.c     |   13 -
 fs/afs/fs_probe.c  |    4 
 fs/afs/fsclient.c  |  657 +++++++++++++++++-----------------------------------
 fs/afs/inode.c     |  444 +++++++++++++++++++++++++++--------
 fs/afs/internal.h  |  167 +++++++------
 fs/afs/rotate.c    |   18 +
 fs/afs/rxrpc.c     |   13 -
 fs/afs/security.c  |   15 +
 fs/afs/super.c     |   20 +-
 fs/afs/vl_probe.c  |    4 
 fs/afs/vlclient.c  |   34 +--
 fs/afs/write.c     |   98 ++++----
 fs/afs/xattr.c     |  103 ++++++--
 fs/afs/yfsclient.c |  652 +++++++++++++++-------------------------------------
 20 files changed, 1335 insertions(+), 1363 deletions(-)

