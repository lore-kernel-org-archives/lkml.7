Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA352176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fatrkrOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfK1Ic7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:32:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44934 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfK1Ic7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:32:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so18326967lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIy277yxYKVobrZz2ToLDywtPrlz1UVDNYgv3IeN1Jg=;
        b=fatrkrOJr4qwMGagesnkLFa7gXLISGxz3MWjlGva/SQ19IbhGVVerqggDnbRpsqLE2
         jVKi54KOnDC0o5PpvG5ebVRMGL8Ts94ShZAr7LpJbt2Du5ymMQuw5YDrSLcNGTyqqBIf
         WwcBWKFTcw8PdqDLjYLsPTBUx8BTQYUp+m6QcdtPGpLMXxj4ZvcZlxkhcgDnT4Q1tfrA
         MRLLO0273PUhmDabzseylDafZeeQssgZPMD/4JGNae91/ZgBoLS8nA6JqeHmPyA7THZK
         Cp2NL+mvNfxsIjM88h3T3JQOmSDz4Xv4/nMcyK8tcySjb+uAnn8+3DSzGX49LrAEs6Rk
         ol4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIy277yxYKVobrZz2ToLDywtPrlz1UVDNYgv3IeN1Jg=;
        b=kFdagGl6Crs3I8TEC/Sqhw+ljrdmyDUoK7glcDyA9HD4FmahiYpmrlnyShr5VI7LoD
         BDSqJtA1wJZuz7z5CUDB5hMYGdIKK6aDTmpWAoCIK7cOSOAMcg/SpHSmrwhdxJaeNHo0
         r/LAnhFlJ505xFiCWdqOhLv76/tjKqHWEUP/KSGswUurNvH2bhL2WldEQ1dAViUE3ShP
         9Vx1cb9+yQ2noz+IcYwU/6AvHkM5hmuWUtFJ1foSiUR6jHyNlZYHYGOk9TCDIFgdNXad
         iwgUg2VTaXQGp3WpQ9U2uIAvSwloL7ZxxXw6qkeVqDioQIN2hVO4rvVzFzceKXM3iSGF
         uZ8w==
X-Gm-Message-State: APjAAAW608ukD3eoHyYELjDM4OJAbAEeZHE0E/jd3+Xj7a9vrJyvcyJo
        otDEnHQiA6Wd0Llrs6FGYRrbsw==
X-Google-Smtp-Source: APXvYqxyczGbS/7hvESPwKMKR0/0KbuTnLjq1DmHGcjCr0kUQd2LoN2KVxqmC3Lm2OWL61xWHAtf7g==
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr29282721lfa.61.1574929977126;
        Thu, 28 Nov 2019 00:32:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r4sm8192396ljn.64.2019.11.28.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 00:32:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A6E76101715; Thu, 28 Nov 2019 11:32:55 +0300 (+03)
Date:   Thu, 28 Nov 2019 11:32:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128010321.21730-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
> At this point, we are sure page is PageTransHuge, which means
> hpage_nr_pages is HPAGE_PMD_NR.
> 
> This is safe to use PMD_SIZE instead of calculating it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/page_vma_mapped.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index eff4b4520c8d..76e03650a3ab 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			if (pvmw->address >= pvmw->vma->vm_end ||
>  			    pvmw->address >=
>  					__vma_address(pvmw->page, pvmw->vma) +
> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
> +					PMD_SIZE)
>  				return not_found(pvmw);
>  			/* Did we cross page table boundary? */
>  			if (pvmw->address % PMD_SIZE == 0) {

It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
break if we ever get PUD THP pages.

-- 
 Kirill A. Shutemov
