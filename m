Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC69C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196CA20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="j9c62XFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfGJTLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:11:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33851 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfGJTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:11:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1697861plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RBKExhVhuO8dUwdopkobYrfDp83fiSSvdj+BjPC70s=;
        b=j9c62XFEZ9kneeuEMtK85d/vkG2d0b3HHa2TZlXsQSuaSKSRug6eb1bl4cKUZZkmJK
         6IS8RZlqzhzFjwNz+zV5QgphhyNsbooUbliEaAnL4/k7y78mowllauMGCE5dCXCUR5+L
         thZKWFHCr6OTl+X4yZ6gTpNHZ3qUDwhE+4uFb5Kl6OwMqJTXO/DGXzNq1TGMG1BZkTdw
         HGxldShXjkSPmX1j5S9pdclx8uY3JXY7bNK29ZFVh0twxvORyjed8MOPePpt96DK/DaI
         5BDryfetRewi2JhNcZ3WsMMVy0mvAAX2JwEk1fsuD/9i0kMVR5sAqIqGyMl0WVWas+N/
         NEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RBKExhVhuO8dUwdopkobYrfDp83fiSSvdj+BjPC70s=;
        b=mVJJY0UeQeZ9MKJAa6VAHUvKZcoJ6LZ4ldpgMOoo/voIl1/8H36bIBkociWll5v1gI
         q3XDBPw9/55jspvmlJSnf+2jIeNapzkCuwMpvuG4D42w7kiZULWBge+Ia1nbrgL2fSEK
         lvbr41eT27lY/Xa/RmEp/GwSwQTyrJiuP86RzXX1chWkNNar+qkDdevOvOem8936w/Hz
         gmQSeFuF/xVKozYpou7w/5dWv7OX8tjs2IT4mKSjWQYsB4izBdWX3AHNk/h67dksxD9X
         haaTZUtXacwqYX7HGlqlFC16uSSly74/Bt6KtITAGAq2oRy6x2fpSu56iWqQT2QmAKUn
         +tNg==
X-Gm-Message-State: APjAAAXFQPbZJ5wr2qFpgcA6pWVF9rkUJXeKYI1hEO2q9IeNzHaOuqxT
        4uo5VlhqmgJJQDA+5uuj7WRCzQ==
X-Google-Smtp-Source: APXvYqzFRRFWfxpescU3C0myEwOeav3RIPv9v2eiOwcuRGi+UKzV4Z/k6Bf+F4vc1CD5unHTdPoy5A==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr40889083plq.12.1562785878616;
        Wed, 10 Jul 2019 12:11:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id t11sm3066474pgb.33.2019.07.10.12.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:11:17 -0700 (PDT)
Date:   Wed, 10 Jul 2019 15:11:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 6/6] mm,thp: avoid writes to file with THP in pagecache
Message-ID: <20190710191116.GG11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-7-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:46PM -0700, Song Liu wrote:
> In previous patch, an application could put part of its text section in
> THP via madvise(). These THPs will be protected from writes when the
> application is still running (TXTBSY). However, after the application
> exits, the file is available for writes.
> 
> This patch avoids writes to file THP by dropping page cache for the file
> when the file is open for write. A new counter nr_thps is added to struct
> address_space. In do_last(), if the file is open for write and nr_thps
> is non-zero, we drop page cache for the whole file.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  fs/inode.c         |  3 +++
>  fs/namei.c         | 23 ++++++++++++++++++++++-
>  include/linux/fs.h | 32 ++++++++++++++++++++++++++++++++
>  mm/filemap.c       |  1 +
>  mm/khugepaged.c    |  4 +++-
>  5 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index df6542ec3b88..518113a4e219 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -181,6 +181,9 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping->flags = 0;
>  	mapping->wb_err = 0;
>  	atomic_set(&mapping->i_mmap_writable, 0);
> +#ifdef CONFIG_READ_ONLY_THP_FOR_FS
> +	atomic_set(&mapping->nr_thps, 0);
> +#endif
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
>  	mapping->private_data = NULL;
>  	mapping->writeback_index = 0;
> diff --git a/fs/namei.c b/fs/namei.c
> index 20831c2fbb34..3d95e94029cc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3249,6 +3249,23 @@ static int lookup_open(struct nameidata *nd, struct path *path,
>  	return error;
>  }
>  
> +/*
> + * The file is open for write, so it is not mmapped with VM_DENYWRITE. If
> + * it still has THP in page cache, drop the whole file from pagecache
> + * before processing writes. This helps us avoid handling write back of
> + * THP for now.
> + */
> +static inline void release_file_thp(struct file *file)
> +{
> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) {
> +		struct inode *inode = file_inode(file);
> +
> +		if (inode_is_open_for_write(inode) &&
> +		    filemap_nr_thps(inode->i_mapping))
> +			truncate_pagecache(inode, 0);
> +	}
> +}
> +
>  /*
>   * Handle the last step of open()
>   */
> @@ -3418,7 +3435,11 @@ static int do_last(struct nameidata *nd,
>  		goto out;
>  opened:
>  	error = ima_file_check(file, op->acc_mode);
> -	if (!error && will_truncate)
> +	if (error)
> +		goto out;
> +
> +	release_file_thp(file);
> +	if (will_truncate)
>  		error = handle_truncate(file);

This would seem better placed in do_dentry_open(), where we're done
with the namespace operation and actually work against the inode.

Something roughly like this?

diff --git a/fs/open.c b/fs/open.c
index b5b80469b93d..cae893edbab6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -799,6 +799,11 @@ static int do_dentry_open(struct file *f,
 		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
 			return -EINVAL;
 	}
+
+	/* XXX: Huge page cache doesn't support writing yet */
+	if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
+		truncate_pagecache(inode, 0);
+
 	return 0;
 
 cleanup_all:
