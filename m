Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E9218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F52O4XIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCVTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:06:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33772 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCVTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:06:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id q24so2881518otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vWMh27wE+42itM8tmOeg0zlK+omjId6ZR5kjx5xHjgI=;
        b=F52O4XIy7dc23i9TOwP50WiYTeSrMNQ1OSEhghT3APpdkMBwrs/0gL1MmANC7Y8EKh
         BzZhpcf4Gpg62w38dTTRreuhxdEYsnvZxjSk2W1MsKB3taPhLadKk4usD2owl/PNyxkR
         JbGkRujF9GMqqlecRcSTj56XKIWtKThAdUTILs93IDqtgmkd0T8khrVcVKByv72uR2oC
         uKMSG4kPgFrapFuumT37MDrZzXbQbuB+eAlhflyYCLPydQYKm+Cv1MnraF3XrL1c4xc0
         z0rYGY04LlDIfEhKGyZ5ct2BK4gTg/M4O/+mJUwp1dsZYLf9bmin3bvmybKJW+hQLeEH
         G7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vWMh27wE+42itM8tmOeg0zlK+omjId6ZR5kjx5xHjgI=;
        b=E6uLYfL75Ix0+LvmGagS4u9fUZ/B7W0zwTbUz/XrYgosruw6qgZm7XVF5N6kdt13fh
         2ONWuTwdbq1jeI5uCXW6FNFLu18+cLmbm5IWxYRZ0g8NXCKEyfbSFD85BKF0kLYdjoZ3
         eJCDbkV3AoRGd2dTLHfaKyq7p3auWVnPf0oX03+HDyPUbkUDLV1cRHhIqDQXtyjsP6lm
         dVJ8DWhbKJ1wqRjAC6r6PTCWSfrEwfKOVZffmspmjcMiAGHK8Ozyb0DR9pmdAWcRyIhX
         X6ReH0QcqHfJrjlwTkYioyBZV3P2G0uGW10kz7ZU7hn8Q533p0qQ4ioBAF952DSypDmD
         Z40A==
X-Gm-Message-State: APjAAAXI8EJ95cbOEbCoTBpZ9dlyfqLRTIxezJgAntgVaFHXGNKgcCxR
        K3fk6xkKqNmzkn1eF0Yd5bmfqA==
X-Google-Smtp-Source: APXvYqx5riAR+6llCvGeeM8uDaXA5ko2KvCRooQ9WikWc2RGqYxReXWN0y0qyw56AkbSoLX3RsTDQg==
X-Received: by 2002:a9d:75cc:: with SMTP id c12mr3759411otl.77.1553281571626;
        Fri, 22 Mar 2019 12:06:11 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j7sm1597563otr.50.2019.03.22.12.06.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Mar 2019 12:06:10 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:05:39 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 107/134] tmpfs: fix link accounting when a tmpfile
 is linked in
In-Reply-To: <20190322111217.997579517@linuxfoundation.org>
Message-ID: <alpine.LSU.2.11.1903221200490.2995@eggly.anvils>
References: <20190322111210.465931067@linuxfoundation.org> <20190322111217.997579517@linuxfoundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other patchsets posted today are complete - thanks -
but this 3.18.137-rc1 tree still wants
29b00e609960 ("tmpfs: fix uninitialized return value in shmem_link")
to be added to fix this one - thanks.

Hugh

On Fri, 22 Mar 2019, Greg Kroah-Hartman wrote:

> 3.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
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
> index 64c33e3dbe69..b40b13c94e03 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2286,10 +2286,14 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
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
>  	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
> -- 
> 2.19.1
