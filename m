Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5CEC606C0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEB8216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562597199;
	bh=rUe9M6ZXQlwXE3sh8ZuYxODKHdTnsKzP34MTX5bc5Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=paZnx0XYuQ5xzbCW1wec4dQ8gA8mGP7phM2mkqEYz6Zn+byjJb+48Pg0LS0Zfuf8M
	 G7RODyEhxKK3sPFFiiYeChYvc7h/Jaye63WvedHmdTmZgvBeNI/HxgBB00NjXtSG7w
	 kkOLlqKka1opfawzsCXDSmRaoQeUnGQc9VdQRIzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfGHOqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:46:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35768 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfGHOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:46:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so13206424qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aVyE/Nb6xnoBUh0eSN7bHXiiu66sZ8TBOBRXV/pruw8=;
        b=WuthXcWABYrK2IVm74B8GNUHJDp1q+id8kEBFSUJjVHH3t70Mvv4cwQn0xDpc7oyiA
         HARII16/xePeJh0paOPkhq8TyKzg3nVgxdEITdtR9hBf2KTKEDfZ4fv84adXRDAbEmrE
         1AplsvlLrnLqDSH3kNSx3x0l1Q8R38eG2LutyjmXhTXPoGJ8vSFAjk3W8LLgpUnloqvU
         OoykdmjN8IcxOJuuGUpG9vWjKu6Om5h1ke2FAllylfyVsnPY7gcUTqWQZ8nXQ4cDykX/
         sSdX+1v9T/zMcvsgHq5Lf/mpJygmlxYwxF8yM8rb+OXxi6R8l+F0u3YLG7ZpU5gBVhDW
         wBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVyE/Nb6xnoBUh0eSN7bHXiiu66sZ8TBOBRXV/pruw8=;
        b=PHcaFG0PoDwvRireG5gqogUaL9klbFpjXzqrAYkqmuQY3f4QOp6dGAyDuz8jxVKfGg
         7JG1fW/CF07VcGwE1lUr0rMcDwiTMXOnH8Qy9NpgvUnRz+woefpWbGeEltRLl9OU392i
         aWqAMYC+PpB3fCexp+HoQCD5RYWiS+wdshqsC3JAssfxKBjjG+uFyfhzsyib7RoFeocN
         riyKQDpjm2nQHEawluc4pMr+unaw/3Nj7AFL5HaFkijKLXyZ/9uF7GeeYzxFDY5DBI87
         9ii73/koh9uyW+u+7lvFFlUoD9/VH0PNF5ydV5KpmHGZILx9pEGlcZ+I5Ru/ouoU5hSS
         RcZw==
X-Gm-Message-State: APjAAAVq+y1FQZOS+fbKTuccLDq7j/+cZPVIDcscsuCStWD+qPjFNJ4u
        2E9nDN92yL22lmNTq4WmXL4=
X-Google-Smtp-Source: APXvYqyDFoIpeL9gDs21wZSb8aQ9VOlAPJvMDrI3NhLDKYQAz6fERnHpt/IOEVel6lyJjIiuTyp74g==
X-Received: by 2002:a37:ad0:: with SMTP id 199mr14706570qkk.90.1562597194758;
        Mon, 08 Jul 2019 07:46:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id y42sm10595026qtc.66.2019.07.08.07.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:46:34 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:46:32 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in kernfs_create_dir_ns
Message-ID: <20190708144632.GB657710@devbig004.ftw2.facebook.com>
References: <0000000000003ec128058c7624ec@google.com>
 <0000000000003bbf1b058c83f55a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003bbf1b058c83f55a@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 01, 2019 at 01:52:35PM +0800, Hillf Danton wrote:
> >WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493 kernfs_get  fs/kernfs/dir.c:493 [inline]
> >WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493 kernfs_new_node  fs/kernfs/dir.c:700 [inline]
> >WARNING: CPU: 0 PID: 8613 at fs/kernfs/dir.c:493 kernfs_create_dir_ns+0x205/0x230 fs/kernfs/dir.c:1022
...
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -53,6 +53,10 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
> 	if (!parent)
> 		return -ENOENT;
> 
> +	/* create dir if parent is not dying */
> +	if (!atomic_inc_not_zero(&parent->count))
> +		return -ENOENT;
> +
> 	kobject_get_ownership(kobj, &uid, &gid);
> 
> 	kn = kernfs_create_dir_ns(parent, kobject_name(kobj),
> @@ -61,10 +65,12 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
> 	if (IS_ERR(kn)) {
> 		if (PTR_ERR(kn) == -EEXIST)
> 			sysfs_warn_dup(parent, kobject_name(kobj));
> +		kernfs_put(parent);
> 		return PTR_ERR(kn);
> 	}
> 
> 	kobj->sd = kn;
> +	kernfs_put(parent);

I don't think this is the correct fix.  It's being called with kobj
whose parent's sysfs node is dangling.  It gotta be fixed from the
caller side.

Thanks.

-- 
tejun
