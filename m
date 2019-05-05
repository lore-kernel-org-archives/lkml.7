Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF467C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F902082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 06:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufspmlRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfEEGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 02:54:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35008 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfEEGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 02:54:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id w197so7428599oia.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9+AItJb59EJLrO+o5ejyqZ+uN8Wx8YTWSUaDDbRPOg=;
        b=ufspmlRvDfBh8u7xJrA7ILKhSxFuQNI2292vOFdjl9cPo1awXwoZiE3YvjDqLPVelr
         KpO4aMCvSYxdvqqU3Gke/D6fjriAPD+PCm92ykeyCekisbXsoEKo4NDAQ4YacfNoyydx
         nlADgpoJ/On8UBLGsC7MssDrOwrVs/SfnVUYJAUqY0BdoSXSwxRRHqNSSQQmYKGGk5na
         1EX94DACdI9CeSI+tXtekZwwPXYDETopAncPQS83rkZWh7hB7l1SSGtmOZUKRMCV1g/K
         1IUiZt6KlhvdncxWO4RjQZgliLh388/l7L0YShewSCxGsx1POIqTl+3dOK4rjL014RKT
         HylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9+AItJb59EJLrO+o5ejyqZ+uN8Wx8YTWSUaDDbRPOg=;
        b=OWHBlw4fp+LqO7Uhgi0Q0a8lPQsLxx3SLSo5VBnzw4AjyYaqpi1HA6ZBGXyvdLWCi+
         ILr20YZDQXhaz3RdXGKKAgGdZeSPWufHTRbo3Isx6d7pf/EZwiTPL+s+aqMPjR+NtUVk
         rohF7PvnRmH66+nGoJ1A46icyjvdXE+pYxN6V/CzMj/8bqMy8oFuhCxGx0hIVhvFOIhH
         cBy1LWt8jXdRvW4F2oCfKyZEwrVT1rgCX3y974tclLoK38m8G3RPMXtVOdzfn5KAhAku
         pIY9Bs7Ke2MkbHUiQizzHt9uokbmAjgDtqDjSq97BGA/eKs2fd7qINpXtvp5Trmms6DJ
         mCUw==
X-Gm-Message-State: APjAAAUjQ7TdWhQcKYpWBETX6GQrEJPTYQRmqViWT20TEfZQwPcL3O2z
        lMzNibTlgnKgM6L6co5yU60=
X-Google-Smtp-Source: APXvYqzrKH+eKSD9fGv6+v5f5ehIxMpQ4VV9dGGvTLgm9zrHsdmPAanf2LrHpUvaE1rx+R16Y5vnwQ==
X-Received: by 2002:aca:3746:: with SMTP id e67mr4555404oia.37.1557039278482;
        Sat, 04 May 2019 23:54:38 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.8])
        by smtp.gmail.com with ESMTPSA id j22sm446378oib.39.2019.05.04.23.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 23:54:37 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] ocfs2: add locking filter debugfs file
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20190429083353.1410-1-ghe@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <f65e80e4-c99c-c84f-30c1-65991aec4da7@gmail.com>
Date:   Sun, 5 May 2019 14:54:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429083353.1410-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gang,

On 19/4/29 16:33, Gang He wrote:
> Add locking filter debugfs file, which is used to filter lock
> resources dump from locking_state debugfs file.
> We use d_filter_secs field to filter lock resources dump,
> the default d_filter_secs(0) value filters nothing,
> otherwise, only dump the last N seconds active lock resources.
> This enhancement can avoid dumping lots of old records.
> The d_filter_secs value can be changed via locking_filter file.
> 
> Compared with v1, the main change is to add CONFIG_OCFS2_FS_STATS
> macro definition judgment.
> 
> Signed-off-by: Gang He <ghe@suse.com>
> ---
>  fs/ocfs2/dlmglue.c | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/ocfs2/ocfs2.h   |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index dccf4136f8c1..554d37d52510 100644
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
> @@ -3258,6 +3282,19 @@ static int ocfs2_dlm_init_debug(struct ocfs2_super *osb)
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
> +		debugfs_remove(dlm_debug->d_locking_state);
> +		dlm_debug->d_locking_state = NULL;

Or we can just leave this cleanup for ocfs2_dlm_shutdown_debug()?

Thanks,
Joseph

> +		goto out;
> +	}
> +
>  	ocfs2_get_dlm_debug(dlm_debug);
>  out:
>  	return ret;
> @@ -3269,6 +3306,7 @@ static void ocfs2_dlm_shutdown_debug(struct ocfs2_super *osb)
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
