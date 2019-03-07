Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B06C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AA820851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3ci0+DXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGQy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:54:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40964 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:54:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x27GsMxY157085;
        Thu, 7 Mar 2019 16:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=XJ8zo00+mA17ru72FYKdhrIzQtlHT11GTYy+ND5g5eE=;
 b=3ci0+DXAdUZeTmwNFd5cixsmckqVEcJebC6MF+z+q3/AIwD4Q54Io5Oj8RLN05rsBEQ+
 fOpXuElSQevxscsCNCXLXfbIDDnRJ+r1jcrWCInDoodtiXYxMZkvMEKjuqhLiu2OwpNp
 5SsUne7KUoZzMh3wY7eOVpAmDeWIZjkDIeMCuEJar8JlwViX6XpNrzy2pXwA+7VZcoDn
 A5r0Iu5eKZB7Q26cKSyx6vJQl0/FjF99Q60eFmnkQW0uPypNfmDUlKZyBmZX4hj0W7/T
 xa/rJX2LND/iwEYCYCXSwH4lAW1i1YhKV6+53sLxySN4nj6BRBmkXfGXOx4bir4G464g bQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfrub0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Mar 2019 16:54:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x27GshP8001731
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 16:54:43 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x27GsgsZ026907;
        Thu, 7 Mar 2019 16:54:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Mar 2019 08:54:42 -0800
Date:   Thu, 7 Mar 2019 08:54:41 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new features for v5.1
Message-ID: <20190307165441.GA20533@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a number of new features and bug fixes for 5.1.  They've
undergone a week's worth of fstesting and merge cleanly with master as
of this morning.  Most of the changes center on improving metadata
validation and fixing problems with online fsck, though there's also a
new cache to speed up unlinked inode handling and cleanup of the copy on
write code in preparation for future features.  Let me know if you
encounter any problems with this merge.

--D

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.1-merge-4

for you to fetch changes up to 1b9598c8fb9965fff901c4caa21fed9644c34df3:

  xfs: fix reporting supported extra file attributes for statx() (2019-03-01 08:57:25 -0800)

----------------------------------------------------------------
Changes for Linux 5.1:
- Fix online fsck to handle inode btrees correctly on 64k block
  filesystems.
- Teach online fsck to check directory and attribute names for invalid
  characters.
- Miscellanous fixes for online fsck.
- Introduce a new panic mask so that we can halt immediately on
  metadata corruption (for debugging purposes)
- Fix a block mapping race during writeback.
- Cache unlinked inode list backrefs in memory to speed up list
  processing.
- Separate the bnobt/cntbt and inobt/finobt buffer verifiers so that we
  can detect crosslinked btrees.
- Refactor magic number verification so that we can standardize it.
- Strengthen ondisk metadata structure offset build time verification.
- Fix a memory corruption problem in the listxattr code.
- Fix a shutdown problem during log recovery due to unreserved finobt
  expansion.
- Fix a referential integrity problem where O_TMPFILE inodes were put on
  the unlinked list with nlink > 0 which would cause asserts during log
  recovery if the system went down immediately.
- Refactor the delayed allocation allocator to be more clever about the
  possibility that its mapping might be stale.
- Various fixes to the copy on write mechanism.
- Make CoW preallocation suitable for use even with writes that wouldn't
  otherwise require it.
- Refactor an internal API.
- Fix some statx implementation bugs.
- Fix miscellaneous compiler and static checker complaints.

----------------------------------------------------------------
Brian Foster (15):
      xfs: update fork seq counter on data fork changes
      xfs: validate writeback mapping using data fork seq counter
      xfs: remove superfluous writeback mapping eof trimming
      xfs: create delalloc bmapi wrapper for full extent allocation
      xfs: use the latest extent at writeback delalloc conversion time
      xfs: clarify documentation for the function to reverify buffers
      xfs: always check magic values in on-disk byte order
      xfs: create a separate finobt verifier
      xfs: distinguish between inobt and finobt magic values
      xfs: split up allocation btree verifier
      xfs: distinguish between bnobt and cntbt magic values
      xfs: use verifier magic field in dir2 leaf verifiers
      xfs: miscellaneous verifier magic value fixups
      xfs: factor xfs_da3_blkinfo verification into common helper
      xfs: compile time offset checks for common v4/v5 metadata

