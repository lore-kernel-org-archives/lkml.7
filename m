Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5552DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E64625A10
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559224921;
	bh=dxgLKyo8opa8cx62Gn4ueciBtQ7cpnCdaxk3jkJYS0c=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=a/JMO+jsOm5TupasU1aApNiyQOttlMqcfw1VmFoKj+P1nO/GEje0mEaBgYNGVfktU
	 KdiC3CarN7It1R5IIuneWRzLONxf1OsgMfMFvmYg1duAuaHSX26KoiM2ZDJRz/j1BX
	 isBzeEjl+jP1PlIDeCc+eyJwt4RwSXXLZUa7fzt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfE3OCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfE3OB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:01:59 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A059425A09;
        Thu, 30 May 2019 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559224918;
        bh=dxgLKyo8opa8cx62Gn4ueciBtQ7cpnCdaxk3jkJYS0c=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DsmGlULR2oEWl1qar4mJJ9jWAeosF/eNOAJQpKu2K8xqugpP0/bHl8XN+Aqqqm52q
         /fh7hlO713/4tyhVPzCCnSrP/z9HgQNUKkaetvJZok5lwffufBiurAeLt44Et+fjhl
         CHts+kFjvSiPwYTRO2RRFWzAe+0BVMUXMtl4fPz0=
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a rw_sem to cover quota flag changes
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190530033115.16853-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a7f6a65e-65c2-51bb-0c9a-84367ca04e44@kernel.org>
Date:   Thu, 30 May 2019 22:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190530033115.16853-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-30 11:31, Jaegeuk Kim wrote:
> thread 1:                        thread 2:
> writeback                        checkpoint
> set QUOTA_NEED_FLUSH
>                                  clear QUOTA_NEED_FLUSH
> f2fs_dquot_commit
> dquot_commit
> clear_dquot_dirty
>                                  f2fs_quota_sync
>                                  dquot_writeback_dquots
> 				 nothing to commit
> commit_dqblk
> quota_write
> f2fs_quota_write
> waiting for f2fs_lock_op()
> 				 pass __need_flush_quota
>                                  (no F2FS_DIRTY_QDATA)

At a glance, will it cause deadlock:

- f2fs_dquot_commit
 - down_read(&sbi->quota_sem)
					- block_operation
					 - f2fs_lock_all
					  - need_flush_quota
					   - down_write(&sbi->quota_sem)
  - f2fs_quota_write
   - f2fs_lock_op

Thanks,

> 
> -> up-to-date quota is not written
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 26 ++++++++++++++++----------
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/super.c      | 27 ++++++++++++++++++++++-----
>  3 files changed, 39 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 89825261d474..cf3b15c963d2 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1131,17 +1131,23 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
>  
>  static bool __need_flush_quota(struct f2fs_sb_info *sbi)
>  {
> +	bool ret = false;
> +
> +	down_write(&sbi->quota_sem);
>  	if (!is_journalled_quota(sbi))
> -		return false;
> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> -		return false;
> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> -		return false;
> -	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
> -		return true;
> -	if (get_pages(sbi, F2FS_DIRTY_QDATA))
> -		return true;
> -	return false;
> +		ret = false;
> +	else if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> +		ret = false;
> +	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> +		ret = false;
> +	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
> +		ret = true;
> +	else if (get_pages(sbi, F2FS_DIRTY_QDATA))
> +		ret = true;
> +	else
> +		ret = false;
> +	up_write(&sbi->quota_sem);
> +	return ret;
>  }
>  
>  /*
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9b3d9977cd1e..692c0922f5b2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1250,6 +1250,7 @@ struct f2fs_sb_info {
>  	block_t unusable_block_count;		/* # of blocks saved by last cp */
>  
>  	unsigned int nquota_files;		/* # of quota sysfile */
> +	struct rw_semaphore quota_sem;		/* blocking cp for flags */
>  
>  	/* # of pages, see count_type */
>  	atomic_t nr_pages[NR_COUNT_TYPE];
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 912e2619d581..5ddf5e97ee60 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1944,7 +1944,10 @@ int f2fs_quota_sync(struct super_block *sb, int type)
>  	int cnt;
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_writeback_dquots(sb, type);
> +	up_read(&sbi->quota_sem);
> +
>  	if (ret)
>  		goto out;
>  
> @@ -2074,32 +2077,40 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
>  
>  static int f2fs_dquot_commit(struct dquot *dquot)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_commit(dquot);
>  	if (ret < 0)
> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +	up_read(&sbi->quota_sem);
>  	return ret;
>  }
>  
>  static int f2fs_dquot_acquire(struct dquot *dquot)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_acquire(dquot);
>  	if (ret < 0)
> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> -
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +	up_read(&sbi->quota_sem);
>  	return ret;
>  }
>  
>  static int f2fs_dquot_release(struct dquot *dquot)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_release(dquot);
>  	if (ret < 0)
> -		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +	up_read(&sbi->quota_sem);
>  	return ret;
>  }
>  
> @@ -2109,22 +2120,27 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_mark_dquot_dirty(dquot);
>  
>  	/* if we are using journalled quota */
>  	if (is_journalled_quota(sbi))
>  		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
>  
> +	up_read(&sbi->quota_sem);
>  	return ret;
>  }
>  
>  static int f2fs_dquot_commit_info(struct super_block *sb, int type)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	int ret;
>  
> +	down_read(&sbi->quota_sem);
>  	ret = dquot_commit_info(sb, type);
>  	if (ret < 0)
> -		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +	up_read(&sbi->quota_sem);
>  	return ret;
>  }
>  
> @@ -3233,6 +3249,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	}
>  
>  	init_rwsem(&sbi->cp_rwsem);
> +	init_rwsem(&sbi->quota_sem);
>  	init_waitqueue_head(&sbi->cp_wait);
>  	init_sb_info(sbi);
>  
> 
