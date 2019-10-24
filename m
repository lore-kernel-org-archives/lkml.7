Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32555CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BA12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438128AbfJXIVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:21:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4755 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfJXIVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:21:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 267BE4A602E9EB09D807;
        Thu, 24 Oct 2019 16:21:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 24 Oct
 2019 16:21:38 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: support aligned pinned file
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c916c749-0abe-a7b7-e748-f0c4d5599e4a@huawei.com>
Date:   Thu, 24 Oct 2019 16:21:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191022171602.93637-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On 2019/10/23 1:16, Jaegeuk Kim wrote:
> This patch supports 2MB-aligned pinned file, which can guarantee no GC at all
> by allocating fully valid 2MB segment.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h     |  4 +++-
>  fs/f2fs/file.c     | 39 ++++++++++++++++++++++++++++++++++-----
>  fs/f2fs/recovery.c |  2 +-
>  fs/f2fs/segment.c  | 21 ++++++++++++++++++++-
>  fs/f2fs/segment.h  |  2 ++
>  fs/f2fs/super.c    |  1 +
>  fs/f2fs/sysfs.c    |  2 ++
>  7 files changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ca342f4c7db1..c681f51e351b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -890,6 +890,7 @@ enum {
>  	CURSEG_WARM_NODE,	/* direct node blocks of normal files */
>  	CURSEG_COLD_NODE,	/* indirect node blocks */
>  	NO_CHECK_TYPE,
> +	CURSEG_COLD_DATA_PINNED,/* cold data for pinned file */
>  };
>  
>  struct flush_cmd {
> @@ -1301,6 +1302,7 @@ struct f2fs_sb_info {
>  
>  	/* threshold for gc trials on pinned files */
>  	u64 gc_pin_file_threshold;
> +	struct rw_semaphore pin_sem;
>  
>  	/* maximum # of trials to find a victim segment for SSR and GC */
>  	unsigned int max_victim_search;
> @@ -3116,7 +3118,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>  void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>  					unsigned int start, unsigned int end);
> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type);
>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>  bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 29bc0a542759..f6c038e8a6a7 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1545,12 +1545,41 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  	if (off_end)
>  		map.m_len++;
>  
> -	if (f2fs_is_pinned_file(inode))
> -		map.m_seg_type = CURSEG_COLD_DATA;
> +	if (!map.m_len)
> +		return 0;
> +
> +	if (f2fs_is_pinned_file(inode)) {
> +		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
> +					sbi->log_blocks_per_seg;
> +		block_t done = 0;
> +
> +		if (map.m_len % sbi->blocks_per_seg)
> +			len += sbi->blocks_per_seg;
>  
> -	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
> -						F2FS_GET_BLOCK_PRE_DIO :
> -						F2FS_GET_BLOCK_PRE_AIO));
> +		map.m_len = sbi->blocks_per_seg;
> +next_alloc:
> +		mutex_lock(&sbi->gc_mutex);
> +		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> +		if (err && err != -ENODATA && err != -EAGAIN)
> +			goto out_err;

To grab enough free space?

Shouldn't we call

	if (has_not_enough_free_secs(sbi, 0, 0)) {
		mutex_lock(&sbi->gc_mutex);
		f2fs_gc(sbi, false, false, NULL_SEGNO);
	}

> +
> +		down_write(&sbi->pin_sem);
> +		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
> +		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
> +		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
> +		up_write(&sbi->pin_sem);
> +
> +		done += map.m_len;
> +		len -= map.m_len;
> +		map.m_lblk += map.m_len;
> +		if (!err && len)
> +			goto next_alloc;
> +
> +		map.m_len = done;
> +	} else {
> +		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
> +	}
> +out_err:
>  	if (err) {
>  		pgoff_t last_off;
>  
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 783773e4560d..76477f71d4ee 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -711,7 +711,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
>  		f2fs_put_page(page, 1);
>  	}
>  	if (!err)
> -		f2fs_allocate_new_segments(sbi);
> +		f2fs_allocate_new_segments(sbi, NO_CHECK_TYPE);
>  	return err;
>  }
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 25c750cd0272..253d72c2663c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2690,7 +2690,7 @@ void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>  	up_read(&SM_I(sbi)->curseg_lock);
>  }
>  
> -void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
> +void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct curseg_info *curseg;
>  	unsigned int old_segno;
> @@ -2699,6 +2699,9 @@ void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
>  	down_write(&SIT_I(sbi)->sentry_lock);
>  
>  	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> +		if (type != NO_CHECK_TYPE && i != type)
> +			continue;
> +
>  		curseg = CURSEG_I(sbi, i);
>  		old_segno = curseg->segno;
>  		SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
> @@ -3068,6 +3071,19 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
>  	struct curseg_info *curseg = CURSEG_I(sbi, type);
> +	bool put_pin_sem = false;
> +
> +	if (type == CURSEG_COLD_DATA) {
> +		/* GC during CURSEG_COLD_DATA_PINNED allocation */
> +		if (down_read_trylock(&sbi->pin_sem)) {
> +			put_pin_sem = true;
> +		} else {
> +			type = CURSEG_WARM_DATA;
> +			curseg = CURSEG_I(sbi, type);

It will mix pending cold data into warm area... rather than recovering curseg to
write pointer of last cold segment?

I know maybe that fallocate aligned address could be corner case, but I guess
there should be some better solutions can handle race case more effectively.

One solution could be: allocating a virtual log header to select free segment as
2m-aligned space target.

Thanks,

> +		}
> +	} else if (type == CURSEG_COLD_DATA_PINNED) {
> +		type = CURSEG_COLD_DATA;
> +	}
>  
>  	down_read(&SM_I(sbi)->curseg_lock);
>  
> @@ -3133,6 +3149,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	mutex_unlock(&curseg->curseg_mutex);
>  
>  	up_read(&SM_I(sbi)->curseg_lock);
> +
> +	if (put_pin_sem)
> +		up_read(&sbi->pin_sem);
>  }
>  
>  static void update_device_state(struct f2fs_io_info *fio)
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 325781a1ae4d..a95467b202ea 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -313,6 +313,8 @@ struct sit_entry_set {
>   */
>  static inline struct curseg_info *CURSEG_I(struct f2fs_sb_info *sbi, int type)
>  {
> +	if (type == CURSEG_COLD_DATA_PINNED)
> +		type = CURSEG_COLD_DATA;
>  	return (struct curseg_info *)(SM_I(sbi)->curseg_array + type);
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f320fd11db48..c02a47ce551b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2853,6 +2853,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	spin_lock_init(&sbi->dev_lock);
>  
>  	init_rwsem(&sbi->sb_lock);
> +	init_rwsem(&sbi->pin_sem);
>  }
>  
>  static int init_percpu_info(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index b558b64a4c9c..f164959e4224 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -154,6 +154,8 @@ static ssize_t features_show(struct f2fs_attr *a,
>  	if (f2fs_sb_has_casefold(sbi))
>  		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "casefold");
> +	len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "pin_file");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>  	return len;
>  }
> 
