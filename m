Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D60C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BEC2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCNOws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:52:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:16604 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfCNOwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:52:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 07:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="125454391"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Mar 2019 07:52:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h4Riu-000BVv-Lf; Thu, 14 Mar 2019 22:52:44 +0800
Date:   Thu, 14 Mar 2019 22:51:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     kbuild-all@01.org, kjlu@umn.edu, pakki001@umn.edu,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: affs: fix a NULL pointer dereference
Message-ID: <201903142217.lKA0aVxd%lkp@intel.com>
References: <20190314074607.28041-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314074607.28041-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0 next-20190306]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/fs-affs-fix-a-NULL-pointer-dereference/20190314-170334
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   fs/affs/file.c:525:23: sparse: expression using sizeof(void)
   fs/affs/file.c:525:23: sparse: expression using sizeof(void)
   fs/affs/file.c:558:23: sparse: expression using sizeof(void)
   fs/affs/file.c:558:23: sparse: expression using sizeof(void)
   fs/affs/file.c:577:23: sparse: expression using sizeof(void)
   fs/affs/file.c:577:23: sparse: expression using sizeof(void)
   fs/affs/file.c:706:23: sparse: expression using sizeof(void)
   fs/affs/file.c:706:23: sparse: expression using sizeof(void)
   fs/affs/file.c:759:23: sparse: expression using sizeof(void)
   fs/affs/file.c:759:23: sparse: expression using sizeof(void)
>> fs/affs/file.c:946:40: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] ext_bk @@    got igned] [usertype] ext_bk @@
   fs/affs/file.c:946:40:    expected unsigned int [unsigned] [usertype] ext_bk
   fs/affs/file.c:946:40:    got restricted __be32 <noident>
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32
>> fs/affs/file.c:947:53: sparse: cast to restricted __be32

vim +946 fs/affs/file.c

   833	
   834	void
   835	affs_truncate(struct inode *inode)
   836	{
   837		struct super_block *sb = inode->i_sb;
   838		u32 ext, ext_key, ext_bk;
   839		u32 last_blk, blkcnt, blk;
   840		u32 size;
   841		struct buffer_head *ext_bh;
   842		int i;
   843	
   844		pr_debug("truncate(inode=%lu, oldsize=%llu, newsize=%llu)\n",
   845			 inode->i_ino, AFFS_I(inode)->mmu_private, inode->i_size);
   846	
   847		last_blk = 0;
   848		ext = 0;
   849		if (inode->i_size) {
   850			last_blk = ((u32)inode->i_size - 1) / AFFS_SB(sb)->s_data_blksize;
   851			ext = last_blk / AFFS_SB(sb)->s_hashsize;
   852		}
   853	
   854		if (inode->i_size > AFFS_I(inode)->mmu_private) {
   855			struct address_space *mapping = inode->i_mapping;
   856			struct page *page;
   857			void *fsdata;
   858			loff_t isize = inode->i_size;
   859			int res;
   860	
   861			res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, 0, &page, &fsdata);
   862			if (!res)
   863				res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page, fsdata);
   864			else
   865				inode->i_size = AFFS_I(inode)->mmu_private;
   866			mark_inode_dirty(inode);
   867			return;
   868		} else if (inode->i_size == AFFS_I(inode)->mmu_private)
   869			return;
   870	
   871		// lock cache
   872		ext_bh = affs_get_extblock(inode, ext);
   873		if (IS_ERR(ext_bh)) {
   874			affs_warning(sb, "truncate",
   875				     "unexpected read error for ext block %u (%ld)",
   876				     ext, PTR_ERR(ext_bh));
   877			return;
   878		}
   879		if (AFFS_I(inode)->i_lc) {
   880			/* clear linear cache */
   881			i = (ext + 1) >> AFFS_I(inode)->i_lc_shift;
   882			if (AFFS_I(inode)->i_lc_size > i) {
   883				AFFS_I(inode)->i_lc_size = i;
   884				for (; i < AFFS_LC_SIZE; i++)
   885					AFFS_I(inode)->i_lc[i] = 0;
   886			}
   887			/* clear associative cache */
   888			for (i = 0; i < AFFS_AC_SIZE; i++)
   889				if (AFFS_I(inode)->i_ac[i].ext >= ext)
   890					AFFS_I(inode)->i_ac[i].ext = 0;
   891		}
   892		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
   893	
   894		blkcnt = AFFS_I(inode)->i_blkcnt;
   895		i = 0;
   896		blk = last_blk;
   897		if (inode->i_size) {
   898			i = last_blk % AFFS_SB(sb)->s_hashsize + 1;
   899			blk++;
   900		} else
   901			AFFS_HEAD(ext_bh)->first_data = 0;
   902		AFFS_HEAD(ext_bh)->block_count = cpu_to_be32(i);
   903		size = AFFS_SB(sb)->s_hashsize;
   904		if (size > blkcnt - blk + i)
   905			size = blkcnt - blk + i;
   906		for (; i < size; i++, blk++) {
   907			affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
   908			AFFS_BLOCK(sb, ext_bh, i) = 0;
   909		}
   910		AFFS_TAIL(sb, ext_bh)->extension = 0;
   911		affs_fix_checksum(sb, ext_bh);
   912		mark_buffer_dirty_inode(ext_bh, inode);
   913		affs_brelse(ext_bh);
   914	
   915		if (inode->i_size) {
   916			AFFS_I(inode)->i_blkcnt = last_blk + 1;
   917			AFFS_I(inode)->i_extcnt = ext + 1;
   918			if (affs_test_opt(AFFS_SB(sb)->s_flags, SF_OFS)) {
   919				struct buffer_head *bh = affs_bread_ino(inode, last_blk, 0);
   920				u32 tmp;
   921				if (IS_ERR(bh)) {
   922					affs_warning(sb, "truncate",
   923						     "unexpected read error for last block %u (%ld)",
   924						     ext, PTR_ERR(bh));
   925					return;
   926				}
   927				tmp = be32_to_cpu(AFFS_DATA_HEAD(bh)->next);
   928				AFFS_DATA_HEAD(bh)->next = 0;
   929				affs_adjust_checksum(bh, -tmp);
   930				affs_brelse(bh);
   931			}
   932		} else {
   933			AFFS_I(inode)->i_blkcnt = 0;
   934			AFFS_I(inode)->i_extcnt = 1;
   935		}
   936		AFFS_I(inode)->mmu_private = inode->i_size;
   937		// unlock cache
   938	
   939		while (ext_key) {
   940			ext_bh = affs_bread(sb, ext_key);
   941			size = AFFS_SB(sb)->s_hashsize;
   942			if (size > blkcnt - blk)
   943				size = blkcnt - blk;
   944			if (ext_bh) {
   945				for (i = 0; i < size; i++, blk++) {
 > 946					ext_bk = AFFS_BLOCK(sb, ext_bh, i);
 > 947					affs_free_block(sb, be32_to_cpu(ext_bk));
   948				}
   949			}
   950			affs_free_block(sb, ext_key);
   951			ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
   952			affs_brelse(ext_bh);
   953		}
   954		affs_free_prealloc(inode);
   955	}
   956	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
