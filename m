Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13442C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DA92133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2KXLt37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCSJBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58190 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:01:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J8wxeu134297;
        Tue, 19 Mar 2019 09:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=e5fODKGc4bRdSRvAwVW8LIWyYyb6ObLgXEUl007td9k=;
 b=Q2KXLt37vEg0mCWtDR4BMZhVzWh9G6FxJCJE8s4ejHPzGB7zVqDDvOaUTp9C6aw7YOjN
 ZWAZiujyVIaf8+THWtqKlx4TJfeB1WTGxmoyDlEPMesp+GwwYLZX+0cqop9N0dZ4rDBy
 BsmkyZ+i5DxaeX1NtLThYzXSNT00yZWnznBzq9/y4dYoRwuRItAMA7/i3MXl8IkktDuB
 5LbRspJWctXLQ602Fqj1OlWL9WZDg5upym8Hbrl6dxl/mTr2Am+KadNy9eogggTN2q0Y
 A9RDD+JxYvMkZaV6MnaLvvULCEXRaQ5XKqyPrK4GUlMWQK8pMjEhh/0VPggtibt1K0Mv tg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjukbf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 09:01:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J913F9019134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 09:01:03 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J9122o021200;
        Tue, 19 Mar 2019 09:01:02 GMT
Received: from kadam (/197.157.0.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 02:01:01 -0700
Date:   Tue, 19 Mar 2019 12:00:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Kangjie Lu <kjlu@umn.edu>
Cc:     kbuild-all@01.org, kjlu@umn.edu, pakki001@umn.edu,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: affs: fix a NULL pointer dereference
Message-ID: <20190319090053.GK2227@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314074607.28041-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=820 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/fs-affs-fix-a-NULL-pointer-dereference/20190314-170334

New smatch warnings:
fs/affs/file.c:951 affs_truncate() error: we previously assumed 'ext_bh' could be null (see line 944)

Old smatch warnings:
fs/affs/file.c:806 affs_write_end_ofs() warn: passing zero to 'PTR_ERR'

# https://github.com/0day-ci/linux/commit/2ee20c56bd586ddaf3ebdb1c3cad26439edc9eb6
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 2ee20c56bd586ddaf3ebdb1c3cad26439edc9eb6
vim +/ext_bh +951 fs/affs/file.c

^1da177e4 Linus Torvalds     2005-04-16  833  
^1da177e4 Linus Torvalds     2005-04-16  834  void
^1da177e4 Linus Torvalds     2005-04-16  835  affs_truncate(struct inode *inode)
^1da177e4 Linus Torvalds     2005-04-16  836  {
^1da177e4 Linus Torvalds     2005-04-16  837  	struct super_block *sb = inode->i_sb;
2ee20c56b Kangjie Lu         2019-03-14  838  	u32 ext, ext_key, ext_bk;
^1da177e4 Linus Torvalds     2005-04-16  839  	u32 last_blk, blkcnt, blk;
^1da177e4 Linus Torvalds     2005-04-16  840  	u32 size;
^1da177e4 Linus Torvalds     2005-04-16  841  	struct buffer_head *ext_bh;
^1da177e4 Linus Torvalds     2005-04-16  842  	int i;
^1da177e4 Linus Torvalds     2005-04-16  843  
08fe100d9 Geert Uytterhoeven 2015-02-17  844  	pr_debug("truncate(inode=%lu, oldsize=%llu, newsize=%llu)\n",
08fe100d9 Geert Uytterhoeven 2015-02-17  845  		 inode->i_ino, AFFS_I(inode)->mmu_private, inode->i_size);
^1da177e4 Linus Torvalds     2005-04-16  846  
^1da177e4 Linus Torvalds     2005-04-16  847  	last_blk = 0;
^1da177e4 Linus Torvalds     2005-04-16  848  	ext = 0;
^1da177e4 Linus Torvalds     2005-04-16  849  	if (inode->i_size) {
^1da177e4 Linus Torvalds     2005-04-16  850  		last_blk = ((u32)inode->i_size - 1) / AFFS_SB(sb)->s_data_blksize;
^1da177e4 Linus Torvalds     2005-04-16  851  		ext = last_blk / AFFS_SB(sb)->s_hashsize;
^1da177e4 Linus Torvalds     2005-04-16  852  	}
^1da177e4 Linus Torvalds     2005-04-16  853  
^1da177e4 Linus Torvalds     2005-04-16  854  	if (inode->i_size > AFFS_I(inode)->mmu_private) {
^1da177e4 Linus Torvalds     2005-04-16  855  		struct address_space *mapping = inode->i_mapping;
^1da177e4 Linus Torvalds     2005-04-16  856  		struct page *page;
f2b6a16eb Nick Piggin        2007-10-16  857  		void *fsdata;
73516ace9 Fabian Frederick   2014-10-13  858  		loff_t isize = inode->i_size;
^1da177e4 Linus Torvalds     2005-04-16  859  		int res;
^1da177e4 Linus Torvalds     2005-04-16  860  
73516ace9 Fabian Frederick   2014-10-13  861  		res = mapping->a_ops->write_begin(NULL, mapping, isize, 0, 0, &page, &fsdata);
^1da177e4 Linus Torvalds     2005-04-16  862  		if (!res)
73516ace9 Fabian Frederick   2014-10-13  863  			res = mapping->a_ops->write_end(NULL, mapping, isize, 0, 0, page, fsdata);
dca3c3365 Roman Zippel       2008-04-29  864  		else
dca3c3365 Roman Zippel       2008-04-29  865  			inode->i_size = AFFS_I(inode)->mmu_private;
^1da177e4 Linus Torvalds     2005-04-16  866  		mark_inode_dirty(inode);
^1da177e4 Linus Torvalds     2005-04-16  867  		return;
^1da177e4 Linus Torvalds     2005-04-16  868  	} else if (inode->i_size == AFFS_I(inode)->mmu_private)
^1da177e4 Linus Torvalds     2005-04-16  869  		return;
^1da177e4 Linus Torvalds     2005-04-16  870  
^1da177e4 Linus Torvalds     2005-04-16  871  	// lock cache
^1da177e4 Linus Torvalds     2005-04-16  872  	ext_bh = affs_get_extblock(inode, ext);
^1da177e4 Linus Torvalds     2005-04-16  873  	if (IS_ERR(ext_bh)) {
1ee54b099 Fabian Frederick   2014-12-12  874  		affs_warning(sb, "truncate",
1ee54b099 Fabian Frederick   2014-12-12  875  			     "unexpected read error for ext block %u (%ld)",
08fe100d9 Geert Uytterhoeven 2015-02-17  876  			     ext, PTR_ERR(ext_bh));
^1da177e4 Linus Torvalds     2005-04-16  877  		return;
^1da177e4 Linus Torvalds     2005-04-16  878  	}
^1da177e4 Linus Torvalds     2005-04-16  879  	if (AFFS_I(inode)->i_lc) {
^1da177e4 Linus Torvalds     2005-04-16  880  		/* clear linear cache */
^1da177e4 Linus Torvalds     2005-04-16  881  		i = (ext + 1) >> AFFS_I(inode)->i_lc_shift;
^1da177e4 Linus Torvalds     2005-04-16  882  		if (AFFS_I(inode)->i_lc_size > i) {
^1da177e4 Linus Torvalds     2005-04-16  883  			AFFS_I(inode)->i_lc_size = i;
^1da177e4 Linus Torvalds     2005-04-16  884  			for (; i < AFFS_LC_SIZE; i++)
^1da177e4 Linus Torvalds     2005-04-16  885  				AFFS_I(inode)->i_lc[i] = 0;
^1da177e4 Linus Torvalds     2005-04-16  886  		}
^1da177e4 Linus Torvalds     2005-04-16  887  		/* clear associative cache */
^1da177e4 Linus Torvalds     2005-04-16  888  		for (i = 0; i < AFFS_AC_SIZE; i++)
^1da177e4 Linus Torvalds     2005-04-16  889  			if (AFFS_I(inode)->i_ac[i].ext >= ext)
^1da177e4 Linus Torvalds     2005-04-16  890  				AFFS_I(inode)->i_ac[i].ext = 0;
^1da177e4 Linus Torvalds     2005-04-16  891  	}
^1da177e4 Linus Torvalds     2005-04-16  892  	ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
^1da177e4 Linus Torvalds     2005-04-16  893  
^1da177e4 Linus Torvalds     2005-04-16  894  	blkcnt = AFFS_I(inode)->i_blkcnt;
^1da177e4 Linus Torvalds     2005-04-16  895  	i = 0;
^1da177e4 Linus Torvalds     2005-04-16  896  	blk = last_blk;
^1da177e4 Linus Torvalds     2005-04-16  897  	if (inode->i_size) {
^1da177e4 Linus Torvalds     2005-04-16  898  		i = last_blk % AFFS_SB(sb)->s_hashsize + 1;
^1da177e4 Linus Torvalds     2005-04-16  899  		blk++;
^1da177e4 Linus Torvalds     2005-04-16  900  	} else
^1da177e4 Linus Torvalds     2005-04-16  901  		AFFS_HEAD(ext_bh)->first_data = 0;
dca3c3365 Roman Zippel       2008-04-29  902  	AFFS_HEAD(ext_bh)->block_count = cpu_to_be32(i);
^1da177e4 Linus Torvalds     2005-04-16  903  	size = AFFS_SB(sb)->s_hashsize;
^1da177e4 Linus Torvalds     2005-04-16  904  	if (size > blkcnt - blk + i)
^1da177e4 Linus Torvalds     2005-04-16  905  		size = blkcnt - blk + i;
^1da177e4 Linus Torvalds     2005-04-16  906  	for (; i < size; i++, blk++) {
^1da177e4 Linus Torvalds     2005-04-16  907  		affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
^1da177e4 Linus Torvalds     2005-04-16  908  		AFFS_BLOCK(sb, ext_bh, i) = 0;
^1da177e4 Linus Torvalds     2005-04-16  909  	}
^1da177e4 Linus Torvalds     2005-04-16  910  	AFFS_TAIL(sb, ext_bh)->extension = 0;
^1da177e4 Linus Torvalds     2005-04-16  911  	affs_fix_checksum(sb, ext_bh);
^1da177e4 Linus Torvalds     2005-04-16  912  	mark_buffer_dirty_inode(ext_bh, inode);
^1da177e4 Linus Torvalds     2005-04-16  913  	affs_brelse(ext_bh);
^1da177e4 Linus Torvalds     2005-04-16  914  
^1da177e4 Linus Torvalds     2005-04-16  915  	if (inode->i_size) {
^1da177e4 Linus Torvalds     2005-04-16  916  		AFFS_I(inode)->i_blkcnt = last_blk + 1;
^1da177e4 Linus Torvalds     2005-04-16  917  		AFFS_I(inode)->i_extcnt = ext + 1;
79bda4d51 Fabian Frederick   2015-04-16  918  		if (affs_test_opt(AFFS_SB(sb)->s_flags, SF_OFS)) {
^1da177e4 Linus Torvalds     2005-04-16  919  			struct buffer_head *bh = affs_bread_ino(inode, last_blk, 0);
^1da177e4 Linus Torvalds     2005-04-16  920  			u32 tmp;
0e45b67d5 Dan Carpenter      2010-08-25  921  			if (IS_ERR(bh)) {
1ee54b099 Fabian Frederick   2014-12-12  922  				affs_warning(sb, "truncate",
1ee54b099 Fabian Frederick   2014-12-12  923  					     "unexpected read error for last block %u (%ld)",
08fe100d9 Geert Uytterhoeven 2015-02-17  924  					     ext, PTR_ERR(bh));
^1da177e4 Linus Torvalds     2005-04-16  925  				return;
^1da177e4 Linus Torvalds     2005-04-16  926  			}
^1da177e4 Linus Torvalds     2005-04-16  927  			tmp = be32_to_cpu(AFFS_DATA_HEAD(bh)->next);
^1da177e4 Linus Torvalds     2005-04-16  928  			AFFS_DATA_HEAD(bh)->next = 0;
^1da177e4 Linus Torvalds     2005-04-16  929  			affs_adjust_checksum(bh, -tmp);
^1da177e4 Linus Torvalds     2005-04-16  930  			affs_brelse(bh);
^1da177e4 Linus Torvalds     2005-04-16  931  		}
^1da177e4 Linus Torvalds     2005-04-16  932  	} else {
^1da177e4 Linus Torvalds     2005-04-16  933  		AFFS_I(inode)->i_blkcnt = 0;
^1da177e4 Linus Torvalds     2005-04-16  934  		AFFS_I(inode)->i_extcnt = 1;
^1da177e4 Linus Torvalds     2005-04-16  935  	}
^1da177e4 Linus Torvalds     2005-04-16  936  	AFFS_I(inode)->mmu_private = inode->i_size;
^1da177e4 Linus Torvalds     2005-04-16  937  	// unlock cache
^1da177e4 Linus Torvalds     2005-04-16  938  
^1da177e4 Linus Torvalds     2005-04-16  939  	while (ext_key) {
^1da177e4 Linus Torvalds     2005-04-16  940  		ext_bh = affs_bread(sb, ext_key);
^1da177e4 Linus Torvalds     2005-04-16  941  		size = AFFS_SB(sb)->s_hashsize;
^1da177e4 Linus Torvalds     2005-04-16  942  		if (size > blkcnt - blk)
^1da177e4 Linus Torvalds     2005-04-16  943  			size = blkcnt - blk;
2ee20c56b Kangjie Lu         2019-03-14 @944  		if (ext_bh) {
2ee20c56b Kangjie Lu         2019-03-14  945  			for (i = 0; i < size; i++, blk++) {
2ee20c56b Kangjie Lu         2019-03-14  946  				ext_bk = AFFS_BLOCK(sb, ext_bh, i);
2ee20c56b Kangjie Lu         2019-03-14  947  				affs_free_block(sb, be32_to_cpu(ext_bk));
2ee20c56b Kangjie Lu         2019-03-14  948  			}
2ee20c56b Kangjie Lu         2019-03-14  949  		}
^1da177e4 Linus Torvalds     2005-04-16  950  		affs_free_block(sb, ext_key);
^1da177e4 Linus Torvalds     2005-04-16 @951  		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
^1da177e4 Linus Torvalds     2005-04-16  952  		affs_brelse(ext_bh);
^1da177e4 Linus Torvalds     2005-04-16  953  	}
^1da177e4 Linus Torvalds     2005-04-16  954  	affs_free_prealloc(inode);
^1da177e4 Linus Torvalds     2005-04-16  955  }
c47587955 Al Viro            2009-06-08  956  

:::::: The code at line 951 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
