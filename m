Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F967C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FBE208C0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 11:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X83mj4oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEELAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 07:00:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34095 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEELAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:00:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 96so1095132otf.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48u/VFU7MSPTrTtzW+FiAouzgGejJVLdqdXTQOSxm6Q=;
        b=X83mj4oP87IVJiRU3uDKZDoKixD41Te7Hv/YfMiEGHZsmMbsj9Xr6TodEtWLjluXaw
         VcHq2mooYsLTVT23a2fYaeQjgKazcJnD8FR3HpovROQfRwpY2KwXQzRqWtCF1C2A5XgW
         KbzisPbQmFPBKfHmO+jQFnCRl7TZIfpT5QkGRBhODdPec4lRhXWcUN4OC7Yd45DDT7Xx
         8F7pip8k72cYqc+Q/IXcig+u7aim7vKW9s8nYbSgvJsFbSTkRTtxrUTkrX91xYG2AuPq
         lqdkTPB+FGd91XKLxTE1G/LhfVoXO5pgp+VwyVNBJcob0SlZ0y2QmBrmUJyGTomPSrWr
         Ce3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48u/VFU7MSPTrTtzW+FiAouzgGejJVLdqdXTQOSxm6Q=;
        b=BBsXl+zPIRxbhQBdr4RzHQHuXjdaKcx4C7H1ecRYjEAslkQH5dHJQlYot8xmo5vZ+C
         QSijHfBelqcPbWt4Ke0kw42yIVJ/AfdtONPZQpx/Rlv84ty0U+805hAwFvL8T56U2XWY
         /WtSdgfF9XUVNPyx2c9nhZk1Su2xdBjzR2ODoqQfZXlbL0H5BW9CHMUEaY7pdN+9m58Z
         +YCjPkjZeBgVEJBeRFuaFo1J9pCHBJn38yZub85yQ4uFHmjrv+zg15EdyjuhoB5n6B1J
         UenMZjYJ87zUnnoyLRemxTld3g0YOjZ9A++DSysN2YpbzUUUV0kCGNX7hXGZ4hKXcBh8
         M2LA==
X-Gm-Message-State: APjAAAXWHbgU/bH/Mh8NeOI7uP/7eQZanwIHZWgkGrBag+BZVZUTFt2A
        pLZ3DQkfNYPBVAlP7tAoqBZ4orMK
X-Google-Smtp-Source: APXvYqxI1Rom9s4CD31U6I7xBB1IbV/3bMnpPiNiZ6WR7LJdc2WoUR9/nHxBgX8Kio6VE348lWQrfQ==
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr13211601oto.355.1557054011796;
        Sun, 05 May 2019 04:00:11 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.8])
        by smtp.gmail.com with ESMTPSA id h8sm2831445oti.64.2019.05.05.04.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 04:00:10 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] ocfs2: add locking filter debugfs file
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20190505101316.17601-1-ghe@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <70129725-0a7e-64a5-9583-81e268e26c21@gmail.com>
Date:   Sun, 5 May 2019 19:00:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505101316.17601-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/5/5 18:13, Gang He wrote:
> Add locking filter debugfs file, which is used to filter lock
> resources dump from locking_state debugfs file.
> We use d_filter_secs field to filter lock resources dump,
> the default d_filter_secs(0) value filters nothing,
> otherwise, only dump the last N seconds active lock resources.
> This enhancement can avoid dumping lots of old records.
> The d_filter_secs value can be changed via locking_filter file.
> 
> Compared with v2, ocfs2_dlm_init_debug() returns directly with
> error when creating locking filter debugfs file is failed, since
> ocfs2_dlm_shutdown_debug() will handle this failure perfectly.
> Compared with v1, the main change is to add CONFIG_OCFS2_FS_STATS
> macro definition judgment.
> 
> Signed-off-by: Gang He <ghe@suse.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlmglue.c | 36 ++++++++++++++++++++++++++++++++++++
>  fs/ocfs2/ocfs2.h   |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index dccf4136f8c1..fbe4562cf4fe 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3006,6 +3006,8 @@ struct ocfs2_dlm_debug *ocfs2_new_dlm_debug(void)
>  	kref_init(&dlm_debug->d_refcnt);
>  	INIT_LIST_HEAD(&dlm_debug->d_lockres_tracking);
>  	dlm_debug->d_locking_state = NULL;
> +	dlm_debug->d_locking_filter = NULL;
> +	dlm_debug->d_filter_secs = 0;
>  out:
>  	return dlm_debug;
>  }
> @@ -3104,11 +3106,33 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  {
>  	int i;
>  	char *lvb;
> +	u32 now, last = 0;
>  	struct ocfs2_lock_res *lockres = v;
> +	struct ocfs2_dlm_debug *dlm_debug =
> +			((struct ocfs2_dlm_seq_priv *)m->private)->p_dlm_debug;
>  
>  	if (!lockres)
>  		return -EINVAL;
>  
> +	if (dlm_debug->d_filter_secs) {
> +		now = ktime_to_timespec(ktime_get()).tv_sec;
> +#ifdef CONFIG_OCFS2_FS_STATS
> +		if (lockres->l_lock_prmode.ls_last >
> +		    lockres->l_lock_exmode.ls_last)
> +			last = lockres->l_lock_prmode.ls_last;
> +		else
> +			last = lockres->l_lock_exmode.ls_last;
> +#endif
> +		/*
> +		 * Use d_filter_secs field to filter lock resources dump,
> +		 * the default d_filter_secs(0) value filters nothing,
> +		 * otherwise, only dump the last N seconds active lock
> +		 * resources.
> +		 */
> +		if ((now - last) > dlm_debug->d_filter_secs)
> +			return 0;
> +	}
> +
>  	seq_printf(m, "0x%x\t", OCFS2_DLM_DEBUG_STR_VERSION);
>  
>  	if (lockres->l_type == OCFS2_LOCK_TYPE_DENTRY)
> @@ -3258,6 +3282,17 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super *osb)
>  		goto out;
>  	}
>  
> +	dlm_debug->d_locking_filter = debugfs_create_u32("locking_filter",
> +						0600,
> +						osb->osb_debug_root,
> +						&dlm_debug->d_filter_secs);
> +	if (!dlm_debug->d_locking_filter) {
> +		ret = -EINVAL;
> +		mlog(ML_ERROR,
> +		     "Unable to create locking filter debugfs file.\n");
> +		goto out;
> +	}
> +
>  	ocfs2_get_dlm_debug(dlm_debug);
>  out:
>  	return ret;
> @@ -3269,6 +3304,7 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
>  
>  	if (dlm_debug) {
>  		debugfs_remove(dlm_debug->d_locking_state);
> +		debugfs_remove(dlm_debug->d_locking_filter);
>  		ocfs2_put_dlm_debug(dlm_debug);
>  	}
>  }
> diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
> index 8efa022684f4..f4da51099889 100644
> --- a/fs/ocfs2/ocfs2.h
> +++ b/fs/ocfs2/ocfs2.h
> @@ -237,6 +237,8 @@ struct ocfs2_orphan_scan {
>  struct ocfs2_dlm_debug {
>  	struct kref d_refcnt;
>  	struct dentry *d_locking_state;
> +	struct dentry *d_locking_filter;
> +	u32 d_filter_secs;
>  	struct list_head d_lockres_tracking;
>  };
>  
> 
