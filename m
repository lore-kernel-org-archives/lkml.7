Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8D42063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EswV1nGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFMRCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:02:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36206 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfFLXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:14:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so7244328plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zENyOoOSgI8QfaggquPMfPbLKw7a6eUv2Qjm9NWJtcQ=;
        b=EswV1nGCdvSMNN+Ssd1h7rS3RXzjTfEdTIdOLjAh5nTRd36k1bdXI6zWruRLqObK0d
         gsC+6WcEPSp6FesMM+ciJCWrwUt+f3/TlPdj8OHr1gJIlaqypHatFu/fEtZyZqtTgxf/
         7MmVJ24TsNjxF3L2qzae4mJRJIWKsdAgvTDM41obh31wU5DHCFOSTfiDeRVan1EyTWT2
         FA4K03WJSZqhv2G4TPC4wR1Lyw2YYsUsmJ5/O926cAuclRrP4DGVaFyTWu7dvlXrp9UC
         rWkAggs99lIDtQwUic825l/5MOVIb6hlsoo+MGQWZsaaKUU00iAbkzb0AD/J2zMhHB2K
         je/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zENyOoOSgI8QfaggquPMfPbLKw7a6eUv2Qjm9NWJtcQ=;
        b=i4v+iDeuIQBQMpszhfhuPpavb8UtffvJ8dGDlrii5++vm0c4h8ep7xXwZLFlNFGjVz
         HBbB3PRwRoisbIihy7/xw1WhGZWTh/lMC56qL66mOqvY/+IYIyT6Nsj3gtJxc3y723gS
         FfFtZlma/1trCo/2auTYk8/Zr0ZP/PtxCyS9ZwBhMA5e6HL6zK0etzShIsWEuSWHcj5A
         s2pOOv9uQruo2kpGD3wtjyWp1x/jbEiMq3TdJqTtF2Fli4rgrYhq5Jda3q7bCP66KdqE
         ub2sbkM5wEakEjaVgqMi46r3gJl46r3kmwVAOjPOrqLKc+X4topGXyhqif3F+tDnEn0d
         bW/g==
X-Gm-Message-State: APjAAAWXAaw0ge2wsR6GkOPv5MjOtzDl1Jj6E8QmUKZ/f4M7XozP6bxZ
        xHmd+bkyBoa138R4lNo0I3Q=
X-Google-Smtp-Source: APXvYqynFN1ludII3XFLYMfIONiHIRT3DEjMebyu/w5SXt66rSlQbatTCpNAcnVu5y6nlAVVC7h8BQ==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr3048117pls.318.1560381270418;
        Wed, 12 Jun 2019 16:14:30 -0700 (PDT)
Received: from gmail.com ([2a00:79e1:abc:1e04:de9a:68c:c1e8:7e8f])
        by smtp.gmail.com with ESMTPSA id o26sm491338pgv.47.2019.06.12.16.14.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:14:29 -0700 (PDT)
Date:   Wed, 12 Jun 2019 16:14:28 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Roman Gushchin <guro@fb.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 5/6] proc: use down_read_killable mmap_sem for
 /proc/pid/map_files
Message-ID: <20190612231426.GA3639@gmail.com>
References: <156007465229.3335.10259979070641486905.stgit@buzz>
 <156007493995.3335.9595044802115356911.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <156007493995.3335.9595044802115356911.stgit@buzz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 01:09:00PM +0300, Konstantin Khlebnikov wrote:
> Do not stuck forever if something wrong.
> Killable lock allows to cleanup stuck tasks and simplifies investigation.

This patch breaks the CRIU project, because stat() returns EINTR instead
of ENOENT:

[root@fc24 criu]# stat /proc/self/map_files/0-0
stat: cannot stat '/proc/self/map_files/0-0': Interrupted system call

Here is one inline comment with the fix for this issue.

> 
> It seems ->d_revalidate() could return any error (except ECHILD) to
> abort validation and pass error as result of lookup sequence.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

It was nice to see all four of you in one place :).

> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  fs/proc/base.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9c8ca6cd3ce4..515ab29c2adf 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1962,9 +1962,12 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
>  		goto out;
>  
>  	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
> -		down_read(&mm->mmap_sem);
> -		exact_vma_exists = !!find_exact_vma(mm, vm_start, vm_end);
> -		up_read(&mm->mmap_sem);
> +		status = down_read_killable(&mm->mmap_sem);
> +		if (!status) {
> +			exact_vma_exists = !!find_exact_vma(mm, vm_start,
> +							    vm_end);
> +			up_read(&mm->mmap_sem);
> +		}
>  	}
>  
>  	mmput(mm);
> @@ -2010,8 +2013,11 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
>  	if (rc)
>  		goto out_mmput;
>  
> +	rc = down_read_killable(&mm->mmap_sem);
> +	if (rc)
> +		goto out_mmput;
> +
>  	rc = -ENOENT;
> -	down_read(&mm->mmap_sem);
>  	vma = find_exact_vma(mm, vm_start, vm_end);
>  	if (vma && vma->vm_file) {
>  		*path = vma->vm_file->f_path;
> @@ -2107,7 +2113,10 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>  	if (!mm)
>  		goto out_put_task;
>  
> -	down_read(&mm->mmap_sem);
> +	result = ERR_PTR(-EINTR);
> +	if (down_read_killable(&mm->mmap_sem))
> +		goto out_put_mm;
> +

	result = ERR_PTR(-ENOENT);

>  	vma = find_exact_vma(mm, vm_start, vm_end);
>  	if (!vma)
>  		goto out_no_vma;
> @@ -2118,6 +2127,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>  
>  out_no_vma:
>  	up_read(&mm->mmap_sem);
> +out_put_mm:
>  	mmput(mm);
>  out_put_task:
>  	put_task_struct(task);
> @@ -2160,7 +2170,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	mm = get_task_mm(task);
>  	if (!mm)
>  		goto out_put_task;
> -	down_read(&mm->mmap_sem);
> +
> +	ret = down_read_killable(&mm->mmap_sem);
> +	if (ret) {
> +		mmput(mm);
> +		goto out_put_task;
> +	}
>  
>  	nr_files = 0;
>  
