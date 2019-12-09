Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9D8207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="PciP+zL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLILlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:41:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46922 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLILlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:41:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so15173410ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMrnNFWgeqnRcHk13MvzMLgeCOEwKQCW11dqbvS445Q=;
        b=PciP+zL0ff67wWIolhvau1lkk+d0NIpPgIZVf3RNIAG1fMbKhxDzQpMkwcMzdD3iND
         g7Qyq3Albi5/Mf4pw5vHqDVvErybbhNzRhlXvax4XyuEoy3RBZi8LmXe7JXXR+zE9yV0
         ItjRGenld+FokPKI4ZHGAkzE1YvtuqvkpTpkVUYxtmNRjM5HMLujX4ZQ5g9ikRk2K8Il
         qXI3Q1gRn/m1H0cDCLzO8uBwgRzm6EHmfwUpUeeldGnLHwCQs01CgRZz1P/3e39np+vV
         S/DkY/cOytTOCwbsd99Op1mzickY++Pid2s6mahoz/SFTJVT7vTcOs/41LTzg3VF5d9S
         Tfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMrnNFWgeqnRcHk13MvzMLgeCOEwKQCW11dqbvS445Q=;
        b=AxrcyjV6FAPdR9JapV87SI20GiNzsU8NGDU6o84+S65d8rjnAgie0RqHwfA6YNrdGj
         /JOcnDr20dY3KI5JNUyFjIWG3ew4cWPYPU4Mmi+3BlzFsYd7YMtAYUbjoSBISvZ0Ij2e
         YRsCCa4S50HGqoFlUxe9OcqyWaciKHHprmrwCzGNlMvCi0Nqhyv3kPy6TyRTUtd0d0tf
         pG94USH5cbFRiGVQ9E8uy58re/Mm4mrUViI9hLix0G2U7WxSwTf0CxWnfJlcH5MTi26Z
         iR3/qq5q2dYFE2TPPjyBziLDuCrKDBLHSUVH/oEwdI6cIRRJNXKETtVP9H41NM+BeQTj
         YyPA==
X-Gm-Message-State: APjAAAUtSBkNdWUDEjHoDIAh86JbLQ1JoLDWRFUwF6oSJ7YTRKTBkN27
        pBFtGyI+5n+DulnU7TODZNgqbA==
X-Google-Smtp-Source: APXvYqy/4a2bWJNY5YMv3zNO/PoEuxf5ZstFqs6N+vA/FlFvwlmh1bApEFi/4+4WH/75KZ0RKxMhig==
X-Received: by 2002:a2e:4704:: with SMTP id u4mr16769328lja.117.1575891701431;
        Mon, 09 Dec 2019 03:41:41 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id 192sm3656131lfh.28.2019.12.09.03.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 03:41:40 -0800 (PST)
Message-ID: <fab6a2085398941f0e37549b628f2b0d682f3ef2.camel@dubeyko.com>
Subject: Re: [PATCH v6 06/13] exfat: add exfat entry operations
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Date:   Mon, 09 Dec 2019 14:41:39 +0300
In-Reply-To: <20191209065149.2230-7-namjae.jeon@samsung.com>
References: <20191209065149.2230-1-namjae.jeon@samsung.com>
         <CGME20191209065500epcas1p2f236643696f32677b809c6bb12ce0bef@epcas1p2.samsung.com>
         <20191209065149.2230-7-namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 01:51 -0500, Namjae Jeon wrote:
> This adds the implementation of exfat entry operations for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/fatent.c | 472
> ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 472 insertions(+)
>  create mode 100644 fs/exfat/fatent.c
> 
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> new file mode 100644
> index 000000000000..0598aa2d04c1
> --- /dev/null
> +++ b/fs/exfat/fatent.c
> @@ -0,0 +1,472 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/slab.h>
> +#include <asm/unaligned.h>
> +#include <linux/buffer_head.h>
> +
> +#include "exfat_raw.h"
> +#include "exfat_fs.h"
> +
> +static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
> +		unsigned int *content)
> +{
> +	unsigned int off, _content;
> +	sector_t sec;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh;
> +
> +	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-
> 2));
> +	off = (loc << 2) & (sb->s_blocksize - 1);

It's slightly hard to follow why 2 is used here. Maybe, it makes sense
to rework the code here? I believe the constant could make this code
more easy to understand.