Christoph Hellwig (18):
      xfs: remove the io_type field from the writeback context and ioend
      xfs: remove the s_maxbytes checks in xfs_map_blocks
      xfs: simplify the xfs_bmap_btree_to_extents calling conventions
      xfs: factor out two helpers from xfs_bmapi_write
      xfs: split XFS_BMAPI_DELALLOC handling from xfs_bmapi_write
      xfs: move transaction handling to xfs_bmapi_convert_delalloc
      xfs: move stat accounting to xfs_bmapi_convert_delalloc
      xfs: move xfs_iomap_write_allocate to xfs_aops.c
      xfs: remove the truncate short cut in xfs_map_blocks
      xfs: retry COW fork delalloc conversion when no extent was found
      xfs: make xfs_bmbt_to_iomap more useful
      xfs: fix SEEK_DATA for speculative COW fork preallocation
      xfs: don't use delalloc extents for COW on files with extsize hints
      xfs: also truncate holes covered by COW blocks
      xfs: merge COW handling into xfs_file_iomap_begin_delay
      xfs: make COW fork unwritten extent conversions more robust
      xfs: report IOMAP_F_SHARED from xfs_file_iomap_begin_delay
      xfs: introduce an always_cow mode

Colin Ian King (1):
      xfs: fix uninitialized error variable

Darrick J. Wong (33):
      xfs: never try to scrub more than 64 inodes per inobt record
      xfs: check the ir_startino alignment directly
      xfs: check inobt record alignment on big block filesystems
      xfs: hoist inode cluster checks out of loop
      xfs: clean up the inode cluster checking in the inobt scrub
      xfs: scrub big block inode btrees correctly
      xfs: consolidate scrub dinode mapping code into a single function
      xfs: abort xattr scrub if fatal signals are pending
      xfs: scrub should flag dir/attr offsets that aren't mappable with xfs_dablk_t
      xfs: fix off-by-one error in rtbitmap cross-reference
      xfs: check directory name validity
      xfs: check attribute name validity
      xfs: clean up iunlink functions
      xfs: add xfs_verify_agino_or_null helper
      xfs: refactor AGI unlinked bucket updates
      xfs: strengthen AGI unlinked inode bucket pointer checks
      xfs: refactor inode unlinked pointer update functions
      xfs: refactor unlinked list search and mapping to a separate function
      xfs: refactor inode update in iunlink_remove
      xfs: add tracepoints for high level iunlink operations
      xfs: cache unlinked pointers in an rhashtable
      xfs: add inode magic to inode verifier
      xfs: add magic numbers to dquot buffer ops
      xfs: use buf ops magic to detect btree block type
      xfs: don't overflow xattr listent buffer
      xfs: rename m_inotbt_nores to m_finobt_nores
      xfs: reserve blocks for ifree transaction during log recovery
      xfs: don't ever put nlink > 0 inodes on the unlinked list
      xfs: fix xfs_buf magic number endian checks
      xfs: don't pass iomap flags to xfs_reflink_allocate_cow
      xfs: rework breaking of shared extents in xfs_file_iomap_begin
      xfs: fix uninitialized error variables
      xfs: fix backwards endian conversion in scrub

Luis R. Rodriguez (1):
      xfs: fix reporting supported extra file attributes for statx()

Marco Benatto (1):
      xfs: Introduce XFS_PTAG_VERIFIER_ERROR panic mask

