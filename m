Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F1C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8600420881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfD1Cth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 22:49:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD1Ctg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 22:49:36 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 192F967446F2ADF382FE;
        Sun, 28 Apr 2019 10:49:33 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 28 Apr 2019 10:49:32 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 28 Apr 2019 10:49:32 +0800
Subject: Re: [PATCH] f2fs: Add option to limit required GC for
 checkpoint=disable
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-team@android.com>
References: <20190424012501.40811-1-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2a63da78-bc04-1a61-0889-ae50a180c330@huawei.com>
Date:   Sun, 28 Apr 2019 10:49:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190424012501.40811-1-drosen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2019/4/24 9:25, Daniel Rosenberg wrote:
> This extends the checkpoint option to allow checkpoint=disable:%u
> This allows you to specify what percent of the drive you are willing
> to lose access to while mounting with checkpoint=disable. If the amount
> lost would be higher, the mount will return -EAGAIN.
> Currently, we need to run garbage collection until the amount of holes
> is smaller than the OVP space. With the new option, f2fs can mark
> space as unusable up front instead of requiring that
> the space be freed up with garbage collection.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 +++++
>  Documentation/filesystems/f2fs.txt      |  8 +++--
>  fs/f2fs/f2fs.h                          |  6 +++-
>  fs/f2fs/segment.c                       | 17 ++++++++--
>  fs/f2fs/super.c                         | 44 +++++++++++++------------
>  fs/f2fs/sysfs.c                         | 16 +++++++++
>  6 files changed, 72 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 91822ce258317..d65b9ebc56190 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -243,3 +243,11 @@ Description:
>  		 - Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
>  		 - [h] means add/del hot file extension
>  		 - [c] means add/del cold file extension
> +
> +What:		/sys/fs/f2fs/<disk>/unusable
> +Date		April 2019
> +Contact:	"Daniel Rosenberg" <drosen@google.com>
> +Description:
> +		Displays the number of blocks that are unusable during checkpoint=disable

Maybe it will be more clear to indicate what you implement in unusable_show():

If checkpoint=enable, it displays...
If checkpoint=disable, it displays...

> +		or the number of blocks that would be unusable if checkpoint=disable
> +		were to be set.
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index f7b5e4ff0de3e..b3b5534407da7 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -214,11 +214,15 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
>                         non-atomic files likewise "nobarrier" mount option.
>  test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
>                         context. The fake fscrypt context is used by xfstests.
> -checkpoint=%s          Set to "disable" to turn off checkpointing. Set to "enable"
> +checkpoint=%s[:%u]     Set to "disable" to turn off checkpointing. Set to "enable"
>                         to reenable checkpointing. Is enabled by default. While
>                         disabled, any unmounting or unexpected shutdowns will cause
>                         the filesystem contents to appear as they did when the
> -                       filesystem was mounted with that option.
> +                       filesystem was mounted with that option. While mounting
> +                       with disabled, you may optionally add a percentage to
> +                       limit the amount of space that checkpoint=disable denies
> +                       access to. If this is set, the mount may return EAGAIN if
> +                       additional garbage collection is required to meet the limit
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 30acde08822ef..d0477251cec56 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -136,6 +136,9 @@ struct f2fs_mount_info {
>  	int alloc_mode;			/* segment allocation policy */
>  	int fsync_mode;			/* fsync policy */
>  	bool test_dummy_encryption;	/* test dummy encryption */
> +	block_t unusable_percent_cap;   /* Percent of space allowed to be
> +					 * unusable when disabling checkpoint
> +					 */
>  };
>  
>  #define F2FS_FEATURE_ENCRYPT		0x0001
> @@ -3049,7 +3052,8 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
>  void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> -int f2fs_disable_cp_again(struct f2fs_sb_info *sbi);
> +block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
> +int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
>  void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>  void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a3380d1de6000..704224f4a2866 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -869,11 +869,12 @@ void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi)
>  	mutex_unlock(&dirty_i->seglist_lock);
>  }
>  
> -int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
> +block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi)
>  {
> -	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	block_t ovp = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	block_t holes[2] = {0, 0};	/* DATA and NODE */
> +	block_t unusable;
>  	struct seg_entry *se;
>  	unsigned int segno;
>  
> @@ -887,7 +888,17 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
>  	}
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
> -	if (holes[DATA] > ovp || holes[NODE] > ovp)
> +	unusable = holes[DATA] > holes[NODE] ? holes[DATA] : holes[NODE];
> +	if (unusable > ovp)
> +		return unusable - ovp;
> +	return 0;
> +}
> +
> +int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable)
> +{
> +	block_t max_allowed =  (sbi->user_block_count / 100) *
> +			F2FS_OPTION(sbi).unusable_percent_cap;

If we allow a high unusable blocks, I doubt in inc_valid_{node,block}_count(),
we may overflow in below calculation:

	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
		valid_block_count += sbi->unusable_block_count;

	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
		avail_user_block_count -= sbi->unusable_block_count;

> +	if (unusable > max_allowed)
>  		return -EAGAIN;
>  	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
>  		dirty_segments(sbi) > overprovision_segments(sbi))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0b6fa77c35f3e..f91ec6b440f39 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -136,7 +136,9 @@ enum {
>  	Opt_alloc,
>  	Opt_fsync,
>  	Opt_test_dummy_encryption,
> -	Opt_checkpoint,
> +	Opt_checkpoint_disable,
> +	Opt_checkpoint_disable_cap,
> +	Opt_checkpoint_enable,
>  	Opt_err,
>  };
>  
> @@ -195,7 +197,9 @@ static match_table_t f2fs_tokens = {
>  	{Opt_alloc, "alloc_mode=%s"},
>  	{Opt_fsync, "fsync_mode=%s"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> -	{Opt_checkpoint, "checkpoint=%s"},
> +	{Opt_checkpoint_disable, "checkpoint=disable"},
> +	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
> +	{Opt_checkpoint_enable, "checkpoint=enable"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -771,22 +775,17 @@ static int parse_options(struct super_block *sb, char *options)
>  					"Test dummy encryption mount option ignored");
>  #endif
>  			break;
> -		case Opt_checkpoint:
> -			name = match_strdup(&args[0]);
> -			if (!name)
> -				return -ENOMEM;
> -
> -			if (strlen(name) == 6 &&
> -					!strncmp(name, "enable", 6)) {
> -				clear_opt(sbi, DISABLE_CHECKPOINT);
> -			} else if (strlen(name) == 7 &&
> -					!strncmp(name, "disable", 7)) {
> -				set_opt(sbi, DISABLE_CHECKPOINT);
> -			} else {
> -				kvfree(name);
> +		case Opt_checkpoint_disable_cap:
> +			if (args->from && match_int(args, &arg))
>  				return -EINVAL;
> -			}
> -			kvfree(name);
> +			if (arg < 0 || arg > 100)
> +				return -EINVAL;
> +			F2FS_OPTION(sbi).unusable_percent_cap = arg;
> +		case Opt_checkpoint_disable:
> +			set_opt(sbi, DISABLE_CHECKPOINT);
> +			break;
> +		case Opt_checkpoint_enable:
> +			clear_opt(sbi, DISABLE_CHECKPOINT);
>  			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
> @@ -1411,8 +1410,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",alloc_mode=%s", "reuse");
>  
>  	if (test_opt(sbi, DISABLE_CHECKPOINT))
> -		seq_puts(seq, ",checkpoint=disable");
> -
> +		seq_printf(seq, ",checkpoint=disable:%u",
> +				F2FS_OPTION(sbi).unusable_percent_cap);
>  	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>  		seq_printf(seq, ",fsync_mode=%s", "posix");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> @@ -1441,6 +1440,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, EXTENT_CACHE);
>  	set_opt(sbi, NOHEAP);
>  	clear_opt(sbi, DISABLE_CHECKPOINT);
> +	F2FS_OPTION(sbi).unusable_percent_cap = 100;

