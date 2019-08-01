Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F4AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69618214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfHAGnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAGnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0872530833A5;
        Thu,  1 Aug 2019 06:43:39 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F202860BE0;
        Thu,  1 Aug 2019 06:43:38 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E31C51800202;
        Thu,  1 Aug 2019 06:43:38 +0000 (UTC)
Date:   Thu, 1 Aug 2019 02:43:38 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Message-ID: <1944499597.6210303.1564641818536.JavaMail.zimbra@redhat.com>
In-Reply-To: <1564640896-1210-1-git-send-email-rppt@linux.ibm.com>
References: <1564640896-1210-1-git-send-email-rppt@linux.ibm.com>
Subject: Re: [PATCH] mm/madvise: reduce code duplication in error handling
 paths
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.181, 10.4.195.4]
Thread-Topic: mm/madvise: reduce code duplication in error handling paths
Thread-Index: epQ2HTIRhoW+wkIZZblxwj+pESe04w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 01 Aug 2019 06:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The madvise_behavior() function converts -ENOMEM to -EAGAIN in several
> places using identical code.
> 
> Move that code to a common error handling path.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/madvise.c | 52 ++++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 36 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 968df3a..55d78fd 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -105,28 +105,14 @@ static long madvise_behavior(struct vm_area_struct
> *vma,
>  	case MADV_MERGEABLE:
>  	case MADV_UNMERGEABLE:
>  		error = ksm_madvise(vma, start, end, behavior, &new_flags);
> -		if (error) {
> -			/*
> -			 * madvise() returns EAGAIN if kernel resources, such as
> -			 * slab, are temporarily unavailable.
> -			 */
> -			if (error == -ENOMEM)
> -				error = -EAGAIN;
> -			goto out;
> -		}
> +		if (error)
> +			goto out_convert_errno;
>  		break;
>  	case MADV_HUGEPAGE:
>  	case MADV_NOHUGEPAGE:
>  		error = hugepage_madvise(vma, &new_flags, behavior);
> -		if (error) {
> -			/*
> -			 * madvise() returns EAGAIN if kernel resources, such as
> -			 * slab, are temporarily unavailable.
> -			 */
> -			if (error == -ENOMEM)
> -				error = -EAGAIN;
> -			goto out;
> -		}
> +		if (error)
> +			goto out_convert_errno;
>  		break;
>  	}
>  
> @@ -152,15 +138,8 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  			goto out;
>  		}
>  		error = __split_vma(mm, vma, start, 1);
> -		if (error) {
> -			/*
> -			 * madvise() returns EAGAIN if kernel resources, such as
> -			 * slab, are temporarily unavailable.
> -			 */
> -			if (error == -ENOMEM)
> -				error = -EAGAIN;
> -			goto out;
> -		}
> +		if (error)
> +			goto out_convert_errno;
>  	}
>  
>  	if (end != vma->vm_end) {
> @@ -169,15 +148,8 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  			goto out;
>  		}
>  		error = __split_vma(mm, vma, end, 0);
> -		if (error) {
> -			/*
> -			 * madvise() returns EAGAIN if kernel resources, such as
> -			 * slab, are temporarily unavailable.
> -			 */
> -			if (error == -ENOMEM)
> -				error = -EAGAIN;
> -			goto out;
> -		}
> +		if (error)
> +			goto out_convert_errno;
>  	}
>  
>  success:
> @@ -185,6 +157,14 @@ static long madvise_behavior(struct vm_area_struct *vma,
>  	 * vm_flags is protected by the mmap_sem held in write mode.
>  	 */
>  	vma->vm_flags = new_flags;
> +
> +out_convert_errno:
> +	/*
> +	 * madvise() returns EAGAIN if kernel resources, such as
> +	 * slab, are temporarily unavailable.
> +	 */
> +	if (error == -ENOMEM)
> +		error = -EAGAIN;
>  out:
>  	return error;
>  }

looks good.

Acked-by: Pankaj Gupta <pagupta@redhat.com>

> --
> 2.7.4
> 
> 
