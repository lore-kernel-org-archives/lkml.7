Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664DFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0A420856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558700043;
	bh=lQa2ZD0AkGmwV+cXHfxks/LzhDAp6FE+dRNET0zMXcw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=EoNFv4jhZ5B5rR5/dqVgMDv0BHNX6WD8E/45enHPPHqdWOTfAOyi9uhqxdeZSORHc
	 p7RY2EHK99Elz9aGFYbtKow0zplsHpAyREEv3u/FtQyvSwp3I93xnBPtZ5IOItyqK3
	 0zBUIaXuQovPDILONeJ0WTA0XU8/X87CITZCFKRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391531AbfEXMOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391244AbfEXMOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:14:01 -0400
Received: from [192.168.0.101] (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8082081C;
        Fri, 24 May 2019 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558700040;
        bh=lQa2ZD0AkGmwV+cXHfxks/LzhDAp6FE+dRNET0zMXcw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JDcueTUfpVJ8P+nuqY9xSq9C4boM6sqhbXXlEP9rwRzS8Ni9pxQEBlzVYdDKjHHNq
         JMtKa//wOioC9KirtDr/BJlTIqnuC7OvEovx5fpcT796lQy/yWuA1DcSfraYIKBeT9
         sYmkNoEpoSkmCnMnfJyAy/3gmi8lNiJj8JJ59fPw=
Subject: Re: [f2fs-dev] [PATCH] f2fs: add errors=panic mount option
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1558694631-12481-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6a4ce8cb-d9ec-1923-8304-6b8956283e85@kernel.org>
Date:   Fri, 24 May 2019 20:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558694631-12481-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-5-24 18:43, Sahitya Tummala wrote:
> Add errors=panic mount option for debugging purpose. It can be
> set dynamically when the config option CONFIG_F2FS_CHECK_FS
> is not enabled.

Sahitya,

I remember Yunlei has a similar patch for this, could you rebase your code on
that patch, if Yunlei agrees, we can add Signed-off of him.

FYI

https://sourceforge.net/p/linux-f2fs/mailman/linux-f2fs-devel/thread/f6a0b1c3-4057-8b64-a419-4b2914d48394%40kernel.org/#msg36376331

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/f2fs.h  |  9 +++++++--
>  fs/f2fs/super.c | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9b3d997..95adedb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -32,8 +32,12 @@
>  #define f2fs_bug_on(sbi, condition)					\
>  	do {								\
>  		if (unlikely(condition)) {				\
> -			WARN_ON(1);					\
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
> +			if (test_opt(sbi, ERRORS_PANIC)) {		\
> +				BUG_ON(condition);			\
> +			} else {					\
> +				WARN_ON(1);				\
> +				set_sbi_flag(sbi, SBI_NEED_FSCK);	\
> +			}						\
>  		}							\
>  	} while (0)
>  #endif
> @@ -99,6 +103,7 @@ struct f2fs_fault_info {
>  #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
>  #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
>  #define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
> +#define F2FS_MOUNT_ERRORS_PANIC		0x04000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 912e261..7d6d96a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -137,6 +137,7 @@ enum {
>  	Opt_fsync,
>  	Opt_test_dummy_encryption,
>  	Opt_checkpoint,
> +	Opt_errors,
>  	Opt_err,
>  };
>  
> @@ -196,6 +197,7 @@ enum {
>  	{Opt_fsync, "fsync_mode=%s"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
>  	{Opt_checkpoint, "checkpoint=%s"},
> +	{Opt_errors, "errors=%s"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -788,6 +790,23 @@ static int parse_options(struct super_block *sb, char *options)
>  			}
>  			kvfree(name);
>  			break;
> +		case Opt_errors:
> +#ifndef CONFIG_F2FS_CHECK_FS
> +			name = match_strdup(&args[0]);
> +			if (!name)
> +				return -ENOMEM;
> +
> +			if (strlen(name) == 5 && !strncmp(name, "panic", 5)) {
> +				set_opt(sbi, ERRORS_PANIC);
> +			} else {
> +				kvfree(name);
> +				return -EINVAL;
> +			}
> +			kvfree(name);
> +			f2fs_msg(sb, KERN_INFO,
> +				"debug mode errors=panic enabled\n");
> +#endif
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -1417,6 +1436,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",fsync_mode=%s", "strict");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
>  		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
> +	if (test_opt(sbi, ERRORS_PANIC))
> +		seq_printf(seq, ",errors=%s", "panic");
>  	return 0;
>  }
>  
> 
