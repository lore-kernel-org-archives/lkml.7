Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4015206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbNumE6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfDZBV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:21:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38237 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDZBV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:21:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id a6so1657906oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 18:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+5XaGkslAC7Nfu7QQlAX3+U3QeV8oWxTTnK+iESO9U=;
        b=GbNumE6inrd1Dvh2cZ+4uUuxtmU5DbFlj7/gNfo5gYw0cxnQEuwkcWF6RDfwaBMXv+
         g+4K04+ng0qi97cGFBGe0+7qIKi6iuQ2CJXo/CGcPtfwdRGgNdPca56Je0Bo/ySNfnGS
         QYWTqaftYNVJI0Ch+pL4F2QxsAm8+BLQbdx0pobF+LkBk2UWnidz7banwQJJ+V+4PJDb
         vg+40rCNeHl0Ie3akL2DGhrzZZc0rrPT6FyKQk7/EYJz+bxPu/oxhlNjbdCwpO23L8p9
         hy8lPIoy1q6SYYBEB73EMFtGpBnAKKoJgrhzlMmYXf6q1taUxm+lEVpBTCdx7a30lKZn
         Dwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+5XaGkslAC7Nfu7QQlAX3+U3QeV8oWxTTnK+iESO9U=;
        b=SrZ3ZgChMFL1KRUX3DB3wPjwezg8SQTk/3zpWqpJkiOc24mqyNqj51TfJZtxX11K5P
         KFXZFIu/STTmMO7JTSqVRQdH73OXLmjSdhi3QFCU2oDHFP4j1HSpCpXMTbK0ZA81ehp/
         cgJ3WdAxI/0vVFrGg9q6QD8bKoU6AuJzV8ICAPpFYqr/7tR3JhENSQCNuvAbyhhd2W9a
         mg1/Ziokkg90HTC6jNxXO7H+w9gsWchGMhe8pVzc6/Y6sFavkoordIhD0Ic1yg6LhsQY
         QF6Yb2wVQW3aWzt//NkmHRTvyBStm4l22A8yaAbsBm6CN7xsIACM+1FDrUSRmp2kwPJX
         9jWg==
X-Gm-Message-State: APjAAAUVBBUyZncW9WFRx77AIzAk8+9N70U3i/pP1vc/jZgJMtPpuWlI
        aHpz8kZvi/YI3i1P8pJp9WW82XDDj70=
X-Google-Smtp-Source: APXvYqyg1oWJTzIC0kgDuIHbbzDXMGKw5dnJDD7hmZ16ZQl9SmyyWtSFWqhx5VhI46APpPkkT2tUcQ==
X-Received: by 2002:aca:bac2:: with SMTP id k185mr5557529oif.85.1556241684921;
        Thu, 25 Apr 2019 18:21:24 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.13])
        by smtp.gmail.com with ESMTPSA id b17sm9867939otq.26.2019.04.25.18.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 18:21:23 -0700 (PDT)
Subject: Re: [PATCH] ocfs2: add last unlock times in locking_state
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20190425091250.3625-1-ghe@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <c855abce-d62c-5fe0-3b31-c252077b4530@gmail.com>
Date:   Fri, 26 Apr 2019 09:21:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425091250.3625-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

On 19/4/25 17:12, Gang He wrote:
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

Why not usecs?
BTW, should we change tools side like debugfs as well?

Thanks,
Joseph

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