YueHaibing (1):
      xfs: remove duplicated xfs_defer.h

 Documentation/filesystems/xfs.txt  |   3 +-
 fs/xfs/libxfs/xfs_ag.c             |   6 +-
 fs/xfs/libxfs/xfs_ag_resv.c        |   2 +-
 fs/xfs/libxfs/xfs_alloc.c          |  12 +-
 fs/xfs/libxfs/xfs_alloc_btree.c    |  74 ++--
 fs/xfs/libxfs/xfs_attr.c           |  17 +
 fs/xfs/libxfs/xfs_attr.h           |   2 +-
 fs/xfs/libxfs/xfs_attr_leaf.c      |  21 +-
 fs/xfs/libxfs/xfs_attr_remote.c    |   8 +-
 fs/xfs/libxfs/xfs_bmap.c           | 302 +++++++++------
 fs/xfs/libxfs/xfs_bmap.h           |  16 +-
 fs/xfs/libxfs/xfs_bmap_btree.c     |  13 +-
 fs/xfs/libxfs/xfs_da_btree.c       |  49 ++-
 fs/xfs/libxfs/xfs_da_format.h      |   3 +
 fs/xfs/libxfs/xfs_dir2.c           |  17 +
 fs/xfs/libxfs/xfs_dir2.h           |   1 +
 fs/xfs/libxfs/xfs_dir2_block.c     |  10 +-
 fs/xfs/libxfs/xfs_dir2_data.c      |  12 +-
 fs/xfs/libxfs/xfs_dir2_leaf.c      | 100 +----
 fs/xfs/libxfs/xfs_dir2_node.c      |  10 +-
 fs/xfs/libxfs/xfs_dquot_buf.c      |   4 +
 fs/xfs/libxfs/xfs_errortag.h       |   4 +-
 fs/xfs/libxfs/xfs_ialloc.c         |   3 +-
 fs/xfs/libxfs/xfs_ialloc_btree.c   |  29 +-
 fs/xfs/libxfs/xfs_iext_tree.c      |  13 +-
 fs/xfs/libxfs/xfs_inode_buf.c      |  11 +-
 fs/xfs/libxfs/xfs_inode_fork.h     |   2 +-
 fs/xfs/libxfs/xfs_refcount_btree.c |   3 +-
 fs/xfs/libxfs/xfs_rmap_btree.c     |   3 +-
 fs/xfs/libxfs/xfs_sb.c             |   7 +-
 fs/xfs/libxfs/xfs_shared.h         |   4 +-
 fs/xfs/libxfs/xfs_symlink_remote.c |   3 +-
 fs/xfs/libxfs/xfs_types.c          |  24 ++
 fs/xfs/libxfs/xfs_types.h          |   3 +
 fs/xfs/scrub/agheader.c            |  10 +-
 fs/xfs/scrub/agheader_repair.c     |  12 +-
 fs/xfs/scrub/attr.c                |  11 +
 fs/xfs/scrub/bmap.c                |  27 ++
 fs/xfs/scrub/dir.c                 |   6 +
 fs/xfs/scrub/ialloc.c              | 330 +++++++++++-----
 fs/xfs/scrub/repair.c              |   3 +-
 fs/xfs/scrub/repair.h              |   3 -
 fs/xfs/scrub/rtbitmap.c            |   5 +-
 fs/xfs/scrub/trace.h               |  45 +++
 fs/xfs/xfs_aops.c                  | 266 +++++++------
 fs/xfs/xfs_aops.h                  |  24 +-
 fs/xfs/xfs_attr_list.c             |   1 +
 fs/xfs/xfs_bmap_util.c             |   9 +-
 fs/xfs/xfs_buf.c                   |  72 +++-
 fs/xfs/xfs_buf.h                   |   8 +-
 fs/xfs/xfs_error.c                 |   6 +-
 fs/xfs/xfs_error.h                 |   1 +
 fs/xfs/xfs_file.c                  |  31 +-
 fs/xfs/xfs_fsops.c                 |   1 +
 fs/xfs/xfs_globals.c               |   2 +-
 fs/xfs/xfs_inode.c                 | 769 +++++++++++++++++++++++++++----------
 fs/xfs/xfs_inode.h                 |   3 +
 fs/xfs/xfs_iomap.c                 | 518 ++++++++++++-------------
 fs/xfs/xfs_iomap.h                 |   7 +-
 fs/xfs/xfs_iops.c                  |  21 +-
 fs/xfs/xfs_log_recover.c           |  14 +-
 fs/xfs/xfs_mount.c                 |   5 +
 fs/xfs/xfs_mount.h                 |  10 +-
 fs/xfs/xfs_ondisk.h                |  21 +
 fs/xfs/xfs_pnfs.c                  |   2 +-
 fs/xfs/xfs_reflink.c               | 150 +++-----
 fs/xfs/xfs_reflink.h               |  18 +-
 fs/xfs/xfs_super.c                 |  22 +-
 fs/xfs/xfs_sysctl.h                |   1 +
 fs/xfs/xfs_sysfs.c                 |  24 ++
 fs/xfs/xfs_trace.h                 | 115 ++++--
 fs/xfs/xfs_trans_bmap.c            |   1 -
 fs/xfs/xfs_trans_buf.c             |   2 +-
 fs/xfs/xfs_trans_extfree.c         |   1 -
 fs/xfs/xfs_trans_refcount.c        |   1 -
 fs/xfs/xfs_trans_rmap.c            |   1 -
 fs/xfs/xfs_xattr.c                 |   3 +
 77 files changed, 2134 insertions(+), 1239 deletions(-)
