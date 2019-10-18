Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5789FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31389222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NYqIWanv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408554AbfJRNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:34:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45328 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfJRNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:34:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so6220002ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mtqhz+l9p2z/Y9+QoW0NlKs8Ee0G0Fl5wkgOZoNBTfE=;
        b=NYqIWanvwetnPi+kg0R4ons+B6C3dxTU+AOGj1o5Kk/Vq/GQyHF9dv9ps909bAKi+s
         vFycJkOyIf0sCHGeTv9Ff0qIA1BlrO7m/ocbIR16k36CUTZokMLg4ZDwTIUB3bOZPjrG
         wseNHPVwYgeAsCIh3Vjneff6CfnILz13ncnRjZnU7TOu1eA9eyq38uXidT66DMqaKVV9
         3OszxSncg4kLct6v+vzWj12nQpkg0BFodb7azVuTxiiQvM+eLZv953AzrpvvyFVeZaXk
         NLbbpTokCrZpJrMxAboemdMoW4/RC0it3mcDMk1M7e//fuCJ2HWvgTxWxY9VXPimEtGO
         uQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtqhz+l9p2z/Y9+QoW0NlKs8Ee0G0Fl5wkgOZoNBTfE=;
        b=tPTkV63fKaj7+Nl2QqDa/d1wZBfsQ3iODrJOcTiMLgjSSjuTiIYRF6ABdKLfU2rsnQ
         9amyKWjo3glqkeIPk0oF2he+CcmEVcBqLovw8NZY8goQ6ztoblMLCDnXaxVCFqwxcVBc
         PIbLj/cYLdOC3zixPvLvpW9+ThDEvCCrKO409rJVZt1U+1NRvCkvsS6YIABBSFGp8VVt
         u8ChTHo1GDyV2XnphzFQBjmc4iNCuhLBEDSgIqWKHJvhv6JwKTAg3vKRdnSrTffvCFYQ
         NQaG1mddQecX7cNsc1gFHY8CN7Dlma+uU59tsUPeEQhnofY1hWINiKS0JPG7pMuyJJrn
         QibA==
X-Gm-Message-State: APjAAAX+3FsiYPuh4Ssctby0zM1rMJ5sOZiOm70sRcEg2QmmT4RfJCkN
        yjYxrweZbsQs6eBjfWNmq+V4Iw==
X-Google-Smtp-Source: APXvYqxSHEyX4P2wiV9AbvuLFAyNsDBlqMKrAO9VbJ1TOkviaIxn6GVTIAEjPhaOwIP43pqNDiHlpw==
X-Received: by 2002:a2e:88d0:: with SMTP id a16mr6296209ljk.39.1571405686573;
        Fri, 18 Oct 2019 06:34:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x76sm5908099ljb.81.2019.10.18.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 06:34:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B6F7D100D76; Fri, 18 Oct 2019 16:34:44 +0300 (+03)
Date:   Fri, 18 Oct 2019 16:34:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm,thp: recheck each page before collapsing file THP
Message-ID: <20191018133444.iif7b33muxmus6lb@box>
References: <20191018050832.1251306-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018050832.1251306-1-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:08:32PM -0700, Song Liu wrote:
> In collapse_file(), after locking the page, it is necessary to recheck
> that the page is up-to-date, clean, and pointing to the proper mapping.
> If any check fails, abort the collapse.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: William Kucharski <william.kucharski@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/khugepaged.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0a1b4b484ac5..7da49b643c4d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1619,6 +1619,14 @@ static void collapse_file(struct mm_struct *mm,
>  				result = SCAN_PAGE_LOCK;
>  				goto xa_locked;
>  			}
> +
> +			/* double check the page is correct and clean */
> +			if (unlikely(!PageUptodate(page)) ||
> +			    unlikely(PageDirty(page)) ||
> +			    unlikely(page->mapping != mapping)) {
> +				result = SCAN_FAIL;
> +				goto out_unlock;
> +			}
>  		}
>  
>  		/*

Hm. But why only for !is_shmem? Or I read it wrong?

-- 
 Kirill A. Shutemov
