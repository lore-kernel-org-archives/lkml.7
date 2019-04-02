Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A8FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA620856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfDBNr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:47:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43002 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731302AbfDBNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:03 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002ny-NW; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0004tQ-OT; Tue, 02 Apr 2019 14:39:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Filipe Manana" <fdmanana@suse.com>, "Chris Mason" <clm@fb.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.919816124@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 37/99] Btrfs: fix stale dir entries after unlink,
 inode eviction and fsync
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit bde6c242027b0f1d697d5333950b3a05761d40e4 upstream.

If we remove a hard link from an inode, the inode gets evicted, then
we fsync the inode and then power fail/crash, when the log tree is
replayed, the parent directory inode still has entries pointing to
the name that no longer exists, while our inode no longer has the
BTRFS_INODE_REF_KEY item matching the deleted hard link (as expected),
leaving the filesystem in an inconsistent state. The stale directory
entries can not be deleted (an attempt to delete them causes -ESTALE
errors), which makes it impossible to delete the parent directory.

This happens because we track the id of the transaction where the last
unlink operation for the inode happened (last_unlink_trans) in an
in-memory only field of the inode, that is, a value that is never
persisted in the inode item stored on the fs/subvol btree. So if an
inode is evicted and loaded again, the value for last_unlink_trans is
set to 0, which prevents the fsync from logging the parent directory
at btrfs_log_inode_parent(). So fix this by setting last_unlink_trans
to the id of the transaction that last modified the inode when we
load the inode. This is a pessimistic approach but it always ensures
correctness with the trade off of ocassional full transaction commits
when an fsync is done against the inode in the same transaction where
it was evicted and reloaded when our inode is a directory and often
logging its parent unnecessarily when our inode is not a directory.

The following test case for fstests triggers the problem:

  seq=`basename $0`
  seqres=$RESULT_DIR/$seq
  echo "QA output created by $seq"
  tmp=/tmp/$$
  status=1	# failure is the default!
  trap "_cleanup; exit \$status" 0 1 2 3 15

  _cleanup()
  {
      _cleanup_flakey
      rm -f $tmp.*
  }

  # get standard environment, filters and checks
  . ./common/rc
  . ./common/filter
  . ./common/dmflakey

  # real QA test starts here
  _need_to_be_root
  _supported_fs generic
  _supported_os Linux
  _require_scratch
  _require_dm_flakey
  _require_metadata_journaling $SCRATCH_DEV

  rm -f $seqres.full

  _scratch_mkfs >>$seqres.full 2>&1
  _init_flakey
  _mount_flakey

  # Create our test file with 2 hard links.
  mkdir $SCRATCH_MNT/testdir
  touch $SCRATCH_MNT/testdir/foo
  ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar

  # Make sure everything done so far is durably persisted.
  sync

  # Now remove one of the links, trigger inode eviction and then fsync
  # our inode.
  unlink $SCRATCH_MNT/testdir/bar
  echo 2 > /proc/sys/vm/drop_caches
  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/foo

  # Silently drop all writes on our scratch device to simulate a power failure.
  _load_flakey_table $FLAKEY_DROP_WRITES
  _unmount_flakey

  # Allow writes again and mount the fs to trigger log/journal replay.
  _load_flakey_table $FLAKEY_ALLOW_WRITES
  _mount_flakey

  # Now verify our directory entries.
  echo "Entries in testdir:"
  ls -1 $SCRATCH_MNT/testdir

  # If we remove our inode, its parent should become empty and therefore we should
  # be able to remove the parent.
  rm -f $SCRATCH_MNT/testdir/*
  rmdir $SCRATCH_MNT/testdir

  _unmount_flakey

  # The fstests framework will call fsck against our filesystem which will verify
  # that all metadata is in a consistent state.

  status=0
  exit

The test failed on btrfs with:

  generic/098 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/098.out.bad)
>   --- tests/generic/098.out	2015-07-23 18:01:12.616175932 +0100
>   +++ /home/fdmanana/git/hub/xfstests/results//generic/098.out.bad	2015-07-23 18:04:58.924138308 +0100
    @@ -1,3 +1,6 @@
     QA output created by 098
     Entries in testdir:
    +bar
     foo
    +rm: cannot remove '/home/fdmanana/btrfs-tests/scratch_1/testdir/foo': Stale file handle
    +rmdir: failed to remove '/home/fdmanana/btrfs-tests/scratch_1/testdir': Directory not empty
    ...
    (Run 'diff -u tests/generic/098.out /home/fdmanana/git/hub/xfstests/results//generic/098.out.bad'  to see the entire diff)
  _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent (see /home/fdmanana/git/hub/xfstests/results//generic/098.full)

  $ cat /home/fdmanana/git/hub/xfstests/results//generic/098.full
  (...)
  checking fs roots
  root 5 inode 258 errors 2001, no inode item, link count wrong
     unresolved ref dir 257 index 0 namelen 3 name foo filetype 1 errors 6, no dir index, no inode ref
     unresolved ref dir 257 index 3 namelen 3 name bar filetype 1 errors 5, no dir item, no inode ref
  Checking filesystem on /dev/sdc
  (...)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3533,6 +3533,35 @@ cache_index:
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
 
+	/*
+	 * We don't persist the id of the transaction where an unlink operation
+	 * against the inode was last made. So here we assume the inode might
+	 * have been evicted, and therefore the exact value of last_unlink_trans
+	 * lost, and set it to last_trans to avoid metadata inconsistencies
+	 * between the inode and its parent if the inode is fsync'ed and the log
+	 * replayed. For example, in the scenario:
+	 *
+	 * touch mydir/foo
+	 * ln mydir/foo mydir/bar
+	 * sync
+	 * unlink mydir/bar
+	 * echo 2 > /proc/sys/vm/drop_caches   # evicts inode
+	 * xfs_io -c fsync mydir/foo
+	 * <power failure>
+	 * mount fs, triggers fsync log replay
+	 *
+	 * We must make sure that when we fsync our inode foo we also log its
+	 * parent inode, otherwise after log replay the parent still has the
+	 * dentry with the "bar" name but our inode foo has a link count of 1
+	 * and doesn't have an inode ref with the name "bar" anymore.
+	 *
+	 * Setting last_unlink_trans to last_trans is a pessimistic approach,
+	 * but it guarantees correctness at the expense of ocassional full
+	 * transaction commits on fsync if our inode is a directory, or if our
+	 * inode is not a directory, logging its parent unnecessarily.
+	 */
+	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+
 	path->slots[0]++;
 	if (inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))

