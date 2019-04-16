Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfDPRtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:49:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57418 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:49:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSCa-0005Jv-Sa; Tue, 16 Apr 2019 17:49:00 +0000
Date:   Tue, 16 Apr 2019 18:49:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCHSET] sorting out RCU-delayed stuff in ->destroy_inode()
Message-ID: <20190416174900.GT2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	We have a lot of boilerplate in ->destroy_inode()
instances, and several filesystems got the things wrong
in that area.  The patchset below attempts to deal with that.

	New method (void ->free_inode(inode)) is introduced,
and RCU-delayed parts of ->destroy_inode() are moved there.
The change is backwards-compatible - unmodified filesystem
will behave as it used to.  Rules:
	->destroy_inode		->free_inode
	f			g		f(), rcu-delayed g()
	f			NULL		f()
	NULL			g		rcu-delayed g()
	NULL			NULL		rcu-delayed free_inode_nonrcu()
IOW, NULL/NULL acts as NULL/free_inode_nonrcu.

	For a lot of filesystems ->destroy_inode() used to consist
only of call_rcu(foo_i_callback, &inode->i_rcu).  Those simply get
rid of ->destroy_inode() and have the callback (with saner prototype)
become their ->free_inode().

	Filesystems with NULL ->destroy_inode() are simply left as-is
and so are the filesystems that don't have RCU-delayed call (pipefs,
xfs, btrfs-tests).

	Filesystems that have both synchronous work and RCU-delayed
call of a callback are more interesting.  In any case, the callback
can be converted to ->free_inode().  Sometimes that's all we can
reasonably do there - the rest is left in ->destroy_inode() and that's
it.  However, for some of those we can do more:
	* some of the synchronous stuff can just as well live in
RCU callback; such can be moved to ->free_inode().
	* some of the synchronous stuff is a better fit for ->evict_inode();
e.g. the code that's undoing something done after the ->alloc_inode() or
sanity checks on the inode state.
	I've done that in the obvious cases; the few non-obvious are up to
fs maintainers - they can be done as followups at any point.

The series lives in vfs.git#work.icache; patchbomb in followups.  Overview:

* a couple of missed fixes for ->i_link freed to early; -stable fodder:
      securityfs: fix use-after-free on symlink traversal
      apparmorfs: fix use-after-free on symlink traversal
* infrastructure:
      new inode method: ->free_inode()
* simple conversions (->destroy_inode() consisting only of call_rcu())
      spufs: switch to ->free_inode()
      erofs: switch to ->free_inode()
      9p: switch to ->free_inode()
      adfs: switch to ->free_inode()
      affs: switch to ->free_inode()
      befs: switch to ->free_inode()
      bfs: switch to ->free_inode()
      bdev: switch to ->free_inode()
      cifs: switch to ->free_inode()
      debugfs: switch to ->free_inode()
      efs: switch to ->free_inode()
      ext2: switch to ->free_inode()
      f2fs: switch to ->free_inode()
      fat: switch to ->free_inode()
      freevxfs: switch to ->free_inode()
      gfs2: switch to ->free_inode()
      hfs: switch to ->free_inode()
      hfsplus: switch to ->free_inode()
      hostfs: switch to ->free_inode()
      hpfs: switch to ->free_inode()
      isofs: switch to ->free_inode()
      jffs2: switch to ->free_inode()
      minix: switch to ->free_inode()
      nfs{,4}: switch to ->free_inode()
      nilfs2: switch to ->free_inode()
      dlmfs: switch to ->free_inode()
      ocfs2: switch to ->free_inode()
      openpromfs: switch to ->free_inode()
      procfs: switch to ->free_inode()
      qnx4: switch to ->free_inode()
      qnx6: switch to ->free_inode()
      reiserfs: convert to ->free_inode()
      romfs: convert to ->free_inode()
      squashfs: switch to ->free_inode()
      ubifs: switch to ->free_inode()
      udf: switch to ->free_inode()
      sysv: switch to ->free_inode()
      coda: switch to ->free_inode()
      ufs: switch to ->free_inode()
      mqueue: switch to ->free_inode()
      bpf: switch to ->free_inode()
      rpcpipe: switch to ->free_inode()
      apparmor: switch to ->free_inode()
      securityfs: switch to ->free_inode()
      ntfs: switch to ->free_inode()
* cases where ->destroy_inode() contains both synchronous and delayed
parts; fuse, jfs have their ->destroy_inode() dissolved and
I'd like an ACK from their maintainers:
      dax: make use of ->free_inode()
      afs: switch to use of ->free_inode()
      btrfs: use ->free_inode()
      ceph: use ->free_inode()
      ecryptfs: make use of ->free_inode()
      ext4: make use of ->free_inode()
      fuse: switch to ->free_inode()
      jfs: switch to ->free_inode()
      overlayfs: make use of ->free_inode()
      hugetlb: make use of ->free_inode()
      shmem: make use of ->free_inode()
      orangefs: make use of ->free_inode()
