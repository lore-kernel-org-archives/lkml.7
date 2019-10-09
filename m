Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1583DECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29382053B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="b1sQezSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfJIPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:14:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35161 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJIPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:14:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so2918978lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i5+F8lTtk0Euakn/RjiS7V/Gyf5iIdmbIbnkhbAYeuk=;
        b=b1sQezSLJ2RpHRT6G4RPpFNQ9QPWcbccuCz+q+XxR+aRGGya3h3HiebQHOKMqCV8Av
         KRFMjlIEMpRE8zpXTYAcDUO682DRTfznIM86/Wf8Lw7JuirqVcfggs2x1V7D1HCHAgVg
         tgBj2YXSfG9eaGuA9qsTLKLFP+ONR6Y6GScGSWQYnLYb/2mkSRN1lzgpRB9tPKcG+Rnr
         ONJbPZZTUQQ1xOjbyvYsrZVwp8vMAxcscwQ1/XgDbpIbpQaMKwOlhtUkvJPpQF6mq3VT
         L2ja+Bf3HNQzKolLib9YqCey4AvVnpMQOseDvlBIh+St5bVyQP59B+lfLVzIh4843QK/
         7BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i5+F8lTtk0Euakn/RjiS7V/Gyf5iIdmbIbnkhbAYeuk=;
        b=SPJDzYGZ9zagAEmXWUkO21MaUUAhd2jtw/JbDWDaLVdDStt07X11Be456YZNPiNsPz
         CaHRIx8b6kv0al+/VfkMA7FPj0HBIyjcmLz9p8NxfChSimFgSfsoSiogCTJHmLSMBpFq
         PqEWZSTdxnBQZKCGs6ucuKTb5j/aizDE/o9nhH+CFz+JNGpGRGPCVJMBvkyfWoGwqbbk
         Zr4S7zCuNBeahb8K8uHkSsVtad7aTCVhXdGut76R7vv713fl/sXHwTgt/FStd0cSDEBd
         6yS6uQPr59vqFgPGvYN8zYD+7nx7f9K2O+Vib3idgNXGNVfVzKtFpL82rhpd/KRhGa2I
         GtRA==
X-Gm-Message-State: APjAAAUka5zmqF9a+3wzOgbwyHIl4ngcovfmFiokWImueEVDP31KBBL3
        KoerRtY8fxWNn45GD7q+27n2Yg==
X-Google-Smtp-Source: APXvYqzonBoG6yUhGVsnPYjcbe2zvWGkU0ePqWPljYB4I3KPXOX9/PxY9scZ4tjLKi0uvWWGIqsxiA==
X-Received: by 2002:a2e:750c:: with SMTP id q12mr2662432ljc.138.1570634040984;
        Wed, 09 Oct 2019 08:14:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w27sm525557ljd.55.2019.10.09.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:14:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7BDF8102BFA; Wed,  9 Oct 2019 18:14:00 +0300 (+03)
Date:   Wed, 9 Oct 2019 18:14:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v4 2/9] mm: pagewalk: Take the pagetable lock in
 walk_pte_range()
Message-ID: <20191009151400.bserdtpoczmawqn5@box>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008091508.2682-3-thomas_os@shipmail.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:15:01AM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Without the lock, anybody modifying a pte from within this function might
> have it concurrently modified by someone else.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>  mm/pagewalk.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index d48c2a986ea3..83c0b78363b4 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -10,8 +10,9 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	pte_t *pte;
>  	int err = 0;
>  	const struct mm_walk_ops *ops = walk->ops;
> +	spinlock_t *ptl;
>  
> -	pte = pte_offset_map(pmd, addr);
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	for (;;) {
>  		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
>  		if (err)
> @@ -22,7 +23,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  		pte++;
>  	}
>  
> -	pte_unmap(pte);
> +	pte_unmap_unlock(pte - 1, ptl);

NAK.

If ->pte_entry() fails on the first entry of the page table, pte - 1 will
point out side the page table.

And the '- 1' is totally unnecessary as we break the loop before pte++ on
the last iteration.

-- 
 Kirill A. Shutemov
