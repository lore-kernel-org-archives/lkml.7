Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A83AC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEAB21479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557738926;
	bh=uJ0ZXgDAkiFnL4ZNWYrbYQhgVPenFOY4ZVeuGhRLAGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kpL8qGqWjXFWBueB/LaREPXKdoyu7PiPZulFzE0L6Ie/mXR+bXgUvMr6gdnNrL+Qh
	 GXhoJjdk57YJmFk+icoXXlWV1R52EtRZnM08KyoS3nsxVt3+b4OcKkyhBC9tmXmyFQ
	 zihWnHehaN62wySD9Hhis0wLzm14Z8ExX1fPhe1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfEMJPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:15:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbfEMJPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38569ACCE;
        Mon, 13 May 2019 09:15:23 +0000 (UTC)
Date:   Mon, 13 May 2019 11:15:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Weikang shi <swkhack@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Change count_mm_mlocked_page_nr return type
Message-ID: <20190513091522.GA30100@dhcp22.suse.cz>
References: <20190513023701.83056-1-swkhack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513023701.83056-1-swkhack@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-05-19 10:37:01, Weikang shi wrote:
> From: swkhack <swkhack@gmail.com>
> 
> In 64-bit machine,the value of "vma->vm_end - vma->vm_start"
> maybe negative in 32bit int and the "count >> PAGE_SHIFT"'s result
> will be wrong.So change the local variable and return
> value to unsigned long will fix the problem.
> 
> Signed-off-by: swkhack <swkhack@gmail.com>

Fixes: 0cf2f6f6dc60 ("mm: mlock: check against vma for actual mlock() size")

Acked-by: Michal Hocko <mhocko@suse.com>

Most users probably never noticed because large mlocked areas are not
allowed by default. So I am not really sure this is worth backporting to
stable trees.

> ---
>  mm/mlock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 080f3b364..d614163f5 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -636,11 +636,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
>   * is also counted.
>   * Return value: previously mlocked page counts
>   */
> -static int count_mm_mlocked_page_nr(struct mm_struct *mm,
> +static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
>  		unsigned long start, size_t len)
>  {
>  	struct vm_area_struct *vma;
> -	int count = 0;
> +	unsigned long count = 0;
>  
>  	if (mm == NULL)
>  		mm = current->mm;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