* sockets: sockfs is a case where everything can be moved to ->free_inode();
we are RCU-delaying the freeing of socket_wq anyway, so we might as well
combine that with freeing the socket_alloc itself.  That allows to get
rid of separate allocations for those, which simplifies the things nicely.
We obviously need an ACK from networking folks on the last pair of commits.
      sockfs: switch to ->free_inode()
      coallocate socket->wq with socket itself

I have *not* included an update of vfs.txt into that branch, since
there's a big patchset converting it to a different format.  I have
a tentative variant of documentation on the tail-end of inode lifecycle,
but it still needs more work; I want to sort out the situation with
writeback for "don't retain inodes in icache" case first...

Diffstat:
 Documentation/filesystems/Locking         |  2 ++
 Documentation/filesystems/porting         | 17 ++++++++++
 arch/powerpc/platforms/cell/spufs/inode.c | 10 ++----
 drivers/dax/super.c                       |  7 ++--
 drivers/net/tap.c                         |  5 ++-
 drivers/net/tun.c                         |  8 ++---
 drivers/staging/erofs/super.c             | 10 ++----
 fs/9p/v9fs_vfs.h                          |  2 +-
 fs/9p/vfs_inode.c                         | 10 ++----
 fs/9p/vfs_super.c                         |  4 +--
 fs/adfs/super.c                           | 10 ++----
 fs/affs/super.c                           | 10 ++----
 fs/afs/super.c                            |  9 +++---
 fs/aio.c                                  |  4 +--
 fs/befs/linuxvfs.c                        | 12 ++-----
 fs/bfs/inode.c                            | 10 ++----
 fs/block_dev.c                            | 14 ++------
 fs/btrfs/ctree.h                          |  1 +
 fs/btrfs/inode.c                          |  7 ++--
 fs/btrfs/super.c                          |  1 +
 fs/ceph/inode.c                           |  5 +--
 fs/ceph/super.c                           |  1 +
 fs/ceph/super.h                           |  1 +
 fs/cifs/cifsfs.c                          | 12 ++-----
 fs/coda/inode.c                           | 10 ++----
 fs/debugfs/inode.c                        | 10 ++----
 fs/ecryptfs/super.c                       |  5 ++-
 fs/efs/super.c                            | 10 ++----
 fs/ext2/super.c                           | 10 ++----
 fs/ext4/super.c                           |  5 ++-
 fs/f2fs/super.c                           | 10 ++----
 fs/fat/inode.c                            | 10 ++----
 fs/freevxfs/vxfs_super.c                  | 11 ++-----
 fs/fuse/inode.c                           | 24 ++++++--------
 fs/gfs2/super.c                           | 12 ++-----
 fs/hfs/super.c                            | 10 ++----
 fs/hfsplus/super.c                        | 13 ++------
 fs/hostfs/hostfs_kern.c                   | 10 ++----
 fs/hpfs/super.c                           | 10 ++----
 fs/hugetlbfs/inode.c                      |  5 ++-
 fs/inode.c                                | 54 ++++++++++++++++++-------------
 fs/isofs/inode.c                          | 10 ++----
 fs/jffs2/super.c                          | 10 ++----
 fs/jfs/inode.c                            | 13 ++++++++
 fs/jfs/super.c                            | 24 ++------------
 fs/minix/inode.c                          | 10 ++----
 fs/nfs/inode.c                            | 10 ++----
 fs/nfs/internal.h                         |  2 +-
 fs/nfs/nfs4super.c                        |  2 +-
 fs/nfs/super.c                            |  2 +-
 fs/nilfs2/nilfs.h                         |  2 --
 fs/nilfs2/super.c                         | 11 ++-----
 fs/ntfs/inode.c                           | 17 +++-------
 fs/ntfs/inode.h                           |  2 +-
 fs/ntfs/super.c                           |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c                    | 10 ++----
 fs/ocfs2/super.c                          | 12 ++-----
 fs/openpromfs/inode.c                     | 10 ++----
 fs/orangefs/super.c                       |  9 ++----
 fs/overlayfs/super.c                      | 13 ++++----
 fs/proc/inode.c                           | 10 ++----
 fs/qnx4/inode.c                           | 12 ++-----
 fs/qnx6/inode.c                           | 12 ++-----
 fs/reiserfs/super.c                       | 10 ++----
 fs/romfs/super.c                          | 11 ++-----
 fs/squashfs/super.c                       | 11 ++-----
 fs/sysv/inode.c                           | 10 ++----
 fs/ubifs/super.c                          | 10 ++----
 fs/udf/super.c                            | 10 ++----
 fs/ufs/super.c                            | 10 ++----
 include/linux/fs.h                        |  1 +
 include/linux/if_tap.h                    |  1 -
 include/linux/net.h                       |  4 +--
 include/net/sock.h                        |  4 +--
 ipc/mqueue.c                              | 10 ++----
 kernel/bpf/inode.c                        | 10 ++----
 lib/iov_iter.c                            |  4 +++
 mm/shmem.c                                |  5 ++-
 net/core/sock.c                           |  2 +-
 net/socket.c                              | 23 ++++---------
 net/sunrpc/rpc_pipe.c                     | 11 ++-----
 security/apparmor/apparmorfs.c            |  7 ++--
 security/inode.c                          |  7 ++--
 83 files changed, 241 insertions(+), 516 deletions(-)
