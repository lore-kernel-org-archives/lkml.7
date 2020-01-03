Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C8C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE872253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 13:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dM9v8enp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgACN0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 08:26:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42345 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:26:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so29520913ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Asw7w06stGi1IWr+2nLUSF6dsNpGXIgVywOg4XUTixQ=;
        b=dM9v8enpv7GyuZ2hsrNesEW4s7o5vYQXBktWha+pyqwORaOfWN1pg7me9woOGhvBq6
         au78hLXhQBpbBaHb16xN67Bo0mD6TRiqX725rlHyLWbH5Klx13nmITqgiuKSqGFNzEKM
         Gux4vCMbriKaiouV96/w7A5L/Chh1GaaaXbp5JtqxeAAd8uNfe/+0l5+zKWoJHw1JpUj
         IB8MCisXkiCBYQXIlt0f8lKKgXCIgyKOXkUBtS/wy2+hNfQVNSybR3IuIb0uYzPmfTdx
         1ngQnQTm0+wX3j+oW/fHu46/AwmKnHRyhvolxZYDvLNU5FHlJyXwCiJku1exmiJQ7Wbf
         VByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Asw7w06stGi1IWr+2nLUSF6dsNpGXIgVywOg4XUTixQ=;
        b=naHG3CNo2ycMoA/0Ro2YmUNHBnSVOlfdp1mdvef1nE1tdTY/acLAFqrjgUIh6l8BVy
         8lg6mj0/KQzWAHhLOIf7ErdLdV95nSNLhyrlpIKCi02T/1+lFfajifgn72M98y1X/LR3
         8hCuKDeLwlfLVpdxI4TK6HATVlVydmvOkTUG/6zNpoLAt8v+0qWydsOulrnesCZCCbBF
         +6ZGCMOgeoGxMZodDORsAuxd11UEO9SNurxrz2cwgRf4WJS2i6fGa7tvElZr1mmapUIZ
         0HGlfdwZt/jgH1JKNwBQc8x+6N2OkiLQ9oTfEiNx6+4sdXeanNHa0PsPwjGblHbMr09T
         prsQ==
X-Gm-Message-State: APjAAAVDSNwqpCY9eBtXWj13LoPJJoKaY0sJeNa4CwQDViEkgoE4Rb94
        TT5Tm4r+GRVQj+R7LxVhG1jwmg==
X-Google-Smtp-Source: APXvYqzyaB+0xH2PprW+j1uckcEe+g7oN5HDml7PQu7wPmRnyVD+PzLlUL15W0tb+0E8HgmgVwUe1w==
X-Received: by 2002:a2e:7816:: with SMTP id t22mr52552757ljc.161.1578058010531;
        Fri, 03 Jan 2020 05:26:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h24sm24490515ljl.80.2020.01.03.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 05:26:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A7B40100741; Fri,  3 Jan 2020 16:26:50 +0300 (+03)
Date:   Fri, 3 Jan 2020 16:26:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20200103132650.jlyd37k6fcvycmy7@box>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20200103071846.GA16057@richard>
 <20200103130554.GA20078@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103130554.GA20078@richard>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 09:05:54PM +0800, Wei Yang wrote:
> On Fri, Jan 03, 2020 at 03:18:46PM +0800, Wei Yang wrote:
> >On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
> >>When page is not NULL, function is called by try_to_unmap_one() with
> >>TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
> >>with TTU_SPLIT_HUGE_PMD set:
> >>
> >>  * unmap_page()
> >>  * shrink_page_list()
> >>
> >>In both case, the page passed to try_to_unmap_one() is PageHead() of the
> >>THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
> >>aligned, this means the THP is not mapped as PMD THP in this process.
> >>This could happen when we do mremap() a PMD size range to an un-aligned
> >>address.
> >>
> >>Currently, this case is handled by following check in __split_huge_pmd()
> >>luckily.
> >>
> >>  page != pmd_page(*pmd)
> >>
> >>This patch checks the address to skip some work.
> >
> >I am sorry to forget address Kirill's comment in 1st version.
> >
> >The first one is the performance difference after this change for a PTE
> >mappged THP.
> >
> >Here is the result:(in cycle)
> >
> >        Before     Patched
> >
> >        963        195
> >        988        40
> >        895        78
> >
> >Average 948        104
> >
> >So the change reduced 90% time for function split_huge_pmd_address().

Right.

But do we have a scenario, where the performance of
split_huge_pmd_address() matters? I mean, it it called as part of rmap
walk, attempt to split huge PMD where we don't have huge PMD should be
within noise.

> >For the 2nd comment, the vma check. Let me take a further look to analysis.
> >
> >Thanks for Kirill's suggestion.
> >
> 
> For 2nd comment, check vma could hold huge page.
> 
> You mean do this check ?
> 
>   vma->vm_start <= address && vma->vm_end >= address + HPAGE_PMD_SIZE
> 
> This happens after munmap a partial of the THP range? After doing so, we can
> skip split_pmd for this case.

Okay, you are right. This kind of check would not be safe as we
split_huge_pmd_address() after adjusting VMA with expectation of splitting
PMD on boundary of the VMA.

-- 
 Kirill A. Shutemov
