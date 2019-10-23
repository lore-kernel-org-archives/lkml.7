Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23CECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TqJ+HRDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbfJWT2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:28:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11652 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732759AbfJWT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:28:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db0a9d40000>; Wed, 23 Oct 2019 12:28:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 23 Oct 2019 12:28:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 23 Oct 2019 12:28:15 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:28:14 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:28:14 +0000
Subject: Re: [PATCH] mm: gup: fix comment of __get_user_pages()
To:     Liu Xiang <liuxiang_1999@126.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1571838707-4994-1-git-send-email-liuxiang_1999@126.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <36315623-2a82-41e6-c399-6cdfccd1d264@nvidia.com>
Date:   Wed, 23 Oct 2019 12:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571838707-4994-1-git-send-email-liuxiang_1999@126.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571858900; bh=gziLaVtBJuU4lCxLTMWw4D2EGiUWv9a+eDJHtPnkjto=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TqJ+HRDxJUhL8d8j3yN8jAqCn/gGAiZpK40rtOL8rbiVTVj+a+dl23Pd4bUN7kMY5
         tTZnsIuiAAkQaTVBGnaOkIiFzOdlp5DdpUh58Uzhc8Brjp0J6cStJ2GDOIaMlkqSOP
         S1ezvnSqfNFc+ktuvSCgqccCVNxLPgRweZvCkqEa1dDvLmamliVkHyeNt8lIFy24At
         bYMsLgnw4Ek3kE2bruzag3Jklhj0mzqvzHpMgbBRUz6L4bud+wp5wdt6tq9y7h3yh0
         o/DsQZoBnqf3+8w6NAi2m1ToVCGGyY7GS/SWhOqgiKJRNyQKFigY4g64HzU1fwQToV
         2jnNJMx4dVGcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 6:51 AM, Liu Xiang wrote:
> Because nr_pages is unsigned long, it can not be negative.
> 
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
> ---
>  mm/gup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8f236a3..0236954 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -735,10 +735,10 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   * @nonblocking: whether waiting for disk IO or mmap_sem contention
>   *
>   * Returns number of pages pinned. This may be fewer than the number
> - * requested. If nr_pages is 0 or negative, returns 0. If no pages
> - * were pinned, returns -errno. Each page returned must be released
> - * with a put_page() call when it is finished with. vmas will only
> - * remain valid while mmap_sem is held.
> + * requested. If nr_pages is 0, returns 0. If no pages were pinned,
> + * returns -errno. Each page returned must be released with a
> + * put_page() call when it is finished with. vmas will only remain
> + * valid while mmap_sem is held.
>   *
>   * Must be called with mmap_sem held.  It may be released.  See below.
>   *
> 

Hi Liu,

Thanks for fixing the documentation! As long as you're there...for the actual 
wording, can we please do it as shown below? This also addresses David's 
feedback, and it makes this read a lot better overall:

diff --git a/mm/gup.c b/mm/gup.c
index 8f236a335ae9..5816876fee51 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -734,11 +734,17 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
  *             Or NULL if the caller does not require them.
  * @nonblocking: whether waiting for disk IO or mmap_sem contention
  *
- * Returns number of pages pinned. This may be fewer than the number
- * requested. If nr_pages is 0 or negative, returns 0. If no pages
- * were pinned, returns -errno. Each page returned must be released
- * with a put_page() call when it is finished with. vmas will only
- * remain valid while mmap_sem is held.
+ * Returns either number of pages pinned (which may be less than the number
+ * requested), or an error. Details about the return value:
+ *
+ *      -- If nr_pages is 0, returns 0.
+ *      -- If nr_pages is >0, but no pages were pinned, returns -errno.
+ *      -- If nr_pages is >0, and some pages were pinned, returns the number of
+ *         pages pinned. Again, this may be less than nr_pages.
+ *
+ * The caller is responsible for releasing returned @pages, via put_page().
+ *
+ * @vmas are valid only as long as mmap_sem is held.
  *
  * Must be called with mmap_sem held.  It may be released.  See below.
  *


Patch ordering: I'll have to change the above as part of my upcoming series, to
make it refer to "put_page() or put_user_page(), depending on FOLL_PIN", 
approximately. (Just more of a note to self than anything else, here.)

thanks,

John Hubbard
NVIDIA
