Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D8BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFBC20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571939527;
	bh=hsDpjEAp46ywWUrxnhTCi5DooEkYl1jS3uW3z/8KfqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P5OAO2LqQKxRQhDrns1Rmlr20NG9dWiDnTHB/Rm99fMasvd5baScg5KC4LdnopVc3
	 R5uWgBHa8Qf/RamxPPpZqmGMftiGwIy0b1yO38MwUNTA+/aMEQ/s5Z6hfwZfxLpsAJ
	 J1h8CDVwp6vEDxE6OZjrhCFfveri8nGErviA81Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394079AbfJXRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:52:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40028 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394057AbfJXRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:52:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id y81so20344750qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2Vh8208W/buzInmSGpqP83enbLuiB5igBHyJQm0B7A=;
        b=Y6ta8XGyVwTVUYfNkxeOtxn8mnAy0nI9TEmCzj4LKbvepb3L8zZzV8eZCSXULGtlRZ
         cWOedHCBpQEg0mUSokyTE5zPoAjKu0pPtCCJZqdaXj0Zz+AxS+kt50+17roceA6wZBGw
         8HpHf7AfJc3JQoCg8iE5GzdCnUIJMSlteBEGfjCIKcQdFhxnFQ5yrKCATLk+oNYXWNZh
         jcZene3v2WSkokgvL/q/DIe3jG1b6mvQbjH1g50655M0PiBBX/EmJk1w9CbjUxOpfd6Y
         F4W8zobZLvWidP77swgwCi0R5BTndLOshRd4032Urc86Bel6RSDm5jvii9eIgDqtUOMd
         uYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2Vh8208W/buzInmSGpqP83enbLuiB5igBHyJQm0B7A=;
        b=sc8vY7khMgHsASjzfdCiGVN1iLeiTEXIjVzWjyCmaeYe2rGU+yA6oBf+nPc8nDjsse
         stT8QGioMMDRqlyKhZOcKfyUprWHBqaomZh6Fl5YyBLMS3uJ8uSMyZzWjg3UQEEhzwBT
         mW+JdJv3rSI2/YzZum0zn5nO6CSCzj0QhQJ+47Kpdc8SUGgJZK9g9+QThstsWcwqi6jb
         4vXMLBdJ79Oy7zenmG6jYZBNcxV/C0P/gZ9RP8eKxbnuzSqSqYM6kpTaptRvonTAuLp2
         4/eZjXwI84tGSzIiciwKnvj5WPtMbszybtLeAVC9ENlxqJah7Pw5d1wdU3MfLA1ser+G
         +EXQ==
X-Gm-Message-State: APjAAAX5C/5r293igujzzPiAB0dFxDpZo6KoDw6gUPdM1vFkCzHgcBol
        B2cSuyVQwpuvmaOJK1/JYdA=
X-Google-Smtp-Source: APXvYqxNpWHM24ADFxyYHacE7pNu1H3xEOSoV2bn3cK/zMB/krk3Oy1IMW/hm1UpsAY9AynqSOMUIA==
X-Received: by 2002:a37:8dc6:: with SMTP id p189mr14896632qkd.132.1571939524331;
        Thu, 24 Oct 2019 10:52:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:b2e])
        by smtp.gmail.com with ESMTPSA id 92sm13263541qte.30.2019.10.24.10.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:52:03 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:52:01 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH 2/2] kernfs: Allow creation with external gen + ino
 numbers
Message-ID: <20191024175201.GB3622521@devbig004.ftw2.facebook.com>
References: <20191016125019.157144-1-namhyung@kernel.org>
 <20191016125019.157144-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016125019.157144-3-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:50:19PM +0900, Namhyung Kim wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 6ebae6bbe6a5..f2e54532c110 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -618,10 +618,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  					     struct kernfs_node *parent,
>  					     const char *name, umode_t mode,
>  					     kuid_t uid, kgid_t gid,
> +					     u32 gen, int ino,

Shouldn't this be ino_t so that we can use 64bit uniq id as ino
directly where possible?  Also, it might make more sense if ino comes
before gen.

> @@ -635,11 +635,24 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&kernfs_idr_lock);
> -	cursor = idr_get_cursor(&root->ino_idr);
> -	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> -	if (ret >= 0 && ret < cursor)
> -		root->next_generation++;
> -	gen = root->next_generation;
> +
> +	if (ino == 0) {
> +		cursor = idr_get_cursor(&root->ino_idr);
> +		ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> +		if (ret >= 0 && ret < cursor)
> +			root->next_generation++;
> +		gen = root->next_generation;
> +	} else {
> +		ret = idr_alloc(&root->ino_idr, kn, ino, ino + 1, GFP_ATOMIC);
> +		if (ret != ino) {
> +			WARN_ONCE(1, "kernfs ino was used: %d", ino);
> +			ret = -EINVAL;
> +		} else {
> +			WARN_ON(root->next_generation > gen);
> +			root->next_generation = gen;
> +		}
> +	}

Oh, I see, so the code is still depending on idr and thus the use of
32bit ino.  Hmm....

>  static inline struct kernfs_node *
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 44c67d26c1fe..13d0d181a9f8 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3916,16 +3916,22 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
>  	char name[CGROUP_FILE_NAME_MAX];
>  	struct kernfs_node *kn;
>  	struct lock_class_key *key = NULL;
> +	struct cgroup_root *root = cgrp->root;
> +	int ino, gen;
>  	int ret;
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	key = &cft->lockdep_key;
>  #endif
> +
> +	ino = cgroup_idr_alloc(&root->cgroup_idr, NULL, false, GFP_KERNEL);
> +	gen = root->cgroup_idr.generation;
> +
>  	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
>  				  cgroup_file_mode(cft),
>  				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
>  				  0, cft->kf_ops, cft,
> -				  NULL, key);
> +				  NULL, key, gen, ino);

Can we move this to a separate patch so that this patch can be an
identity conversion?

Thanks.

-- 
tejun
