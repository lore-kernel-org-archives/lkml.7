Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE7221773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508516;
	bh=c6VDO5ZevrMLWD0rc/Hyyfd69c30AayWYCM0yESRcAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K/WpVgXmFyqGRdLLwl5wtAqaPaFyOrRx3WZ5Rzia3VunmX4UOyPhdkLAmYDMIGKnQ
	 FPpm9qIsjUp7l+ed8CEpKXTWhzh7sBDJEcMTz0La7vUgTk+HMSuLT3qezwDWPI8UHE
	 5eu0eQwl+jwxzghLhn2K6WWSzT6ZM3ET7XS3R7Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfDQNlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:41:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729939AbfDQNly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:41:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A131B175;
        Wed, 17 Apr 2019 13:41:53 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:41:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mateusz Guzik <mguzik@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arun KS <arunks@codeaurora.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190417134152.GM5878@dhcp22.suse.cz>
References: <20190417120347.15397-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417120347.15397-1-mkoutny@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 14:03:47, Michal Koutny wrote:
> The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
> semaphore taken.") added synchronization of reading argument/environment
> boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
> arg_lock to protect arg_start|end and env_start|end in mm_struct")
> avoided the coarse use of mmap_sem in similar situations.
> 
> get_cmdline can also use arg_lock instead of mmap_sem when it reads the
> boundaries.

Don't we need to use the lock in prctl_set_mm as well then?

> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  mm/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index d559bde497a9..568575cceefc 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	if (!mm->arg_end)
>  		goto out_mm;	/* Shh! No looking before we're done */
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	len = arg_end - arg_start;
>  
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