> +
> +	bh = sb_bread(sb, sec);
> +	if (!bh)
> +		return -EIO;
> +
> +	_content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
> +
> +	/* remap reserved clusters to simplify code */
> +	if (_content >= CLUSTER_32(0xFFFFFFF8))
> +		_content = EOF_CLUSTER;
> +
> +	*content = CLUSTER_32(_content);
> +	brelse(bh);
> +	return 0;
> +}
> +
> +int exfat_ent_set(struct super_block *sb, unsigned int loc,
> +		unsigned int content)
> +{
> +	unsigned int off;
> +	sector_t sec;
> +	__le32 *fat_entry;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh;
> +
> +	sec = sbi->FAT1_start_sector + (loc >> (sb->s_blocksize_bits-
> 2));
> +	off = (loc << 2) & (sb->s_blocksize - 1);

Ditto.

> +
> +	bh = sb_bread(sb, sec);
> +	if (!bh)
> +		return -EIO;
> +
> +	fat_entry = (__le32 *)&(bh->b_data[off]);
> +	*fat_entry = cpu_to_le32(content);
> +	exfat_update_bh(sb, bh, sb->s_flags & SB_SYNCHRONOUS);
> +	exfat_mirror_bh(sb, sec, bh);
> +	brelse(bh);
> +	return 0;
> +}
> +
> +static inline bool is_reserved_cluster(unsigned int clus)
> +{
> +	if (clus == FREE_CLUSTER || clus == EOF_CLUSTER || clus ==
> BAD_CLUSTER)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
> +		unsigned int clus)
> +{
> +	if (clus < BASE_CLUSTER || sbi->num_clusters <= clus)
> +		return false;
> +	return true;
> +}
> +
> +int exfat_ent_get(struct super_block *sb, unsigned int loc,
> +		unsigned int *content)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	int err;
> +
> +	if (!is_valid_cluster(sbi, loc)) {
> +		exfat_fs_error(sb, "invalid access to FAT (entry
> 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	err = __exfat_ent_get(sb, loc, content);
> +	if (err) {
> +		exfat_fs_error(sb,
> +			"failed to access to FAT (entry 0x%08x,
> err:%d)",
> +			loc, err);
> +		return err;
> +	}
> +
> +	if (!is_reserved_cluster(*content) &&
> +			!is_valid_cluster(sbi, *content)) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT (entry 0x%08x) bogus
> content (0x%08x)",
> +			loc, *content);
> +		return -EIO;
> +	}
> +
> +	if (*content == FREE_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT free cluster (entry
> 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +
> +	if (*content == BAD_CLUSTER) {
> +		exfat_fs_error(sb,
> +			"invalid access to FAT bad cluster (entry
> 0x%08x)",
> +			loc);
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +int exfat_chain_cont_cluster(struct super_block *sb, unsigned int
> chain,
> +		unsigned int len)
> +{
> +	if (!len)
> +		return 0;
> +
> +	while (len > 1) {
> +		if (exfat_ent_set(sb, chain, chain + 1))
> +			return -EIO;
> +		chain++;
> +		len--;
> +	}
> +
> +	if (exfat_ent_set(sb, chain, EOF_CLUSTER))
> +		return -EIO;
> +	return 0;
> +}
> +
> +int exfat_free_cluster(struct inode *inode, struct exfat_chain
> *p_chain)
> +{
> +	unsigned int num_clusters = 0;
> +	unsigned int clu;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	/* invalid cluster number */
> +	if (p_chain->dir == FREE_CLUSTER || p_chain->dir ==
> EOF_CLUSTER)
> +		return 0;
> +
> +	/* no cluster to truncate */
> +	if (p_chain->size == 0)
> +		return 0;
> +
> +	/* check cluster validation */
> +	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
> +		exfat_msg(sb, KERN_ERR, "invalid start cluster (%u)",
> +				p_chain->dir);
> +		return -EIO;
> +	}
> +
> +	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
> +	clu = p_chain->dir;
> +
> +	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +		do {
> +			exfat_clear_bitmap(inode, clu-2);

What if clu could be lesser than 2? Any gurantee of this?

> +			clu++;
> +
> +			num_clusters++;
> +		} while (num_clusters < p_chain->size);
> +	} else {
> +		do {
> +			exfat_clear_bitmap(inode, (clu -
> BASE_CLUSTER));

Ditto.

> +
> +			if (exfat_get_next_cluster(sb, &clu))
> +				goto dec_used_clus;
> +
> +			num_clusters++;
> +		} while (clu != EOF_CLUSTER);
> +	}
> +
> +dec_used_clus:
> +	sbi->used_clusters -= num_clusters;
> +	return 0;
> +}
> +
> +int exfat_find_last_cluster(struct super_block *sb, struct
> exfat_chain *p_chain,
> +		unsigned int *ret_clu)
> +{
> +	unsigned int clu, next;
> +	unsigned int count = 0;
> +
> +	next = p_chain->dir;
> +	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +		*ret_clu = next + p_chain->size - 1;
> +		return 0;
> +	}
> +
> +	do {
> +		count++;
> +		clu = next;
> +		if (exfat_ent_get(sb, clu, &next))
> +			return -EIO;
> +	} while (next != EOF_CLUSTER);
> +
> +	if (p_chain->size != count) {
> +		exfat_fs_error(sb,
> +			"bogus directory size (clus : ondisk(%d) !=
> counted(%d))",
> +			p_chain->size, count);
> +		return -EIO;
> +	}
> +
> +	*ret_clu = clu;
> +	return 0;
> +}
> +
> +static inline int exfat_sync_bhs(struct buffer_head **bhs, int
> nr_bhs)
> +{
> +	int i, err = 0;
> +
> +	for (i = 0; i < nr_bhs; i++)
> +		write_dirty_buffer(bhs[i], 0);
> +
> +	for (i = 0; i < nr_bhs; i++) {
> +		wait_on_buffer(bhs[i]);
> +		if (!err && !buffer_uptodate(bhs[i]))
> +			err = -EIO;
> +	}
> +	return err;
> +}
> +
> +int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
> +{
> +	struct super_block *sb = dir->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
> +	int nr_bhs = MAX_BUF_PER_PAGE;
> +	sector_t blknr, last_blknr;
> +	int err, i, n;
> +
> +	blknr = exfat_cluster_to_sector(sbi, clu);
> +	last_blknr = blknr + sbi->sect_per_clus;
> +
> +	if (last_blknr > sbi->num_sectors && sbi->num_sectors > 0) {
> +		exfat_fs_error_ratelimit(sb,
> +			"%s: out of range(sect:%llu len:%u)",
> +			__func__, (unsigned long long)blknr,
> +			sbi->sect_per_clus);
> +		return -EIO;
> +	}
> +
> +	/* Zeroing the unused blocks on this cluster */
> +	n = 0;
> +	while (blknr < last_blknr) {
> +		bhs[n] = sb_getblk(sb, blknr);
> +		if (!bhs[n]) {
> +			err = -ENOMEM;
> +			goto release_bhs;
> +		}
> +		memset(bhs[n]->b_data, 0, sb->s_blocksize);
> +		exfat_update_bh(sb, bhs[n], 0);
> +
> +		n++;
> +		blknr++;
> +
> +		if (n == nr_bhs) {
> +			if (IS_DIRSYNC(dir)) {
> +				err = exfat_sync_bhs(bhs, n);
> +				if (err)
> +					goto release_bhs;
> +			}
> +
> +			for (i = 0; i < n; i++)
> +				brelse(bhs[i]);
> +			n = 0;
> +		}
> +	}
> +
> +	if (IS_DIRSYNC(dir)) {
> +		err = exfat_sync_bhs(bhs, n);
> +		if (err)
> +			goto release_bhs;
> +	}
> +
> +	for (i = 0; i < n; i++)
> +		brelse(bhs[i]);
> +
> +	return 0;
> +
> +release_bhs:
> +	exfat_msg(sb, KERN_ERR, "failed zeroed sect %llu\n",
> +		(unsigned long long)blknr);
> +	for (i = 0; i < n; i++)
> +		bforget(bhs[i]);
> +	return err;
> +}
> +
> +int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
> +		struct exfat_chain *p_chain)
> +{
> +	int ret = -ENOSPC;
> +	unsigned int num_clusters = 0, total_cnt;
> +	unsigned int hint_clu, new_clu, last_clu = EOF_CLUSTER;
> +	struct super_block *sb = inode->i_sb;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	total_cnt = sbi->num_clusters - BASE_CLUSTER;
> +
> +	if (unlikely(total_cnt < sbi->used_clusters)) {
> +		exfat_fs_error_ratelimit(sb,
> +			"%s: invalid used clusters(t:%u,u:%u)\n",
> +			__func__, total_cnt, sbi->used_clusters);
> +		return -EIO;
> +	}
> +
> +	if (num_alloc > total_cnt - sbi->used_clusters)
> +		return -ENOSPC;
> +
> +	hint_clu = p_chain->dir;
> +	/* find new cluster */
> +	if (hint_clu == EOF_CLUSTER) {
> +		if (sbi->clu_srch_ptr < BASE_CLUSTER) {
> +			exfat_msg(sb, KERN_ERR,
> +				"sbi->clu_srch_ptr is invalid (%u)\n",
> +				sbi->clu_srch_ptr);
> +			sbi->clu_srch_ptr = BASE_CLUSTER;
> +		}
> +
> +		hint_clu = exfat_test_bitmap(sb,
> +				sbi->clu_srch_ptr - BASE_CLUSTER);
> +		if (hint_clu == EOF_CLUSTER)
> +			return -ENOSPC;
> +	}
> +
> +	/* check cluster validation */
> +	if (hint_clu < BASE_CLUSTER && hint_clu >= sbi->num_clusters) {
> +		exfat_msg(sb, KERN_ERR, "hint_cluster is invalid
> (%u)\n",
> +			hint_clu);
> +		hint_clu = BASE_CLUSTER;
> +		if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +			if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +					num_clusters))
> +				return -EIO;
> +			p_chain->flags = ALLOC_FAT_CHAIN;
> +		}
> +	}
> +
> +	set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
> +
> +	p_chain->dir = EOF_CLUSTER;
> +
> +	while ((new_clu = exfat_test_bitmap(sb,
> +			hint_clu - BASE_CLUSTER)) != EOF_CLUSTER) {
> +		if (new_clu != hint_clu &&
> +		    p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +			if (exfat_chain_cont_cluster(sb, p_chain->dir,
> +					num_clusters)) {
> +				ret = -EIO;
> +				goto free_cluster;
> +			}
> +			p_chain->flags = ALLOC_FAT_CHAIN;
> +		}
> +
> +		/* update allocation bitmap */
> +		if (exfat_set_bitmap(inode, new_clu - BASE_CLUSTER)) {
> +			ret = -EIO;
> +			goto free_cluster;
> +		}
> +
> +		num_clusters++;
> +
> +		/* update FAT table */
> +		if (p_chain->flags == ALLOC_FAT_CHAIN) {
> +			if (exfat_ent_set(sb, new_clu, EOF_CLUSTER)) {
> +				ret = -EIO;
> +				goto free_cluster;
> +			}
> +		}
> +
> +		if (p_chain->dir == EOF_CLUSTER) {
> +			p_chain->dir = new_clu;
> +		} else if (p_chain->flags == ALLOC_FAT_CHAIN) {
> +			if (exfat_ent_set(sb, last_clu, new_clu)) {
> +				ret = -EIO;
> +				goto free_cluster;
> +			}
> +		}
> +		last_clu = new_clu;
> +
> +		if (--num_alloc == 0) {
> +			sbi->clu_srch_ptr = hint_clu;
> +			sbi->used_clusters += num_clusters;
> +
> +			p_chain->size += num_clusters;
> +			return 0;
> +		}
> +
> +		hint_clu = new_clu + 1;
> +		if (hint_clu >= sbi->num_clusters) {
> +			hint_clu = BASE_CLUSTER;
> +
> +			if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +				if (exfat_chain_cont_cluster(sb,
> p_chain->dir,
> +						num_clusters)) {
> +					ret = -EIO;
> +					goto free_cluster;
> +				}
> +				p_chain->flags = ALLOC_FAT_CHAIN;
> +			}
> +		}
> +	}
> +free_cluster:
> +	if (num_clusters)
> +		exfat_free_cluster(inode, p_chain);
> +	return ret;
> +}
> +
> +int exfat_count_num_clusters(struct super_block *sb,
> +		struct exfat_chain *p_chain, unsigned int *ret_count)
> +{
> +	unsigned int i, count;
> +	unsigned int clu;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	if (!p_chain->dir || p_chain->dir == EOF_CLUSTER) {
> +		*ret_count = 0;
> +		return 0;
> +	}
> +
> +	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
> +		*ret_count = p_chain->size;
> +		return 0;
> +	}
> +
> +	clu = p_chain->dir;
> +	count = 0;
> +	for (i = BASE_CLUSTER; i < sbi->num_clusters; i++) {

Why does it start from BASE_CLUSTER? Maybe it makese sense to comment
this?

Thanks,
Viacheslav Dubeyko.

> +		count++;
> +		if (exfat_ent_get(sb, clu, &clu))
> +			return -EIO;
> +		if (clu == EOF_CLUSTER)
> +			break;
> +	}
> +
> +	*ret_count = count;
> +	return 0;
> +}
> +
> +int exfat_mirror_bh(struct super_block *sb, sector_t sec,
> +		struct buffer_head *bh)
> +{
> +	struct buffer_head *c_bh;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	sector_t sec2;
> +	int err = 0;
> +
> +	if (sbi->FAT2_start_sector != sbi->FAT1_start_sector) {
> +		sec2 = sec - sbi->FAT1_start_sector + sbi-
> >FAT2_start_sector;
> +		c_bh = sb_getblk(sb, sec2);
> +		if (!c_bh)
> +			return -ENOMEM;
> +		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
> +		set_buffer_uptodate(c_bh);
> +		mark_buffer_dirty(c_bh);
> +		if (sb->s_flags & SB_SYNCHRONOUS)
> +			err = sync_dirty_buffer(c_bh);
> +		brelse(c_bh);
> +	}
> +
> +	return err;
> +}