Before this patch, with checkpoint=disabe mount option, if slack free node/data
space size is large than ovp's, we will return -EAGAIN;

f2fs_disable_cp_again()

	if (holes[DATA] > ovp || holes[NODE] > ovp)
		return -EAGAIN;

But after this patch, with checkpoint=disabe mount option, it won't fail since
below condition:

f2fs_disable_cp_again()

	if (unusable > max_allowed(:=sbi->user_block_count))
		return -EAGAIN;

Thanks,

>  	sbi->sb->s_flags |= SB_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
>  	set_opt(sbi, DISCARD);
> @@ -1469,6 +1469,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	struct cp_control cpc;
>  	int err = 0;
>  	int ret;
> +	block_t unusable;
>  
>  	if (s_flags & SB_RDONLY) {
>  		f2fs_msg(sbi->sb, KERN_ERR,
> @@ -1496,7 +1497,8 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  		goto restore_flag;
>  	}
>  
> -	if (f2fs_disable_cp_again(sbi)) {
> +	unusable = f2fs_get_unusable_blocks(sbi);
> +	if (f2fs_disable_cp_again(sbi, unusable)) {
>  		err = -EAGAIN;
>  		goto restore_flag;
>  	}
> @@ -1506,7 +1508,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	set_sbi_flag(sbi, SBI_CP_DISABLED);
>  	f2fs_write_checkpoint(sbi, &cpc);
>  
> -	sbi->unusable_block_count = 0;
> +	sbi->unusable_block_count = unusable;
>  	mutex_unlock(&sbi->gc_mutex);
>  restore_flag:
>  	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 729f46a3c9ee0..fa184880cff34 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -68,6 +68,20 @@ static ssize_t dirty_segments_show(struct f2fs_attr *a,
>  		(unsigned long long)(dirty_segments(sbi)));
>  }
>  
> +static ssize_t unusable_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	block_t unusable;
> +
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		unusable = sbi->unusable_block_count;
> +	else
> +		unusable = f2fs_get_unusable_blocks(sbi);
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		(unsigned long long)unusable);
> +}
> +
> +
>  static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -440,6 +454,7 @@ F2FS_GENERAL_RO_ATTR(dirty_segments);
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>  F2FS_GENERAL_RO_ATTR(features);
>  F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> +F2FS_GENERAL_RO_ATTR(unusable);
>  
>  #ifdef CONFIG_FS_ENCRYPTION
>  F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
> @@ -495,6 +510,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(inject_type),
>  #endif
>  	ATTR_LIST(dirty_segments),
> +	ATTR_LIST(unusable),
>  	ATTR_LIST(lifetime_write_kbytes),
>  	ATTR_LIST(features),
>  	ATTR_LIST(reserved_blocks),
> 
