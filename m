Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B011C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8544206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slc9fyOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEEGrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:47:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42086 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:47:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so7324285oig.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1qtzkFXaelneSWhU8a639u8F4WomAkSaJKV/SMpZhM8=;
        b=Slc9fyOJLeEwCIEPgDUgB8LSN8em/sYyUtDztIrNxe428k46uhWsr8sRCpGo59OPZq
         ZyYziEYo1QtHJguVYPt1Y1CLzt2/crae4aI8bit3vWEpiDRtOCIHcoZRBAoL6PRhidbB
         P3oFAU4nKNRp7JiYzJPb/N8msj59E5AdeC9hcL+9caDReBuUC6aZq0899gsyYik52NpI
         F+9wjKH0W7UYuZf1hetre6miGnCChqy7VFNqnVw250BY80JWRb4jGzqWYBCvh1lyWagD
         axecXm6Ig1eVOgcaU80wbRBKVIQBX/UKfXwgmdgknk2jm+5QKOaqeaHRJxG0BlZ0PZTU
         dyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qtzkFXaelneSWhU8a639u8F4WomAkSaJKV/SMpZhM8=;
        b=GVzrDR8LA4A4EGU9o0oU1qO4rEHu5ugptbjyp08A9zlY0YiVPN1hjOeIYyZ/GMuDHi
         XglXmaLtMgvFZq/x5zRbOBkCgnjlL2Gv8wzJ6UBMKAc5x6PfJpzqj8LQm1VGN5kl/j6e
         2mUakWRd5DeTAEv3hzIQ8Y1a6HBeTXl7etstl0teQiE3zmqdR/J/QzhLYJQwH9nM1Efa
         ZxbHLp0wiLvBDZSTiA0T4sW1clwjDP3pxC2j4ujGf9tVu89ckaSe2/JZpwZlEjsrLIz3
         lbBvQKiOiQ74jURyen9jfFcVC6/GMpqDLUdCpZ7f51njwhniFSoTuDyLsMML+R1rbO2I
         sffg==
X-Gm-Message-State: APjAAAWz4lg3X8zfQqkjXbn5uv3LAFTN05xgzh2XreA8dgO4mDCYyh2x
        IIeDCRV6mRUAmci2fTNo8h0=
X-Google-Smtp-Source: APXvYqwZjlzGjqKVzqPzCkjeEX98VXmpsF9jfEWT143Krra6+1PkbE2RzR6guF54MIMck7IAxohung==
X-Received: by 2002:aca:e38f:: with SMTP id a137mr4783125oih.87.1557038864343;
        Sat, 04 May 2019 23:47:44 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.8])
        by smtp.gmail.com with ESMTPSA id x197sm1402140oia.14.2019.05.04.23.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 23:47:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] ocfs2: add last unlock times in locking_state
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20190429064613.29365-1-ghe@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <ca92aad8-ccea-fca6-4ebc-da7e4041caf8@gmail.com>
Date:   Sun, 5 May 2019 14:47:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429064613.29365-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/4/29 14:46, Gang He wrote:
> ocfs2 file system uses locking_state file under debugfs to dump
> each ocfs2 file system's dlm lock resources, but the dlm lock
> resources in memory are becoming more and more after the files
> were touched by the user. it will become a bit difficult to analyze
> these dlm lock resource records in locking_state file by the upper
> scripts, though some files are not active for now, which were
> accessed long time ago.
> Then, I'd like to add last pr/ex unlock times in locking_state file
> for each dlm lock resource record, the the upper scripts can use
> last unlock time to filter inactive dlm lock resource record.
> 
> Signed-off-by: Gang He <ghe@suse.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlmglue.c | 21 +++++++++++++++++----
>  fs/ocfs2/ocfs2.h   |  1 +
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index af405586c5b1..dccf4136f8c1 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -448,7 +448,7 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>  				    struct ocfs2_mask_waiter *mw, int ret)
>  {
>  	u32 usec;
> -	ktime_t kt;
> +	ktime_t last, kt;
>  	struct ocfs2_lock_stats *stats;
>  
>  	if (level == LKM_PRMODE)
> @@ -458,7 +458,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>  	else
>  		return;
>  
> -	kt = ktime_sub(ktime_get(), mw->mw_lock_start);
> +	last = ktime_get();
> +	kt = ktime_sub(last, mw->mw_lock_start);
>  	usec = ktime_to_us(kt);
>  
>  	stats->ls_gets++;
> @@ -474,6 +475,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>  
>  	if (ret)
>  		stats->ls_fail++;
> +
> +	stats->ls_last = ktime_to_timespec(last).tv_sec;
>  }
>  
>  static inline void ocfs2_track_lock_refresh(struct ocfs2_lock_res *lockres)
> @@ -3093,8 +3096,10 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>   *	- Lock stats printed
>   * New in version 3
>   *	- Max time in lock stats is in usecs (instead of nsecs)
> + * New in version 4
> + *	- Add last pr/ex unlock times in secs
>   */
> -#define OCFS2_DLM_DEBUG_STR_VERSION 3
> +#define OCFS2_DLM_DEBUG_STR_VERSION 4
>  static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  {
>  	int i;
> @@ -3145,6 +3150,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  # define lock_max_prmode(_l)		((_l)->l_lock_prmode.ls_max)
>  # define lock_max_exmode(_l)		((_l)->l_lock_exmode.ls_max)
>  # define lock_refresh(_l)		((_l)->l_lock_refresh)
> +# define lock_last_prmode(_l)		((_l)->l_lock_prmode.ls_last)
> +# define lock_last_exmode(_l)		((_l)->l_lock_exmode.ls_last)
>  #else
>  # define lock_num_prmode(_l)		(0)
>  # define lock_num_exmode(_l)		(0)
> @@ -3155,6 +3162,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  # define lock_max_prmode(_l)		(0)
>  # define lock_max_exmode(_l)		(0)
>  # define lock_refresh(_l)		(0)
> +# define lock_last_prmode(_l)		(0)
> +# define lock_last_exmode(_l)		(0)
>  #endif
>  	/* The following seq_print was added in version 2 of this output */
>  	seq_printf(m, "%u\t"
> @@ -3165,6 +3174,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  		   "%llu\t"
>  		   "%u\t"
>  		   "%u\t"
> +		   "%u\t"
> +		   "%u\t"
>  		   "%u\t",
>  		   lock_num_prmode(lockres),
>  		   lock_num_exmode(lockres),
> @@ -3174,7 +3185,9 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  		   lock_total_exmode(lockres),
>  		   lock_max_prmode(lockres),
>  		   lock_max_exmode(lockres),
> -		   lock_refresh(lockres));
> +		   lock_refresh(lockres),
> +		   lock_last_prmode(lockres),
> +		   lock_last_exmode(lockres));
>  
>  	/* End the line */
>  	seq_printf(m, "\n");
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 1f029fbe8b8d..8efa022684f4 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -164,6 +164,7 @@ struct ocfs2_lock_stats {
>  
>  	/* Storing max wait in usecs saves 24 bytes per inode */
>  	u32		ls_max;		/* Max wait in USEC */
> +	u32		ls_last;	/* Last unlock time in SEC */
>  };
>  #endif
>  
> 
