Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB03C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3298E20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfCAPJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:09:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:41174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfCAPJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:09:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1A9BAC91;
        Fri,  1 Mar 2019 15:08:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 46E4D1E13E2; Fri,  1 Mar 2019 16:08:59 +0100 (CET)
Date:   Fri, 1 Mar 2019 16:08:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext2 and udf fixes for v5.1-rc1
Message-ID: <20190301150859.GA15758@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.1-rc1

to get a couple of fixes for udf and ext2. Namely:
* fix making ext2 mountable (again) with 64k blocksize
* fix for ext2 statx(2) handling
* fix for udf handling of corrupted filesystem so that it doesn't get
  corrupted even further
* couple smaller ext2 and udf cleanups

Top of the tree is 52b9666efd8b. The full shortlog is:

Chengguang Xu (1):
      ext2: set proper return code

Jan Kara (3):
      ext2: Set superblock revision when enabling xattr feature
      ext2: Fix underflow in ext2_max_size()
      udf: Drop pointless check from udf_sync_fs()

Liu Xiang (3):
      ext2: Remove redundant check on s_inode_size
      ext2: Remove redundant check for finding no group
      ext2: Fix a typo in comment

Mathieu Malaterre (1):
      ext2: Annotate implicit fall through in __ext2_truncate_blocks

Steve Magnani (3):
      udf: factor out LVID finalization for reuse
      udf: finalize integrity descriptor before writeback
      udf: disallow RW mount without valid integrity descriptor

yangerkun (1):
      ext2: support statx syscall

The diffstat is

 fs/ext2/ext2.h    |  1 +
 fs/ext2/file.c    |  1 +
 fs/ext2/ialloc.c  |  2 --
 fs/ext2/inode.c   | 30 +++++++++++++++++++++++++++++-
 fs/ext2/namei.c   |  2 ++
 fs/ext2/super.c   | 44 ++++++++++++++++++++++++++++----------------
 fs/ext2/symlink.c |  2 ++
 fs/ext2/xattr.c   |  1 +
 fs/udf/super.c    | 51 +++++++++++++++++++++++++++++++++------------------
 9 files changed, 97 insertions(+), 37 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
