Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21461C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58F2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBr3m5X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCMT7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:59:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41450 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfCMT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:59:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2260526pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SajRrUaUGaud6Nn4Qj6K9i18P4JO+MNtdJ37Bn8y7bQ=;
        b=SBr3m5X/eJzdT+sEonH+SmkvXYruM+CrkEu9nppT3EY0319WJl+seG3l5xz3A4DZYE
         A+oRZ9HXJeu60cYin5WicOu2UtNbEI4SBvN25Tni1LO2EXl+FCnyKxPkxb7K6d9IRthM
         6sVG/zHpR+leoapOgFGFCQayKJJr81IyKkQ3KgWD9FHZEi+H7GyYf9aGJILNWm3j5MJv
         7X8Ap3skyXpWAGZJbnrxBuZltTxhekSKYPjUddN1oy4zJFFHkKnvFlvpnuorr/qczwVy
         su7wZJV7u72Q1W1t881hlTX/VvhqJdGEGK+UJpXt/fG3xqpYm9CN7TbG1JfQPB8qIvCu
         Uy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SajRrUaUGaud6Nn4Qj6K9i18P4JO+MNtdJ37Bn8y7bQ=;
        b=Z08cRfoZmjttKG2H41p/OvNXc5/4ZLorvgNQ/pFNQ7NgZBgVMiNUc5z1yaHtOKJsvh
         N2NWy6R65h+UcBpvPfgIxgLqeBPmBpoPSj6+LfGGS1Ij/dcYnFDJ+1Ek+Zg27O5a92Gp
         7mGloC1WMy3wvx5dnTrOkR99V29pKKadCCSh4LyoxeLWEEMmgdfAfHL5PSoqN/dfvcQc
         UleCyv3yTOicPXnJGWR6Th5uR8YlnrKdVrWM7BU3LURu5LIbzx02NsJQKJWQCfhQSjvt
         SUCvL+rFu6+Kd9wPKFN7bhssY92+lip++6MbRwIm9nNq0AChdWdoAlUTuWT6phfN+I5c
         ZWVg==
X-Gm-Message-State: APjAAAXhOELIKirVRjFhq63bgU02ZN3YZxKs2IEXSuZWf0ZVckOD0x0b
        iNlad7rZ3YDtUaNvQ4PucBUGFyYNexM=
X-Google-Smtp-Source: APXvYqxtqw/l3jAmyf1Nv+r2FH56v+9+XlPl1VhkWGkRCkFf6Jsi+2m51OrFhzBX29knybK33dc4mA==
X-Received: by 2002:a63:2bcd:: with SMTP id r196mr40920203pgr.355.1552507138925;
        Wed, 13 Mar 2019 12:58:58 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id e63sm17933208pfa.116.2019.03.13.12.58.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 12:58:58 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:58:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Sasha Levin <sashal@kernel.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.20 37/60] tmpfs: fix link accounting when a
 tmpfile is linked in
In-Reply-To: <20190313191021.158171-37-sashal@kernel.org>
Message-ID: <alpine.LSU.2.11.1903131248210.1629@eggly.anvils>
References: <20190313191021.158171-1-sashal@kernel.org> <20190313191021.158171-37-sashal@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUTOSEL is wrong to select this commit without also selecting
29b00e609960 ("tmpfs: fix uninitialized return value in shmem_link")
which contains the tag
Fixes: 1062af920c07 ("tmpfs: fix link accounting when a tmpfile is linked in")
Please add 29b00e609960 for those 6 trees, or else omit 1062af920c07 for now.

Thanks,
Hugh

On Wed, 13 Mar 2019, Sasha Levin wrote:

> From: "Darrick J. Wong" <darrick.wong@oracle.com>
> 
> [ Upstream commit 1062af920c07f5b54cf5060fde3339da6df0cf6b ]
> 
> tmpfs has a peculiarity of accounting hard links as if they were
> separate inodes: so that when the number of inodes is limited, as it is
> by default, a user cannot soak up an unlimited amount of unreclaimable
> dcache memory just by repeatedly linking a file.
> 
> But when v3.11 added O_TMPFILE, and the ability to use linkat() on the
> fd, we missed accommodating this new case in tmpfs: "df -i" shows that
> an extra "inode" remains accounted after the file is unlinked and the fd
> closed and the actual inode evicted.  If a user repeatedly links
> tmpfiles into a tmpfs, the limit will be hit (ENOSPC) even after they
> are deleted.
> 
> Just skip the extra reservation from shmem_link() in this case: there's
> a sense in which this first link of a tmpfile is then cheaper than a
> hard link of another file, but the accounting works out, and there's
> still good limiting, so no need to do anything more complicated.
> 
> Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1902182134370.7035@eggly.anvils
> Fixes: f4e0c30c191 ("allow the temp files created by open() to be linked to")
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reported-by: Matej Kupljen <matej.kupljen@gmail.com>
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/shmem.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5d07e0b1352f..7872e3b75e57 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2852,10 +2852,14 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>  	 * No ordinary (disk based) filesystem counts links as inodes;
>  	 * but each new link needs a new dentry, pinning lowmem, and
>  	 * tmpfs dentries cannot be pruned until they are unlinked.
> +	 * But if an O_TMPFILE file is linked into the tmpfs, the
> +	 * first link must skip that, to get the accounting right.
>  	 */
> -	ret = shmem_reserve_inode(inode->i_sb);
> -	if (ret)
> -		goto out;
> +	if (inode->i_nlink) {
> +		ret = shmem_reserve_inode(inode->i_sb);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	dir->i_size += BOGO_DIRENT_SIZE;
>  	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
> -- 
> 2.19.1
