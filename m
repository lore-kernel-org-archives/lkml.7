Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4ABC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF72081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfGOMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:43:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:29268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfGOMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:43:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 05:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="190548649"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2019 05:43:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hn0K0-000BMs-MK; Mon, 15 Jul 2019 20:43:12 +0800
Date:   Mon, 15 Jul 2019 20:42:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: fs/f2fs/file.c:42:54: sparse: sparse: cast from restricted vm_fault_t
Message-ID: <201907152009.i0UARewN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a2d79c7174aeb43b13020dd53d85a7aefdd9f3e5
commit: 36af5f407bbb2da6dd9809dd6f173dd377b57d74 f2fs: fix sparse warning
date:   7 weeks ago
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 36af5f407bbb2da6dd9809dd6f173dd377b57d74
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/file.c:42:54: sparse: sparse: cast from restricted vm_fault_t

vim +42 fs/f2fs/file.c

fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    32  
ea4d479bb360372 Souptick Joarder   2018-04-15    33  static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
5a3a2d83cda82df Qiuyang Sun        2017-05-18    34  {
5a3a2d83cda82df Qiuyang Sun        2017-05-18    35  	struct inode *inode = file_inode(vmf->vma->vm_file);
ea4d479bb360372 Souptick Joarder   2018-04-15    36  	vm_fault_t ret;
5a3a2d83cda82df Qiuyang Sun        2017-05-18    37  
5a3a2d83cda82df Qiuyang Sun        2017-05-18    38  	down_read(&F2FS_I(inode)->i_mmap_sem);
ea4d479bb360372 Souptick Joarder   2018-04-15    39  	ret = filemap_fault(vmf);
5a3a2d83cda82df Qiuyang Sun        2017-05-18    40  	up_read(&F2FS_I(inode)->i_mmap_sem);
5a3a2d83cda82df Qiuyang Sun        2017-05-18    41  
d764834378a9870 Chao Yu            2019-04-15   @42  	trace_f2fs_filemap_fault(inode, vmf->pgoff, (unsigned long)ret);
d764834378a9870 Chao Yu            2019-04-15    43  
ea4d479bb360372 Souptick Joarder   2018-04-15    44  	return ret;
5a3a2d83cda82df Qiuyang Sun        2017-05-18    45  }
5a3a2d83cda82df Qiuyang Sun        2017-05-18    46  
ea4d479bb360372 Souptick Joarder   2018-04-15    47  static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    48  {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    49  	struct page *page = vmf->page;
11bac80004499ea Dave Jiang         2017-02-24    50  	struct inode *inode = file_inode(vmf->vma->vm_file);
4081363fbe84a7e Jaegeuk Kim        2014-09-02    51  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
39a8695824510a9 Chao Yu            2018-09-27    52  	struct dnode_of_data dn = { .node_changed = false };
e479556bfdd1366 Gu Zheng           2013-09-27    53  	int err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    54  
1f227a3e215d361 Jaegeuk Kim        2017-10-23    55  	if (unlikely(f2fs_cp_error(sbi))) {
1f227a3e215d361 Jaegeuk Kim        2017-10-23    56  		err = -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23    57  		goto err;
1f227a3e215d361 Jaegeuk Kim        2017-10-23    58  	}
1f227a3e215d361 Jaegeuk Kim        2017-10-23    59  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    60  	sb_start_pagefault(inode->i_sb);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23    61  
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23    62  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
b067ba1f1b3fa7e Jaegeuk Kim        2014-08-07    63  
11bac80004499ea Dave Jiang         2017-02-24    64  	file_update_time(vmf->vma->vm_file);
5a3a2d83cda82df Qiuyang Sun        2017-05-18    65  	down_read(&F2FS_I(inode)->i_mmap_sem);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    66  	lock_page(page);
6bacf52fb58aeb3 Jaegeuk Kim        2013-12-06    67  	if (unlikely(page->mapping != inode->i_mapping ||
9851e6e18943f25 Namjae Jeon        2013-04-28    68  			page_offset(page) > i_size_read(inode) ||
6bacf52fb58aeb3 Jaegeuk Kim        2013-12-06    69  			!PageUptodate(page))) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    70  		unlock_page(page);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    71  		err = -EFAULT;
5a3a2d83cda82df Qiuyang Sun        2017-05-18    72  		goto out_sem;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    73  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    74  
39a8695824510a9 Chao Yu            2018-09-27    75  	/* block allocation */
39a8695824510a9 Chao Yu            2018-09-27    76  	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
39a8695824510a9 Chao Yu            2018-09-27    77  	set_new_dnode(&dn, inode, NULL, NULL, 0);
39a8695824510a9 Chao Yu            2018-09-27    78  	err = f2fs_get_block(&dn, page->index);
39a8695824510a9 Chao Yu            2018-09-27    79  	f2fs_put_dnode(&dn);
39a8695824510a9 Chao Yu            2018-09-27    80  	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
39a8695824510a9 Chao Yu            2018-09-27    81  	if (err) {
39a8695824510a9 Chao Yu            2018-09-27    82  		unlock_page(page);
39a8695824510a9 Chao Yu            2018-09-27    83  		goto out_sem;
39a8695824510a9 Chao Yu            2018-09-27    84  	}
39a8695824510a9 Chao Yu            2018-09-27    85  
39a8695824510a9 Chao Yu            2018-09-27    86  	/* fill the page */
bae0ee7a767ceee Chao Yu            2018-12-25    87  	f2fs_wait_on_page_writeback(page, DATA, false, true);
39a8695824510a9 Chao Yu            2018-09-27    88  
39a8695824510a9 Chao Yu            2018-09-27    89  	/* wait for GCed page writeback via META_MAPPING */
39a8695824510a9 Chao Yu            2018-09-27    90  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
39a8695824510a9 Chao Yu            2018-09-27    91  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    92  	/*
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    93  	 * check to see if the page is mapped already (no holes)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    94  	 */
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    95  	if (PageMappedToDisk(page))
39a8695824510a9 Chao Yu            2018-09-27    96  		goto out_sem;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    97  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02    98  	/* page is wholly or partially inside EOF */
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01    99  	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
9edcdabf36422d1 Chao Yu            2015-09-11   100  						i_size_read(inode)) {
193bea1dd8dadc4 youngjun yoo       2018-05-30   101  		loff_t offset;
f11e98bdbe7d6ee youngjun yoo       2018-05-30   102  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   103  		offset = i_size_read(inode) & ~PAGE_MASK;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   104  		zero_user_segment(page, offset, PAGE_SIZE);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   105  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   106  	set_page_dirty(page);
237c0790e54020d Jaegeuk Kim        2016-06-30   107  	if (!PageUptodate(page))
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   108  		SetPageUptodate(page);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   109  
b0af6d491a6b5f5 Chao Yu            2017-08-02   110  	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
c75f2feb80eb8cb Sahitya Tummala    2018-10-05   111  	f2fs_update_time(sbi, REQ_TIME);
b0af6d491a6b5f5 Chao Yu            2017-08-02   112  
e943a10d94f6076 Jaegeuk Kim        2013-10-25   113  	trace_f2fs_vm_page_mkwrite(page, DATA);
5a3a2d83cda82df Qiuyang Sun        2017-05-18   114  out_sem:
5a3a2d83cda82df Qiuyang Sun        2017-05-18   115  	up_read(&F2FS_I(inode)->i_mmap_sem);
39a8695824510a9 Chao Yu            2018-09-27   116  
39a8695824510a9 Chao Yu            2018-09-27   117  	f2fs_balance_fs(sbi, dn.node_changed);
39a8695824510a9 Chao Yu            2018-09-27   118  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   119  	sb_end_pagefault(inode->i_sb);
1f227a3e215d361 Jaegeuk Kim        2017-10-23   120  err:
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   121  	return block_page_mkwrite_return(err);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   122  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   123  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   124  static const struct vm_operations_struct f2fs_file_vm_ops = {
5a3a2d83cda82df Qiuyang Sun        2017-05-18   125  	.fault		= f2fs_filemap_fault,
f1820361f83d556 Kirill A. Shutemov 2014-04-07   126  	.map_pages	= filemap_map_pages,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   127  	.page_mkwrite	= f2fs_vm_page_mkwrite,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   128  };
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   129  
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   130  static int get_parent_ino(struct inode *inode, nid_t *pino)
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   131  {
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   132  	struct dentry *dentry;
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   133  
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   134  	inode = igrab(inode);
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   135  	dentry = d_find_any_alias(inode);
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   136  	iput(inode);
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   137  	if (!dentry)
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   138  		return 0;
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   139  
f0947e5ccedb749 Jaegeuk Kim        2013-07-22   140  	*pino = parent_ino(dentry);
f0947e5ccedb749 Jaegeuk Kim        2013-07-22   141  	dput(dentry);
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   142  	return 1;
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   143  }
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   144  
a5fd505092863c5 Chao Yu            2017-11-06   145  static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
9d1589ef2edeb45 Chao Yu            2014-08-20   146  {
4081363fbe84a7e Jaegeuk Kim        2014-09-02   147  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
a5fd505092863c5 Chao Yu            2017-11-06   148  	enum cp_reason_type cp_reason = CP_NO_NEEDED;
9d1589ef2edeb45 Chao Yu            2014-08-20   149  
a5fd505092863c5 Chao Yu            2017-11-06   150  	if (!S_ISREG(inode->i_mode))
a5fd505092863c5 Chao Yu            2017-11-06   151  		cp_reason = CP_NON_REGULAR;
a5fd505092863c5 Chao Yu            2017-11-06   152  	else if (inode->i_nlink != 1)
a5fd505092863c5 Chao Yu            2017-11-06   153  		cp_reason = CP_HARDLINK;
bbf156f7afa7f3c Jaegeuk Kim        2016-08-29   154  	else if (is_sbi_flag_set(sbi, SBI_NEED_CP))
a5fd505092863c5 Chao Yu            2017-11-06   155  		cp_reason = CP_SB_NEED_CP;
9d1589ef2edeb45 Chao Yu            2014-08-20   156  	else if (file_wrong_pino(inode))
a5fd505092863c5 Chao Yu            2017-11-06   157  		cp_reason = CP_WRONG_PINO;
4d57b86dd86404f Chao Yu            2018-05-30   158  	else if (!f2fs_space_for_roll_forward(sbi))
a5fd505092863c5 Chao Yu            2017-11-06   159  		cp_reason = CP_NO_SPC_ROLL;
4d57b86dd86404f Chao Yu            2018-05-30   160  	else if (!f2fs_is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
a5fd505092863c5 Chao Yu            2017-11-06   161  		cp_reason = CP_NODE_NEED_CP;
d5053a34a9cc797 Jaegeuk Kim        2014-10-30   162  	else if (test_opt(sbi, FASTBOOT))
a5fd505092863c5 Chao Yu            2017-11-06   163  		cp_reason = CP_FASTBOOT_MODE;
63189b785960c33 Chao Yu            2018-03-08   164  	else if (F2FS_OPTION(sbi).active_logs == 2)
a5fd505092863c5 Chao Yu            2017-11-06   165  		cp_reason = CP_SPEC_LOG_NUM;
63189b785960c33 Chao Yu            2018-03-08   166  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
4d57b86dd86404f Chao Yu            2018-05-30   167  		f2fs_need_dentry_mark(sbi, inode->i_ino) &&
4d57b86dd86404f Chao Yu            2018-05-30   168  		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
4d57b86dd86404f Chao Yu            2018-05-30   169  							TRANS_DIR_INO))
0a007b97aad6e17 Jaegeuk Kim        2017-12-28   170  		cp_reason = CP_RECOVER_DIR;
9d1589ef2edeb45 Chao Yu            2014-08-20   171  
a5fd505092863c5 Chao Yu            2017-11-06   172  	return cp_reason;
9d1589ef2edeb45 Chao Yu            2014-08-20   173  }
9d1589ef2edeb45 Chao Yu            2014-08-20   174  
9c7bb702122fdf7 Changman Lee       2014-12-08   175  static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
9c7bb702122fdf7 Changman Lee       2014-12-08   176  {
9c7bb702122fdf7 Changman Lee       2014-12-08   177  	struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
9c7bb702122fdf7 Changman Lee       2014-12-08   178  	bool ret = false;
9c7bb702122fdf7 Changman Lee       2014-12-08   179  	/* But we need to avoid that there are some inode updates */
4d57b86dd86404f Chao Yu            2018-05-30   180  	if ((i && PageDirty(i)) || f2fs_need_inode_block_update(sbi, ino))
9c7bb702122fdf7 Changman Lee       2014-12-08   181  		ret = true;
9c7bb702122fdf7 Changman Lee       2014-12-08   182  	f2fs_put_page(i, 0);
9c7bb702122fdf7 Changman Lee       2014-12-08   183  	return ret;
9c7bb702122fdf7 Changman Lee       2014-12-08   184  }
9c7bb702122fdf7 Changman Lee       2014-12-08   185  
51455b19384d26a Changman Lee       2014-12-08   186  static void try_to_fix_pino(struct inode *inode)
51455b19384d26a Changman Lee       2014-12-08   187  {
51455b19384d26a Changman Lee       2014-12-08   188  	struct f2fs_inode_info *fi = F2FS_I(inode);
51455b19384d26a Changman Lee       2014-12-08   189  	nid_t pino;
51455b19384d26a Changman Lee       2014-12-08   190  
51455b19384d26a Changman Lee       2014-12-08   191  	down_write(&fi->i_sem);
51455b19384d26a Changman Lee       2014-12-08   192  	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
51455b19384d26a Changman Lee       2014-12-08   193  			get_parent_ino(inode, &pino)) {
205b98221cdf72b Jaegeuk Kim        2016-05-20   194  		f2fs_i_pino_write(inode, pino);
51455b19384d26a Changman Lee       2014-12-08   195  		file_got_pino(inode);
51455b19384d26a Changman Lee       2014-12-08   196  	}
ee6d182f2a19d5d Jaegeuk Kim        2016-05-20   197  	up_write(&fi->i_sem);
51455b19384d26a Changman Lee       2014-12-08   198  }
51455b19384d26a Changman Lee       2014-12-08   199  
608514deba38c86 Jaegeuk Kim        2016-04-15   200  static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
608514deba38c86 Jaegeuk Kim        2016-04-15   201  						int datasync, bool atomic)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   202  {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   203  	struct inode *inode = file->f_mapping->host;
4081363fbe84a7e Jaegeuk Kim        2014-09-02   204  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
2403c155b83c09d Jaegeuk Kim        2014-09-10   205  	nid_t ino = inode->i_ino;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   206  	int ret = 0;
a5fd505092863c5 Chao Yu            2017-11-06   207  	enum cp_reason_type cp_reason = 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   208  	struct writeback_control wbc = {
c81bf1c84f69246 Jaegeuk Kim        2014-03-03   209  		.sync_mode = WB_SYNC_ALL,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   210  		.nr_to_write = LONG_MAX,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   211  		.for_reclaim = 0,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   212  	};
50fa53eccf9f911 Chao Yu            2018-08-02   213  	unsigned int seq_id = 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   214  
4354994f097d068 Daniel Rosenberg   2018-08-20   215  	if (unlikely(f2fs_readonly(inode->i_sb) ||
4354994f097d068 Daniel Rosenberg   2018-08-20   216  				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
1fa95b0b6798164 Namjae Jeon        2012-12-01   217  		return 0;
1fa95b0b6798164 Namjae Jeon        2012-12-01   218  
a2a4a7e4abb27c8 Namjae Jeon        2013-04-20   219  	trace_f2fs_sync_file_enter(inode);
ea1aa12ca237149 Jaegeuk Kim        2014-07-24   220  
b61ac5b720146c6 Yunlei He          2018-11-06   221  	if (S_ISDIR(inode->i_mode))
b61ac5b720146c6 Yunlei He          2018-11-06   222  		goto go_write;
b61ac5b720146c6 Yunlei He          2018-11-06   223  
ea1aa12ca237149 Jaegeuk Kim        2014-07-24   224  	/* if fdatasync is triggered, let's do in-place-update */
c46a155bdf3c887 Jaegeuk Kim        2015-12-31   225  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
91942321e4c9f84 Jaegeuk Kim        2016-05-20   226  		set_inode_flag(inode, FI_NEED_IPU);
3b49c9a1e984b52 Jeff Layton        2017-07-07   227  	ret = file_write_and_wait_range(file, start, end);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   228  	clear_inode_flag(inode, FI_NEED_IPU);
c1ce1b02bb25640 Jaegeuk Kim        2014-09-10   229  
a2a4a7e4abb27c8 Namjae Jeon        2013-04-20   230  	if (ret) {
a5fd505092863c5 Chao Yu            2017-11-06   231  		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   232  		return ret;
a2a4a7e4abb27c8 Namjae Jeon        2013-04-20   233  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   234  
9c7bb702122fdf7 Changman Lee       2014-12-08   235  	/* if the inode is dirty, let's recover all the time */
281518c694a5228 Chao Yu            2016-11-17   236  	if (!f2fs_skip_inode_update(inode, datasync)) {
2286c0205d1478d Jaegeuk Kim        2015-08-15   237  		f2fs_write_inode(inode, NULL);
9c7bb702122fdf7 Changman Lee       2014-12-08   238  		goto go_write;
9c7bb702122fdf7 Changman Lee       2014-12-08   239  	}
9c7bb702122fdf7 Changman Lee       2014-12-08   240  
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   241  	/*
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   242  	 * if there is no written data, don't waste time to write recovery info.
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   243  	 */
91942321e4c9f84 Jaegeuk Kim        2016-05-20   244  	if (!is_inode_flag_set(inode, FI_APPEND_WRITE) &&
4d57b86dd86404f Chao Yu            2018-05-30   245  			!f2fs_exist_written_data(sbi, ino, APPEND_INO)) {
19c9c466e5c7940 Jaegeuk Kim        2014-09-10   246  
9c7bb702122fdf7 Changman Lee       2014-12-08   247  		/* it may call write_inode just prior to fsync */
9c7bb702122fdf7 Changman Lee       2014-12-08   248  		if (need_inode_page_update(sbi, ino))
19c9c466e5c7940 Jaegeuk Kim        2014-09-10   249  			goto go_write;
19c9c466e5c7940 Jaegeuk Kim        2014-09-10   250  
91942321e4c9f84 Jaegeuk Kim        2016-05-20   251  		if (is_inode_flag_set(inode, FI_UPDATE_WRITE) ||
4d57b86dd86404f Chao Yu            2018-05-30   252  				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   253  			goto flush_out;
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   254  		goto out;
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   255  	}
19c9c466e5c7940 Jaegeuk Kim        2014-09-10   256  go_write:
e5d2385ed6d8543 Jaegeuk Kim        2013-07-03   257  	/*
e5d2385ed6d8543 Jaegeuk Kim        2013-07-03   258  	 * Both of fdatasync() and fsync() are able to be recovered from
e5d2385ed6d8543 Jaegeuk Kim        2013-07-03   259  	 * sudden-power-off.
e5d2385ed6d8543 Jaegeuk Kim        2013-07-03   260  	 */
91942321e4c9f84 Jaegeuk Kim        2016-05-20   261  	down_read(&F2FS_I(inode)->i_sem);
a5fd505092863c5 Chao Yu            2017-11-06   262  	cp_reason = need_do_checkpoint(inode);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   263  	up_read(&F2FS_I(inode)->i_sem);
d928bfbfe77aa45 Jaegeuk Kim        2014-03-20   264  
a5fd505092863c5 Chao Yu            2017-11-06   265  	if (cp_reason) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   266  		/* all the dirty node pages should be flushed for POR */
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   267  		ret = f2fs_sync_fs(inode->i_sb, 1);
d928bfbfe77aa45 Jaegeuk Kim        2014-03-20   268  
51455b19384d26a Changman Lee       2014-12-08   269  		/*
51455b19384d26a Changman Lee       2014-12-08   270  		 * We've secured consistency through sync_fs. Following pino
51455b19384d26a Changman Lee       2014-12-08   271  		 * will be used only for fsynced inodes after checkpoint.
51455b19384d26a Changman Lee       2014-12-08   272  		 */
51455b19384d26a Changman Lee       2014-12-08   273  		try_to_fix_pino(inode);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   274  		clear_inode_flag(inode, FI_APPEND_WRITE);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   275  		clear_inode_flag(inode, FI_UPDATE_WRITE);
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   276  		goto out;
354a3399dc6f7e5 Jaegeuk Kim        2013-06-14   277  	}
88bd02c9472a166 Jaegeuk Kim        2014-09-15   278  sync_nodes:
c29fd0c0e26dacb Chao Yu            2018-06-04   279  	atomic_inc(&sbi->wb_sync_req[NODE]);
50fa53eccf9f911 Chao Yu            2018-08-02   280  	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic, &seq_id);
c29fd0c0e26dacb Chao Yu            2018-06-04   281  	atomic_dec(&sbi->wb_sync_req[NODE]);
c267ec1526da2d3 Jaegeuk Kim        2016-04-15   282  	if (ret)
c267ec1526da2d3 Jaegeuk Kim        2016-04-15   283  		goto out;
88bd02c9472a166 Jaegeuk Kim        2014-09-15   284  
871f599f4a869d2 Jaegeuk Kim        2015-01-09   285  	/* if cp_error was enabled, we should avoid infinite loop */
6d5a1495eebd441 Chao Yu            2015-12-24   286  	if (unlikely(f2fs_cp_error(sbi))) {
6d5a1495eebd441 Chao Yu            2015-12-24   287  		ret = -EIO;
871f599f4a869d2 Jaegeuk Kim        2015-01-09   288  		goto out;
6d5a1495eebd441 Chao Yu            2015-12-24   289  	}
871f599f4a869d2 Jaegeuk Kim        2015-01-09   290  
4d57b86dd86404f Chao Yu            2018-05-30   291  	if (f2fs_need_inode_block_update(sbi, ino)) {
7c45729a4d6d1c9 Jaegeuk Kim        2016-10-14   292  		f2fs_mark_inode_dirty_sync(inode, true);
51455b19384d26a Changman Lee       2014-12-08   293  		f2fs_write_inode(inode, NULL);
88bd02c9472a166 Jaegeuk Kim        2014-09-15   294  		goto sync_nodes;
398b1ac5a572198 Jaegeuk Kim        2012-12-19   295  	}
88bd02c9472a166 Jaegeuk Kim        2014-09-15   296  
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   297  	/*
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   298  	 * If it's atomic_write, it's just fine to keep write ordering. So
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   299  	 * here we don't need to wait for node write completion, since we use
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   300  	 * node chain which serializes node blocks. If one of node writes are
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   301  	 * reordered, we can see simply broken chain, resulting in stopping
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   302  	 * roll-forward recovery. It means we'll recover all or none node blocks
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   303  	 * given fsync mark.
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   304  	 */
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   305  	if (!atomic) {
50fa53eccf9f911 Chao Yu            2018-08-02   306  		ret = f2fs_wait_on_node_pages_writeback(sbi, seq_id);
cfe58f9dcd9afe1 Jaegeuk Kim        2013-10-31   307  		if (ret)
cfe58f9dcd9afe1 Jaegeuk Kim        2013-10-31   308  			goto out;
b6a245eb34cd935 Jaegeuk Kim        2017-07-28   309  	}
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   310  
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   311  	/* once recovery info is written, don't need to tack this */
4d57b86dd86404f Chao Yu            2018-05-30   312  	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   313  	clear_inode_flag(inode, FI_APPEND_WRITE);
6d99ba41a72c121 Jaegeuk Kim        2014-07-24   314  flush_out:
d6290814b018aa9 Jaegeuk Kim        2018-05-25   315  	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
39d787bec4f792e Chao Yu            2017-09-29   316  		ret = f2fs_issue_flush(sbi, inode->i_ino);
3f06252f7aa5862 Chao Yu            2017-09-29   317  	if (!ret) {
4d57b86dd86404f Chao Yu            2018-05-30   318  		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
91942321e4c9f84 Jaegeuk Kim        2016-05-20   319  		clear_inode_flag(inode, FI_UPDATE_WRITE);
4d57b86dd86404f Chao Yu            2018-05-30   320  		f2fs_remove_ino_entry(sbi, ino, FLUSH_INO);
3f06252f7aa5862 Chao Yu            2017-09-29   321  	}
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08   322  	f2fs_update_time(sbi, REQ_TIME);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   323  out:
a5fd505092863c5 Chao Yu            2017-11-06   324  	trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
05ca3632e5a73b4 Jaegeuk Kim        2015-04-23   325  	f2fs_trace_ios(NULL, 1);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   326  	return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   327  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   328  
608514deba38c86 Jaegeuk Kim        2016-04-15   329  int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
608514deba38c86 Jaegeuk Kim        2016-04-15   330  {
1f227a3e215d361 Jaegeuk Kim        2017-10-23   331  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23   332  		return -EIO;
608514deba38c86 Jaegeuk Kim        2016-04-15   333  	return f2fs_do_sync_file(file, start, end, datasync, false);
608514deba38c86 Jaegeuk Kim        2016-04-15   334  }
608514deba38c86 Jaegeuk Kim        2016-04-15   335  
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   336  static pgoff_t __get_first_dirty_index(struct address_space *mapping,
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   337  						pgoff_t pgofs, int whence)
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   338  {
8faab64229a5d5f Jan Kara           2017-11-15   339  	struct page *page;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   340  	int nr_pages;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   341  
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   342  	if (whence != SEEK_DATA)
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   343  		return 0;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   344  
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   345  	/* find first dirty page index */
8faab64229a5d5f Jan Kara           2017-11-15   346  	nr_pages = find_get_pages_tag(mapping, &pgofs, PAGECACHE_TAG_DIRTY,
8faab64229a5d5f Jan Kara           2017-11-15   347  				      1, &page);
8faab64229a5d5f Jan Kara           2017-11-15   348  	if (!nr_pages)
8faab64229a5d5f Jan Kara           2017-11-15   349  		return ULONG_MAX;
8faab64229a5d5f Jan Kara           2017-11-15   350  	pgofs = page->index;
8faab64229a5d5f Jan Kara           2017-11-15   351  	put_page(page);
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   352  	return pgofs;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   353  }
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   354  
e1da7872f6eda97 Chao Yu            2018-06-05   355  static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
e1da7872f6eda97 Chao Yu            2018-06-05   356  				pgoff_t dirty, pgoff_t pgofs, int whence)
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   357  {
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   358  	switch (whence) {
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   359  	case SEEK_DATA:
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   360  		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
93770ab7a6e9631 Chao Yu            2019-04-15   361  			__is_valid_data_blkaddr(blkaddr))
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   362  			return true;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   363  		break;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   364  	case SEEK_HOLE:
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   365  		if (blkaddr == NULL_ADDR)
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   366  			return true;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   367  		break;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   368  	}
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   369  	return false;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   370  }
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   371  
267378d4de696d4 Chao Yu            2014-04-23   372  static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
267378d4de696d4 Chao Yu            2014-04-23   373  {
267378d4de696d4 Chao Yu            2014-04-23   374  	struct inode *inode = file->f_mapping->host;
267378d4de696d4 Chao Yu            2014-04-23   375  	loff_t maxbytes = inode->i_sb->s_maxbytes;
267378d4de696d4 Chao Yu            2014-04-23   376  	struct dnode_of_data dn;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   377  	pgoff_t pgofs, end_offset, dirty;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   378  	loff_t data_ofs = offset;
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   379  	loff_t isize;
267378d4de696d4 Chao Yu            2014-04-23   380  	int err = 0;
267378d4de696d4 Chao Yu            2014-04-23   381  
5955102c9984fa0 Al Viro            2016-01-22   382  	inode_lock(inode);
267378d4de696d4 Chao Yu            2014-04-23   383  
267378d4de696d4 Chao Yu            2014-04-23   384  	isize = i_size_read(inode);
267378d4de696d4 Chao Yu            2014-04-23   385  	if (offset >= isize)
267378d4de696d4 Chao Yu            2014-04-23   386  		goto fail;
267378d4de696d4 Chao Yu            2014-04-23   387  
267378d4de696d4 Chao Yu            2014-04-23   388  	/* handle inline data case */
622f28ae9ba4fa8 Chao Yu            2014-09-24   389  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode)) {
267378d4de696d4 Chao Yu            2014-04-23   390  		if (whence == SEEK_HOLE)
267378d4de696d4 Chao Yu            2014-04-23   391  			data_ofs = isize;
267378d4de696d4 Chao Yu            2014-04-23   392  		goto found;
267378d4de696d4 Chao Yu            2014-04-23   393  	}
267378d4de696d4 Chao Yu            2014-04-23   394  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   395  	pgofs = (pgoff_t)(offset >> PAGE_SHIFT);
267378d4de696d4 Chao Yu            2014-04-23   396  
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   397  	dirty = __get_first_dirty_index(inode->i_mapping, pgofs, whence);
7f7670fe9fe47e7 Jaegeuk Kim        2014-04-28   398  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   399  	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
267378d4de696d4 Chao Yu            2014-04-23   400  		set_new_dnode(&dn, inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30   401  		err = f2fs_get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
267378d4de696d4 Chao Yu            2014-04-23   402  		if (err && err != -ENOENT) {
267378d4de696d4 Chao Yu            2014-04-23   403  			goto fail;
267378d4de696d4 Chao Yu            2014-04-23   404  		} else if (err == -ENOENT) {
e1c42045203071c arter97            2014-08-06   405  			/* direct node does not exists */
267378d4de696d4 Chao Yu            2014-04-23   406  			if (whence == SEEK_DATA) {
4d57b86dd86404f Chao Yu            2018-05-30   407  				pgofs = f2fs_get_next_page_offset(&dn, pgofs);
267378d4de696d4 Chao Yu            2014-04-23   408  				continue;
267378d4de696d4 Chao Yu            2014-04-23   409  			} else {
267378d4de696d4 Chao Yu            2014-04-23   410  				goto found;
267378d4de696d4 Chao Yu            2014-04-23   411  			}
267378d4de696d4 Chao Yu            2014-04-23   412  		}
267378d4de696d4 Chao Yu            2014-04-23   413  
81ca7350ce5ed43 Chao Yu            2016-01-26   414  		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
267378d4de696d4 Chao Yu            2014-04-23   415  
267378d4de696d4 Chao Yu            2014-04-23   416  		/* find data/hole in dnode block */
267378d4de696d4 Chao Yu            2014-04-23   417  		for (; dn.ofs_in_node < end_offset;
267378d4de696d4 Chao Yu            2014-04-23   418  				dn.ofs_in_node++, pgofs++,
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   419  				data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
267378d4de696d4 Chao Yu            2014-04-23   420  			block_t blkaddr;
f11e98bdbe7d6ee youngjun yoo       2018-05-30   421  
7a2af766af15887 Chao Yu            2017-07-19   422  			blkaddr = datablock_addr(dn.inode,
7a2af766af15887 Chao Yu            2017-07-19   423  					dn.node_page, dn.ofs_in_node);
267378d4de696d4 Chao Yu            2014-04-23   424  
c9b60788fc760d1 Chao Yu            2018-08-01   425  			if (__is_valid_data_blkaddr(blkaddr) &&
c9b60788fc760d1 Chao Yu            2018-08-01   426  				!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
93770ab7a6e9631 Chao Yu            2019-04-15   427  					blkaddr, DATA_GENERIC_ENHANCE)) {
c9b60788fc760d1 Chao Yu            2018-08-01   428  				f2fs_put_dnode(&dn);
c9b60788fc760d1 Chao Yu            2018-08-01   429  				goto fail;
c9b60788fc760d1 Chao Yu            2018-08-01   430  			}
c9b60788fc760d1 Chao Yu            2018-08-01   431  
e1da7872f6eda97 Chao Yu            2018-06-05   432  			if (__found_offset(F2FS_I_SB(inode), blkaddr, dirty,
e1da7872f6eda97 Chao Yu            2018-06-05   433  							pgofs, whence)) {
267378d4de696d4 Chao Yu            2014-04-23   434  				f2fs_put_dnode(&dn);
267378d4de696d4 Chao Yu            2014-04-23   435  				goto found;
267378d4de696d4 Chao Yu            2014-04-23   436  			}
267378d4de696d4 Chao Yu            2014-04-23   437  		}
267378d4de696d4 Chao Yu            2014-04-23   438  		f2fs_put_dnode(&dn);
267378d4de696d4 Chao Yu            2014-04-23   439  	}
267378d4de696d4 Chao Yu            2014-04-23   440  
267378d4de696d4 Chao Yu            2014-04-23   441  	if (whence == SEEK_DATA)
267378d4de696d4 Chao Yu            2014-04-23   442  		goto fail;
267378d4de696d4 Chao Yu            2014-04-23   443  found:
fe369bc8ba20553 Jaegeuk Kim        2014-04-28   444  	if (whence == SEEK_HOLE && data_ofs > isize)
fe369bc8ba20553 Jaegeuk Kim        2014-04-28   445  		data_ofs = isize;
5955102c9984fa0 Al Viro            2016-01-22   446  	inode_unlock(inode);
267378d4de696d4 Chao Yu            2014-04-23   447  	return vfs_setpos(file, data_ofs, maxbytes);
267378d4de696d4 Chao Yu            2014-04-23   448  fail:
5955102c9984fa0 Al Viro            2016-01-22   449  	inode_unlock(inode);
267378d4de696d4 Chao Yu            2014-04-23   450  	return -ENXIO;
267378d4de696d4 Chao Yu            2014-04-23   451  }
267378d4de696d4 Chao Yu            2014-04-23   452  
267378d4de696d4 Chao Yu            2014-04-23   453  static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
267378d4de696d4 Chao Yu            2014-04-23   454  {
267378d4de696d4 Chao Yu            2014-04-23   455  	struct inode *inode = file->f_mapping->host;
267378d4de696d4 Chao Yu            2014-04-23   456  	loff_t maxbytes = inode->i_sb->s_maxbytes;
267378d4de696d4 Chao Yu            2014-04-23   457  
267378d4de696d4 Chao Yu            2014-04-23   458  	switch (whence) {
267378d4de696d4 Chao Yu            2014-04-23   459  	case SEEK_SET:
267378d4de696d4 Chao Yu            2014-04-23   460  	case SEEK_CUR:
267378d4de696d4 Chao Yu            2014-04-23   461  	case SEEK_END:
267378d4de696d4 Chao Yu            2014-04-23   462  		return generic_file_llseek_size(file, offset, whence,
267378d4de696d4 Chao Yu            2014-04-23   463  						maxbytes, i_size_read(inode));
267378d4de696d4 Chao Yu            2014-04-23   464  	case SEEK_DATA:
267378d4de696d4 Chao Yu            2014-04-23   465  	case SEEK_HOLE:
0b4c5afde9b57c0 Jaegeuk Kim        2014-09-08   466  		if (offset < 0)
0b4c5afde9b57c0 Jaegeuk Kim        2014-09-08   467  			return -ENXIO;
267378d4de696d4 Chao Yu            2014-04-23   468  		return f2fs_seek_block(file, offset, whence);
267378d4de696d4 Chao Yu            2014-04-23   469  	}
267378d4de696d4 Chao Yu            2014-04-23   470  
267378d4de696d4 Chao Yu            2014-04-23   471  	return -EINVAL;
267378d4de696d4 Chao Yu            2014-04-23   472  }
267378d4de696d4 Chao Yu            2014-04-23   473  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   474  static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   475  {
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   476  	struct inode *inode = file_inode(file);
b9d777b85ff1ff7 Jaegeuk Kim        2015-12-22   477  	int err;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   478  
1f227a3e215d361 Jaegeuk Kim        2017-10-23   479  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23   480  		return -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23   481  
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   482  	/* we don't need to use inline_data strictly */
b9d777b85ff1ff7 Jaegeuk Kim        2015-12-22   483  	err = f2fs_convert_inline_inode(inode);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   484  	if (err)
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   485  		return err;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   486  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   487  	file_accessed(file);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   488  	vma->vm_ops = &f2fs_file_vm_ops;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   489  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   490  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   491  
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21   492  static int f2fs_file_open(struct inode *inode, struct file *filp)
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21   493  {
2e168c82dc32e02 Eric Biggers       2017-11-29   494  	int err = fscrypt_file_open(inode, filp);
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21   495  
2e168c82dc32e02 Eric Biggers       2017-11-29   496  	if (err)
2e168c82dc32e02 Eric Biggers       2017-11-29   497  		return err;
b91050a80cec3da Hyunchul Lee       2018-03-08   498  
b91050a80cec3da Hyunchul Lee       2018-03-08   499  	filp->f_mode |= FMODE_NOWAIT;
b91050a80cec3da Hyunchul Lee       2018-03-08   500  
0abd675e97e60d4 Chao Yu            2017-07-09   501  	return dquot_file_open(inode, filp);
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21   502  }
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21   503  
4d57b86dd86404f Chao Yu            2018-05-30   504  void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   505  {
4081363fbe84a7e Jaegeuk Kim        2014-09-02   506  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   507  	struct f2fs_node *raw_node;
19b2c30d3cce928 Chao Yu            2015-08-26   508  	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   509  	__le32 *addr;
7a2af766af15887 Chao Yu            2017-07-19   510  	int base = 0;
7a2af766af15887 Chao Yu            2017-07-19   511  
7a2af766af15887 Chao Yu            2017-07-19   512  	if (IS_INODE(dn->node_page) && f2fs_has_extra_attr(dn->inode))
7a2af766af15887 Chao Yu            2017-07-19   513  		base = get_extra_isize(dn->inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   514  
455907106327099 Gu Zheng           2013-07-15   515  	raw_node = F2FS_NODE(dn->node_page);
7a2af766af15887 Chao Yu            2017-07-19   516  	addr = blkaddr_in_node(raw_node) + base + ofs;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   517  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   518  	for (; count > 0; count--, addr++, dn->ofs_in_node++) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   519  		block_t blkaddr = le32_to_cpu(*addr);
f11e98bdbe7d6ee youngjun yoo       2018-05-30   520  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   521  		if (blkaddr == NULL_ADDR)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   522  			continue;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   523  
e1509cf294cc670 Jaegeuk Kim        2014-12-30   524  		dn->data_blkaddr = NULL_ADDR;
4d57b86dd86404f Chao Yu            2018-05-30   525  		f2fs_set_data_blkaddr(dn);
c9b60788fc760d1 Chao Yu            2018-08-01   526  
c9b60788fc760d1 Chao Yu            2018-08-01   527  		if (__is_valid_data_blkaddr(blkaddr) &&
93770ab7a6e9631 Chao Yu            2019-04-15   528  			!f2fs_is_valid_blkaddr(sbi, blkaddr,
93770ab7a6e9631 Chao Yu            2019-04-15   529  					DATA_GENERIC_ENHANCE))
c9b60788fc760d1 Chao Yu            2018-08-01   530  			continue;
c9b60788fc760d1 Chao Yu            2018-08-01   531  
4d57b86dd86404f Chao Yu            2018-05-30   532  		f2fs_invalidate_blocks(sbi, blkaddr);
3c6c2bebef79999 Jaegeuk Kim        2015-03-17   533  		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
91942321e4c9f84 Jaegeuk Kim        2016-05-20   534  			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   535  		nr_free++;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   536  	}
19b2c30d3cce928 Chao Yu            2015-08-26   537  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   538  	if (nr_free) {
19b2c30d3cce928 Chao Yu            2015-08-26   539  		pgoff_t fofs;
19b2c30d3cce928 Chao Yu            2015-08-26   540  		/*
19b2c30d3cce928 Chao Yu            2015-08-26   541  		 * once we invalidate valid blkaddr in range [ofs, ofs + count],
19b2c30d3cce928 Chao Yu            2015-08-26   542  		 * we will invalidate all blkaddr in the whole range.
19b2c30d3cce928 Chao Yu            2015-08-26   543  		 */
4d57b86dd86404f Chao Yu            2018-05-30   544  		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page),
81ca7350ce5ed43 Chao Yu            2016-01-26   545  							dn->inode) + ofs;
19b2c30d3cce928 Chao Yu            2015-08-26   546  		f2fs_update_extent_cache_range(dn, fofs, 0, len);
d7cc950b4c910e4 Namjae Jeon        2013-06-08   547  		dec_valid_block_count(sbi, dn->inode, nr_free);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   548  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   549  	dn->ofs_in_node = ofs;
51dd62493477923 Namjae Jeon        2013-04-20   550  
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08   551  	f2fs_update_time(sbi, REQ_TIME);
51dd62493477923 Namjae Jeon        2013-04-20   552  	trace_f2fs_truncate_data_blocks_range(dn->inode, dn->nid,
51dd62493477923 Namjae Jeon        2013-04-20   553  					 dn->ofs_in_node, nr_free);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   554  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   555  
4d57b86dd86404f Chao Yu            2018-05-30   556  void f2fs_truncate_data_blocks(struct dnode_of_data *dn)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   557  {
d02a6e6174a772f Chao Yu            2019-03-25   558  	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   559  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   560  
0bfcfcca3d4351f Chao Yu            2015-03-10   561  static int truncate_partial_data_page(struct inode *inode, u64 from,
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   562  								bool cache_only)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   563  {
193bea1dd8dadc4 youngjun yoo       2018-05-30   564  	loff_t offset = from & (PAGE_SIZE - 1);
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   565  	pgoff_t index = from >> PAGE_SHIFT;
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   566  	struct address_space *mapping = inode->i_mapping;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   567  	struct page *page;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   568  
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   569  	if (!offset && !cache_only)
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   570  		return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   571  
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   572  	if (cache_only) {
34b5d5c22d64273 Jaegeuk Kim        2016-09-06   573  		page = find_lock_page(mapping, index);
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   574  		if (page && PageUptodate(page))
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   575  			goto truncate_out;
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   576  		f2fs_put_page(page, 1);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   577  		return 0;
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   578  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   579  
4d57b86dd86404f Chao Yu            2018-05-30   580  	page = f2fs_get_lock_data_page(inode, index, true);
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   581  	if (IS_ERR(page))
a78aaa2c3cf1e60 Yunlei He          2017-02-28   582  		return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
43f3eae1d3b1de6 Jaegeuk Kim        2015-04-30   583  truncate_out:
bae0ee7a767ceee Chao Yu            2018-12-25   584  	f2fs_wait_on_page_writeback(page, DATA, true, true);
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   585  	zero_user(page, offset, PAGE_SIZE - offset);
a9bcf9bcd014990 Jaegeuk Kim        2017-06-14   586  
a9bcf9bcd014990 Jaegeuk Kim        2017-06-14   587  	/* An encrypted inode should have a key and truncate the last page. */
62230e0d702f613 Chandan Rajendra   2018-12-12   588  	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
a9bcf9bcd014990 Jaegeuk Kim        2017-06-14   589  	if (!cache_only)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   590  		set_page_dirty(page);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   591  	f2fs_put_page(page, 1);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   592  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   593  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   594  
c42d28ce3e16dbd Chao Yu            2019-02-02   595  int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   596  {
4081363fbe84a7e Jaegeuk Kim        2014-09-02   597  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   598  	struct dnode_of_data dn;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   599  	pgoff_t free_from;
9ffe0fb5f3bbd01 Huajun Li          2013-11-10   600  	int count = 0, err = 0;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   601  	struct page *ipage;
0bfcfcca3d4351f Chao Yu            2015-03-10   602  	bool truncate_page = false;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   603  
51dd62493477923 Namjae Jeon        2013-04-20   604  	trace_f2fs_truncate_blocks_enter(inode, from);
51dd62493477923 Namjae Jeon        2013-04-20   605  
df033caf51c01ed Chao Yu            2018-03-20   606  	free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   607  
09210c973af3032 Chao Yu            2016-05-05   608  	if (free_from >= sbi->max_file_blocks)
09210c973af3032 Chao Yu            2016-05-05   609  		goto free_partial;
09210c973af3032 Chao Yu            2016-05-05   610  
764aa3e97802012 Jaegeuk Kim        2014-08-14   611  	if (lock)
c42d28ce3e16dbd Chao Yu            2019-02-02   612  		f2fs_lock_op(sbi);
9ffe0fb5f3bbd01 Huajun Li          2013-11-10   613  
4d57b86dd86404f Chao Yu            2018-05-30   614  	ipage = f2fs_get_node_page(sbi, inode->i_ino);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   615  	if (IS_ERR(ipage)) {
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   616  		err = PTR_ERR(ipage);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   617  		goto out;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   618  	}
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   619  
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   620  	if (f2fs_has_inline_data(inode)) {
4d57b86dd86404f Chao Yu            2018-05-30   621  		f2fs_truncate_inline_inode(inode, ipage, from);
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   622  		f2fs_put_page(ipage, 1);
0bfcfcca3d4351f Chao Yu            2015-03-10   623  		truncate_page = true;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   624  		goto out;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   625  	}
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   626  
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   627  	set_new_dnode(&dn, inode, ipage, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30   628  	err = f2fs_get_dnode_of_data(&dn, free_from, LOOKUP_NODE_RA);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   629  	if (err) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   630  		if (err == -ENOENT)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   631  			goto free_next;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   632  		goto out;
1ce86bf6f882381 Jaegeuk Kim        2014-10-15   633  	}
1ce86bf6f882381 Jaegeuk Kim        2014-10-15   634  
81ca7350ce5ed43 Chao Yu            2016-01-26   635  	count = ADDRS_PER_PAGE(dn.node_page, inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   636  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   637  	count -= dn.ofs_in_node;
9850cf4a8908886 Jaegeuk Kim        2014-09-02   638  	f2fs_bug_on(sbi, count < 0);
399368372ed9f3c Jaegeuk Kim        2012-11-22   639  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   640  	if (dn.ofs_in_node || IS_INODE(dn.node_page)) {
4d57b86dd86404f Chao Yu            2018-05-30   641  		f2fs_truncate_data_blocks_range(&dn, count);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   642  		free_from += count;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   643  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   644  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   645  	f2fs_put_dnode(&dn);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   646  free_next:
4d57b86dd86404f Chao Yu            2018-05-30   647  	err = f2fs_truncate_inode_blocks(inode, free_from);
764d2c80401fcc7 Jaegeuk Kim        2014-11-11   648  out:
764d2c80401fcc7 Jaegeuk Kim        2014-11-11   649  	if (lock)
c42d28ce3e16dbd Chao Yu            2019-02-02   650  		f2fs_unlock_op(sbi);
09210c973af3032 Chao Yu            2016-05-05   651  free_partial:
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   652  	/* lastly zero out the first data page */
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   653  	if (!err)
0bfcfcca3d4351f Chao Yu            2015-03-10   654  		err = truncate_partial_data_page(inode, from, truncate_page);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   655  
51dd62493477923 Namjae Jeon        2013-04-20   656  	trace_f2fs_truncate_blocks_exit(inode, err);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   657  	return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   658  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   659  
9a449e9c3b34ef3 Jaegeuk Kim        2016-06-02   660  int f2fs_truncate(struct inode *inode)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   661  {
b01548919c33767 Chao Yu            2015-08-24   662  	int err;
b01548919c33767 Chao Yu            2015-08-24   663  
1f227a3e215d361 Jaegeuk Kim        2017-10-23   664  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23   665  		return -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23   666  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   667  	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   668  				S_ISLNK(inode->i_mode)))
b01548919c33767 Chao Yu            2015-08-24   669  		return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   670  
51dd62493477923 Namjae Jeon        2013-04-20   671  	trace_f2fs_truncate(inode);
51dd62493477923 Namjae Jeon        2013-04-20   672  
14b44d238ce7402 Jaegeuk Kim        2017-03-09   673  	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
14b44d238ce7402 Jaegeuk Kim        2017-03-09   674  		f2fs_show_injection_info(FAULT_TRUNCATE);
14b44d238ce7402 Jaegeuk Kim        2017-03-09   675  		return -EIO;
14b44d238ce7402 Jaegeuk Kim        2017-03-09   676  	}
7fa750a163089cf Arnd Bergmann      2018-08-13   677  
92dffd01790a521 Jaegeuk Kim        2014-11-11   678  	/* we should check inline_data size */
b9d777b85ff1ff7 Jaegeuk Kim        2015-12-22   679  	if (!f2fs_may_inline_data(inode)) {
b01548919c33767 Chao Yu            2015-08-24   680  		err = f2fs_convert_inline_inode(inode);
b01548919c33767 Chao Yu            2015-08-24   681  		if (err)
b01548919c33767 Chao Yu            2015-08-24   682  			return err;
92dffd01790a521 Jaegeuk Kim        2014-11-11   683  	}
92dffd01790a521 Jaegeuk Kim        2014-11-11   684  
c42d28ce3e16dbd Chao Yu            2019-02-02   685  	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
b01548919c33767 Chao Yu            2015-08-24   686  	if (err)
b01548919c33767 Chao Yu            2015-08-24   687  		return err;
b01548919c33767 Chao Yu            2015-08-24   688  
078cd8279e65998 Deepa Dinamani     2016-09-14   689  	inode->i_mtime = inode->i_ctime = current_time(inode);
7c45729a4d6d1c9 Jaegeuk Kim        2016-10-14   690  	f2fs_mark_inode_dirty_sync(inode, false);
b01548919c33767 Chao Yu            2015-08-24   691  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   692  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   693  
a528d35e8bfcc52 David Howells      2017-01-31   694  int f2fs_getattr(const struct path *path, struct kstat *stat,
1c6d8ee4b8aaadc Chao Yu            2017-05-03   695  		 u32 request_mask, unsigned int query_flags)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   696  {
a528d35e8bfcc52 David Howells      2017-01-31   697  	struct inode *inode = d_inode(path->dentry);
1c6d8ee4b8aaadc Chao Yu            2017-05-03   698  	struct f2fs_inode_info *fi = F2FS_I(inode);
1c1d35df71104c7 Chao Yu            2018-01-25   699  	struct f2fs_inode *ri;
1c6d8ee4b8aaadc Chao Yu            2017-05-03   700  	unsigned int flags;
1c6d8ee4b8aaadc Chao Yu            2017-05-03   701  
1c1d35df71104c7 Chao Yu            2018-01-25   702  	if (f2fs_has_extra_attr(inode) &&
7beb01f74415c56 Chao Yu            2018-10-24   703  			f2fs_sb_has_inode_crtime(F2FS_I_SB(inode)) &&
1c1d35df71104c7 Chao Yu            2018-01-25   704  			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
1c1d35df71104c7 Chao Yu            2018-01-25   705  		stat->result_mask |= STATX_BTIME;
1c1d35df71104c7 Chao Yu            2018-01-25   706  		stat->btime.tv_sec = fi->i_crtime.tv_sec;
1c1d35df71104c7 Chao Yu            2018-01-25   707  		stat->btime.tv_nsec = fi->i_crtime.tv_nsec;
1c1d35df71104c7 Chao Yu            2018-01-25   708  	}
1c1d35df71104c7 Chao Yu            2018-01-25   709  
c807a7cb543b535 Chao Yu            2018-04-08   710  	flags = fi->i_flags & F2FS_FL_USER_VISIBLE;
59c844088b19c54 Chao Yu            2018-04-03   711  	if (flags & F2FS_APPEND_FL)
1c6d8ee4b8aaadc Chao Yu            2017-05-03   712  		stat->attributes |= STATX_ATTR_APPEND;
59c844088b19c54 Chao Yu            2018-04-03   713  	if (flags & F2FS_COMPR_FL)
1c6d8ee4b8aaadc Chao Yu            2017-05-03   714  		stat->attributes |= STATX_ATTR_COMPRESSED;
62230e0d702f613 Chandan Rajendra   2018-12-12   715  	if (IS_ENCRYPTED(inode))
1c6d8ee4b8aaadc Chao Yu            2017-05-03   716  		stat->attributes |= STATX_ATTR_ENCRYPTED;
59c844088b19c54 Chao Yu            2018-04-03   717  	if (flags & F2FS_IMMUTABLE_FL)
1c6d8ee4b8aaadc Chao Yu            2017-05-03   718  		stat->attributes |= STATX_ATTR_IMMUTABLE;
59c844088b19c54 Chao Yu            2018-04-03   719  	if (flags & F2FS_NODUMP_FL)
1c6d8ee4b8aaadc Chao Yu            2017-05-03   720  		stat->attributes |= STATX_ATTR_NODUMP;
1c6d8ee4b8aaadc Chao Yu            2017-05-03   721  
1c6d8ee4b8aaadc Chao Yu            2017-05-03   722  	stat->attributes_mask |= (STATX_ATTR_APPEND |
1c6d8ee4b8aaadc Chao Yu            2017-05-03   723  				  STATX_ATTR_COMPRESSED |
1c6d8ee4b8aaadc Chao Yu            2017-05-03   724  				  STATX_ATTR_ENCRYPTED |
1c6d8ee4b8aaadc Chao Yu            2017-05-03   725  				  STATX_ATTR_IMMUTABLE |
1c6d8ee4b8aaadc Chao Yu            2017-05-03   726  				  STATX_ATTR_NODUMP);
1c6d8ee4b8aaadc Chao Yu            2017-05-03   727  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   728  	generic_fillattr(inode, stat);
5b4267d195dd887 Jaegeuk Kim        2017-10-13   729  
5b4267d195dd887 Jaegeuk Kim        2017-10-13   730  	/* we need to show initial sectors used for inline_data/dentries */
5b4267d195dd887 Jaegeuk Kim        2017-10-13   731  	if ((S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode)) ||
5b4267d195dd887 Jaegeuk Kim        2017-10-13   732  					f2fs_has_inline_dentry(inode))
5b4267d195dd887 Jaegeuk Kim        2017-10-13   733  		stat->blocks += (stat->size + 511) >> 9;
5b4267d195dd887 Jaegeuk Kim        2017-10-13   734  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   735  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   736  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   737  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   738  #ifdef CONFIG_F2FS_FS_POSIX_ACL
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   739  static void __setattr_copy(struct inode *inode, const struct iattr *attr)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   740  {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   741  	unsigned int ia_valid = attr->ia_valid;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   742  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   743  	if (ia_valid & ATTR_UID)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   744  		inode->i_uid = attr->ia_uid;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   745  	if (ia_valid & ATTR_GID)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   746  		inode->i_gid = attr->ia_gid;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   747  	if (ia_valid & ATTR_ATIME)
95582b00838837f Deepa Dinamani     2018-05-08   748  		inode->i_atime = timespec64_trunc(attr->ia_atime,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   749  						  inode->i_sb->s_time_gran);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   750  	if (ia_valid & ATTR_MTIME)
95582b00838837f Deepa Dinamani     2018-05-08   751  		inode->i_mtime = timespec64_trunc(attr->ia_mtime,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   752  						  inode->i_sb->s_time_gran);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   753  	if (ia_valid & ATTR_CTIME)
95582b00838837f Deepa Dinamani     2018-05-08   754  		inode->i_ctime = timespec64_trunc(attr->ia_ctime,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   755  						  inode->i_sb->s_time_gran);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   756  	if (ia_valid & ATTR_MODE) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   757  		umode_t mode = attr->ia_mode;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   758  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   759  		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   760  			mode &= ~S_ISGID;
91942321e4c9f84 Jaegeuk Kim        2016-05-20   761  		set_acl_inode(inode, mode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   762  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   763  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   764  #else
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   765  #define __setattr_copy setattr_copy
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   766  #endif
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   767  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   768  int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   769  {
2b0143b5c986be1 David Howells      2015-03-17   770  	struct inode *inode = d_inode(dentry);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   771  	int err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   772  
1f227a3e215d361 Jaegeuk Kim        2017-10-23   773  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23   774  		return -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23   775  
31051c85b5e2aaa Jan Kara           2016-05-26   776  	err = setattr_prepare(dentry, attr);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   777  	if (err)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   778  		return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   779  
20bb2479be49296 Eric Biggers       2017-11-29   780  	err = fscrypt_prepare_setattr(dentry, attr);
20bb2479be49296 Eric Biggers       2017-11-29   781  	if (err)
20bb2479be49296 Eric Biggers       2017-11-29   782  		return err;
20bb2479be49296 Eric Biggers       2017-11-29   783  
0abd675e97e60d4 Chao Yu            2017-07-09   784  	if (is_quota_modification(inode, attr)) {
0abd675e97e60d4 Chao Yu            2017-07-09   785  		err = dquot_initialize(inode);
0abd675e97e60d4 Chao Yu            2017-07-09   786  		if (err)
0abd675e97e60d4 Chao Yu            2017-07-09   787  			return err;
0abd675e97e60d4 Chao Yu            2017-07-09   788  	}
0abd675e97e60d4 Chao Yu            2017-07-09   789  	if ((attr->ia_valid & ATTR_UID &&
0abd675e97e60d4 Chao Yu            2017-07-09   790  		!uid_eq(attr->ia_uid, inode->i_uid)) ||
0abd675e97e60d4 Chao Yu            2017-07-09   791  		(attr->ia_valid & ATTR_GID &&
0abd675e97e60d4 Chao Yu            2017-07-09   792  		!gid_eq(attr->ia_gid, inode->i_gid))) {
af033b2aa8a874f Chao Yu            2018-09-20   793  		f2fs_lock_op(F2FS_I_SB(inode));
0abd675e97e60d4 Chao Yu            2017-07-09   794  		err = dquot_transfer(inode, attr);
af033b2aa8a874f Chao Yu            2018-09-20   795  		if (err) {
af033b2aa8a874f Chao Yu            2018-09-20   796  			set_sbi_flag(F2FS_I_SB(inode),
af033b2aa8a874f Chao Yu            2018-09-20   797  					SBI_QUOTA_NEED_REPAIR);
af033b2aa8a874f Chao Yu            2018-09-20   798  			f2fs_unlock_op(F2FS_I_SB(inode));
0abd675e97e60d4 Chao Yu            2017-07-09   799  			return err;
0abd675e97e60d4 Chao Yu            2017-07-09   800  		}
af033b2aa8a874f Chao Yu            2018-09-20   801  		/*
af033b2aa8a874f Chao Yu            2018-09-20   802  		 * update uid/gid under lock_op(), so that dquot and inode can
af033b2aa8a874f Chao Yu            2018-09-20   803  		 * be updated atomically.
af033b2aa8a874f Chao Yu            2018-09-20   804  		 */
af033b2aa8a874f Chao Yu            2018-09-20   805  		if (attr->ia_valid & ATTR_UID)
af033b2aa8a874f Chao Yu            2018-09-20   806  			inode->i_uid = attr->ia_uid;
af033b2aa8a874f Chao Yu            2018-09-20   807  		if (attr->ia_valid & ATTR_GID)
af033b2aa8a874f Chao Yu            2018-09-20   808  			inode->i_gid = attr->ia_gid;
af033b2aa8a874f Chao Yu            2018-09-20   809  		f2fs_mark_inode_dirty_sync(inode, true);
af033b2aa8a874f Chao Yu            2018-09-20   810  		f2fs_unlock_op(F2FS_I_SB(inode));
af033b2aa8a874f Chao Yu            2018-09-20   811  	}
0abd675e97e60d4 Chao Yu            2017-07-09   812  
09db6a2ef8d9ca6 Chao Yu            2014-09-15   813  	if (attr->ia_valid & ATTR_SIZE) {
a33c150237a20d9 Chao Yu            2018-08-05   814  		bool to_smaller = (attr->ia_size <= i_size_read(inode));
a33c150237a20d9 Chao Yu            2018-08-05   815  
a33c150237a20d9 Chao Yu            2018-08-05   816  		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25   817  		down_write(&F2FS_I(inode)->i_mmap_sem);
a33c150237a20d9 Chao Yu            2018-08-05   818  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   819  		truncate_setsize(inode, attr->ia_size);
a33c150237a20d9 Chao Yu            2018-08-05   820  
a33c150237a20d9 Chao Yu            2018-08-05   821  		if (to_smaller)
9a449e9c3b34ef3 Jaegeuk Kim        2016-06-02   822  			err = f2fs_truncate(inode);
09db6a2ef8d9ca6 Chao Yu            2014-09-15   823  		/*
3c4541452748754 Chao Yu            2015-06-05   824  		 * do not trim all blocks after i_size if target size is
3c4541452748754 Chao Yu            2015-06-05   825  		 * larger than i_size.
09db6a2ef8d9ca6 Chao Yu            2014-09-15   826  		 */
5a3a2d83cda82df Qiuyang Sun        2017-05-18   827  		up_write(&F2FS_I(inode)->i_mmap_sem);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25   828  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
0cab80ee0c9e173 Chao Yu            2015-12-01   829  
a33c150237a20d9 Chao Yu            2018-08-05   830  		if (err)
a33c150237a20d9 Chao Yu            2018-08-05   831  			return err;
a33c150237a20d9 Chao Yu            2018-08-05   832  
a33c150237a20d9 Chao Yu            2018-08-05   833  		if (!to_smaller) {
0cab80ee0c9e173 Chao Yu            2015-12-01   834  			/* should convert inline inode here */
b9d777b85ff1ff7 Jaegeuk Kim        2015-12-22   835  			if (!f2fs_may_inline_data(inode)) {
0cab80ee0c9e173 Chao Yu            2015-12-01   836  				err = f2fs_convert_inline_inode(inode);
0cab80ee0c9e173 Chao Yu            2015-12-01   837  				if (err)
0cab80ee0c9e173 Chao Yu            2015-12-01   838  					return err;
0cab80ee0c9e173 Chao Yu            2015-12-01   839  			}
078cd8279e65998 Deepa Dinamani     2016-09-14   840  			inode->i_mtime = inode->i_ctime = current_time(inode);
09db6a2ef8d9ca6 Chao Yu            2014-09-15   841  		}
c0ed4405a99ec9b Yunlei He          2016-12-11   842  
a0d00fad353d4a3 Chao Yu            2017-10-09   843  		down_write(&F2FS_I(inode)->i_sem);
a0d00fad353d4a3 Chao Yu            2017-10-09   844  		F2FS_I(inode)->last_disk_size = i_size_read(inode);
a0d00fad353d4a3 Chao Yu            2017-10-09   845  		up_write(&F2FS_I(inode)->i_sem);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   846  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   847  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   848  	__setattr_copy(inode, attr);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   849  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   850  	if (attr->ia_valid & ATTR_MODE) {
4d57b86dd86404f Chao Yu            2018-05-30   851  		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
91942321e4c9f84 Jaegeuk Kim        2016-05-20   852  		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
91942321e4c9f84 Jaegeuk Kim        2016-05-20   853  			inode->i_mode = F2FS_I(inode)->i_acl_mode;
91942321e4c9f84 Jaegeuk Kim        2016-05-20   854  			clear_inode_flag(inode, FI_ACL_MODE);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   855  		}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   856  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   857  
c0ed4405a99ec9b Yunlei He          2016-12-11   858  	/* file size may changed here */
ca597bddedd9490 Chao Yu            2019-02-23   859  	f2fs_mark_inode_dirty_sync(inode, true);
15d04354555fdfe Jaegeuk Kim        2016-10-14   860  
15d04354555fdfe Jaegeuk Kim        2016-10-14   861  	/* inode change will produce dirty node pages flushed by checkpoint */
15d04354555fdfe Jaegeuk Kim        2016-10-14   862  	f2fs_balance_fs(F2FS_I_SB(inode), true);
15d04354555fdfe Jaegeuk Kim        2016-10-14   863  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   864  	return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   865  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   866  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   867  const struct inode_operations f2fs_file_inode_operations = {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   868  	.getattr	= f2fs_getattr,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   869  	.setattr	= f2fs_setattr,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   870  	.get_acl	= f2fs_get_acl,
a6dda0e63e97122 Christoph Hellwig  2013-12-20   871  	.set_acl	= f2fs_set_acl,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   872  #ifdef CONFIG_F2FS_FS_XATTR
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   873  	.listxattr	= f2fs_listxattr,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   874  #endif
9ab701349247368 Jaegeuk Kim        2014-06-08   875  	.fiemap		= f2fs_fiemap,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   876  };
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   877  
6394328ab8a2ab6 Chao Yu            2015-08-07   878  static int fill_zero(struct inode *inode, pgoff_t index,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   879  					loff_t start, loff_t len)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   880  {
4081363fbe84a7e Jaegeuk Kim        2014-09-02   881  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   882  	struct page *page;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   883  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   884  	if (!len)
6394328ab8a2ab6 Chao Yu            2015-08-07   885  		return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   886  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07   887  	f2fs_balance_fs(sbi, true);
bd43df021ac3724 Jaegeuk Kim        2013-01-25   888  
e479556bfdd1366 Gu Zheng           2013-09-27   889  	f2fs_lock_op(sbi);
4d57b86dd86404f Chao Yu            2018-05-30   890  	page = f2fs_get_new_data_page(inode, NULL, index, false);
e479556bfdd1366 Gu Zheng           2013-09-27   891  	f2fs_unlock_op(sbi);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   892  
6394328ab8a2ab6 Chao Yu            2015-08-07   893  	if (IS_ERR(page))
6394328ab8a2ab6 Chao Yu            2015-08-07   894  		return PTR_ERR(page);
6394328ab8a2ab6 Chao Yu            2015-08-07   895  
bae0ee7a767ceee Chao Yu            2018-12-25   896  	f2fs_wait_on_page_writeback(page, DATA, true, true);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   897  	zero_user(page, start, len);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   898  	set_page_dirty(page);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   899  	f2fs_put_page(page, 1);
6394328ab8a2ab6 Chao Yu            2015-08-07   900  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   901  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   902  
4d57b86dd86404f Chao Yu            2018-05-30   903  int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   904  {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   905  	int err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   906  
ea58711e884c300 Chao Yu            2015-09-17   907  	while (pg_start < pg_end) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   908  		struct dnode_of_data dn;
ea58711e884c300 Chao Yu            2015-09-17   909  		pgoff_t end_offset, count;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   910  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   911  		set_new_dnode(&dn, inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30   912  		err = f2fs_get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   913  		if (err) {
ea58711e884c300 Chao Yu            2015-09-17   914  			if (err == -ENOENT) {
4d57b86dd86404f Chao Yu            2018-05-30   915  				pg_start = f2fs_get_next_page_offset(&dn,
4d57b86dd86404f Chao Yu            2018-05-30   916  								pg_start);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   917  				continue;
ea58711e884c300 Chao Yu            2015-09-17   918  			}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   919  			return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   920  		}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   921  
81ca7350ce5ed43 Chao Yu            2016-01-26   922  		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
ea58711e884c300 Chao Yu            2015-09-17   923  		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
ea58711e884c300 Chao Yu            2015-09-17   924  
ea58711e884c300 Chao Yu            2015-09-17   925  		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
ea58711e884c300 Chao Yu            2015-09-17   926  
4d57b86dd86404f Chao Yu            2018-05-30   927  		f2fs_truncate_data_blocks_range(&dn, count);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   928  		f2fs_put_dnode(&dn);
ea58711e884c300 Chao Yu            2015-09-17   929  
ea58711e884c300 Chao Yu            2015-09-17   930  		pg_start += count;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   931  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   932  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   933  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   934  
a66c7b2fcfbc9ef Chao Yu            2013-11-22   935  static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   936  {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   937  	pgoff_t pg_start, pg_end;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   938  	loff_t off_start, off_end;
b9d777b85ff1ff7 Jaegeuk Kim        2015-12-22   939  	int ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   940  
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23   941  	ret = f2fs_convert_inline_inode(inode);
9ffe0fb5f3bbd01 Huajun Li          2013-11-10   942  	if (ret)
9ffe0fb5f3bbd01 Huajun Li          2013-11-10   943  		return ret;
9ffe0fb5f3bbd01 Huajun Li          2013-11-10   944  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   945  	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   946  	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   947  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   948  	off_start = offset & (PAGE_SIZE - 1);
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   949  	off_end = (offset + len) & (PAGE_SIZE - 1);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   950  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   951  	if (pg_start == pg_end) {
6394328ab8a2ab6 Chao Yu            2015-08-07   952  		ret = fill_zero(inode, pg_start, off_start,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   953  						off_end - off_start);
6394328ab8a2ab6 Chao Yu            2015-08-07   954  		if (ret)
6394328ab8a2ab6 Chao Yu            2015-08-07   955  			return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   956  	} else {
6394328ab8a2ab6 Chao Yu            2015-08-07   957  		if (off_start) {
6394328ab8a2ab6 Chao Yu            2015-08-07   958  			ret = fill_zero(inode, pg_start++, off_start,
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   959  						PAGE_SIZE - off_start);
6394328ab8a2ab6 Chao Yu            2015-08-07   960  			if (ret)
6394328ab8a2ab6 Chao Yu            2015-08-07   961  				return ret;
6394328ab8a2ab6 Chao Yu            2015-08-07   962  		}
6394328ab8a2ab6 Chao Yu            2015-08-07   963  		if (off_end) {
6394328ab8a2ab6 Chao Yu            2015-08-07   964  			ret = fill_zero(inode, pg_end, 0, off_end);
6394328ab8a2ab6 Chao Yu            2015-08-07   965  			if (ret)
6394328ab8a2ab6 Chao Yu            2015-08-07   966  				return ret;
6394328ab8a2ab6 Chao Yu            2015-08-07   967  		}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   968  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   969  		if (pg_start < pg_end) {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   970  			struct address_space *mapping = inode->i_mapping;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   971  			loff_t blk_start, blk_end;
4081363fbe84a7e Jaegeuk Kim        2014-09-02   972  			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
1127a3d448bcf4d Jason Hrycay       2013-04-08   973  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07   974  			f2fs_balance_fs(sbi, true);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   975  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   976  			blk_start = (loff_t)pg_start << PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01   977  			blk_end = (loff_t)pg_end << PAGE_SHIFT;
a33c150237a20d9 Chao Yu            2018-08-05   978  
a33c150237a20d9 Chao Yu            2018-08-05   979  			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25   980  			down_write(&F2FS_I(inode)->i_mmap_sem);
a33c150237a20d9 Chao Yu            2018-08-05   981  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   982  			truncate_inode_pages_range(mapping, blk_start,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   983  					blk_end - 1);
399368372ed9f3c Jaegeuk Kim        2012-11-22   984  
e479556bfdd1366 Gu Zheng           2013-09-27   985  			f2fs_lock_op(sbi);
4d57b86dd86404f Chao Yu            2018-05-30   986  			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
e479556bfdd1366 Gu Zheng           2013-09-27   987  			f2fs_unlock_op(sbi);
a33c150237a20d9 Chao Yu            2018-08-05   988  
5a3a2d83cda82df Qiuyang Sun        2017-05-18   989  			up_write(&F2FS_I(inode)->i_mmap_sem);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25   990  			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   991  		}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   992  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   993  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   994  	return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   995  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02   996  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08   997  static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08   998  				int *do_replace, pgoff_t off, pgoff_t len)
b4ace33703243fe Chao Yu            2015-05-06   999  {
b4ace33703243fe Chao Yu            2015-05-06  1000  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
b4ace33703243fe Chao Yu            2015-05-06  1001  	struct dnode_of_data dn;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1002  	int ret, done, i;
ecbaa4068f88f96 Chao Yu            2015-07-16  1003  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1004  next_dnode:
b4ace33703243fe Chao Yu            2015-05-06  1005  	set_new_dnode(&dn, inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30  1006  	ret = f2fs_get_dnode_of_data(&dn, off, LOOKUP_NODE_RA);
b4ace33703243fe Chao Yu            2015-05-06  1007  	if (ret && ret != -ENOENT) {
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1008  		return ret;
b4ace33703243fe Chao Yu            2015-05-06  1009  	} else if (ret == -ENOENT) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1010  		if (dn.max_level == 0)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1011  			return -ENOENT;
d02a6e6174a772f Chao Yu            2019-03-25  1012  		done = min((pgoff_t)ADDRS_PER_BLOCK(inode) - dn.ofs_in_node,
d02a6e6174a772f Chao Yu            2019-03-25  1013  									len);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1014  		blkaddr += done;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1015  		do_replace += done;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1016  		goto next;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1017  	}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1018  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1019  	done = min((pgoff_t)ADDRS_PER_PAGE(dn.node_page, inode) -
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1020  							dn.ofs_in_node, len);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1021  	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
7a2af766af15887 Chao Yu            2017-07-19  1022  		*blkaddr = datablock_addr(dn.inode,
7a2af766af15887 Chao Yu            2017-07-19  1023  					dn.node_page, dn.ofs_in_node);
93770ab7a6e9631 Chao Yu            2019-04-15  1024  
93770ab7a6e9631 Chao Yu            2019-04-15  1025  		if (__is_valid_data_blkaddr(*blkaddr) &&
93770ab7a6e9631 Chao Yu            2019-04-15  1026  			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
93770ab7a6e9631 Chao Yu            2019-04-15  1027  					DATA_GENERIC_ENHANCE)) {
93770ab7a6e9631 Chao Yu            2019-04-15  1028  			f2fs_put_dnode(&dn);
93770ab7a6e9631 Chao Yu            2019-04-15  1029  			return -EFAULT;
93770ab7a6e9631 Chao Yu            2019-04-15  1030  		}
93770ab7a6e9631 Chao Yu            2019-04-15  1031  
4d57b86dd86404f Chao Yu            2018-05-30  1032  		if (!f2fs_is_checkpointed_data(sbi, *blkaddr)) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1033  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1034  			if (test_opt(sbi, LFS)) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1035  				f2fs_put_dnode(&dn);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1036  				return -ENOTSUPP;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1037  			}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1038  
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1039  			/* do not invalidate this block address */
f28b3434afb8bb5 Chao Yu            2016-02-24  1040  			f2fs_update_data_blkaddr(&dn, NULL_ADDR);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1041  			*do_replace = 1;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1042  		}
ecbaa4068f88f96 Chao Yu            2015-07-16  1043  	}
b4ace33703243fe Chao Yu            2015-05-06  1044  	f2fs_put_dnode(&dn);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1045  next:
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1046  	len -= done;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1047  	off += done;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1048  	if (len)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1049  		goto next_dnode;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1050  	return 0;
b4ace33703243fe Chao Yu            2015-05-06  1051  }
b4ace33703243fe Chao Yu            2015-05-06  1052  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1053  static int __roll_back_blkaddrs(struct inode *inode, block_t *blkaddr,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1054  				int *do_replace, pgoff_t off, int len)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1055  {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1056  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1057  	struct dnode_of_data dn;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1058  	int ret, i;
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1059  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1060  	for (i = 0; i < len; i++, do_replace++, blkaddr++) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1061  		if (*do_replace == 0)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1062  			continue;
b4ace33703243fe Chao Yu            2015-05-06  1063  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1064  		set_new_dnode(&dn, inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30  1065  		ret = f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_NODE_RA);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1066  		if (ret) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1067  			dec_valid_block_count(sbi, inode, 1);
4d57b86dd86404f Chao Yu            2018-05-30  1068  			f2fs_invalidate_blocks(sbi, *blkaddr);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1069  		} else {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1070  			f2fs_update_data_blkaddr(&dn, *blkaddr);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1071  		}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1072  		f2fs_put_dnode(&dn);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1073  	}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1074  	return 0;
36abef4e796d382 Jaegeuk Kim        2016-06-03  1075  }
36abef4e796d382 Jaegeuk Kim        2016-06-03  1076  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1077  static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1078  			block_t *blkaddr, int *do_replace,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1079  			pgoff_t src, pgoff_t dst, pgoff_t len, bool full)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1080  {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1081  	struct f2fs_sb_info *sbi = F2FS_I_SB(src_inode);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1082  	pgoff_t i = 0;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1083  	int ret;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1084  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1085  	while (i < len) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1086  		if (blkaddr[i] == NULL_ADDR && !full) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1087  			i++;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1088  			continue;
b4ace33703243fe Chao Yu            2015-05-06  1089  		}
b4ace33703243fe Chao Yu            2015-05-06  1090  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1091  		if (do_replace[i] || blkaddr[i] == NULL_ADDR) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1092  			struct dnode_of_data dn;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1093  			struct node_info ni;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1094  			size_t new_size;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1095  			pgoff_t ilen;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1096  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1097  			set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30  1098  			ret = f2fs_get_dnode_of_data(&dn, dst + i, ALLOC_NODE);
b4ace33703243fe Chao Yu            2015-05-06  1099  			if (ret)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1100  				return ret;
b4ace33703243fe Chao Yu            2015-05-06  1101  
7735730d39d75e7 Chao Yu            2018-07-17  1102  			ret = f2fs_get_node_info(sbi, dn.nid, &ni);
7735730d39d75e7 Chao Yu            2018-07-17  1103  			if (ret) {
7735730d39d75e7 Chao Yu            2018-07-17  1104  				f2fs_put_dnode(&dn);
7735730d39d75e7 Chao Yu            2018-07-17  1105  				return ret;
7735730d39d75e7 Chao Yu            2018-07-17  1106  			}
7735730d39d75e7 Chao Yu            2018-07-17  1107  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1108  			ilen = min((pgoff_t)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1109  				ADDRS_PER_PAGE(dn.node_page, dst_inode) -
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1110  						dn.ofs_in_node, len - i);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1111  			do {
7a2af766af15887 Chao Yu            2017-07-19  1112  				dn.data_blkaddr = datablock_addr(dn.inode,
7a2af766af15887 Chao Yu            2017-07-19  1113  						dn.node_page, dn.ofs_in_node);
4d57b86dd86404f Chao Yu            2018-05-30  1114  				f2fs_truncate_data_blocks_range(&dn, 1);
b4ace33703243fe Chao Yu            2015-05-06  1115  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1116  				if (do_replace[i]) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1117  					f2fs_i_blocks_write(src_inode,
0abd675e97e60d4 Chao Yu            2017-07-09  1118  							1, false, false);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1119  					f2fs_i_blocks_write(dst_inode,
0abd675e97e60d4 Chao Yu            2017-07-09  1120  							1, true, false);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1121  					f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1122  					blkaddr[i], ni.version, true, false);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1123  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1124  					do_replace[i] = 0;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1125  				}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1126  				dn.ofs_in_node++;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1127  				i++;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1128  				new_size = (dst + i) << PAGE_SHIFT;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1129  				if (dst_inode->i_size < new_size)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1130  					f2fs_i_size_write(dst_inode, new_size);
e87f7329bbd6760 Jaegeuk Kim        2016-11-23  1131  			} while (--ilen && (do_replace[i] || blkaddr[i] == NULL_ADDR));
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1132  
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1133  			f2fs_put_dnode(&dn);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1134  		} else {
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1135  			struct page *psrc, *pdst;
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1136  
4d57b86dd86404f Chao Yu            2018-05-30  1137  			psrc = f2fs_get_lock_data_page(src_inode,
4d57b86dd86404f Chao Yu            2018-05-30  1138  							src + i, true);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1139  			if (IS_ERR(psrc))
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1140  				return PTR_ERR(psrc);
4d57b86dd86404f Chao Yu            2018-05-30  1141  			pdst = f2fs_get_new_data_page(dst_inode, NULL, dst + i,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1142  								true);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1143  			if (IS_ERR(pdst)) {
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1144  				f2fs_put_page(psrc, 1);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1145  				return PTR_ERR(pdst);
b4ace33703243fe Chao Yu            2015-05-06  1146  			}
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1147  			f2fs_copy_page(psrc, pdst);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1148  			set_page_dirty(pdst);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1149  			f2fs_put_page(pdst, 1);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1150  			f2fs_put_page(psrc, 1);
b4ace33703243fe Chao Yu            2015-05-06  1151  
4d57b86dd86404f Chao Yu            2018-05-30  1152  			ret = f2fs_truncate_hole(src_inode,
4d57b86dd86404f Chao Yu            2018-05-30  1153  						src + i, src + i + 1);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1154  			if (ret)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1155  				return ret;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1156  			i++;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1157  		}
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1158  	}
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1159  	return 0;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1160  }
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1161  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1162  static int __exchange_data_block(struct inode *src_inode,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1163  			struct inode *dst_inode, pgoff_t src, pgoff_t dst,
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1164  			pgoff_t len, bool full)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1165  {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1166  	block_t *src_blkaddr;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1167  	int *do_replace;
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1168  	pgoff_t olen;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1169  	int ret;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1170  
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1171  	while (len) {
d02a6e6174a772f Chao Yu            2019-03-25  1172  		olen = min((pgoff_t)4 * ADDRS_PER_BLOCK(src_inode), len);
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1173  
628b3d1438fbcb1 Chao Yu            2017-11-30  1174  		src_blkaddr = f2fs_kvzalloc(F2FS_I_SB(src_inode),
9d2a789c1db75d0 Kees Cook          2018-06-12  1175  					array_size(olen, sizeof(block_t)),
9d2a789c1db75d0 Kees Cook          2018-06-12  1176  					GFP_KERNEL);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1177  		if (!src_blkaddr)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1178  			return -ENOMEM;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1179  
628b3d1438fbcb1 Chao Yu            2017-11-30  1180  		do_replace = f2fs_kvzalloc(F2FS_I_SB(src_inode),
9d2a789c1db75d0 Kees Cook          2018-06-12  1181  					array_size(olen, sizeof(int)),
9d2a789c1db75d0 Kees Cook          2018-06-12  1182  					GFP_KERNEL);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1183  		if (!do_replace) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1184  			kvfree(src_blkaddr);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1185  			return -ENOMEM;
b4ace33703243fe Chao Yu            2015-05-06  1186  		}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1187  
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1188  		ret = __read_out_blkaddrs(src_inode, src_blkaddr,
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1189  					do_replace, src, olen);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1190  		if (ret)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1191  			goto roll_back;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1192  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1193  		ret = __clone_blkaddrs(src_inode, dst_inode, src_blkaddr,
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1194  					do_replace, src, dst, olen, full);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1195  		if (ret)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1196  			goto roll_back;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1197  
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1198  		src += olen;
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1199  		dst += olen;
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1200  		len -= olen;
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1201  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1202  		kvfree(src_blkaddr);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1203  		kvfree(do_replace);
363cad7f7e586b3 Jaegeuk Kim        2016-07-16  1204  	}
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1205  	return 0;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1206  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1207  roll_back:
9fd62605bba9a8c Chao Yu            2018-05-28  1208  	__roll_back_blkaddrs(src_inode, src_blkaddr, do_replace, src, olen);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1209  	kvfree(src_blkaddr);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1210  	kvfree(do_replace);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1211  	return ret;
b4ace33703243fe Chao Yu            2015-05-06  1212  }
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1213  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1214  static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1215  {
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1216  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1217  	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1218  	pgoff_t start = offset >> PAGE_SHIFT;
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1219  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1220  	int ret;
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1221  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07  1222  	f2fs_balance_fs(sbi, true);
5f281fab9b9a300 Jaegeuk Kim        2016-07-12  1223  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1224  	/* avoid gc operation during block exchange */
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1225  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1226  	down_write(&F2FS_I(inode)->i_mmap_sem);
5f281fab9b9a300 Jaegeuk Kim        2016-07-12  1227  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1228  	f2fs_lock_op(sbi);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1229  	f2fs_drop_extent_tree(inode);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1230  	truncate_pagecache(inode, offset);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1231  	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
b4ace33703243fe Chao Yu            2015-05-06  1232  	f2fs_unlock_op(sbi);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1233  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1234  	up_write(&F2FS_I(inode)->i_mmap_sem);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1235  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
b4ace33703243fe Chao Yu            2015-05-06  1236  	return ret;
b4ace33703243fe Chao Yu            2015-05-06  1237  }
b4ace33703243fe Chao Yu            2015-05-06  1238  
b4ace33703243fe Chao Yu            2015-05-06  1239  static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
b4ace33703243fe Chao Yu            2015-05-06  1240  {
b4ace33703243fe Chao Yu            2015-05-06  1241  	loff_t new_size;
b4ace33703243fe Chao Yu            2015-05-06  1242  	int ret;
b4ace33703243fe Chao Yu            2015-05-06  1243  
b4ace33703243fe Chao Yu            2015-05-06  1244  	if (offset + len >= i_size_read(inode))
b4ace33703243fe Chao Yu            2015-05-06  1245  		return -EINVAL;
b4ace33703243fe Chao Yu            2015-05-06  1246  
b4ace33703243fe Chao Yu            2015-05-06  1247  	/* collapse range should be aligned to block size of f2fs. */
b4ace33703243fe Chao Yu            2015-05-06  1248  	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
b4ace33703243fe Chao Yu            2015-05-06  1249  		return -EINVAL;
b4ace33703243fe Chao Yu            2015-05-06  1250  
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1251  	ret = f2fs_convert_inline_inode(inode);
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1252  	if (ret)
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1253  		return ret;
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1254  
b4ace33703243fe Chao Yu            2015-05-06  1255  	/* write out all dirty pages from offset */
b4ace33703243fe Chao Yu            2015-05-06  1256  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
b4ace33703243fe Chao Yu            2015-05-06  1257  	if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1258  		return ret;
b4ace33703243fe Chao Yu            2015-05-06  1259  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1260  	ret = f2fs_do_collapse(inode, offset, len);
b4ace33703243fe Chao Yu            2015-05-06  1261  	if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1262  		return ret;
b4ace33703243fe Chao Yu            2015-05-06  1263  
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1264  	/* write out all moved pages, if possible */
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1265  	down_write(&F2FS_I(inode)->i_mmap_sem);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1266  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1267  	truncate_pagecache(inode, offset);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1268  
b4ace33703243fe Chao Yu            2015-05-06  1269  	new_size = i_size_read(inode) - len;
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1270  	truncate_pagecache(inode, new_size);
b4ace33703243fe Chao Yu            2015-05-06  1271  
c42d28ce3e16dbd Chao Yu            2019-02-02  1272  	ret = f2fs_truncate_blocks(inode, new_size, true);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1273  	up_write(&F2FS_I(inode)->i_mmap_sem);
b4ace33703243fe Chao Yu            2015-05-06  1274  	if (!ret)
fc9581c80972296 Jaegeuk Kim        2016-05-20  1275  		f2fs_i_size_write(inode, new_size);
b4ace33703243fe Chao Yu            2015-05-06  1276  	return ret;
b4ace33703243fe Chao Yu            2015-05-06  1277  }
b4ace33703243fe Chao Yu            2015-05-06  1278  
6e9619499f53b22 Chao Yu            2016-05-09  1279  static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
6e9619499f53b22 Chao Yu            2016-05-09  1280  								pgoff_t end)
6e9619499f53b22 Chao Yu            2016-05-09  1281  {
6e9619499f53b22 Chao Yu            2016-05-09  1282  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
6e9619499f53b22 Chao Yu            2016-05-09  1283  	pgoff_t index = start;
6e9619499f53b22 Chao Yu            2016-05-09  1284  	unsigned int ofs_in_node = dn->ofs_in_node;
6e9619499f53b22 Chao Yu            2016-05-09  1285  	blkcnt_t count = 0;
6e9619499f53b22 Chao Yu            2016-05-09  1286  	int ret;
6e9619499f53b22 Chao Yu            2016-05-09  1287  
6e9619499f53b22 Chao Yu            2016-05-09  1288  	for (; index < end; index++, dn->ofs_in_node++) {
7a2af766af15887 Chao Yu            2017-07-19  1289  		if (datablock_addr(dn->inode, dn->node_page,
7a2af766af15887 Chao Yu            2017-07-19  1290  					dn->ofs_in_node) == NULL_ADDR)
6e9619499f53b22 Chao Yu            2016-05-09  1291  			count++;
6e9619499f53b22 Chao Yu            2016-05-09  1292  	}
6e9619499f53b22 Chao Yu            2016-05-09  1293  
6e9619499f53b22 Chao Yu            2016-05-09  1294  	dn->ofs_in_node = ofs_in_node;
4d57b86dd86404f Chao Yu            2018-05-30  1295  	ret = f2fs_reserve_new_blocks(dn, count);
6e9619499f53b22 Chao Yu            2016-05-09  1296  	if (ret)
6e9619499f53b22 Chao Yu            2016-05-09  1297  		return ret;
6e9619499f53b22 Chao Yu            2016-05-09  1298  
6e9619499f53b22 Chao Yu            2016-05-09  1299  	dn->ofs_in_node = ofs_in_node;
6e9619499f53b22 Chao Yu            2016-05-09  1300  	for (index = start; index < end; index++, dn->ofs_in_node++) {
7a2af766af15887 Chao Yu            2017-07-19  1301  		dn->data_blkaddr = datablock_addr(dn->inode,
7a2af766af15887 Chao Yu            2017-07-19  1302  					dn->node_page, dn->ofs_in_node);
6e9619499f53b22 Chao Yu            2016-05-09  1303  		/*
4d57b86dd86404f Chao Yu            2018-05-30  1304  		 * f2fs_reserve_new_blocks will not guarantee entire block
6e9619499f53b22 Chao Yu            2016-05-09  1305  		 * allocation.
6e9619499f53b22 Chao Yu            2016-05-09  1306  		 */
6e9619499f53b22 Chao Yu            2016-05-09  1307  		if (dn->data_blkaddr == NULL_ADDR) {
6e9619499f53b22 Chao Yu            2016-05-09  1308  			ret = -ENOSPC;
6e9619499f53b22 Chao Yu            2016-05-09  1309  			break;
6e9619499f53b22 Chao Yu            2016-05-09  1310  		}
6e9619499f53b22 Chao Yu            2016-05-09  1311  		if (dn->data_blkaddr != NEW_ADDR) {
4d57b86dd86404f Chao Yu            2018-05-30  1312  			f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
6e9619499f53b22 Chao Yu            2016-05-09  1313  			dn->data_blkaddr = NEW_ADDR;
4d57b86dd86404f Chao Yu            2018-05-30  1314  			f2fs_set_data_blkaddr(dn);
6e9619499f53b22 Chao Yu            2016-05-09  1315  		}
6e9619499f53b22 Chao Yu            2016-05-09  1316  	}
6e9619499f53b22 Chao Yu            2016-05-09  1317  
6e9619499f53b22 Chao Yu            2016-05-09  1318  	f2fs_update_extent_cache_range(dn, start, 0, index - start);
6e9619499f53b22 Chao Yu            2016-05-09  1319  
6e9619499f53b22 Chao Yu            2016-05-09  1320  	return ret;
6e9619499f53b22 Chao Yu            2016-05-09  1321  }
6e9619499f53b22 Chao Yu            2016-05-09  1322  
75cd4e098d17843 Chao Yu            2015-05-06  1323  static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
75cd4e098d17843 Chao Yu            2015-05-06  1324  								int mode)
75cd4e098d17843 Chao Yu            2015-05-06  1325  {
75cd4e098d17843 Chao Yu            2015-05-06  1326  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
75cd4e098d17843 Chao Yu            2015-05-06  1327  	struct address_space *mapping = inode->i_mapping;
75cd4e098d17843 Chao Yu            2015-05-06  1328  	pgoff_t index, pg_start, pg_end;
75cd4e098d17843 Chao Yu            2015-05-06  1329  	loff_t new_size = i_size_read(inode);
75cd4e098d17843 Chao Yu            2015-05-06  1330  	loff_t off_start, off_end;
75cd4e098d17843 Chao Yu            2015-05-06  1331  	int ret = 0;
75cd4e098d17843 Chao Yu            2015-05-06  1332  
75cd4e098d17843 Chao Yu            2015-05-06  1333  	ret = inode_newsize_ok(inode, (len + offset));
75cd4e098d17843 Chao Yu            2015-05-06  1334  	if (ret)
75cd4e098d17843 Chao Yu            2015-05-06  1335  		return ret;
75cd4e098d17843 Chao Yu            2015-05-06  1336  
75cd4e098d17843 Chao Yu            2015-05-06  1337  	ret = f2fs_convert_inline_inode(inode);
75cd4e098d17843 Chao Yu            2015-05-06  1338  	if (ret)
75cd4e098d17843 Chao Yu            2015-05-06  1339  		return ret;
75cd4e098d17843 Chao Yu            2015-05-06  1340  
75cd4e098d17843 Chao Yu            2015-05-06  1341  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
75cd4e098d17843 Chao Yu            2015-05-06  1342  	if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1343  		return ret;
75cd4e098d17843 Chao Yu            2015-05-06  1344  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1345  	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1346  	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
75cd4e098d17843 Chao Yu            2015-05-06  1347  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1348  	off_start = offset & (PAGE_SIZE - 1);
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1349  	off_end = (offset + len) & (PAGE_SIZE - 1);
75cd4e098d17843 Chao Yu            2015-05-06  1350  
75cd4e098d17843 Chao Yu            2015-05-06  1351  	if (pg_start == pg_end) {
6394328ab8a2ab6 Chao Yu            2015-08-07  1352  		ret = fill_zero(inode, pg_start, off_start,
6394328ab8a2ab6 Chao Yu            2015-08-07  1353  						off_end - off_start);
6394328ab8a2ab6 Chao Yu            2015-08-07  1354  		if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1355  			return ret;
6394328ab8a2ab6 Chao Yu            2015-08-07  1356  
75cd4e098d17843 Chao Yu            2015-05-06  1357  		new_size = max_t(loff_t, new_size, offset + len);
75cd4e098d17843 Chao Yu            2015-05-06  1358  	} else {
75cd4e098d17843 Chao Yu            2015-05-06  1359  		if (off_start) {
6394328ab8a2ab6 Chao Yu            2015-08-07  1360  			ret = fill_zero(inode, pg_start++, off_start,
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1361  						PAGE_SIZE - off_start);
6394328ab8a2ab6 Chao Yu            2015-08-07  1362  			if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1363  				return ret;
6394328ab8a2ab6 Chao Yu            2015-08-07  1364  
75cd4e098d17843 Chao Yu            2015-05-06  1365  			new_size = max_t(loff_t, new_size,
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1366  					(loff_t)pg_start << PAGE_SHIFT);
75cd4e098d17843 Chao Yu            2015-05-06  1367  		}
75cd4e098d17843 Chao Yu            2015-05-06  1368  
6e9619499f53b22 Chao Yu            2016-05-09  1369  		for (index = pg_start; index < pg_end;) {
75cd4e098d17843 Chao Yu            2015-05-06  1370  			struct dnode_of_data dn;
6e9619499f53b22 Chao Yu            2016-05-09  1371  			unsigned int end_offset;
6e9619499f53b22 Chao Yu            2016-05-09  1372  			pgoff_t end;
75cd4e098d17843 Chao Yu            2015-05-06  1373  
c7079853c859c91 Chao Yu            2018-08-05  1374  			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1375  			down_write(&F2FS_I(inode)->i_mmap_sem);
c7079853c859c91 Chao Yu            2018-08-05  1376  
c7079853c859c91 Chao Yu            2018-08-05  1377  			truncate_pagecache_range(inode,
c7079853c859c91 Chao Yu            2018-08-05  1378  				(loff_t)index << PAGE_SHIFT,
c7079853c859c91 Chao Yu            2018-08-05  1379  				((loff_t)pg_end << PAGE_SHIFT) - 1);
c7079853c859c91 Chao Yu            2018-08-05  1380  
75cd4e098d17843 Chao Yu            2015-05-06  1381  			f2fs_lock_op(sbi);
75cd4e098d17843 Chao Yu            2015-05-06  1382  
6e9619499f53b22 Chao Yu            2016-05-09  1383  			set_new_dnode(&dn, inode, NULL, NULL, 0);
4d57b86dd86404f Chao Yu            2018-05-30  1384  			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
75cd4e098d17843 Chao Yu            2015-05-06  1385  			if (ret) {
75cd4e098d17843 Chao Yu            2015-05-06  1386  				f2fs_unlock_op(sbi);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1387  				up_write(&F2FS_I(inode)->i_mmap_sem);
c7079853c859c91 Chao Yu            2018-08-05  1388  				up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
75cd4e098d17843 Chao Yu            2015-05-06  1389  				goto out;
75cd4e098d17843 Chao Yu            2015-05-06  1390  			}
75cd4e098d17843 Chao Yu            2015-05-06  1391  
6e9619499f53b22 Chao Yu            2016-05-09  1392  			end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
6e9619499f53b22 Chao Yu            2016-05-09  1393  			end = min(pg_end, end_offset - dn.ofs_in_node + index);
6e9619499f53b22 Chao Yu            2016-05-09  1394  
6e9619499f53b22 Chao Yu            2016-05-09  1395  			ret = f2fs_do_zero_range(&dn, index, end);
75cd4e098d17843 Chao Yu            2015-05-06  1396  			f2fs_put_dnode(&dn);
c7079853c859c91 Chao Yu            2018-08-05  1397  
75cd4e098d17843 Chao Yu            2015-05-06  1398  			f2fs_unlock_op(sbi);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1399  			up_write(&F2FS_I(inode)->i_mmap_sem);
c7079853c859c91 Chao Yu            2018-08-05  1400  			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
9434fcde1fa0f48 Chao Yu            2016-10-11  1401  
9434fcde1fa0f48 Chao Yu            2016-10-11  1402  			f2fs_balance_fs(sbi, dn.node_changed);
9434fcde1fa0f48 Chao Yu            2016-10-11  1403  
6e9619499f53b22 Chao Yu            2016-05-09  1404  			if (ret)
6e9619499f53b22 Chao Yu            2016-05-09  1405  				goto out;
75cd4e098d17843 Chao Yu            2015-05-06  1406  
6e9619499f53b22 Chao Yu            2016-05-09  1407  			index = end;
75cd4e098d17843 Chao Yu            2015-05-06  1408  			new_size = max_t(loff_t, new_size,
6e9619499f53b22 Chao Yu            2016-05-09  1409  					(loff_t)index << PAGE_SHIFT);
75cd4e098d17843 Chao Yu            2015-05-06  1410  		}
75cd4e098d17843 Chao Yu            2015-05-06  1411  
75cd4e098d17843 Chao Yu            2015-05-06  1412  		if (off_end) {
6394328ab8a2ab6 Chao Yu            2015-08-07  1413  			ret = fill_zero(inode, pg_end, 0, off_end);
6394328ab8a2ab6 Chao Yu            2015-08-07  1414  			if (ret)
6394328ab8a2ab6 Chao Yu            2015-08-07  1415  				goto out;
6394328ab8a2ab6 Chao Yu            2015-08-07  1416  
75cd4e098d17843 Chao Yu            2015-05-06  1417  			new_size = max_t(loff_t, new_size, offset + len);
75cd4e098d17843 Chao Yu            2015-05-06  1418  		}
75cd4e098d17843 Chao Yu            2015-05-06  1419  	}
75cd4e098d17843 Chao Yu            2015-05-06  1420  
75cd4e098d17843 Chao Yu            2015-05-06  1421  out:
17cd07ae95073c2 Chao Yu            2018-02-25  1422  	if (new_size > i_size_read(inode)) {
17cd07ae95073c2 Chao Yu            2018-02-25  1423  		if (mode & FALLOC_FL_KEEP_SIZE)
17cd07ae95073c2 Chao Yu            2018-02-25  1424  			file_set_keep_isize(inode);
17cd07ae95073c2 Chao Yu            2018-02-25  1425  		else
fc9581c80972296 Jaegeuk Kim        2016-05-20  1426  			f2fs_i_size_write(inode, new_size);
17cd07ae95073c2 Chao Yu            2018-02-25  1427  	}
75cd4e098d17843 Chao Yu            2015-05-06  1428  	return ret;
75cd4e098d17843 Chao Yu            2015-05-06  1429  }
75cd4e098d17843 Chao Yu            2015-05-06  1430  
f62185d0e283e9d Chao Yu            2015-05-28  1431  static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
f62185d0e283e9d Chao Yu            2015-05-28  1432  {
f62185d0e283e9d Chao Yu            2015-05-28  1433  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1434  	pgoff_t nr, pg_start, pg_end, delta, idx;
f62185d0e283e9d Chao Yu            2015-05-28  1435  	loff_t new_size;
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1436  	int ret = 0;
f62185d0e283e9d Chao Yu            2015-05-28  1437  
f62185d0e283e9d Chao Yu            2015-05-28  1438  	new_size = i_size_read(inode) + len;
46e82fb1b5349e7 Kinglong Mee       2017-03-10  1439  	ret = inode_newsize_ok(inode, new_size);
46e82fb1b5349e7 Kinglong Mee       2017-03-10  1440  	if (ret)
46e82fb1b5349e7 Kinglong Mee       2017-03-10  1441  		return ret;
f62185d0e283e9d Chao Yu            2015-05-28  1442  
f62185d0e283e9d Chao Yu            2015-05-28  1443  	if (offset >= i_size_read(inode))
f62185d0e283e9d Chao Yu            2015-05-28  1444  		return -EINVAL;
f62185d0e283e9d Chao Yu            2015-05-28  1445  
f62185d0e283e9d Chao Yu            2015-05-28  1446  	/* insert range should be aligned to block size of f2fs. */
f62185d0e283e9d Chao Yu            2015-05-28  1447  	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
f62185d0e283e9d Chao Yu            2015-05-28  1448  		return -EINVAL;
f62185d0e283e9d Chao Yu            2015-05-28  1449  
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1450  	ret = f2fs_convert_inline_inode(inode);
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1451  	if (ret)
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1452  		return ret;
97a7b2c274d5dbe Jaegeuk Kim        2015-06-17  1453  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07  1454  	f2fs_balance_fs(sbi, true);
2a3407607028f7c Jaegeuk Kim        2015-12-22  1455  
5a3a2d83cda82df Qiuyang Sun        2017-05-18  1456  	down_write(&F2FS_I(inode)->i_mmap_sem);
c42d28ce3e16dbd Chao Yu            2019-02-02  1457  	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1458  	up_write(&F2FS_I(inode)->i_mmap_sem);
f62185d0e283e9d Chao Yu            2015-05-28  1459  	if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1460  		return ret;
f62185d0e283e9d Chao Yu            2015-05-28  1461  
f62185d0e283e9d Chao Yu            2015-05-28  1462  	/* write out all dirty pages from offset */
f62185d0e283e9d Chao Yu            2015-05-28  1463  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
f62185d0e283e9d Chao Yu            2015-05-28  1464  	if (ret)
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1465  		return ret;
f62185d0e283e9d Chao Yu            2015-05-28  1466  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1467  	pg_start = offset >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1468  	pg_end = (offset + len) >> PAGE_SHIFT;
f62185d0e283e9d Chao Yu            2015-05-28  1469  	delta = pg_end - pg_start;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1470  	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1471  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1472  	/* avoid gc operation during block exchange */
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1473  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1474  	down_write(&F2FS_I(inode)->i_mmap_sem);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1475  	truncate_pagecache(inode, offset);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1476  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1477  	while (!ret && idx > pg_start) {
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1478  		nr = idx - pg_start;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1479  		if (nr > delta)
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1480  			nr = delta;
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1481  		idx -= nr;
f62185d0e283e9d Chao Yu            2015-05-28  1482  
f62185d0e283e9d Chao Yu            2015-05-28  1483  		f2fs_lock_op(sbi);
5f281fab9b9a300 Jaegeuk Kim        2016-07-12  1484  		f2fs_drop_extent_tree(inode);
5f281fab9b9a300 Jaegeuk Kim        2016-07-12  1485  
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1486  		ret = __exchange_data_block(inode, inode, idx,
0a2aa8fbb969302 Jaegeuk Kim        2016-07-08  1487  					idx + delta, nr, false);
f62185d0e283e9d Chao Yu            2015-05-28  1488  		f2fs_unlock_op(sbi);
f62185d0e283e9d Chao Yu            2015-05-28  1489  	}
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1490  	up_write(&F2FS_I(inode)->i_mmap_sem);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1491  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
f62185d0e283e9d Chao Yu            2015-05-28  1492  
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1493  	/* write out all moved pages, if possible */
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1494  	down_write(&F2FS_I(inode)->i_mmap_sem);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1495  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1496  	truncate_pagecache(inode, offset);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1497  	up_write(&F2FS_I(inode)->i_mmap_sem);
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1498  
6e2c64ad7cebf87 Jaegeuk Kim        2015-10-07  1499  	if (!ret)
fc9581c80972296 Jaegeuk Kim        2016-05-20  1500  		f2fs_i_size_write(inode, new_size);
f62185d0e283e9d Chao Yu            2015-05-28  1501  	return ret;
f62185d0e283e9d Chao Yu            2015-05-28  1502  }
f62185d0e283e9d Chao Yu            2015-05-28  1503  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1504  static int expand_inode_data(struct inode *inode, loff_t offset,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1505  					loff_t len, int mode)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1506  {
4081363fbe84a7e Jaegeuk Kim        2014-09-02  1507  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
d5097be55c21c10 Hyunchul Lee       2017-11-28  1508  	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
f9d6d0597698c0d Chao Yu            2018-11-13  1509  			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE,
f9d6d0597698c0d Chao Yu            2018-11-13  1510  			.m_may_create = true };
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1511  	pgoff_t pg_end;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1512  	loff_t new_size = i_size_read(inode);
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1513  	loff_t off_end;
a7de608691f766c Jaegeuk Kim        2016-11-11  1514  	int err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1515  
a7de608691f766c Jaegeuk Kim        2016-11-11  1516  	err = inode_newsize_ok(inode, (len + offset));
a7de608691f766c Jaegeuk Kim        2016-11-11  1517  	if (err)
a7de608691f766c Jaegeuk Kim        2016-11-11  1518  		return err;
9ffe0fb5f3bbd01 Huajun Li          2013-11-10  1519  
a7de608691f766c Jaegeuk Kim        2016-11-11  1520  	err = f2fs_convert_inline_inode(inode);
a7de608691f766c Jaegeuk Kim        2016-11-11  1521  	if (err)
a7de608691f766c Jaegeuk Kim        2016-11-11  1522  		return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1523  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07  1524  	f2fs_balance_fs(sbi, true);
2a3407607028f7c Jaegeuk Kim        2015-12-22  1525  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1526  	pg_end = ((unsigned long long)offset + len) >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  1527  	off_end = (offset + len) & (PAGE_SIZE - 1);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1528  
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1529  	map.m_lblk = ((unsigned long long)offset) >> PAGE_SHIFT;
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1530  	map.m_len = pg_end - map.m_lblk;
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1531  	if (off_end)
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1532  		map.m_len++;
ead432756ab2c76 Jaegeuk Kim        2014-06-13  1533  
a7de608691f766c Jaegeuk Kim        2016-11-11  1534  	err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
a7de608691f766c Jaegeuk Kim        2016-11-11  1535  	if (err) {
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1536  		pgoff_t last_off;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1537  
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1538  		if (!map.m_len)
a7de608691f766c Jaegeuk Kim        2016-11-11  1539  			return err;
98397ff3cddcfde Jaegeuk Kim        2014-06-13  1540  
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1541  		last_off = map.m_lblk + map.m_len - 1;
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1542  
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1543  		/* update new size to the failed position */
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1544  		new_size = (last_off == pg_end) ? offset + len :
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1545  					(loff_t)(last_off + 1) << PAGE_SHIFT;
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1546  	} else {
e12dd7bd874cb1c Jaegeuk Kim        2016-05-06  1547  		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1548  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1549  
e8ed90a6d9a4789 Chao Yu            2017-11-05  1550  	if (new_size > i_size_read(inode)) {
e8ed90a6d9a4789 Chao Yu            2017-11-05  1551  		if (mode & FALLOC_FL_KEEP_SIZE)
e8ed90a6d9a4789 Chao Yu            2017-11-05  1552  			file_set_keep_isize(inode);
e8ed90a6d9a4789 Chao Yu            2017-11-05  1553  		else
fc9581c80972296 Jaegeuk Kim        2016-05-20  1554  			f2fs_i_size_write(inode, new_size);
e8ed90a6d9a4789 Chao Yu            2017-11-05  1555  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1556  
a7de608691f766c Jaegeuk Kim        2016-11-11  1557  	return err;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1558  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1559  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1560  static long f2fs_fallocate(struct file *file, int mode,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1561  				loff_t offset, loff_t len)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1562  {
6131ffaa1f09141 Al Viro            2013-02-27  1563  	struct inode *inode = file_inode(file);
587c0a42552a69a Taehee Yoo         2015-04-21  1564  	long ret = 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1565  
1f227a3e215d361 Jaegeuk Kim        2017-10-23  1566  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23  1567  		return -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23  1568  
c998012b0bb9300 Chao Yu            2015-09-11  1569  	/* f2fs only support ->fallocate for regular file */
c998012b0bb9300 Chao Yu            2015-09-11  1570  	if (!S_ISREG(inode->i_mode))
c998012b0bb9300 Chao Yu            2015-09-11  1571  		return -EINVAL;
c998012b0bb9300 Chao Yu            2015-09-11  1572  
62230e0d702f613 Chandan Rajendra   2018-12-12  1573  	if (IS_ENCRYPTED(inode) &&
f62185d0e283e9d Chao Yu            2015-05-28  1574  		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  1575  		return -EOPNOTSUPP;
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  1576  
b4ace33703243fe Chao Yu            2015-05-06  1577  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
f62185d0e283e9d Chao Yu            2015-05-28  1578  			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
f62185d0e283e9d Chao Yu            2015-05-28  1579  			FALLOC_FL_INSERT_RANGE))
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1580  		return -EOPNOTSUPP;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1581  
5955102c9984fa0 Al Viro            2016-01-22  1582  	inode_lock(inode);
3375f696bd9cfdf Chao Yu            2014-01-28  1583  
587c0a42552a69a Taehee Yoo         2015-04-21  1584  	if (mode & FALLOC_FL_PUNCH_HOLE) {
587c0a42552a69a Taehee Yoo         2015-04-21  1585  		if (offset >= inode->i_size)
587c0a42552a69a Taehee Yoo         2015-04-21  1586  			goto out;
587c0a42552a69a Taehee Yoo         2015-04-21  1587  
a66c7b2fcfbc9ef Chao Yu            2013-11-22  1588  		ret = punch_hole(inode, offset, len);
b4ace33703243fe Chao Yu            2015-05-06  1589  	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
b4ace33703243fe Chao Yu            2015-05-06  1590  		ret = f2fs_collapse_range(inode, offset, len);
75cd4e098d17843 Chao Yu            2015-05-06  1591  	} else if (mode & FALLOC_FL_ZERO_RANGE) {
75cd4e098d17843 Chao Yu            2015-05-06  1592  		ret = f2fs_zero_range(inode, offset, len, mode);
f62185d0e283e9d Chao Yu            2015-05-28  1593  	} else if (mode & FALLOC_FL_INSERT_RANGE) {
f62185d0e283e9d Chao Yu            2015-05-28  1594  		ret = f2fs_insert_range(inode, offset, len);
b4ace33703243fe Chao Yu            2015-05-06  1595  	} else {
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1596  		ret = expand_inode_data(inode, offset, len, mode);
b4ace33703243fe Chao Yu            2015-05-06  1597  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1598  
3af60a49fd2edfe Namjae Jeon        2012-12-30  1599  	if (!ret) {
078cd8279e65998 Deepa Dinamani     2016-09-14  1600  		inode->i_mtime = inode->i_ctime = current_time(inode);
7c45729a4d6d1c9 Jaegeuk Kim        2016-10-14  1601  		f2fs_mark_inode_dirty_sync(inode, false);
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  1602  		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
3af60a49fd2edfe Namjae Jeon        2012-12-30  1603  	}
3375f696bd9cfdf Chao Yu            2014-01-28  1604  
587c0a42552a69a Taehee Yoo         2015-04-21  1605  out:
5955102c9984fa0 Al Viro            2016-01-22  1606  	inode_unlock(inode);
3375f696bd9cfdf Chao Yu            2014-01-28  1607  
c01e285324793a8 Namjae Jeon        2013-04-23  1608  	trace_f2fs_fallocate(inode, mode, offset, len, ret);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1609  	return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1610  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1611  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1612  static int f2fs_release_file(struct inode *inode, struct file *filp)
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1613  {
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1614  	/*
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1615  	 * f2fs_relase_file is called at every close calls. So we should
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1616  	 * not drop any inmemory pages by close called by other process.
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1617  	 */
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1618  	if (!(filp->f_mode & FMODE_WRITE) ||
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1619  			atomic_read(&inode->i_writecount) != 1)
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1620  		return 0;
de5307e46d28aa2 Jaegeuk Kim        2016-04-11  1621  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1622  	/* some remained atomic pages should discarded */
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1623  	if (f2fs_is_atomic_file(inode))
4d57b86dd86404f Chao Yu            2018-05-30  1624  		f2fs_drop_inmem_pages(inode);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1625  	if (f2fs_is_volatile_file(inode)) {
91942321e4c9f84 Jaegeuk Kim        2016-05-20  1626  		set_inode_flag(inode, FI_DROP_CACHE);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1627  		filemap_fdatawrite(inode->i_mapping);
91942321e4c9f84 Jaegeuk Kim        2016-05-20  1628  		clear_inode_flag(inode, FI_DROP_CACHE);
dfa742803fbbd8b Chao Yu            2018-06-04  1629  		clear_inode_flag(inode, FI_VOLATILE_FILE);
dfa742803fbbd8b Chao Yu            2018-06-04  1630  		stat_dec_volatile_write(inode);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1631  	}
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1632  	return 0;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1633  }
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1634  
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1635  static int f2fs_file_flush(struct file *file, fl_owner_t id)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1636  {
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1637  	struct inode *inode = file_inode(file);
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1638  
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1639  	/*
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1640  	 * If the process doing a transaction is crashed, we should do
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1641  	 * roll-back. Otherwise, other reader/write can see corrupted database
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1642  	 * until all the writers close its file. Since this should be done
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1643  	 * before dropping file lock, it needs to do in ->flush.
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1644  	 */
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1645  	if (f2fs_is_atomic_file(inode) &&
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1646  			F2FS_I(inode)->inmem_task == current)
4d57b86dd86404f Chao Yu            2018-05-30  1647  		f2fs_drop_inmem_pages(inode);
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1648  	return 0;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1649  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1650  
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1651  static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1652  {
6131ffaa1f09141 Al Viro            2013-02-27  1653  	struct inode *inode = file_inode(filp);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1654  	struct f2fs_inode_info *fi = F2FS_I(inode);
764811581d1cfb5 Chao Yu            2018-04-08  1655  	unsigned int flags = fi->i_flags;
764811581d1cfb5 Chao Yu            2018-04-08  1656  
62230e0d702f613 Chandan Rajendra   2018-12-12  1657  	if (IS_ENCRYPTED(inode))
764811581d1cfb5 Chao Yu            2018-04-08  1658  		flags |= F2FS_ENCRYPT_FL;
764811581d1cfb5 Chao Yu            2018-04-08  1659  	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
764811581d1cfb5 Chao Yu            2018-04-08  1660  		flags |= F2FS_INLINE_DATA_FL;
5d539245cb18afa Jaegeuk Kim        2019-01-03  1661  	if (is_inode_flag_set(inode, FI_PIN_FILE))
5d539245cb18afa Jaegeuk Kim        2019-01-03  1662  		flags |= F2FS_NOCOW_FL;
764811581d1cfb5 Chao Yu            2018-04-08  1663  
764811581d1cfb5 Chao Yu            2018-04-08  1664  	flags &= F2FS_FL_USER_VISIBLE;
764811581d1cfb5 Chao Yu            2018-04-08  1665  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1666  	return put_user(flags, (int __user *)arg);
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1667  }
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1668  
2c1d03056991286 Chao Yu            2017-07-29  1669  static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
2c1d03056991286 Chao Yu            2017-07-29  1670  {
2c1d03056991286 Chao Yu            2017-07-29  1671  	struct f2fs_inode_info *fi = F2FS_I(inode);
2c1d03056991286 Chao Yu            2017-07-29  1672  	unsigned int oldflags;
2c1d03056991286 Chao Yu            2017-07-29  1673  
2c1d03056991286 Chao Yu            2017-07-29  1674  	/* Is it quota file? Do not allow user to mess with it */
2c1d03056991286 Chao Yu            2017-07-29  1675  	if (IS_NOQUOTA(inode))
2c1d03056991286 Chao Yu            2017-07-29  1676  		return -EPERM;
2c1d03056991286 Chao Yu            2017-07-29  1677  
2c1d03056991286 Chao Yu            2017-07-29  1678  	flags = f2fs_mask_flags(inode->i_mode, flags);
2c1d03056991286 Chao Yu            2017-07-29  1679  
2c1d03056991286 Chao Yu            2017-07-29  1680  	oldflags = fi->i_flags;
2c1d03056991286 Chao Yu            2017-07-29  1681  
59c844088b19c54 Chao Yu            2018-04-03  1682  	if ((flags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
2c1d03056991286 Chao Yu            2017-07-29  1683  		if (!capable(CAP_LINUX_IMMUTABLE))
2c1d03056991286 Chao Yu            2017-07-29  1684  			return -EPERM;
2c1d03056991286 Chao Yu            2017-07-29  1685  
c807a7cb543b535 Chao Yu            2018-04-08  1686  	flags = flags & F2FS_FL_USER_MODIFIABLE;
c807a7cb543b535 Chao Yu            2018-04-08  1687  	flags |= oldflags & ~F2FS_FL_USER_MODIFIABLE;
2c1d03056991286 Chao Yu            2017-07-29  1688  	fi->i_flags = flags;
2c1d03056991286 Chao Yu            2017-07-29  1689  
59c844088b19c54 Chao Yu            2018-04-03  1690  	if (fi->i_flags & F2FS_PROJINHERIT_FL)
2c1d03056991286 Chao Yu            2017-07-29  1691  		set_inode_flag(inode, FI_PROJ_INHERIT);
2c1d03056991286 Chao Yu            2017-07-29  1692  	else
2c1d03056991286 Chao Yu            2017-07-29  1693  		clear_inode_flag(inode, FI_PROJ_INHERIT);
2c1d03056991286 Chao Yu            2017-07-29  1694  
2c1d03056991286 Chao Yu            2017-07-29  1695  	inode->i_ctime = current_time(inode);
2c1d03056991286 Chao Yu            2017-07-29  1696  	f2fs_set_inode_flags(inode);
b32e019049e959e Chao Yu            2018-12-18  1697  	f2fs_mark_inode_dirty_sync(inode, true);
2c1d03056991286 Chao Yu            2017-07-29  1698  	return 0;
2c1d03056991286 Chao Yu            2017-07-29  1699  }
2c1d03056991286 Chao Yu            2017-07-29  1700  
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1701  static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1702  {
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1703  	struct inode *inode = file_inode(filp);
69494229ba5ada1 Sheng Yong         2016-08-23  1704  	unsigned int flags;
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1705  	int ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1706  
7fb17fe44b70c85 Chao Yu            2016-05-09  1707  	if (!inode_owner_or_capable(inode))
7fb17fe44b70c85 Chao Yu            2016-05-09  1708  		return -EACCES;
7fb17fe44b70c85 Chao Yu            2016-05-09  1709  
7fb17fe44b70c85 Chao Yu            2016-05-09  1710  	if (get_user(flags, (int __user *)arg))
7fb17fe44b70c85 Chao Yu            2016-05-09  1711  		return -EFAULT;
7fb17fe44b70c85 Chao Yu            2016-05-09  1712  
bdaec334bbe7d23 Al Viro            2013-03-20  1713  	ret = mnt_want_write_file(filp);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1714  	if (ret)
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1715  		return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1716  
5955102c9984fa0 Al Viro            2016-01-22  1717  	inode_lock(inode);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1718  
2c1d03056991286 Chao Yu            2017-07-29  1719  	ret = __f2fs_ioc_setflags(inode, flags);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1720  
a72d4b97bb83c92 Chao Yu            2017-05-03  1721  	inode_unlock(inode);
bdaec334bbe7d23 Al Viro            2013-03-20  1722  	mnt_drop_write_file(filp);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1723  	return ret;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  1724  }
52656e6cf7be695 Jaegeuk Kim        2014-09-24  1725  
d49f3e890290bd1 Chao Yu            2015-01-23  1726  static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
d49f3e890290bd1 Chao Yu            2015-01-23  1727  {
d49f3e890290bd1 Chao Yu            2015-01-23  1728  	struct inode *inode = file_inode(filp);
d49f3e890290bd1 Chao Yu            2015-01-23  1729  
d49f3e890290bd1 Chao Yu            2015-01-23  1730  	return put_user(inode->i_generation, (int __user *)arg);
d49f3e890290bd1 Chao Yu            2015-01-23  1731  }
d49f3e890290bd1 Chao Yu            2015-01-23  1732  
88b88a667971599 Jaegeuk Kim        2014-10-06  1733  static int f2fs_ioc_start_atomic_write(struct file *filp)
88b88a667971599 Jaegeuk Kim        2014-10-06  1734  {
88b88a667971599 Jaegeuk Kim        2014-10-06  1735  	struct inode *inode = file_inode(filp);
f4c9c743acedc2f Chao Yu            2015-07-17  1736  	int ret;
88b88a667971599 Jaegeuk Kim        2014-10-06  1737  
88b88a667971599 Jaegeuk Kim        2014-10-06  1738  	if (!inode_owner_or_capable(inode))
88b88a667971599 Jaegeuk Kim        2014-10-06  1739  		return -EACCES;
88b88a667971599 Jaegeuk Kim        2014-10-06  1740  
e811898c97f83ae Jaegeuk Kim        2017-03-17  1741  	if (!S_ISREG(inode->i_mode))
e811898c97f83ae Jaegeuk Kim        2017-03-17  1742  		return -EINVAL;
e811898c97f83ae Jaegeuk Kim        2017-03-17  1743  
7fb17fe44b70c85 Chao Yu            2016-05-09  1744  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1745  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1746  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  1747  
0fac558b9658479 Chao Yu            2016-05-09  1748  	inode_lock(inode);
0fac558b9658479 Chao Yu            2016-05-09  1749  
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1750  	if (f2fs_is_atomic_file(inode)) {
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1751  		if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST))
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1752  			ret = -EINVAL;
7fb17fe44b70c85 Chao Yu            2016-05-09  1753  		goto out;
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1754  	}
88b88a667971599 Jaegeuk Kim        2014-10-06  1755  
f4c9c743acedc2f Chao Yu            2015-07-17  1756  	ret = f2fs_convert_inline_inode(inode);
f4c9c743acedc2f Chao Yu            2015-07-17  1757  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1758  		goto out;
88b88a667971599 Jaegeuk Kim        2014-10-06  1759  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1760  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1761  
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1762  	/*
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1763  	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1764  	 * f2fs_is_atomic_file.
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1765  	 */
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1766  	if (get_dirty_pages(inode))
c27753d675fccd3 Jaegeuk Kim        2016-04-12  1767  		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
204706c7accfabb Jaegeuk Kim        2016-12-02  1768  		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
c27753d675fccd3 Jaegeuk Kim        2016-04-12  1769  					inode->i_ino, get_dirty_pages(inode));
c27753d675fccd3 Jaegeuk Kim        2016-04-12  1770  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1771  	if (ret) {
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1772  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
684ca7e55de1f3d Kinglong Mee       2017-03-18  1773  		goto out;
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1774  	}
31867b23d7d1ee3 Jaegeuk Kim        2018-12-28  1775  
054afda9991786e Yunlei He          2018-04-18  1776  	set_inode_flag(inode, FI_ATOMIC_FILE);
2ef79ecb5e906d8 Chao Yu            2018-05-07  1777  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1778  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
684ca7e55de1f3d Kinglong Mee       2017-03-18  1779  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1780  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  1781  	F2FS_I(inode)->inmem_task = current;
26a28a0c1eb756b Jaegeuk Kim        2016-12-28  1782  	stat_inc_atomic_write(inode);
26a28a0c1eb756b Jaegeuk Kim        2016-12-28  1783  	stat_update_max_atomic_write(inode);
684ca7e55de1f3d Kinglong Mee       2017-03-18  1784  out:
0fac558b9658479 Chao Yu            2016-05-09  1785  	inode_unlock(inode);
7fb17fe44b70c85 Chao Yu            2016-05-09  1786  	mnt_drop_write_file(filp);
c27753d675fccd3 Jaegeuk Kim        2016-04-12  1787  	return ret;
88b88a667971599 Jaegeuk Kim        2014-10-06  1788  }
88b88a667971599 Jaegeuk Kim        2014-10-06  1789  
88b88a667971599 Jaegeuk Kim        2014-10-06  1790  static int f2fs_ioc_commit_atomic_write(struct file *filp)
88b88a667971599 Jaegeuk Kim        2014-10-06  1791  {
88b88a667971599 Jaegeuk Kim        2014-10-06  1792  	struct inode *inode = file_inode(filp);
88b88a667971599 Jaegeuk Kim        2014-10-06  1793  	int ret;
88b88a667971599 Jaegeuk Kim        2014-10-06  1794  
88b88a667971599 Jaegeuk Kim        2014-10-06  1795  	if (!inode_owner_or_capable(inode))
88b88a667971599 Jaegeuk Kim        2014-10-06  1796  		return -EACCES;
88b88a667971599 Jaegeuk Kim        2014-10-06  1797  
88b88a667971599 Jaegeuk Kim        2014-10-06  1798  	ret = mnt_want_write_file(filp);
88b88a667971599 Jaegeuk Kim        2014-10-06  1799  	if (ret)
88b88a667971599 Jaegeuk Kim        2014-10-06  1800  		return ret;
88b88a667971599 Jaegeuk Kim        2014-10-06  1801  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1802  	f2fs_balance_fs(F2FS_I_SB(inode), true);
0fac558b9658479 Chao Yu            2016-05-09  1803  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  1804  	inode_lock(inode);
1dc0f8991d4d931 Chao Yu            2018-02-27  1805  
b169c3c560e2b13 Chao Yu            2018-04-18  1806  	if (f2fs_is_volatile_file(inode)) {
b169c3c560e2b13 Chao Yu            2018-04-18  1807  		ret = -EINVAL;
7fb17fe44b70c85 Chao Yu            2016-05-09  1808  		goto err_out;
b169c3c560e2b13 Chao Yu            2018-04-18  1809  	}
7fb17fe44b70c85 Chao Yu            2016-05-09  1810  
6282adbf932c226 Jaegeuk Kim        2015-07-25  1811  	if (f2fs_is_atomic_file(inode)) {
4d57b86dd86404f Chao Yu            2018-05-30  1812  		ret = f2fs_commit_inmem_pages(inode);
5fe457430e554a2 Chao Yu            2017-01-07  1813  		if (ret)
edb27deea7cabff Jaegeuk Kim        2015-07-25  1814  			goto err_out;
88b88a667971599 Jaegeuk Kim        2014-10-06  1815  
608514deba38c86 Jaegeuk Kim        2016-04-15  1816  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
5fe457430e554a2 Chao Yu            2017-01-07  1817  		if (!ret) {
5fe457430e554a2 Chao Yu            2017-01-07  1818  			clear_inode_flag(inode, FI_ATOMIC_FILE);
2ef79ecb5e906d8 Chao Yu            2018-05-07  1819  			F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
26a28a0c1eb756b Jaegeuk Kim        2016-12-28  1820  			stat_dec_atomic_write(inode);
5fe457430e554a2 Chao Yu            2017-01-07  1821  		}
26a28a0c1eb756b Jaegeuk Kim        2016-12-28  1822  	} else {
774e1b78a0f90a7 Chao Yu            2017-08-23  1823  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
26a28a0c1eb756b Jaegeuk Kim        2016-12-28  1824  	}
edb27deea7cabff Jaegeuk Kim        2015-07-25  1825  err_out:
2ef79ecb5e906d8 Chao Yu            2018-05-07  1826  	if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
2ef79ecb5e906d8 Chao Yu            2018-05-07  1827  		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
2ef79ecb5e906d8 Chao Yu            2018-05-07  1828  		ret = -EINVAL;
2ef79ecb5e906d8 Chao Yu            2018-05-07  1829  	}
0fac558b9658479 Chao Yu            2016-05-09  1830  	inode_unlock(inode);
88b88a667971599 Jaegeuk Kim        2014-10-06  1831  	mnt_drop_write_file(filp);
88b88a667971599 Jaegeuk Kim        2014-10-06  1832  	return ret;
88b88a667971599 Jaegeuk Kim        2014-10-06  1833  }
88b88a667971599 Jaegeuk Kim        2014-10-06  1834  
02a1335f25a386d Jaegeuk Kim        2014-10-06  1835  static int f2fs_ioc_start_volatile_write(struct file *filp)
02a1335f25a386d Jaegeuk Kim        2014-10-06  1836  {
02a1335f25a386d Jaegeuk Kim        2014-10-06  1837  	struct inode *inode = file_inode(filp);
f4c9c743acedc2f Chao Yu            2015-07-17  1838  	int ret;
02a1335f25a386d Jaegeuk Kim        2014-10-06  1839  
02a1335f25a386d Jaegeuk Kim        2014-10-06  1840  	if (!inode_owner_or_capable(inode))
02a1335f25a386d Jaegeuk Kim        2014-10-06  1841  		return -EACCES;
02a1335f25a386d Jaegeuk Kim        2014-10-06  1842  
8ff0971f1500953 Chao Yu            2017-03-17  1843  	if (!S_ISREG(inode->i_mode))
8ff0971f1500953 Chao Yu            2017-03-17  1844  		return -EINVAL;
8ff0971f1500953 Chao Yu            2017-03-17  1845  
7fb17fe44b70c85 Chao Yu            2016-05-09  1846  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1847  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1848  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  1849  
0fac558b9658479 Chao Yu            2016-05-09  1850  	inode_lock(inode);
0fac558b9658479 Chao Yu            2016-05-09  1851  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1852  	if (f2fs_is_volatile_file(inode))
7fb17fe44b70c85 Chao Yu            2016-05-09  1853  		goto out;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1854  
f4c9c743acedc2f Chao Yu            2015-07-17  1855  	ret = f2fs_convert_inline_inode(inode);
f4c9c743acedc2f Chao Yu            2015-07-17  1856  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1857  		goto out;
b3d208f96d6bb21 Jaegeuk Kim        2014-10-23  1858  
648d50ba12c805d Chao Yu            2017-03-22  1859  	stat_inc_volatile_write(inode);
648d50ba12c805d Chao Yu            2017-03-22  1860  	stat_update_max_volatile_write(inode);
648d50ba12c805d Chao Yu            2017-03-22  1861  
91942321e4c9f84 Jaegeuk Kim        2016-05-20  1862  	set_inode_flag(inode, FI_VOLATILE_FILE);
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  1863  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
7fb17fe44b70c85 Chao Yu            2016-05-09  1864  out:
0fac558b9658479 Chao Yu            2016-05-09  1865  	inode_unlock(inode);
7fb17fe44b70c85 Chao Yu            2016-05-09  1866  	mnt_drop_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1867  	return ret;
02a1335f25a386d Jaegeuk Kim        2014-10-06  1868  }
02a1335f25a386d Jaegeuk Kim        2014-10-06  1869  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1870  static int f2fs_ioc_release_volatile_write(struct file *filp)
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1871  {
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1872  	struct inode *inode = file_inode(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1873  	int ret;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1874  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1875  	if (!inode_owner_or_capable(inode))
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1876  		return -EACCES;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1877  
7fb17fe44b70c85 Chao Yu            2016-05-09  1878  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1879  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1880  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  1881  
0fac558b9658479 Chao Yu            2016-05-09  1882  	inode_lock(inode);
0fac558b9658479 Chao Yu            2016-05-09  1883  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1884  	if (!f2fs_is_volatile_file(inode))
7fb17fe44b70c85 Chao Yu            2016-05-09  1885  		goto out;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1886  
7fb17fe44b70c85 Chao Yu            2016-05-09  1887  	if (!f2fs_is_first_block_written(inode)) {
7fb17fe44b70c85 Chao Yu            2016-05-09  1888  		ret = truncate_partial_data_page(inode, 0, true);
7fb17fe44b70c85 Chao Yu            2016-05-09  1889  		goto out;
7fb17fe44b70c85 Chao Yu            2016-05-09  1890  	}
3c6c2bebef79999 Jaegeuk Kim        2015-03-17  1891  
7fb17fe44b70c85 Chao Yu            2016-05-09  1892  	ret = punch_hole(inode, 0, F2FS_BLKSIZE);
7fb17fe44b70c85 Chao Yu            2016-05-09  1893  out:
0fac558b9658479 Chao Yu            2016-05-09  1894  	inode_unlock(inode);
7fb17fe44b70c85 Chao Yu            2016-05-09  1895  	mnt_drop_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1896  	return ret;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1897  }
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1898  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1899  static int f2fs_ioc_abort_volatile_write(struct file *filp)
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1900  {
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1901  	struct inode *inode = file_inode(filp);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1902  	int ret;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1903  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1904  	if (!inode_owner_or_capable(inode))
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1905  		return -EACCES;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1906  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1907  	ret = mnt_want_write_file(filp);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1908  	if (ret)
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1909  		return ret;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1910  
0fac558b9658479 Chao Yu            2016-05-09  1911  	inode_lock(inode);
0fac558b9658479 Chao Yu            2016-05-09  1912  
26dc3d4424e9f47 Jaegeuk Kim        2016-04-11  1913  	if (f2fs_is_atomic_file(inode))
4d57b86dd86404f Chao Yu            2018-05-30  1914  		f2fs_drop_inmem_pages(inode);
732d56489f21c04 Jaegeuk Kim        2015-12-29  1915  	if (f2fs_is_volatile_file(inode)) {
91942321e4c9f84 Jaegeuk Kim        2016-05-20  1916  		clear_inode_flag(inode, FI_VOLATILE_FILE);
648d50ba12c805d Chao Yu            2017-03-22  1917  		stat_dec_volatile_write(inode);
608514deba38c86 Jaegeuk Kim        2016-04-15  1918  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
732d56489f21c04 Jaegeuk Kim        2015-12-29  1919  	}
de6a8ec9822dbe2 Jaegeuk Kim        2015-06-08  1920  
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1921  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
455e3a5887ee7eb Jaegeuk Kim        2018-07-27  1922  
0fac558b9658479 Chao Yu            2016-05-09  1923  	inode_unlock(inode);
0fac558b9658479 Chao Yu            2016-05-09  1924  
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1925  	mnt_drop_write_file(filp);
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  1926  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1927  	return ret;
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1928  }
1e84371ffeef451 Jaegeuk Kim        2014-12-09  1929  
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1930  static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1931  {
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1932  	struct inode *inode = file_inode(filp);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1933  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1934  	struct super_block *sb = sbi->sb;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1935  	__u32 in;
2a96d8ad94ce57c Dan Carpenter      2018-06-20  1936  	int ret = 0;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1937  
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1938  	if (!capable(CAP_SYS_ADMIN))
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1939  		return -EPERM;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1940  
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1941  	if (get_user(in, (__u32 __user *)arg))
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1942  		return -EFAULT;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1943  
60b2b4ee2bc01dd Sahitya Tummala    2018-05-18  1944  	if (in != F2FS_GOING_DOWN_FULLSYNC) {
7fb17fe44b70c85 Chao Yu            2016-05-09  1945  		ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  1946  		if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  1947  			return ret;
60b2b4ee2bc01dd Sahitya Tummala    2018-05-18  1948  	}
7fb17fe44b70c85 Chao Yu            2016-05-09  1949  
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1950  	switch (in) {
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1951  	case F2FS_GOING_DOWN_FULLSYNC:
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1952  		sb = freeze_bdev(sb->s_bdev);
d027c48447c2c2f Chao Yu            2018-01-17  1953  		if (IS_ERR(sb)) {
d027c48447c2c2f Chao Yu            2018-01-17  1954  			ret = PTR_ERR(sb);
d027c48447c2c2f Chao Yu            2018-01-17  1955  			goto out;
d027c48447c2c2f Chao Yu            2018-01-17  1956  		}
d027c48447c2c2f Chao Yu            2018-01-17  1957  		if (sb) {
38f91ca8c0ea69f Jaegeuk Kim        2016-05-18  1958  			f2fs_stop_checkpoint(sbi, false);
83a3bfdb5a8a086 Jaegeuk Kim        2018-06-21  1959  			set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1960  			thaw_bdev(sb->s_bdev, sb);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1961  		}
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1962  		break;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1963  	case F2FS_GOING_DOWN_METASYNC:
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1964  		/* do checkpoint only */
d027c48447c2c2f Chao Yu            2018-01-17  1965  		ret = f2fs_sync_fs(sb, 1);
d027c48447c2c2f Chao Yu            2018-01-17  1966  		if (ret)
d027c48447c2c2f Chao Yu            2018-01-17  1967  			goto out;
38f91ca8c0ea69f Jaegeuk Kim        2016-05-18  1968  		f2fs_stop_checkpoint(sbi, false);
83a3bfdb5a8a086 Jaegeuk Kim        2018-06-21  1969  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1970  		break;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1971  	case F2FS_GOING_DOWN_NOSYNC:
38f91ca8c0ea69f Jaegeuk Kim        2016-05-18  1972  		f2fs_stop_checkpoint(sbi, false);
83a3bfdb5a8a086 Jaegeuk Kim        2018-06-21  1973  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1974  		break;
c912a8298c16ef1 Jaegeuk Kim        2015-10-07  1975  	case F2FS_GOING_DOWN_METAFLUSH:
4d57b86dd86404f Chao Yu            2018-05-30  1976  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
38f91ca8c0ea69f Jaegeuk Kim        2016-05-18  1977  		f2fs_stop_checkpoint(sbi, false);
83a3bfdb5a8a086 Jaegeuk Kim        2018-06-21  1978  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
c912a8298c16ef1 Jaegeuk Kim        2015-10-07  1979  		break;
0cd6d9b0d23416a Jaegeuk Kim        2018-11-28  1980  	case F2FS_GOING_DOWN_NEED_FSCK:
0cd6d9b0d23416a Jaegeuk Kim        2018-11-28  1981  		set_sbi_flag(sbi, SBI_NEED_FSCK);
db610a640eeeb26 Jaegeuk Kim        2019-01-24  1982  		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
db610a640eeeb26 Jaegeuk Kim        2019-01-24  1983  		set_sbi_flag(sbi, SBI_IS_DIRTY);
0cd6d9b0d23416a Jaegeuk Kim        2018-11-28  1984  		/* do checkpoint only */
0cd6d9b0d23416a Jaegeuk Kim        2018-11-28  1985  		ret = f2fs_sync_fs(sb, 1);
0cd6d9b0d23416a Jaegeuk Kim        2018-11-28  1986  		goto out;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1987  	default:
7fb17fe44b70c85 Chao Yu            2016-05-09  1988  		ret = -EINVAL;
7fb17fe44b70c85 Chao Yu            2016-05-09  1989  		goto out;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  1990  	}
7950e9ac638e845 Chao Yu            2018-01-18  1991  
4d57b86dd86404f Chao Yu            2018-05-30  1992  	f2fs_stop_gc_thread(sbi);
4d57b86dd86404f Chao Yu            2018-05-30  1993  	f2fs_stop_discard_thread(sbi);
7950e9ac638e845 Chao Yu            2018-01-18  1994  
4d57b86dd86404f Chao Yu            2018-05-30  1995  	f2fs_drop_discard_cmd(sbi);
7950e9ac638e845 Chao Yu            2018-01-18  1996  	clear_opt(sbi, DISCARD);
7950e9ac638e845 Chao Yu            2018-01-18  1997  
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  1998  	f2fs_update_time(sbi, REQ_TIME);
7fb17fe44b70c85 Chao Yu            2016-05-09  1999  out:
60b2b4ee2bc01dd Sahitya Tummala    2018-05-18  2000  	if (in != F2FS_GOING_DOWN_FULLSYNC)
7fb17fe44b70c85 Chao Yu            2016-05-09  2001  		mnt_drop_write_file(filp);
559e87c497a820e Chao Yu            2019-02-26  2002  
559e87c497a820e Chao Yu            2019-02-26  2003  	trace_f2fs_shutdown(sbi, in, ret);
559e87c497a820e Chao Yu            2019-02-26  2004  
7fb17fe44b70c85 Chao Yu            2016-05-09  2005  	return ret;
1abff93d01eddaa Jaegeuk Kim        2015-01-08  2006  }
1abff93d01eddaa Jaegeuk Kim        2015-01-08  2007  
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2008  static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2009  {
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2010  	struct inode *inode = file_inode(filp);
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2011  	struct super_block *sb = inode->i_sb;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2012  	struct request_queue *q = bdev_get_queue(sb->s_bdev);
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2013  	struct fstrim_range range;
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2014  	int ret;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2015  
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2016  	if (!capable(CAP_SYS_ADMIN))
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2017  		return -EPERM;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2018  
7d20c8abb2edcf9 Chao Yu            2018-09-04  2019  	if (!f2fs_hw_support_discard(F2FS_SB(sb)))
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2020  		return -EOPNOTSUPP;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2021  
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2022  	if (copy_from_user(&range, (struct fstrim_range __user *)arg,
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2023  				sizeof(range)))
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2024  		return -EFAULT;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2025  
7fb17fe44b70c85 Chao Yu            2016-05-09  2026  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  2027  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  2028  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  2029  
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2030  	range.minlen = max((unsigned int)range.minlen,
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2031  				q->limits.discard_granularity);
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2032  	ret = f2fs_trim_fs(F2FS_SB(sb), &range);
7fb17fe44b70c85 Chao Yu            2016-05-09  2033  	mnt_drop_write_file(filp);
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2034  	if (ret < 0)
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2035  		return ret;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2036  
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2037  	if (copy_to_user((struct fstrim_range __user *)arg, &range,
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2038  				sizeof(range)))
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2039  		return -EFAULT;
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  2040  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2041  	return 0;
4b2fecc84655055 Jaegeuk Kim        2014-09-20  2042  }
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2043  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2044  static bool uuid_is_nonzero(__u8 u[16])
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2045  {
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2046  	int i;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2047  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2048  	for (i = 0; i < 16; i++)
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2049  		if (u[i])
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2050  			return true;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2051  	return false;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2052  }
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2053  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2054  static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2055  {
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2056  	struct inode *inode = file_inode(filp);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2057  
7beb01f74415c56 Chao Yu            2018-10-24  2058  	if (!f2fs_sb_has_encrypt(F2FS_I_SB(inode)))
ead710b7d82dc9e Chao Yu            2017-11-14  2059  		return -EOPNOTSUPP;
ead710b7d82dc9e Chao Yu            2017-11-14  2060  
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  2061  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
7fb17fe44b70c85 Chao Yu            2016-05-09  2062  
db717d8e26c2d1b Eric Biggers       2016-11-26  2063  	return fscrypt_ioctl_set_policy(filp, (const void __user *)arg);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2064  }
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2065  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2066  static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2067  {
7beb01f74415c56 Chao Yu            2018-10-24  2068  	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
ead710b7d82dc9e Chao Yu            2017-11-14  2069  		return -EOPNOTSUPP;
db717d8e26c2d1b Eric Biggers       2016-11-26  2070  	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2071  }
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2072  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2073  static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2074  {
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2075  	struct inode *inode = file_inode(filp);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2076  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2077  	int err;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2078  
7beb01f74415c56 Chao Yu            2018-10-24  2079  	if (!f2fs_sb_has_encrypt(sbi))
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2080  		return -EOPNOTSUPP;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2081  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2082  	err = mnt_want_write_file(filp);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2083  	if (err)
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2084  		return err;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2085  
846ae671ad368e3 Chao Yu            2018-02-26  2086  	down_write(&sbi->sb_lock);
d0d3f1b329b01a9 Chao Yu            2018-02-11  2087  
d0d3f1b329b01a9 Chao Yu            2018-02-11  2088  	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
d0d3f1b329b01a9 Chao Yu            2018-02-11  2089  		goto got_it;
d0d3f1b329b01a9 Chao Yu            2018-02-11  2090  
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2091  	/* update superblock with uuid */
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2092  	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2093  
c5bda1c8b13ad78 Chao Yu            2015-06-08  2094  	err = f2fs_commit_super(sbi, false);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2095  	if (err) {
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2096  		/* undo new data */
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2097  		memset(sbi->raw_super->encrypt_pw_salt, 0, 16);
d0d3f1b329b01a9 Chao Yu            2018-02-11  2098  		goto out_err;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2099  	}
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2100  got_it:
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2101  	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2102  									16))
d0d3f1b329b01a9 Chao Yu            2018-02-11  2103  		err = -EFAULT;
d0d3f1b329b01a9 Chao Yu            2018-02-11  2104  out_err:
846ae671ad368e3 Chao Yu            2018-02-26  2105  	up_write(&sbi->sb_lock);
d0d3f1b329b01a9 Chao Yu            2018-02-11  2106  	mnt_drop_write_file(filp);
d0d3f1b329b01a9 Chao Yu            2018-02-11  2107  	return err;
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2108  }
f424f664f0e8949 Jaegeuk Kim        2015-04-20  2109  
c1c1b58359d45e1 Chao Yu            2015-07-10  2110  static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
c1c1b58359d45e1 Chao Yu            2015-07-10  2111  {
c1c1b58359d45e1 Chao Yu            2015-07-10  2112  	struct inode *inode = file_inode(filp);
c1c1b58359d45e1 Chao Yu            2015-07-10  2113  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
d530d4d8e237f4d Chao Yu            2015-10-05  2114  	__u32 sync;
7fb17fe44b70c85 Chao Yu            2016-05-09  2115  	int ret;
c1c1b58359d45e1 Chao Yu            2015-07-10  2116  
c1c1b58359d45e1 Chao Yu            2015-07-10  2117  	if (!capable(CAP_SYS_ADMIN))
c1c1b58359d45e1 Chao Yu            2015-07-10  2118  		return -EPERM;
c1c1b58359d45e1 Chao Yu            2015-07-10  2119  
d530d4d8e237f4d Chao Yu            2015-10-05  2120  	if (get_user(sync, (__u32 __user *)arg))
c1c1b58359d45e1 Chao Yu            2015-07-10  2121  		return -EFAULT;
c1c1b58359d45e1 Chao Yu            2015-07-10  2122  
d530d4d8e237f4d Chao Yu            2015-10-05  2123  	if (f2fs_readonly(sbi->sb))
d530d4d8e237f4d Chao Yu            2015-10-05  2124  		return -EROFS;
c1c1b58359d45e1 Chao Yu            2015-07-10  2125  
7fb17fe44b70c85 Chao Yu            2016-05-09  2126  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  2127  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  2128  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  2129  
d530d4d8e237f4d Chao Yu            2015-10-05  2130  	if (!sync) {
7fb17fe44b70c85 Chao Yu            2016-05-09  2131  		if (!mutex_trylock(&sbi->gc_mutex)) {
7fb17fe44b70c85 Chao Yu            2016-05-09  2132  			ret = -EBUSY;
7fb17fe44b70c85 Chao Yu            2016-05-09  2133  			goto out;
7fb17fe44b70c85 Chao Yu            2016-05-09  2134  		}
d530d4d8e237f4d Chao Yu            2015-10-05  2135  	} else {
d530d4d8e237f4d Chao Yu            2015-10-05  2136  		mutex_lock(&sbi->gc_mutex);
c1c1b58359d45e1 Chao Yu            2015-07-10  2137  	}
c1c1b58359d45e1 Chao Yu            2015-07-10  2138  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2139  	ret = f2fs_gc(sbi, sync, true, NULL_SEGNO);
7fb17fe44b70c85 Chao Yu            2016-05-09  2140  out:
7fb17fe44b70c85 Chao Yu            2016-05-09  2141  	mnt_drop_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  2142  	return ret;
c1c1b58359d45e1 Chao Yu            2015-07-10  2143  }
c1c1b58359d45e1 Chao Yu            2015-07-10  2144  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2145  static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2146  {
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2147  	struct inode *inode = file_inode(filp);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2148  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2149  	struct f2fs_gc_range range;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2150  	u64 end;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2151  	int ret;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2152  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2153  	if (!capable(CAP_SYS_ADMIN))
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2154  		return -EPERM;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2155  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2156  	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2157  							sizeof(range)))
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2158  		return -EFAULT;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2159  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2160  	if (f2fs_readonly(sbi->sb))
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2161  		return -EROFS;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2162  
b82f6e347bfb689 Yunlei He          2018-04-24  2163  	end = range.start + range.len;
b82f6e347bfb689 Yunlei He          2018-04-24  2164  	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
b82f6e347bfb689 Yunlei He          2018-04-24  2165  		return -EINVAL;
b82f6e347bfb689 Yunlei He          2018-04-24  2166  	}
b82f6e347bfb689 Yunlei He          2018-04-24  2167  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2168  	ret = mnt_want_write_file(filp);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2169  	if (ret)
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2170  		return ret;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2171  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2172  do_more:
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2173  	if (!range.sync) {
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2174  		if (!mutex_trylock(&sbi->gc_mutex)) {
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2175  			ret = -EBUSY;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2176  			goto out;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2177  		}
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2178  	} else {
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2179  		mutex_lock(&sbi->gc_mutex);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2180  	}
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2181  
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2182  	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
67b0e42b768c9dd Yunlong Song       2018-10-30  2183  	range.start += BLKS_PER_SEC(sbi);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2184  	if (range.start <= end)
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2185  		goto do_more;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2186  out:
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2187  	mnt_drop_write_file(filp);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2188  	return ret;
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2189  }
34dc77ad7436870 Jaegeuk Kim        2017-06-15  2190  
059c0648c6aeb25 Chao Yu            2018-07-17  2191  static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
456b88e4d15de83 Chao Yu            2015-10-05  2192  {
456b88e4d15de83 Chao Yu            2015-10-05  2193  	struct inode *inode = file_inode(filp);
456b88e4d15de83 Chao Yu            2015-10-05  2194  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
7fb17fe44b70c85 Chao Yu            2016-05-09  2195  	int ret;
456b88e4d15de83 Chao Yu            2015-10-05  2196  
456b88e4d15de83 Chao Yu            2015-10-05  2197  	if (!capable(CAP_SYS_ADMIN))
456b88e4d15de83 Chao Yu            2015-10-05  2198  		return -EPERM;
456b88e4d15de83 Chao Yu            2015-10-05  2199  
456b88e4d15de83 Chao Yu            2015-10-05  2200  	if (f2fs_readonly(sbi->sb))
456b88e4d15de83 Chao Yu            2015-10-05  2201  		return -EROFS;
456b88e4d15de83 Chao Yu            2015-10-05  2202  
4354994f097d068 Daniel Rosenberg   2018-08-20  2203  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
4354994f097d068 Daniel Rosenberg   2018-08-20  2204  		f2fs_msg(sbi->sb, KERN_INFO,
4354994f097d068 Daniel Rosenberg   2018-08-20  2205  			"Skipping Checkpoint. Checkpoints currently disabled.");
4354994f097d068 Daniel Rosenberg   2018-08-20  2206  		return -EINVAL;
4354994f097d068 Daniel Rosenberg   2018-08-20  2207  	}
4354994f097d068 Daniel Rosenberg   2018-08-20  2208  
7fb17fe44b70c85 Chao Yu            2016-05-09  2209  	ret = mnt_want_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  2210  	if (ret)
7fb17fe44b70c85 Chao Yu            2016-05-09  2211  		return ret;
7fb17fe44b70c85 Chao Yu            2016-05-09  2212  
7fb17fe44b70c85 Chao Yu            2016-05-09  2213  	ret = f2fs_sync_fs(sbi->sb, 1);
7fb17fe44b70c85 Chao Yu            2016-05-09  2214  
7fb17fe44b70c85 Chao Yu            2016-05-09  2215  	mnt_drop_write_file(filp);
7fb17fe44b70c85 Chao Yu            2016-05-09  2216  	return ret;
456b88e4d15de83 Chao Yu            2015-10-05  2217  }
456b88e4d15de83 Chao Yu            2015-10-05  2218  
d323d005ac4a2d4 Chao Yu            2015-10-27  2219  static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
d323d005ac4a2d4 Chao Yu            2015-10-27  2220  					struct file *filp,
d323d005ac4a2d4 Chao Yu            2015-10-27  2221  					struct f2fs_defragment *range)
d323d005ac4a2d4 Chao Yu            2015-10-27  2222  {
d323d005ac4a2d4 Chao Yu            2015-10-27  2223  	struct inode *inode = file_inode(filp);
f3d98e74fcddb23 Chao Yu            2018-01-10  2224  	struct f2fs_map_blocks map = { .m_next_extent = NULL,
f4f0b6777db4e7a Jia Zhu            2018-11-20  2225  					.m_seg_type = NO_CHECK_TYPE ,
f4f0b6777db4e7a Jia Zhu            2018-11-20  2226  					.m_may_create = false };
e15882b6c6caff4 Hou Pengyang       2017-02-23  2227  	struct extent_info ei = {0, 0, 0};
f3d98e74fcddb23 Chao Yu            2018-01-10  2228  	pgoff_t pg_start, pg_end, next_pgofs;
3519e3f992995d4 Chao Yu            2015-12-01  2229  	unsigned int blk_per_seg = sbi->blocks_per_seg;
d323d005ac4a2d4 Chao Yu            2015-10-27  2230  	unsigned int total = 0, sec_num;
d323d005ac4a2d4 Chao Yu            2015-10-27  2231  	block_t blk_end = 0;
d323d005ac4a2d4 Chao Yu            2015-10-27  2232  	bool fragmented = false;
d323d005ac4a2d4 Chao Yu            2015-10-27  2233  	int err;
d323d005ac4a2d4 Chao Yu            2015-10-27  2234  
d323d005ac4a2d4 Chao Yu            2015-10-27  2235  	/* if in-place-update policy is enabled, don't waste time here */
4d57b86dd86404f Chao Yu            2018-05-30  2236  	if (f2fs_should_update_inplace(inode, NULL))
d323d005ac4a2d4 Chao Yu            2015-10-27  2237  		return -EINVAL;
d323d005ac4a2d4 Chao Yu            2015-10-27  2238  
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  2239  	pg_start = range->start >> PAGE_SHIFT;
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  2240  	pg_end = (range->start + range->len) >> PAGE_SHIFT;
d323d005ac4a2d4 Chao Yu            2015-10-27  2241  
2c4db1a6f6b42e2 Jaegeuk Kim        2016-01-07  2242  	f2fs_balance_fs(sbi, true);
d323d005ac4a2d4 Chao Yu            2015-10-27  2243  
5955102c9984fa0 Al Viro            2016-01-22  2244  	inode_lock(inode);
d323d005ac4a2d4 Chao Yu            2015-10-27  2245  
d323d005ac4a2d4 Chao Yu            2015-10-27  2246  	/* writeback all dirty pages in the range */
d323d005ac4a2d4 Chao Yu            2015-10-27  2247  	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
d8fe4f0e74cb27e Fan Li             2015-12-14  2248  						range->start + range->len - 1);
d323d005ac4a2d4 Chao Yu            2015-10-27  2249  	if (err)
d323d005ac4a2d4 Chao Yu            2015-10-27  2250  		goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2251  
d323d005ac4a2d4 Chao Yu            2015-10-27  2252  	/*
d323d005ac4a2d4 Chao Yu            2015-10-27  2253  	 * lookup mapping info in extent cache, skip defragmenting if physical
d323d005ac4a2d4 Chao Yu            2015-10-27  2254  	 * block addresses are continuous.
d323d005ac4a2d4 Chao Yu            2015-10-27  2255  	 */
d323d005ac4a2d4 Chao Yu            2015-10-27  2256  	if (f2fs_lookup_extent_cache(inode, pg_start, &ei)) {
d323d005ac4a2d4 Chao Yu            2015-10-27  2257  		if (ei.fofs + ei.len >= pg_end)
d323d005ac4a2d4 Chao Yu            2015-10-27  2258  			goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2259  	}
d323d005ac4a2d4 Chao Yu            2015-10-27  2260  
d323d005ac4a2d4 Chao Yu            2015-10-27  2261  	map.m_lblk = pg_start;
f3d98e74fcddb23 Chao Yu            2018-01-10  2262  	map.m_next_pgofs = &next_pgofs;
d323d005ac4a2d4 Chao Yu            2015-10-27  2263  
d323d005ac4a2d4 Chao Yu            2015-10-27  2264  	/*
d323d005ac4a2d4 Chao Yu            2015-10-27  2265  	 * lookup mapping info in dnode page cache, skip defragmenting if all
d323d005ac4a2d4 Chao Yu            2015-10-27  2266  	 * physical block addresses are continuous even if there are hole(s)
d323d005ac4a2d4 Chao Yu            2015-10-27  2267  	 * in logical blocks.
d323d005ac4a2d4 Chao Yu            2015-10-27  2268  	 */
d323d005ac4a2d4 Chao Yu            2015-10-27  2269  	while (map.m_lblk < pg_end) {
a1c1e9b74ff3801 Fan Li             2015-12-15  2270  		map.m_len = pg_end - map.m_lblk;
f2220c7f155c993 Qiuyang Sun        2017-08-09  2271  		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
d323d005ac4a2d4 Chao Yu            2015-10-27  2272  		if (err)
d323d005ac4a2d4 Chao Yu            2015-10-27  2273  			goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2274  
d323d005ac4a2d4 Chao Yu            2015-10-27  2275  		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
f3d98e74fcddb23 Chao Yu            2018-01-10  2276  			map.m_lblk = next_pgofs;
d323d005ac4a2d4 Chao Yu            2015-10-27  2277  			continue;
d323d005ac4a2d4 Chao Yu            2015-10-27  2278  		}
d323d005ac4a2d4 Chao Yu            2015-10-27  2279  
25a912e51af7c07 Chao Yu            2018-01-10  2280  		if (blk_end && blk_end != map.m_pblk)
d323d005ac4a2d4 Chao Yu            2015-10-27  2281  			fragmented = true;
25a912e51af7c07 Chao Yu            2018-01-10  2282  
25a912e51af7c07 Chao Yu            2018-01-10  2283  		/* record total count of block that we're going to move */
25a912e51af7c07 Chao Yu            2018-01-10  2284  		total += map.m_len;
25a912e51af7c07 Chao Yu            2018-01-10  2285  
d323d005ac4a2d4 Chao Yu            2015-10-27  2286  		blk_end = map.m_pblk + map.m_len;
d323d005ac4a2d4 Chao Yu            2015-10-27  2287  
d323d005ac4a2d4 Chao Yu            2015-10-27  2288  		map.m_lblk += map.m_len;
d323d005ac4a2d4 Chao Yu            2015-10-27  2289  	}
d323d005ac4a2d4 Chao Yu            2015-10-27  2290  
d323d005ac4a2d4 Chao Yu            2015-10-27  2291  	if (!fragmented)
d323d005ac4a2d4 Chao Yu            2015-10-27  2292  		goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2293  
25a912e51af7c07 Chao Yu            2018-01-10  2294  	sec_num = (total + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
d323d005ac4a2d4 Chao Yu            2015-10-27  2295  
d323d005ac4a2d4 Chao Yu            2015-10-27  2296  	/*
d323d005ac4a2d4 Chao Yu            2015-10-27  2297  	 * make sure there are enough free section for LFS allocation, this can
d323d005ac4a2d4 Chao Yu            2015-10-27  2298  	 * avoid defragment running in SSR mode when free section are allocated
d323d005ac4a2d4 Chao Yu            2015-10-27  2299  	 * intensively
d323d005ac4a2d4 Chao Yu            2015-10-27  2300  	 */
7f3037a5ec0672e Jaegeuk Kim        2016-09-01  2301  	if (has_not_enough_free_secs(sbi, 0, sec_num)) {
d323d005ac4a2d4 Chao Yu            2015-10-27  2302  		err = -EAGAIN;
d323d005ac4a2d4 Chao Yu            2015-10-27  2303  		goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2304  	}
d323d005ac4a2d4 Chao Yu            2015-10-27  2305  
25a912e51af7c07 Chao Yu            2018-01-10  2306  	map.m_lblk = pg_start;
25a912e51af7c07 Chao Yu            2018-01-10  2307  	map.m_len = pg_end - pg_start;
25a912e51af7c07 Chao Yu            2018-01-10  2308  	total = 0;
25a912e51af7c07 Chao Yu            2018-01-10  2309  
d323d005ac4a2d4 Chao Yu            2015-10-27  2310  	while (map.m_lblk < pg_end) {
d323d005ac4a2d4 Chao Yu            2015-10-27  2311  		pgoff_t idx;
d323d005ac4a2d4 Chao Yu            2015-10-27  2312  		int cnt = 0;
d323d005ac4a2d4 Chao Yu            2015-10-27  2313  
d323d005ac4a2d4 Chao Yu            2015-10-27  2314  do_map:
a1c1e9b74ff3801 Fan Li             2015-12-15  2315  		map.m_len = pg_end - map.m_lblk;
f2220c7f155c993 Qiuyang Sun        2017-08-09  2316  		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_DEFAULT);
d323d005ac4a2d4 Chao Yu            2015-10-27  2317  		if (err)
d323d005ac4a2d4 Chao Yu            2015-10-27  2318  			goto clear_out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2319  
d323d005ac4a2d4 Chao Yu            2015-10-27  2320  		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
f3d98e74fcddb23 Chao Yu            2018-01-10  2321  			map.m_lblk = next_pgofs;
d323d005ac4a2d4 Chao Yu            2015-10-27  2322  			continue;
d323d005ac4a2d4 Chao Yu            2015-10-27  2323  		}
d323d005ac4a2d4 Chao Yu            2015-10-27  2324  
91942321e4c9f84 Jaegeuk Kim        2016-05-20  2325  		set_inode_flag(inode, FI_DO_DEFRAG);
d323d005ac4a2d4 Chao Yu            2015-10-27  2326  
d323d005ac4a2d4 Chao Yu            2015-10-27  2327  		idx = map.m_lblk;
d323d005ac4a2d4 Chao Yu            2015-10-27  2328  		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
d323d005ac4a2d4 Chao Yu            2015-10-27  2329  			struct page *page;
d323d005ac4a2d4 Chao Yu            2015-10-27  2330  
4d57b86dd86404f Chao Yu            2018-05-30  2331  			page = f2fs_get_lock_data_page(inode, idx, true);
d323d005ac4a2d4 Chao Yu            2015-10-27  2332  			if (IS_ERR(page)) {
d323d005ac4a2d4 Chao Yu            2015-10-27  2333  				err = PTR_ERR(page);
d323d005ac4a2d4 Chao Yu            2015-10-27  2334  				goto clear_out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2335  			}
d323d005ac4a2d4 Chao Yu            2015-10-27  2336  
d323d005ac4a2d4 Chao Yu            2015-10-27  2337  			set_page_dirty(page);
d323d005ac4a2d4 Chao Yu            2015-10-27  2338  			f2fs_put_page(page, 1);
d323d005ac4a2d4 Chao Yu            2015-10-27  2339  
d323d005ac4a2d4 Chao Yu            2015-10-27  2340  			idx++;
d323d005ac4a2d4 Chao Yu            2015-10-27  2341  			cnt++;
d323d005ac4a2d4 Chao Yu            2015-10-27  2342  			total++;
d323d005ac4a2d4 Chao Yu            2015-10-27  2343  		}
d323d005ac4a2d4 Chao Yu            2015-10-27  2344  
d323d005ac4a2d4 Chao Yu            2015-10-27  2345  		map.m_lblk = idx;
d323d005ac4a2d4 Chao Yu            2015-10-27  2346  
d323d005ac4a2d4 Chao Yu            2015-10-27  2347  		if (idx < pg_end && cnt < blk_per_seg)
d323d005ac4a2d4 Chao Yu            2015-10-27  2348  			goto do_map;
d323d005ac4a2d4 Chao Yu            2015-10-27  2349  
91942321e4c9f84 Jaegeuk Kim        2016-05-20  2350  		clear_inode_flag(inode, FI_DO_DEFRAG);
d323d005ac4a2d4 Chao Yu            2015-10-27  2351  
d323d005ac4a2d4 Chao Yu            2015-10-27  2352  		err = filemap_fdatawrite(inode->i_mapping);
d323d005ac4a2d4 Chao Yu            2015-10-27  2353  		if (err)
d323d005ac4a2d4 Chao Yu            2015-10-27  2354  			goto out;
d323d005ac4a2d4 Chao Yu            2015-10-27  2355  	}
d323d005ac4a2d4 Chao Yu            2015-10-27  2356  clear_out:
91942321e4c9f84 Jaegeuk Kim        2016-05-20  2357  	clear_inode_flag(inode, FI_DO_DEFRAG);
d323d005ac4a2d4 Chao Yu            2015-10-27  2358  out:
5955102c9984fa0 Al Viro            2016-01-22  2359  	inode_unlock(inode);
d323d005ac4a2d4 Chao Yu            2015-10-27  2360  	if (!err)
09cbfeaf1a5a67b Kirill A. Shutemov 2016-04-01  2361  		range->len = (u64)total << PAGE_SHIFT;
d323d005ac4a2d4 Chao Yu            2015-10-27  2362  	return err;
d323d005ac4a2d4 Chao Yu            2015-10-27  2363  }
d323d005ac4a2d4 Chao Yu            2015-10-27  2364  
d323d005ac4a2d4 Chao Yu            2015-10-27  2365  static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
d323d005ac4a2d4 Chao Yu            2015-10-27  2366  {
d323d005ac4a2d4 Chao Yu            2015-10-27  2367  	struct inode *inode = file_inode(filp);
d323d005ac4a2d4 Chao Yu            2015-10-27  2368  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
d323d005ac4a2d4 Chao Yu            2015-10-27  2369  	struct f2fs_defragment range;
d323d005ac4a2d4 Chao Yu            2015-10-27  2370  	int err;
d323d005ac4a2d4 Chao Yu            2015-10-27  2371  
d323d005ac4a2d4 Chao Yu            2015-10-27  2372  	if (!capable(CAP_SYS_ADMIN))
d323d005ac4a2d4 Chao Yu            2015-10-27  2373  		return -EPERM;
d323d005ac4a2d4 Chao Yu            2015-10-27  2374  
7eab0c0df8d1a8c Hou Pengyang       2017-04-25  2375  	if (!S_ISREG(inode->i_mode) || f2fs_is_atomic_file(inode))
d323d005ac4a2d4 Chao Yu            2015-10-27  2376  		return -EINVAL;
d323d005ac4a2d4 Chao Yu            2015-10-27  2377  
d7563861722a471 Kinglong Mee       2017-03-10  2378  	if (f2fs_readonly(sbi->sb))
d7563861722a471 Kinglong Mee       2017-03-10  2379  		return -EROFS;
d323d005ac4a2d4 Chao Yu            2015-10-27  2380  
d323d005ac4a2d4 Chao Yu            2015-10-27  2381  	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
d7563861722a471 Kinglong Mee       2017-03-10  2382  							sizeof(range)))
d7563861722a471 Kinglong Mee       2017-03-10  2383  		return -EFAULT;
d323d005ac4a2d4 Chao Yu            2015-10-27  2384  
d323d005ac4a2d4 Chao Yu            2015-10-27  2385  	/* verify alignment of offset & size */
d7563861722a471 Kinglong Mee       2017-03-10  2386  	if (range.start & (F2FS_BLKSIZE - 1) || range.len & (F2FS_BLKSIZE - 1))
d7563861722a471 Kinglong Mee       2017-03-10  2387  		return -EINVAL;
d323d005ac4a2d4 Chao Yu            2015-10-27  2388  
1941d7bcb474aa3 Sheng Yong         2017-03-08  2389  	if (unlikely((range.start + range.len) >> PAGE_SHIFT >
d7563861722a471 Kinglong Mee       2017-03-10  2390  					sbi->max_file_blocks))
d7563861722a471 Kinglong Mee       2017-03-10  2391  		return -EINVAL;
d7563861722a471 Kinglong Mee       2017-03-10  2392  
d7563861722a471 Kinglong Mee       2017-03-10  2393  	err = mnt_want_write_file(filp);
d7563861722a471 Kinglong Mee       2017-03-10  2394  	if (err)
d7563861722a471 Kinglong Mee       2017-03-10  2395  		return err;
1941d7bcb474aa3 Sheng Yong         2017-03-08  2396  
d323d005ac4a2d4 Chao Yu            2015-10-27  2397  	err = f2fs_defragment_range(sbi, filp, &range);
d7563861722a471 Kinglong Mee       2017-03-10  2398  	mnt_drop_write_file(filp);
d7563861722a471 Kinglong Mee       2017-03-10  2399  
d0239e1bf5204d6 Jaegeuk Kim        2016-01-08  2400  	f2fs_update_time(sbi, REQ_TIME);
d323d005ac4a2d4 Chao Yu            2015-10-27  2401  	if (err < 0)
d7563861722a471 Kinglong Mee       2017-03-10  2402  		return err;
d323d005ac4a2d4 Chao Yu            2015-10-27  2403  
d323d005ac4a2d4 Chao Yu            2015-10-27  2404  	if (copy_to_user((struct f2fs_defragment __user *)arg, &range,
d323d005ac4a2d4 Chao Yu            2015-10-27  2405  							sizeof(range)))
d7563861722a471 Kinglong Mee       2017-03-10  2406  		return -EFAULT;
d7563861722a471 Kinglong Mee       2017-03-10  2407  
d7563861722a471 Kinglong Mee       2017-03-10  2408  	return 0;
d323d005ac4a2d4 Chao Yu            2015-10-27  2409  }
d323d005ac4a2d4 Chao Yu            2015-10-27  2410  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2411  static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2412  			struct file *file_out, loff_t pos_out, size_t len)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2413  {
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2414  	struct inode *src = file_inode(file_in);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2415  	struct inode *dst = file_inode(file_out);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2416  	struct f2fs_sb_info *sbi = F2FS_I_SB(src);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2417  	size_t olen = len, dst_max_i_size = 0;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2418  	size_t dst_osize;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2419  	int ret;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2420  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2421  	if (file_in->f_path.mnt != file_out->f_path.mnt ||
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2422  				src->i_sb != dst->i_sb)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2423  		return -EXDEV;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2424  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2425  	if (unlikely(f2fs_readonly(src->i_sb)))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2426  		return -EROFS;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2427  
fe8494bfc8c2914 Chao Yu            2016-08-04  2428  	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
fe8494bfc8c2914 Chao Yu            2016-08-04  2429  		return -EINVAL;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2430  
62230e0d702f613 Chandan Rajendra   2018-12-12  2431  	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2432  		return -EOPNOTSUPP;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2433  
d95fd91c1ac1f55 Fan Li             2016-09-13  2434  	if (src == dst) {
d95fd91c1ac1f55 Fan Li             2016-09-13  2435  		if (pos_in == pos_out)
d95fd91c1ac1f55 Fan Li             2016-09-13  2436  			return 0;
d95fd91c1ac1f55 Fan Li             2016-09-13  2437  		if (pos_out > pos_in && pos_out < pos_in + len)
d95fd91c1ac1f55 Fan Li             2016-09-13  2438  			return -EINVAL;
d95fd91c1ac1f55 Fan Li             2016-09-13  2439  	}
d95fd91c1ac1f55 Fan Li             2016-09-13  2440  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2441  	inode_lock(src);
20a3d61d46e1fb4 Chao Yu            2016-08-04  2442  	if (src != dst) {
20a3d61d46e1fb4 Chao Yu            2016-08-04  2443  		ret = -EBUSY;
bb06664a534ba48 Chao Yu            2017-11-03  2444  		if (!inode_trylock(dst))
bb06664a534ba48 Chao Yu            2017-11-03  2445  			goto out;
20a3d61d46e1fb4 Chao Yu            2016-08-04  2446  	}
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2447  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2448  	ret = -EINVAL;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2449  	if (pos_in + len > src->i_size || pos_in + len < pos_in)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2450  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2451  	if (len == 0)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2452  		olen = len = src->i_size - pos_in;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2453  	if (pos_in + len == src->i_size)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2454  		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2455  	if (len == 0) {
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2456  		ret = 0;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2457  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2458  	}
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2459  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2460  	dst_osize = dst->i_size;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2461  	if (pos_out + olen > dst->i_size)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2462  		dst_max_i_size = pos_out + olen;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2463  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2464  	/* verify the end result is block aligned */
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2465  	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2466  			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE) ||
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2467  			!IS_ALIGNED(pos_out, F2FS_BLKSIZE))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2468  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2469  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2470  	ret = f2fs_convert_inline_inode(src);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2471  	if (ret)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2472  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2473  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2474  	ret = f2fs_convert_inline_inode(dst);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2475  	if (ret)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2476  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2477  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2478  	/* write out all dirty pages from offset */
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2479  	ret = filemap_write_and_wait_range(src->i_mapping,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2480  					pos_in, pos_in + len);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2481  	if (ret)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2482  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2483  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2484  	ret = filemap_write_and_wait_range(dst->i_mapping,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2485  					pos_out, pos_out + len);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2486  	if (ret)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2487  		goto out_unlock;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2488  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2489  	f2fs_balance_fs(sbi, true);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2490  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2491  	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2492  	if (src != dst) {
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2493  		ret = -EBUSY;
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2494  		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE]))
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2495  			goto out_src;
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2496  	}
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2497  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2498  	f2fs_lock_op(sbi);
61e4da1172d18f5 Fan Li             2016-09-10  2499  	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
61e4da1172d18f5 Fan Li             2016-09-10  2500  				pos_out >> F2FS_BLKSIZE_BITS,
61e4da1172d18f5 Fan Li             2016-09-10  2501  				len >> F2FS_BLKSIZE_BITS, false);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2502  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2503  	if (!ret) {
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2504  		if (dst_max_i_size)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2505  			f2fs_i_size_write(dst, dst_max_i_size);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2506  		else if (dst_osize != dst->i_size)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2507  			f2fs_i_size_write(dst, dst_osize);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2508  	}
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2509  	f2fs_unlock_op(sbi);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2510  
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2511  	if (src != dst)
b2532c694033fb6 Chao Yu            2018-04-24  2512  		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2513  out_src:
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2514  	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2515  out_unlock:
6f8d4455060dfb0 Jaegeuk Kim        2018-07-25  2516  	if (src != dst)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2517  		inode_unlock(dst);
20a3d61d46e1fb4 Chao Yu            2016-08-04  2518  out:
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2519  	inode_unlock(src);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2520  	return ret;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2521  }
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2522  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2523  static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2524  {
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2525  	struct f2fs_move_range range;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2526  	struct fd dst;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2527  	int err;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2528  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2529  	if (!(filp->f_mode & FMODE_READ) ||
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2530  			!(filp->f_mode & FMODE_WRITE))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2531  		return -EBADF;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2532  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2533  	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2534  							sizeof(range)))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2535  		return -EFAULT;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2536  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2537  	dst = fdget(range.dst_fd);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2538  	if (!dst.file)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2539  		return -EBADF;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2540  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2541  	if (!(dst.file->f_mode & FMODE_WRITE)) {
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2542  		err = -EBADF;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2543  		goto err_out;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2544  	}
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2545  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2546  	err = mnt_want_write_file(filp);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2547  	if (err)
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2548  		goto err_out;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2549  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2550  	err = f2fs_move_file_range(filp, range.pos_in, dst.file,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2551  					range.pos_out, range.len);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2552  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2553  	mnt_drop_write_file(filp);
3cecfa5f6700c07 Kinglong Mee       2017-03-10  2554  	if (err)
3cecfa5f6700c07 Kinglong Mee       2017-03-10  2555  		goto err_out;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2556  
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2557  	if (copy_to_user((struct f2fs_move_range __user *)arg,
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2558  						&range, sizeof(range)))
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2559  		err = -EFAULT;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2560  err_out:
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2561  	fdput(dst);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2562  	return err;
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2563  }
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  2564  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2565  static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2566  {
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2567  	struct inode *inode = file_inode(filp);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2568  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2569  	struct sit_info *sm = SIT_I(sbi);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2570  	unsigned int start_segno = 0, end_segno = 0;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2571  	unsigned int dev_start_segno = 0, dev_end_segno = 0;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2572  	struct f2fs_flush_device range;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2573  	int ret;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2574  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2575  	if (!capable(CAP_SYS_ADMIN))
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2576  		return -EPERM;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2577  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2578  	if (f2fs_readonly(sbi->sb))
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2579  		return -EROFS;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2580  
4354994f097d068 Daniel Rosenberg   2018-08-20  2581  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
4354994f097d068 Daniel Rosenberg   2018-08-20  2582  		return -EINVAL;
4354994f097d068 Daniel Rosenberg   2018-08-20  2583  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2584  	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2585  							sizeof(range)))
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2586  		return -EFAULT;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2587  
0916878da355650 Damien Le Moal     2019-03-16  2588  	if (!f2fs_is_multi_device(sbi) || sbi->s_ndevs - 1 <= range.dev_num ||
2c70c5e3874e8cf Chao Yu            2018-10-24  2589  			__is_large_section(sbi)) {
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2590  		f2fs_msg(sbi->sb, KERN_WARNING,
bda5239738fac6a Chao Yu            2019-04-15  2591  			"Can't flush %u in %d for segs_per_sec %u != 1",
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2592  				range.dev_num, sbi->s_ndevs,
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2593  				sbi->segs_per_sec);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2594  		return -EINVAL;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2595  	}
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2596  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2597  	ret = mnt_want_write_file(filp);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2598  	if (ret)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2599  		return ret;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2600  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2601  	if (range.dev_num != 0)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2602  		dev_start_segno = GET_SEGNO(sbi, FDEV(range.dev_num).start_blk);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2603  	dev_end_segno = GET_SEGNO(sbi, FDEV(range.dev_num).end_blk);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2604  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2605  	start_segno = sm->last_victim[FLUSH_DEVICE];
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2606  	if (start_segno < dev_start_segno || start_segno >= dev_end_segno)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2607  		start_segno = dev_start_segno;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2608  	end_segno = min(start_segno + range.segments, dev_end_segno);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2609  
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2610  	while (start_segno < end_segno) {
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2611  		if (!mutex_trylock(&sbi->gc_mutex)) {
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2612  			ret = -EBUSY;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2613  			goto out;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2614  		}
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2615  		sm->last_victim[GC_CB] = end_segno + 1;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2616  		sm->last_victim[GC_GREEDY] = end_segno + 1;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2617  		sm->last_victim[ALLOC_NEXT] = end_segno + 1;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2618  		ret = f2fs_gc(sbi, true, true, start_segno);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2619  		if (ret == -EAGAIN)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2620  			ret = 0;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2621  		else if (ret < 0)
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2622  			break;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2623  		start_segno++;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2624  	}
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2625  out:
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2626  	mnt_drop_write_file(filp);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2627  	return ret;
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2628  }
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2629  
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2630  static int f2fs_ioc_get_features(struct file *filp, unsigned long arg)
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2631  {
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2632  	struct inode *inode = file_inode(filp);
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2633  	u32 sb_feature = le32_to_cpu(F2FS_I_SB(inode)->raw_super->feature);
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2634  
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2635  	/* Must validate to set it with SQLite behavior in Android. */
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2636  	sb_feature |= F2FS_FEATURE_ATOMIC_WRITE;
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2637  
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2638  	return put_user(sb_feature, (u32 __user *)arg);
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  2639  }
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2640  
2c1d03056991286 Chao Yu            2017-07-29  2641  #ifdef CONFIG_QUOTA
78130819695f17f Chao Yu            2018-09-25  2642  int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
78130819695f17f Chao Yu            2018-09-25  2643  {
78130819695f17f Chao Yu            2018-09-25  2644  	struct dquot *transfer_to[MAXQUOTAS] = {};
78130819695f17f Chao Yu            2018-09-25  2645  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
78130819695f17f Chao Yu            2018-09-25  2646  	struct super_block *sb = sbi->sb;
78130819695f17f Chao Yu            2018-09-25  2647  	int err = 0;
78130819695f17f Chao Yu            2018-09-25  2648  
78130819695f17f Chao Yu            2018-09-25  2649  	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
78130819695f17f Chao Yu            2018-09-25  2650  	if (!IS_ERR(transfer_to[PRJQUOTA])) {
78130819695f17f Chao Yu            2018-09-25  2651  		err = __dquot_transfer(inode, transfer_to);
78130819695f17f Chao Yu            2018-09-25  2652  		if (err)
78130819695f17f Chao Yu            2018-09-25  2653  			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
78130819695f17f Chao Yu            2018-09-25  2654  		dqput(transfer_to[PRJQUOTA]);
78130819695f17f Chao Yu            2018-09-25  2655  	}
78130819695f17f Chao Yu            2018-09-25  2656  	return err;
78130819695f17f Chao Yu            2018-09-25  2657  }
78130819695f17f Chao Yu            2018-09-25  2658  
2c1d03056991286 Chao Yu            2017-07-29  2659  static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
2c1d03056991286 Chao Yu            2017-07-29  2660  {
2c1d03056991286 Chao Yu            2017-07-29  2661  	struct inode *inode = file_inode(filp);
2c1d03056991286 Chao Yu            2017-07-29  2662  	struct f2fs_inode_info *fi = F2FS_I(inode);
2c1d03056991286 Chao Yu            2017-07-29  2663  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
2c1d03056991286 Chao Yu            2017-07-29  2664  	struct page *ipage;
2c1d03056991286 Chao Yu            2017-07-29  2665  	kprojid_t kprojid;
2c1d03056991286 Chao Yu            2017-07-29  2666  	int err;
2c1d03056991286 Chao Yu            2017-07-29  2667  
7beb01f74415c56 Chao Yu            2018-10-24  2668  	if (!f2fs_sb_has_project_quota(sbi)) {
2c1d03056991286 Chao Yu            2017-07-29  2669  		if (projid != F2FS_DEF_PROJID)
2c1d03056991286 Chao Yu            2017-07-29  2670  			return -EOPNOTSUPP;
2c1d03056991286 Chao Yu            2017-07-29  2671  		else
2c1d03056991286 Chao Yu            2017-07-29  2672  			return 0;
2c1d03056991286 Chao Yu            2017-07-29  2673  	}
2c1d03056991286 Chao Yu            2017-07-29  2674  
2c1d03056991286 Chao Yu            2017-07-29  2675  	if (!f2fs_has_extra_attr(inode))
2c1d03056991286 Chao Yu            2017-07-29  2676  		return -EOPNOTSUPP;
2c1d03056991286 Chao Yu            2017-07-29  2677  
2c1d03056991286 Chao Yu            2017-07-29  2678  	kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
2c1d03056991286 Chao Yu            2017-07-29  2679  
2c1d03056991286 Chao Yu            2017-07-29  2680  	if (projid_eq(kprojid, F2FS_I(inode)->i_projid))
2c1d03056991286 Chao Yu            2017-07-29  2681  		return 0;
2c1d03056991286 Chao Yu            2017-07-29  2682  
2c1d03056991286 Chao Yu            2017-07-29  2683  	err = -EPERM;
2c1d03056991286 Chao Yu            2017-07-29  2684  	/* Is it quota file? Do not allow user to mess with it */
2c1d03056991286 Chao Yu            2017-07-29  2685  	if (IS_NOQUOTA(inode))
c8e927579e00a18 Wang Shilong       2018-09-11  2686  		return err;
2c1d03056991286 Chao Yu            2017-07-29  2687  
4d57b86dd86404f Chao Yu            2018-05-30  2688  	ipage = f2fs_get_node_page(sbi, inode->i_ino);
c8e927579e00a18 Wang Shilong       2018-09-11  2689  	if (IS_ERR(ipage))
c8e927579e00a18 Wang Shilong       2018-09-11  2690  		return PTR_ERR(ipage);
2c1d03056991286 Chao Yu            2017-07-29  2691  
2c1d03056991286 Chao Yu            2017-07-29  2692  	if (!F2FS_FITS_IN_INODE(F2FS_INODE(ipage), fi->i_extra_isize,
2c1d03056991286 Chao Yu            2017-07-29  2693  								i_projid)) {
2c1d03056991286 Chao Yu            2017-07-29  2694  		err = -EOVERFLOW;
2c1d03056991286 Chao Yu            2017-07-29  2695  		f2fs_put_page(ipage, 1);
c8e927579e00a18 Wang Shilong       2018-09-11  2696  		return err;
2c1d03056991286 Chao Yu            2017-07-29  2697  	}
2c1d03056991286 Chao Yu            2017-07-29  2698  	f2fs_put_page(ipage, 1);
2c1d03056991286 Chao Yu            2017-07-29  2699  
c22aecd75919511 Chao Yu            2018-04-21  2700  	err = dquot_initialize(inode);
c22aecd75919511 Chao Yu            2018-04-21  2701  	if (err)
c8e927579e00a18 Wang Shilong       2018-09-11  2702  		return err;
2c1d03056991286 Chao Yu            2017-07-29  2703  
78130819695f17f Chao Yu            2018-09-25  2704  	f2fs_lock_op(sbi);
78130819695f17f Chao Yu            2018-09-25  2705  	err = f2fs_transfer_project_quota(inode, kprojid);
2c1d03056991286 Chao Yu            2017-07-29  2706  	if (err)
78130819695f17f Chao Yu            2018-09-25  2707  		goto out_unlock;
2c1d03056991286 Chao Yu            2017-07-29  2708  
2c1d03056991286 Chao Yu            2017-07-29  2709  	F2FS_I(inode)->i_projid = kprojid;
2c1d03056991286 Chao Yu            2017-07-29  2710  	inode->i_ctime = current_time(inode);
2c1d03056991286 Chao Yu            2017-07-29  2711  	f2fs_mark_inode_dirty_sync(inode, true);
78130819695f17f Chao Yu            2018-09-25  2712  out_unlock:
78130819695f17f Chao Yu            2018-09-25  2713  	f2fs_unlock_op(sbi);
2c1d03056991286 Chao Yu            2017-07-29  2714  	return err;
2c1d03056991286 Chao Yu            2017-07-29  2715  }
2c1d03056991286 Chao Yu            2017-07-29  2716  #else
78130819695f17f Chao Yu            2018-09-25  2717  int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
78130819695f17f Chao Yu            2018-09-25  2718  {
78130819695f17f Chao Yu            2018-09-25  2719  	return 0;
78130819695f17f Chao Yu            2018-09-25  2720  }
78130819695f17f Chao Yu            2018-09-25  2721  
2c1d03056991286 Chao Yu            2017-07-29  2722  static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
2c1d03056991286 Chao Yu            2017-07-29  2723  {
2c1d03056991286 Chao Yu            2017-07-29  2724  	if (projid != F2FS_DEF_PROJID)
2c1d03056991286 Chao Yu            2017-07-29  2725  		return -EOPNOTSUPP;
2c1d03056991286 Chao Yu            2017-07-29  2726  	return 0;
2c1d03056991286 Chao Yu            2017-07-29  2727  }
2c1d03056991286 Chao Yu            2017-07-29  2728  #endif
2c1d03056991286 Chao Yu            2017-07-29  2729  
2c1d03056991286 Chao Yu            2017-07-29  2730  /* Transfer internal flags to xflags */
2c1d03056991286 Chao Yu            2017-07-29  2731  static inline __u32 f2fs_iflags_to_xflags(unsigned long iflags)
2c1d03056991286 Chao Yu            2017-07-29  2732  {
2c1d03056991286 Chao Yu            2017-07-29  2733  	__u32 xflags = 0;
2c1d03056991286 Chao Yu            2017-07-29  2734  
59c844088b19c54 Chao Yu            2018-04-03  2735  	if (iflags & F2FS_SYNC_FL)
2c1d03056991286 Chao Yu            2017-07-29  2736  		xflags |= FS_XFLAG_SYNC;
59c844088b19c54 Chao Yu            2018-04-03  2737  	if (iflags & F2FS_IMMUTABLE_FL)
2c1d03056991286 Chao Yu            2017-07-29  2738  		xflags |= FS_XFLAG_IMMUTABLE;
59c844088b19c54 Chao Yu            2018-04-03  2739  	if (iflags & F2FS_APPEND_FL)
2c1d03056991286 Chao Yu            2017-07-29  2740  		xflags |= FS_XFLAG_APPEND;
59c844088b19c54 Chao Yu            2018-04-03  2741  	if (iflags & F2FS_NODUMP_FL)
2c1d03056991286 Chao Yu            2017-07-29  2742  		xflags |= FS_XFLAG_NODUMP;
59c844088b19c54 Chao Yu            2018-04-03  2743  	if (iflags & F2FS_NOATIME_FL)
2c1d03056991286 Chao Yu            2017-07-29  2744  		xflags |= FS_XFLAG_NOATIME;
59c844088b19c54 Chao Yu            2018-04-03  2745  	if (iflags & F2FS_PROJINHERIT_FL)
2c1d03056991286 Chao Yu            2017-07-29  2746  		xflags |= FS_XFLAG_PROJINHERIT;
2c1d03056991286 Chao Yu            2017-07-29  2747  	return xflags;
2c1d03056991286 Chao Yu            2017-07-29  2748  }
2c1d03056991286 Chao Yu            2017-07-29  2749  
2c1d03056991286 Chao Yu            2017-07-29  2750  #define F2FS_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
2c1d03056991286 Chao Yu            2017-07-29  2751  				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
2c1d03056991286 Chao Yu            2017-07-29  2752  				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
2c1d03056991286 Chao Yu            2017-07-29  2753  
2c1d03056991286 Chao Yu            2017-07-29  2754  /* Transfer xflags flags to internal */
2c1d03056991286 Chao Yu            2017-07-29  2755  static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
2c1d03056991286 Chao Yu            2017-07-29  2756  {
2c1d03056991286 Chao Yu            2017-07-29  2757  	unsigned long iflags = 0;
2c1d03056991286 Chao Yu            2017-07-29  2758  
2c1d03056991286 Chao Yu            2017-07-29  2759  	if (xflags & FS_XFLAG_SYNC)
59c844088b19c54 Chao Yu            2018-04-03  2760  		iflags |= F2FS_SYNC_FL;
2c1d03056991286 Chao Yu            2017-07-29  2761  	if (xflags & FS_XFLAG_IMMUTABLE)
59c844088b19c54 Chao Yu            2018-04-03  2762  		iflags |= F2FS_IMMUTABLE_FL;
2c1d03056991286 Chao Yu            2017-07-29  2763  	if (xflags & FS_XFLAG_APPEND)
59c844088b19c54 Chao Yu            2018-04-03  2764  		iflags |= F2FS_APPEND_FL;
2c1d03056991286 Chao Yu            2017-07-29  2765  	if (xflags & FS_XFLAG_NODUMP)
59c844088b19c54 Chao Yu            2018-04-03  2766  		iflags |= F2FS_NODUMP_FL;
2c1d03056991286 Chao Yu            2017-07-29  2767  	if (xflags & FS_XFLAG_NOATIME)
59c844088b19c54 Chao Yu            2018-04-03  2768  		iflags |= F2FS_NOATIME_FL;
2c1d03056991286 Chao Yu            2017-07-29  2769  	if (xflags & FS_XFLAG_PROJINHERIT)
59c844088b19c54 Chao Yu            2018-04-03  2770  		iflags |= F2FS_PROJINHERIT_FL;
2c1d03056991286 Chao Yu            2017-07-29  2771  
2c1d03056991286 Chao Yu            2017-07-29  2772  	return iflags;
2c1d03056991286 Chao Yu            2017-07-29  2773  }
2c1d03056991286 Chao Yu            2017-07-29  2774  
2c1d03056991286 Chao Yu            2017-07-29  2775  static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
2c1d03056991286 Chao Yu            2017-07-29  2776  {
2c1d03056991286 Chao Yu            2017-07-29  2777  	struct inode *inode = file_inode(filp);
2c1d03056991286 Chao Yu            2017-07-29  2778  	struct f2fs_inode_info *fi = F2FS_I(inode);
2c1d03056991286 Chao Yu            2017-07-29  2779  	struct fsxattr fa;
2c1d03056991286 Chao Yu            2017-07-29  2780  
2c1d03056991286 Chao Yu            2017-07-29  2781  	memset(&fa, 0, sizeof(struct fsxattr));
2c1d03056991286 Chao Yu            2017-07-29  2782  	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
c807a7cb543b535 Chao Yu            2018-04-08  2783  				F2FS_FL_USER_VISIBLE);
2c1d03056991286 Chao Yu            2017-07-29  2784  
7beb01f74415c56 Chao Yu            2018-10-24  2785  	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
2c1d03056991286 Chao Yu            2017-07-29  2786  		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
2c1d03056991286 Chao Yu            2017-07-29  2787  							fi->i_projid);
2c1d03056991286 Chao Yu            2017-07-29  2788  
2c1d03056991286 Chao Yu            2017-07-29  2789  	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
2c1d03056991286 Chao Yu            2017-07-29  2790  		return -EFAULT;
2c1d03056991286 Chao Yu            2017-07-29  2791  	return 0;
2c1d03056991286 Chao Yu            2017-07-29  2792  }
2c1d03056991286 Chao Yu            2017-07-29  2793  
c8e927579e00a18 Wang Shilong       2018-09-11  2794  static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
c8e927579e00a18 Wang Shilong       2018-09-11  2795  {
c8e927579e00a18 Wang Shilong       2018-09-11  2796  	/*
c8e927579e00a18 Wang Shilong       2018-09-11  2797  	 * Project Quota ID state is only allowed to change from within the init
c8e927579e00a18 Wang Shilong       2018-09-11  2798  	 * namespace. Enforce that restriction only if we are trying to change
c8e927579e00a18 Wang Shilong       2018-09-11  2799  	 * the quota ID state. Everything else is allowed in user namespaces.
c8e927579e00a18 Wang Shilong       2018-09-11  2800  	 */
c8e927579e00a18 Wang Shilong       2018-09-11  2801  	if (current_user_ns() == &init_user_ns)
c8e927579e00a18 Wang Shilong       2018-09-11  2802  		return 0;
c8e927579e00a18 Wang Shilong       2018-09-11  2803  
c8e927579e00a18 Wang Shilong       2018-09-11  2804  	if (__kprojid_val(F2FS_I(inode)->i_projid) != fa->fsx_projid)
c8e927579e00a18 Wang Shilong       2018-09-11  2805  		return -EINVAL;
c8e927579e00a18 Wang Shilong       2018-09-11  2806  
c8e927579e00a18 Wang Shilong       2018-09-11  2807  	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL) {
c8e927579e00a18 Wang Shilong       2018-09-11  2808  		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
c8e927579e00a18 Wang Shilong       2018-09-11  2809  			return -EINVAL;
c8e927579e00a18 Wang Shilong       2018-09-11  2810  	} else {
c8e927579e00a18 Wang Shilong       2018-09-11  2811  		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
c8e927579e00a18 Wang Shilong       2018-09-11  2812  			return -EINVAL;
c8e927579e00a18 Wang Shilong       2018-09-11  2813  	}
c8e927579e00a18 Wang Shilong       2018-09-11  2814  
c8e927579e00a18 Wang Shilong       2018-09-11  2815  	return 0;
c8e927579e00a18 Wang Shilong       2018-09-11  2816  }
c8e927579e00a18 Wang Shilong       2018-09-11  2817  
2c1d03056991286 Chao Yu            2017-07-29  2818  static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
2c1d03056991286 Chao Yu            2017-07-29  2819  {
2c1d03056991286 Chao Yu            2017-07-29  2820  	struct inode *inode = file_inode(filp);
2c1d03056991286 Chao Yu            2017-07-29  2821  	struct f2fs_inode_info *fi = F2FS_I(inode);
2c1d03056991286 Chao Yu            2017-07-29  2822  	struct fsxattr fa;
2c1d03056991286 Chao Yu            2017-07-29  2823  	unsigned int flags;
2c1d03056991286 Chao Yu            2017-07-29  2824  	int err;
2c1d03056991286 Chao Yu            2017-07-29  2825  
2c1d03056991286 Chao Yu            2017-07-29  2826  	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
2c1d03056991286 Chao Yu            2017-07-29  2827  		return -EFAULT;
2c1d03056991286 Chao Yu            2017-07-29  2828  
2c1d03056991286 Chao Yu            2017-07-29  2829  	/* Make sure caller has proper permission */
2c1d03056991286 Chao Yu            2017-07-29  2830  	if (!inode_owner_or_capable(inode))
2c1d03056991286 Chao Yu            2017-07-29  2831  		return -EACCES;
2c1d03056991286 Chao Yu            2017-07-29  2832  
2c1d03056991286 Chao Yu            2017-07-29  2833  	if (fa.fsx_xflags & ~F2FS_SUPPORTED_FS_XFLAGS)
2c1d03056991286 Chao Yu            2017-07-29  2834  		return -EOPNOTSUPP;
2c1d03056991286 Chao Yu            2017-07-29  2835  
2c1d03056991286 Chao Yu            2017-07-29  2836  	flags = f2fs_xflags_to_iflags(fa.fsx_xflags);
2c1d03056991286 Chao Yu            2017-07-29  2837  	if (f2fs_mask_flags(inode->i_mode, flags) != flags)
2c1d03056991286 Chao Yu            2017-07-29  2838  		return -EOPNOTSUPP;
2c1d03056991286 Chao Yu            2017-07-29  2839  
2c1d03056991286 Chao Yu            2017-07-29  2840  	err = mnt_want_write_file(filp);
2c1d03056991286 Chao Yu            2017-07-29  2841  	if (err)
2c1d03056991286 Chao Yu            2017-07-29  2842  		return err;
2c1d03056991286 Chao Yu            2017-07-29  2843  
2c1d03056991286 Chao Yu            2017-07-29  2844  	inode_lock(inode);
c8e927579e00a18 Wang Shilong       2018-09-11  2845  	err = f2fs_ioctl_check_project(inode, &fa);
c8e927579e00a18 Wang Shilong       2018-09-11  2846  	if (err)
c8e927579e00a18 Wang Shilong       2018-09-11  2847  		goto out;
2c1d03056991286 Chao Yu            2017-07-29  2848  	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
2c1d03056991286 Chao Yu            2017-07-29  2849  				(flags & F2FS_FL_XFLAG_VISIBLE);
2c1d03056991286 Chao Yu            2017-07-29  2850  	err = __f2fs_ioc_setflags(inode, flags);
2c1d03056991286 Chao Yu            2017-07-29  2851  	if (err)
c8e927579e00a18 Wang Shilong       2018-09-11  2852  		goto out;
2c1d03056991286 Chao Yu            2017-07-29  2853  
2c1d03056991286 Chao Yu            2017-07-29  2854  	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
c8e927579e00a18 Wang Shilong       2018-09-11  2855  out:
c8e927579e00a18 Wang Shilong       2018-09-11  2856  	inode_unlock(inode);
c8e927579e00a18 Wang Shilong       2018-09-11  2857  	mnt_drop_write_file(filp);
2c1d03056991286 Chao Yu            2017-07-29  2858  	return err;
2c1d03056991286 Chao Yu            2017-07-29  2859  }
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  2860  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2861  int f2fs_pin_file_control(struct inode *inode, bool inc)
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2862  {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2863  	struct f2fs_inode_info *fi = F2FS_I(inode);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2864  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2865  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2866  	/* Use i_gc_failures for normal file as a risk signal. */
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2867  	if (inc)
2ef79ecb5e906d8 Chao Yu            2018-05-07  2868  		f2fs_i_gc_failures_write(inode,
2ef79ecb5e906d8 Chao Yu            2018-05-07  2869  				fi->i_gc_failures[GC_FAILURE_PIN] + 1);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2870  
2ef79ecb5e906d8 Chao Yu            2018-05-07  2871  	if (fi->i_gc_failures[GC_FAILURE_PIN] > sbi->gc_pin_file_threshold) {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2872  		f2fs_msg(sbi->sb, KERN_WARNING,
bda5239738fac6a Chao Yu            2019-04-15  2873  			"%s: Enable GC = ino %lx after %x GC trials",
2ef79ecb5e906d8 Chao Yu            2018-05-07  2874  			__func__, inode->i_ino,
2ef79ecb5e906d8 Chao Yu            2018-05-07  2875  			fi->i_gc_failures[GC_FAILURE_PIN]);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2876  		clear_inode_flag(inode, FI_PIN_FILE);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2877  		return -EAGAIN;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2878  	}
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2879  	return 0;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2880  }
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2881  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2882  static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2883  {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2884  	struct inode *inode = file_inode(filp);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2885  	__u32 pin;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2886  	int ret = 0;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2887  
aff7b628ac2d586 Jaegeuk Kim        2019-03-13  2888  	if (!capable(CAP_SYS_ADMIN))
aff7b628ac2d586 Jaegeuk Kim        2019-03-13  2889  		return -EPERM;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2890  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2891  	if (get_user(pin, (__u32 __user *)arg))
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2892  		return -EFAULT;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2893  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2894  	if (!S_ISREG(inode->i_mode))
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2895  		return -EINVAL;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2896  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2897  	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2898  		return -EROFS;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2899  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2900  	ret = mnt_want_write_file(filp);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2901  	if (ret)
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2902  		return ret;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2903  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2904  	inode_lock(inode);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2905  
4d57b86dd86404f Chao Yu            2018-05-30  2906  	if (f2fs_should_update_outplace(inode, NULL)) {
bb9e3bb8dbf5975 Chao Yu            2018-01-17  2907  		ret = -EINVAL;
bb9e3bb8dbf5975 Chao Yu            2018-01-17  2908  		goto out;
bb9e3bb8dbf5975 Chao Yu            2018-01-17  2909  	}
bb9e3bb8dbf5975 Chao Yu            2018-01-17  2910  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2911  	if (!pin) {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2912  		clear_inode_flag(inode, FI_PIN_FILE);
309333648156524 Chao Yu            2018-07-28  2913  		f2fs_i_gc_failures_write(inode, 0);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2914  		goto done;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2915  	}
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2916  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2917  	if (f2fs_pin_file_control(inode, false)) {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2918  		ret = -EAGAIN;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2919  		goto out;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2920  	}
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2921  	ret = f2fs_convert_inline_inode(inode);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2922  	if (ret)
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2923  		goto out;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2924  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2925  	set_inode_flag(inode, FI_PIN_FILE);
2ef79ecb5e906d8 Chao Yu            2018-05-07  2926  	ret = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2927  done:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2928  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2929  out:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2930  	inode_unlock(inode);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2931  	mnt_drop_write_file(filp);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2932  	return ret;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2933  }
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2934  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2935  static int f2fs_ioc_get_pin_file(struct file *filp, unsigned long arg)
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2936  {
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2937  	struct inode *inode = file_inode(filp);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2938  	__u32 pin = 0;
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2939  
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2940  	if (is_inode_flag_set(inode, FI_PIN_FILE))
2ef79ecb5e906d8 Chao Yu            2018-05-07  2941  		pin = F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN];
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2942  	return put_user(pin, (u32 __user *)arg);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2943  }
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  2944  
c4020b2da4c9e84 Chao Yu            2018-01-11  2945  int f2fs_precache_extents(struct inode *inode)
c4020b2da4c9e84 Chao Yu            2018-01-11  2946  {
c4020b2da4c9e84 Chao Yu            2018-01-11  2947  	struct f2fs_inode_info *fi = F2FS_I(inode);
c4020b2da4c9e84 Chao Yu            2018-01-11  2948  	struct f2fs_map_blocks map;
c4020b2da4c9e84 Chao Yu            2018-01-11  2949  	pgoff_t m_next_extent;
c4020b2da4c9e84 Chao Yu            2018-01-11  2950  	loff_t end;
c4020b2da4c9e84 Chao Yu            2018-01-11  2951  	int err;
c4020b2da4c9e84 Chao Yu            2018-01-11  2952  
c4020b2da4c9e84 Chao Yu            2018-01-11  2953  	if (is_inode_flag_set(inode, FI_NO_EXTENT))
c4020b2da4c9e84 Chao Yu            2018-01-11  2954  		return -EOPNOTSUPP;
c4020b2da4c9e84 Chao Yu            2018-01-11  2955  
c4020b2da4c9e84 Chao Yu            2018-01-11  2956  	map.m_lblk = 0;
c4020b2da4c9e84 Chao Yu            2018-01-11  2957  	map.m_next_pgofs = NULL;
c4020b2da4c9e84 Chao Yu            2018-01-11  2958  	map.m_next_extent = &m_next_extent;
c4020b2da4c9e84 Chao Yu            2018-01-11  2959  	map.m_seg_type = NO_CHECK_TYPE;
f4f0b6777db4e7a Jia Zhu            2018-11-20  2960  	map.m_may_create = false;
c4020b2da4c9e84 Chao Yu            2018-01-11  2961  	end = F2FS_I_SB(inode)->max_file_blocks;
c4020b2da4c9e84 Chao Yu            2018-01-11  2962  
c4020b2da4c9e84 Chao Yu            2018-01-11  2963  	while (map.m_lblk < end) {
c4020b2da4c9e84 Chao Yu            2018-01-11  2964  		map.m_len = end - map.m_lblk;
c4020b2da4c9e84 Chao Yu            2018-01-11  2965  
b2532c694033fb6 Chao Yu            2018-04-24  2966  		down_write(&fi->i_gc_rwsem[WRITE]);
c4020b2da4c9e84 Chao Yu            2018-01-11  2967  		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
b2532c694033fb6 Chao Yu            2018-04-24  2968  		up_write(&fi->i_gc_rwsem[WRITE]);
c4020b2da4c9e84 Chao Yu            2018-01-11  2969  		if (err)
c4020b2da4c9e84 Chao Yu            2018-01-11  2970  			return err;
c4020b2da4c9e84 Chao Yu            2018-01-11  2971  
c4020b2da4c9e84 Chao Yu            2018-01-11  2972  		map.m_lblk = m_next_extent;
c4020b2da4c9e84 Chao Yu            2018-01-11  2973  	}
c4020b2da4c9e84 Chao Yu            2018-01-11  2974  
c4020b2da4c9e84 Chao Yu            2018-01-11  2975  	return err;
c4020b2da4c9e84 Chao Yu            2018-01-11  2976  }
c4020b2da4c9e84 Chao Yu            2018-01-11  2977  
c4020b2da4c9e84 Chao Yu            2018-01-11  2978  static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
c4020b2da4c9e84 Chao Yu            2018-01-11  2979  {
c4020b2da4c9e84 Chao Yu            2018-01-11  2980  	return f2fs_precache_extents(file_inode(filp));
c4020b2da4c9e84 Chao Yu            2018-01-11  2981  }
c4020b2da4c9e84 Chao Yu            2018-01-11  2982  
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2983  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2984  {
1f227a3e215d361 Jaegeuk Kim        2017-10-23  2985  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
1f227a3e215d361 Jaegeuk Kim        2017-10-23  2986  		return -EIO;
1f227a3e215d361 Jaegeuk Kim        2017-10-23  2987  
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2988  	switch (cmd) {
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2989  	case F2FS_IOC_GETFLAGS:
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2990  		return f2fs_ioc_getflags(filp, arg);
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2991  	case F2FS_IOC_SETFLAGS:
52656e6cf7be695 Jaegeuk Kim        2014-09-24  2992  		return f2fs_ioc_setflags(filp, arg);
d49f3e890290bd1 Chao Yu            2015-01-23  2993  	case F2FS_IOC_GETVERSION:
d49f3e890290bd1 Chao Yu            2015-01-23  2994  		return f2fs_ioc_getversion(filp, arg);
88b88a667971599 Jaegeuk Kim        2014-10-06  2995  	case F2FS_IOC_START_ATOMIC_WRITE:
88b88a667971599 Jaegeuk Kim        2014-10-06  2996  		return f2fs_ioc_start_atomic_write(filp);
88b88a667971599 Jaegeuk Kim        2014-10-06  2997  	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
88b88a667971599 Jaegeuk Kim        2014-10-06  2998  		return f2fs_ioc_commit_atomic_write(filp);
02a1335f25a386d Jaegeuk Kim        2014-10-06  2999  	case F2FS_IOC_START_VOLATILE_WRITE:
02a1335f25a386d Jaegeuk Kim        2014-10-06  3000  		return f2fs_ioc_start_volatile_write(filp);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  3001  	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
1e84371ffeef451 Jaegeuk Kim        2014-12-09  3002  		return f2fs_ioc_release_volatile_write(filp);
1e84371ffeef451 Jaegeuk Kim        2014-12-09  3003  	case F2FS_IOC_ABORT_VOLATILE_WRITE:
1e84371ffeef451 Jaegeuk Kim        2014-12-09  3004  		return f2fs_ioc_abort_volatile_write(filp);
1abff93d01eddaa Jaegeuk Kim        2015-01-08  3005  	case F2FS_IOC_SHUTDOWN:
1abff93d01eddaa Jaegeuk Kim        2015-01-08  3006  		return f2fs_ioc_shutdown(filp, arg);
52656e6cf7be695 Jaegeuk Kim        2014-09-24  3007  	case FITRIM:
52656e6cf7be695 Jaegeuk Kim        2014-09-24  3008  		return f2fs_ioc_fitrim(filp, arg);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3009  	case F2FS_IOC_SET_ENCRYPTION_POLICY:
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3010  		return f2fs_ioc_set_encryption_policy(filp, arg);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3011  	case F2FS_IOC_GET_ENCRYPTION_POLICY:
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3012  		return f2fs_ioc_get_encryption_policy(filp, arg);
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3013  	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
f424f664f0e8949 Jaegeuk Kim        2015-04-20  3014  		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
c1c1b58359d45e1 Chao Yu            2015-07-10  3015  	case F2FS_IOC_GARBAGE_COLLECT:
c1c1b58359d45e1 Chao Yu            2015-07-10  3016  		return f2fs_ioc_gc(filp, arg);
34dc77ad7436870 Jaegeuk Kim        2017-06-15  3017  	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
34dc77ad7436870 Jaegeuk Kim        2017-06-15  3018  		return f2fs_ioc_gc_range(filp, arg);
456b88e4d15de83 Chao Yu            2015-10-05  3019  	case F2FS_IOC_WRITE_CHECKPOINT:
059c0648c6aeb25 Chao Yu            2018-07-17  3020  		return f2fs_ioc_write_checkpoint(filp, arg);
d323d005ac4a2d4 Chao Yu            2015-10-27  3021  	case F2FS_IOC_DEFRAGMENT:
d323d005ac4a2d4 Chao Yu            2015-10-27  3022  		return f2fs_ioc_defragment(filp, arg);
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  3023  	case F2FS_IOC_MOVE_RANGE:
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  3024  		return f2fs_ioc_move_range(filp, arg);
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  3025  	case F2FS_IOC_FLUSH_DEVICE:
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  3026  		return f2fs_ioc_flush_device(filp, arg);
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  3027  	case F2FS_IOC_GET_FEATURES:
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  3028  		return f2fs_ioc_get_features(filp, arg);
2c1d03056991286 Chao Yu            2017-07-29  3029  	case F2FS_IOC_FSGETXATTR:
2c1d03056991286 Chao Yu            2017-07-29  3030  		return f2fs_ioc_fsgetxattr(filp, arg);
2c1d03056991286 Chao Yu            2017-07-29  3031  	case F2FS_IOC_FSSETXATTR:
2c1d03056991286 Chao Yu            2017-07-29  3032  		return f2fs_ioc_fssetxattr(filp, arg);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3033  	case F2FS_IOC_GET_PIN_FILE:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3034  		return f2fs_ioc_get_pin_file(filp, arg);
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3035  	case F2FS_IOC_SET_PIN_FILE:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3036  		return f2fs_ioc_set_pin_file(filp, arg);
c4020b2da4c9e84 Chao Yu            2018-01-11  3037  	case F2FS_IOC_PRECACHE_EXTENTS:
c4020b2da4c9e84 Chao Yu            2018-01-11  3038  		return f2fs_ioc_precache_extents(filp, arg);
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3039  	default:
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3040  		return -ENOTTY;
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3041  	}
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3042  }
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3043  
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3044  static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3045  {
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3046  	struct file *file = iocb->ki_filp;
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3047  	struct inode *inode = file_inode(file);
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3048  	ssize_t ret;
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3049  
126ce7214d21341 Chao Yu            2019-04-02  3050  	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
126ce7214d21341 Chao Yu            2019-04-02  3051  		ret = -EIO;
126ce7214d21341 Chao Yu            2019-04-02  3052  		goto out;
126ce7214d21341 Chao Yu            2019-04-02  3053  	}
1f227a3e215d361 Jaegeuk Kim        2017-10-23  3054  
126ce7214d21341 Chao Yu            2019-04-02  3055  	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
126ce7214d21341 Chao Yu            2019-04-02  3056  		ret = -EINVAL;
126ce7214d21341 Chao Yu            2019-04-02  3057  		goto out;
126ce7214d21341 Chao Yu            2019-04-02  3058  	}
b91050a80cec3da Hyunchul Lee       2018-03-08  3059  
b91050a80cec3da Hyunchul Lee       2018-03-08  3060  	if (!inode_trylock(inode)) {
126ce7214d21341 Chao Yu            2019-04-02  3061  		if (iocb->ki_flags & IOCB_NOWAIT) {
126ce7214d21341 Chao Yu            2019-04-02  3062  			ret = -EAGAIN;
126ce7214d21341 Chao Yu            2019-04-02  3063  			goto out;
126ce7214d21341 Chao Yu            2019-04-02  3064  		}
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3065  		inode_lock(inode);
b91050a80cec3da Hyunchul Lee       2018-03-08  3066  	}
b91050a80cec3da Hyunchul Lee       2018-03-08  3067  
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3068  	ret = generic_write_checks(iocb, from);
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3069  	if (ret > 0) {
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3070  		bool preallocated = false;
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3071  		size_t target_size = 0;
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3072  		int err;
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3073  
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3074  		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3075  			set_inode_flag(inode, FI_NO_PREALLOC);
a7de608691f766c Jaegeuk Kim        2016-11-11  3076  
d5d5f0c0c9160f0 Chengguang Xu      2019-04-23  3077  		if ((iocb->ki_flags & IOCB_NOWAIT)) {
b91050a80cec3da Hyunchul Lee       2018-03-08  3078  			if (!f2fs_overwrite_io(inode, iocb->ki_pos,
b91050a80cec3da Hyunchul Lee       2018-03-08  3079  						iov_iter_count(from)) ||
b91050a80cec3da Hyunchul Lee       2018-03-08  3080  				f2fs_has_inline_data(inode) ||
d5d5f0c0c9160f0 Chengguang Xu      2019-04-23  3081  				f2fs_force_buffered_io(inode, iocb, from)) {
d5d5f0c0c9160f0 Chengguang Xu      2019-04-23  3082  				clear_inode_flag(inode, FI_NO_PREALLOC);
b91050a80cec3da Hyunchul Lee       2018-03-08  3083  				inode_unlock(inode);
126ce7214d21341 Chao Yu            2019-04-02  3084  				ret = -EAGAIN;
126ce7214d21341 Chao Yu            2019-04-02  3085  				goto out;
b91050a80cec3da Hyunchul Lee       2018-03-08  3086  			}
b91050a80cec3da Hyunchul Lee       2018-03-08  3087  		} else {
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3088  			preallocated = true;
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3089  			target_size = iocb->ki_pos + iov_iter_count(from);
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3090  
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3091  			err = f2fs_preallocate_blocks(iocb, from);
a7de608691f766c Jaegeuk Kim        2016-11-11  3092  			if (err) {
28cfafb73853f04 Chao Yu            2017-11-13  3093  				clear_inode_flag(inode, FI_NO_PREALLOC);
a7de608691f766c Jaegeuk Kim        2016-11-11  3094  				inode_unlock(inode);
126ce7214d21341 Chao Yu            2019-04-02  3095  				ret = err;
126ce7214d21341 Chao Yu            2019-04-02  3096  				goto out;
a7de608691f766c Jaegeuk Kim        2016-11-11  3097  			}
b91050a80cec3da Hyunchul Lee       2018-03-08  3098  		}
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3099  		ret = __generic_file_write_iter(iocb, from);
dc91de78e5e1d44 Jaegeuk Kim        2017-01-13  3100  		clear_inode_flag(inode, FI_NO_PREALLOC);
b0af6d491a6b5f5 Chao Yu            2017-08-02  3101  
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3102  		/* if we couldn't write data, we should deallocate blocks. */
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3103  		if (preallocated && i_size_read(inode) < target_size)
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3104  			f2fs_truncate(inode);
dc7a10ddee0c56c Jaegeuk Kim        2018-03-30  3105  
b0af6d491a6b5f5 Chao Yu            2017-08-02  3106  		if (ret > 0)
b0af6d491a6b5f5 Chao Yu            2017-08-02  3107  			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
9dfa1baff76d088 Jaegeuk Kim        2016-07-13  3108  	}
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3109  	inode_unlock(inode);
126ce7214d21341 Chao Yu            2019-04-02  3110  out:
126ce7214d21341 Chao Yu            2019-04-02  3111  	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
126ce7214d21341 Chao Yu            2019-04-02  3112  					iov_iter_count(from), ret);
e259221763a4040 Christoph Hellwig  2016-04-07  3113  	if (ret > 0)
e259221763a4040 Christoph Hellwig  2016-04-07  3114  		ret = generic_write_sync(iocb, ret);
b439b103a6c9eb3 Jaegeuk Kim        2016-02-03  3115  	return ret;
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3116  }
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3117  
e9750824114ff93 Namjae Jeon        2013-02-04  3118  #ifdef CONFIG_COMPAT
e9750824114ff93 Namjae Jeon        2013-02-04  3119  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
e9750824114ff93 Namjae Jeon        2013-02-04  3120  {
e9750824114ff93 Namjae Jeon        2013-02-04  3121  	switch (cmd) {
e9750824114ff93 Namjae Jeon        2013-02-04  3122  	case F2FS_IOC32_GETFLAGS:
e9750824114ff93 Namjae Jeon        2013-02-04  3123  		cmd = F2FS_IOC_GETFLAGS;
e9750824114ff93 Namjae Jeon        2013-02-04  3124  		break;
e9750824114ff93 Namjae Jeon        2013-02-04  3125  	case F2FS_IOC32_SETFLAGS:
e9750824114ff93 Namjae Jeon        2013-02-04  3126  		cmd = F2FS_IOC_SETFLAGS;
e9750824114ff93 Namjae Jeon        2013-02-04  3127  		break;
04ef4b626c324a7 Chao Yu            2015-11-10  3128  	case F2FS_IOC32_GETVERSION:
04ef4b626c324a7 Chao Yu            2015-11-10  3129  		cmd = F2FS_IOC_GETVERSION;
04ef4b626c324a7 Chao Yu            2015-11-10  3130  		break;
04ef4b626c324a7 Chao Yu            2015-11-10  3131  	case F2FS_IOC_START_ATOMIC_WRITE:
04ef4b626c324a7 Chao Yu            2015-11-10  3132  	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
04ef4b626c324a7 Chao Yu            2015-11-10  3133  	case F2FS_IOC_START_VOLATILE_WRITE:
04ef4b626c324a7 Chao Yu            2015-11-10  3134  	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
04ef4b626c324a7 Chao Yu            2015-11-10  3135  	case F2FS_IOC_ABORT_VOLATILE_WRITE:
04ef4b626c324a7 Chao Yu            2015-11-10  3136  	case F2FS_IOC_SHUTDOWN:
04ef4b626c324a7 Chao Yu            2015-11-10  3137  	case F2FS_IOC_SET_ENCRYPTION_POLICY:
04ef4b626c324a7 Chao Yu            2015-11-10  3138  	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
04ef4b626c324a7 Chao Yu            2015-11-10  3139  	case F2FS_IOC_GET_ENCRYPTION_POLICY:
04ef4b626c324a7 Chao Yu            2015-11-10  3140  	case F2FS_IOC_GARBAGE_COLLECT:
34dc77ad7436870 Jaegeuk Kim        2017-06-15  3141  	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
04ef4b626c324a7 Chao Yu            2015-11-10  3142  	case F2FS_IOC_WRITE_CHECKPOINT:
04ef4b626c324a7 Chao Yu            2015-11-10  3143  	case F2FS_IOC_DEFRAGMENT:
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  3144  	case F2FS_IOC_MOVE_RANGE:
e066b83c9b40f3a Jaegeuk Kim        2017-04-13  3145  	case F2FS_IOC_FLUSH_DEVICE:
e65ef20781cbfcb Jaegeuk Kim        2017-07-21  3146  	case F2FS_IOC_GET_FEATURES:
2c1d03056991286 Chao Yu            2017-07-29  3147  	case F2FS_IOC_FSGETXATTR:
2c1d03056991286 Chao Yu            2017-07-29  3148  	case F2FS_IOC_FSSETXATTR:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3149  	case F2FS_IOC_GET_PIN_FILE:
1ad71a27124caf0 Jaegeuk Kim        2017-12-07  3150  	case F2FS_IOC_SET_PIN_FILE:
c4020b2da4c9e84 Chao Yu            2018-01-11  3151  	case F2FS_IOC_PRECACHE_EXTENTS:
4dd6f977fc778e5 Jaegeuk Kim        2016-07-08  3152  		break;
e9750824114ff93 Namjae Jeon        2013-02-04  3153  	default:
e9750824114ff93 Namjae Jeon        2013-02-04  3154  		return -ENOIOCTLCMD;
e9750824114ff93 Namjae Jeon        2013-02-04  3155  	}
e9750824114ff93 Namjae Jeon        2013-02-04  3156  	return f2fs_ioctl(file, cmd, (unsigned long) compat_ptr(arg));
e9750824114ff93 Namjae Jeon        2013-02-04  3157  }
e9750824114ff93 Namjae Jeon        2013-02-04  3158  #endif
e9750824114ff93 Namjae Jeon        2013-02-04  3159  
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3160  const struct file_operations f2fs_file_operations = {
267378d4de696d4 Chao Yu            2014-04-23  3161  	.llseek		= f2fs_llseek,
aad4f8bb42af063 Al Viro            2014-04-02  3162  	.read_iter	= generic_file_read_iter,
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3163  	.write_iter	= f2fs_file_write_iter,
fcc85a4d86b5018 Jaegeuk Kim        2015-04-21  3164  	.open		= f2fs_file_open,
126622343a84889 Jaegeuk Kim        2014-12-05  3165  	.release	= f2fs_release_file,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3166  	.mmap		= f2fs_file_mmap,
7a10f0177e117e9 Jaegeuk Kim        2017-07-24  3167  	.flush		= f2fs_file_flush,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3168  	.fsync		= f2fs_sync_file,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3169  	.fallocate	= f2fs_fallocate,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3170  	.unlocked_ioctl	= f2fs_ioctl,
e9750824114ff93 Namjae Jeon        2013-02-04  3171  #ifdef CONFIG_COMPAT
e9750824114ff93 Namjae Jeon        2013-02-04  3172  	.compat_ioctl	= f2fs_compat_ioctl,
e9750824114ff93 Namjae Jeon        2013-02-04  3173  #endif
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3174  	.splice_read	= generic_file_splice_read,
8d0207652cbe27d Al Viro            2014-04-05  3175  	.splice_write	= iter_file_splice_write,
fbfa2cc58d5363f Jaegeuk Kim        2012-11-02  3176  };

:::::: The code at line 42 was first introduced by commit
:::::: d764834378a9870ca56e9b2977ea46e9911ec358 f2fs: add tracepoint for f2fs_filemap_fault()

:::::: TO: Chao Yu <yuchao0@huawei.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
