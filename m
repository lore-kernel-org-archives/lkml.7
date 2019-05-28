Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB5216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1knwOVCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE1RY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:24:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1RY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:24:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SHJ0w2025010;
        Tue, 28 May 2019 17:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yIR5KILMIfQyVVNhI1f1eKnl3P6dGAdoWRI/Ecl2G9w=;
 b=1knwOVCDjXAgbM8RRH9HuTFsfMwYtY6KMWqJY6TAS3dMUNOsQXPeX3UZ8eijLCvysD6N
 9v3zIJWZkwxL+o+x+Y7XvnR+ChSDRADS1uppjbWVMWMmjl/o7+QxlijZ+zkvCUjaiuN+
 hCAxbnhXZ6tCJHCNt5sYdFSSDxjBmhQ81fCr2hvB6t09nJwiDNfUi0eHLOiRW6Uho0IR
 XyS8GRMEglDvLYelaut3B+g1pU1lwJ/Y12xz+e5rgND55mf43PW4dEyJQo7CX8MEpA6J
 VlhLtJhtBo9lwNDHi+dXKl60bKfN5khMkuxQTZTVj2k1yrF42+8hWhj/h9M/SGV1cJHQ vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2spxbq4nef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 17:24:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SHMYCG070694;
        Tue, 28 May 2019 17:22:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2srbdwwvxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 17:22:34 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4SHMYbt070702;
        Tue, 28 May 2019 17:22:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdwwvxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 17:22:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4SHMWht018598;
        Tue, 28 May 2019 17:22:32 GMT
Received: from wengwanwork.cn.oracle.com (/10.211.52.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 10:22:31 -0700
Subject: Re: [Ocfs2-devel] [PATCH 1/2] ocfs2: add last unlock times in
 locking_state
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org,
        jiangqi903@gmail.com
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20190523104047.14794-1-ghe@suse.com>
From:   Wengang <wen.gang.wang@oracle.com>
Message-ID: <66083663-1d25-437b-ce98-07d200f446ab@oracle.com>
Date:   Tue, 28 May 2019 10:22:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190523104047.14794-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

This idea sounds cool!
Some comments in lines:

On 05/23/2019 03:40 AM, Gang He wrote:
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
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>   fs/ocfs2/dlmglue.c | 21 +++++++++++++++++----
>   fs/ocfs2/ocfs2.h   |  1 +
>   2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index af405586c5b1..dccf4136f8c1 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -448,7 +448,7 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>   				    struct ocfs2_mask_waiter *mw, int ret)
>   {
>   	u32 usec;
> -	ktime_t kt;
> +	ktime_t last, kt;
>   	struct ocfs2_lock_stats *stats;
>   
>   	if (level == LKM_PRMODE)
> @@ -458,7 +458,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>   	else
>   		return;
>   
> -	kt = ktime_sub(ktime_get(), mw->mw_lock_start);
> +	last = ktime_get();
Will ktime_get_real() be better than ktime_get() here?
Per description,
ktime_get:
Useful for reliable timestamps and measuring short time intervals 
accurately. Starts at system boot time but stops during suspend.
ktime_get_real:
Returns the time in relative to the UNIX epoch starting in 1970 using 
the Coordinated Universal Time (UTC), same as gettimeofday() user space.

Since ktime_get() returnis time since boot time, this value is 
meaningless when compared to those from a different node in cluster, right?

And we need a "__kernel_long_t" to rather than a "u32"?


> +	kt = ktime_sub(last, mw->mw_lock_start);
>   	usec = ktime_to_us(kt);
>   
>   	stats->ls_gets++;
> @@ -474,6 +475,8 @@ static void ocfs2_update_lock_stats(struct ocfs2_lock_res *res, int level,
>   
>   	if (ret)
>   		stats->ls_fail++;
> +
> +	stats->ls_last = ktime_to_timespec(last).tv_sec;
>   }
>   
Though maybe ocfs2_update_lock_stats() is designed to be called for each 
successful lock request,
seems current code calls it even when it returns with -EAGAIN which 
breaks the design.  That's not introduced by your change, well, it may 
lead to wrong stats...

thanks,
wengang

>   static inline void ocfs2_track_lock_refresh(struct ocfs2_lock_res *lockres)
> @@ -3093,8 +3096,10 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>    *	- Lock stats printed
>    * New in version 3
>    *	- Max time in lock stats is in usecs (instead of nsecs)
> + * New in version 4
> + *	- Add last pr/ex unlock times in secs
>    */
> -#define OCFS2_DLM_DEBUG_STR_VERSION 3
> +#define OCFS2_DLM_DEBUG_STR_VERSION 4
>   static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   {
>   	int i;
> @@ -3145,6 +3150,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   # define lock_max_prmode(_l)		((_l)->l_lock_prmode.ls_max)
>   # define lock_max_exmode(_l)		((_l)->l_lock_exmode.ls_max)
>   # define lock_refresh(_l)		((_l)->l_lock_refresh)
> +# define lock_last_prmode(_l)		((_l)->l_lock_prmode.ls_last)
> +# define lock_last_exmode(_l)		((_l)->l_lock_exmode.ls_last)
>   #else
>   # define lock_num_prmode(_l)		(0)
>   # define lock_num_exmode(_l)		(0)
> @@ -3155,6 +3162,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   # define lock_max_prmode(_l)		(0)
>   # define lock_max_exmode(_l)		(0)
>   # define lock_refresh(_l)		(0)
> +# define lock_last_prmode(_l)		(0)
> +# define lock_last_exmode(_l)		(0)
>   #endif
>   	/* The following seq_print was added in version 2 of this output */
>   	seq_printf(m, "%u\t"
> @@ -3165,6 +3174,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   		   "%llu\t"
>   		   "%u\t"
>   		   "%u\t"
> +		   "%u\t"
> +		   "%u\t"
>   		   "%u\t",
>   		   lock_num_prmode(lockres),
>   		   lock_num_exmode(lockres),
> @@ -3174,7 +3185,9 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>   		   lock_total_exmode(lockres),
>   		   lock_max_prmode(lockres),
>   		   lock_max_exmode(lockres),
> -		   lock_refresh(lockres));
> +		   lock_refresh(lockres),
> +		   lock_last_prmode(lockres),
> +		   lock_last_exmode(lockres));
>   
>   	/* End the line */
>   	seq_printf(m, "\n");
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 1f029fbe8b8d..8efa022684f4 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -164,6 +164,7 @@ struct ocfs2_lock_stats {
>   
>   	/* Storing max wait in usecs saves 24 bytes per inode */
>   	u32		ls_max;		/* Max wait in USEC */
> +	u32		ls_last;	/* Last unlock time in SEC */
>   };
>   #endif
>   

