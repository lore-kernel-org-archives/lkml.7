Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2221774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="p3WWMLeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLBIDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:03:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfLBIDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:03:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so15724131ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 00:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pZzAMwk10JqTjDXwgTJurkovZOHqxsdyWD2t9EmKVOQ=;
        b=p3WWMLeEJ/fPe3vlpWukc3E52B41OYT04vWL+sVy/5hBJUFLKkTJvLTDGlIbGL6iIn
         fw00EwBteZvV5N4AB+pHHH2/5HnqeBFUA1yKNWSisRIJxD3K3R2FLaV59i0E0D3MIpK7
         RHDqcqOGLQAlbuTSIs6njIEiw2lNtmg+kUVj0Poexk+sQgQudXhN1FolwrZ9VYzpl+1a
         cB0C6EJa+VI6wmCi8ZsXd/jN79cO7nHqw3Gev+O0Nco3V7QWR3V6TrPd1ciJIxloMrH5
         8tzldXn/qE02e1lopdnIDGwpTKQeGUYAollVWB8MkmDgadtNiBkKFLc9m2cqnAEIryYv
         tJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pZzAMwk10JqTjDXwgTJurkovZOHqxsdyWD2t9EmKVOQ=;
        b=oO3YgsY+DNhalA44v0SjyRunBnbICW5iQNB7aAvEVpMOjJFLyaWGRzNalDLlrtafAr
         XdLfHh0NmKDIhd7EiqM6LfyLNj602LZpkH2aKFzuhi6cf0d8n36xsf8ekZNIR/qk/8Nh
         2z0/sDcdPAMrVCWdf79pWfR9RV/U3Knr+d24q7E37ov/x3ReugBzpdxXs67mc0XIg5gH
         4OmP8n/KIi0n+fL0iePE8aAOQGc41WoTbv8FujiWmwyjVW0TnTFo+5dITdhE9CxFikua
         CL32ob/h9kiwfSS7ykMLDLThQABEyQg4MX95B6oLLEPpsZqFbR1cL1GGiYbf0hO7iHWw
         Mu1A==
X-Gm-Message-State: APjAAAX40XqeneWrYZse8RzhXrdL6O9QtHnVYPl/Nfkde8JSr7qZwCZy
        bGbEEdPHpRJdU8Uu3OJApdB3hOePBCA=
X-Google-Smtp-Source: APXvYqw2xS4YykGPdeRcFE4NZLnndPBghVdFAcfy3CqcTLlc0mTqj0TGZ4HMlNzmb41uz0qVkwLKnw==
X-Received: by 2002:a2e:2283:: with SMTP id i125mr30215378lji.244.1575273795843;
        Mon, 02 Dec 2019 00:03:15 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m9sm5099306lfj.57.2019.12.02.00.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:03:14 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1B9B6100F4E; Mon,  2 Dec 2019 11:03:15 +0300 (+03)
Date:   Mon, 2 Dec 2019 11:03:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
 <20191128212226.sfrhfs5m3q7m6tly@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128212226.sfrhfs5m3q7m6tly@master>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:22:26PM +0000, Wei Yang wrote:
> On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
> >On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
> >> At this point, we are sure page is PageTransHuge, which means
> >> hpage_nr_pages is HPAGE_PMD_NR.
> >> 
> >> This is safe to use PMD_SIZE instead of calculating it.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  mm/page_vma_mapped.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >> index eff4b4520c8d..76e03650a3ab 100644
> >> --- a/mm/page_vma_mapped.c
> >> +++ b/mm/page_vma_mapped.c
> >> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >>  			if (pvmw->address >= pvmw->vma->vm_end ||
> >>  			    pvmw->address >=
> >>  					__vma_address(pvmw->page, pvmw->vma) +
> >> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
> >> +					PMD_SIZE)
> >>  				return not_found(pvmw);
> >>  			/* Did we cross page table boundary? */
> >>  			if (pvmw->address % PMD_SIZE == 0) {
> >
> >It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
> >break if we ever get PUD THP pages.
> >
> 
> Thanks for your comment.
> 
> I took a look into the code again and found I may miss something.
> 
> I found we support PUD THP pages, whilc hpage_nr_pages() just return
> HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?

We only support PUD THP for DAX. Means, we don't have struct page for it.

-- 
 Kirill A. Shutemov
