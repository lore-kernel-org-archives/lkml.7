Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D832070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="obyctRCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHLOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:40:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37866 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfHLOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:40:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id f22so1051438edt.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TVVRSVkI8qvD2lGSoeUmZF8tCfKzDhhlBaSpCOxArnc=;
        b=obyctRCgWgERgLG9YsSV9pgUbXG+BwvEDlG9jtBCQVI1C6bvH5m/SwrLIrfFLjvksi
         Nb++0xO4rLuuFAiTrBT5bfKhZ+5NertpHGXDs+rkxTUxu4hTb0OZXIaFsOM7Tn66afMB
         kTPWRhTNqDQYBIXl3kU5jXapTQTYVkExo/dj4/fjNi8ouR1H402RS2li23UO7n+SNKeP
         Er1e0U/BhDsZtcVRjl6/ZmkLMLJZxy7ds6Ru9Sd2mJSb3IWvTK8Tfob+eVyC+2mdKFAC
         cnnSMRtKT0qLrb/oOKAFUOf9aKSemCcD+3010yGECqQfCkG0uGy57ishKgoJNuCWlBYb
         kKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVVRSVkI8qvD2lGSoeUmZF8tCfKzDhhlBaSpCOxArnc=;
        b=sNFxoAblHznVryx2Zpae1ozjWX12s2xc/YMzpG/XPtPVsHEo/4I4fKSnsH5aZKi4Ty
         VYIKbnwALpX1SxOP7s9Z49oNZ4T/x7BDYSBsEuyxb2eLSNpAvp5/E4YBLeYUJ8fIEHtL
         LiYP/DQm84moPP7rNHGHbT6Wn++JhHgd9v4blpiYBvDJ6to9waZ6KaB+jePRuoT1Mgza
         z3v2PznXyDmdvcnHQNtp7C2ZK3JkhIOBg3F6/h2vmc+VyhXzkq0wZPsWk2zyqQb34gMk
         DUkueVLYYR0iM1hdsa9ufqrXWgJK+IPzCawgLSuJ/8P771FcRmmr6ZYzIP2mNajsYJ+V
         7prw==
X-Gm-Message-State: APjAAAV4+iFXU9AReZDVgj40fJHS4uBnuZrLZjzjyPQYq5k5neGT1hO0
        WKc/s0syKDMLLFRS9EkSzBjOSHVHaiU=
X-Google-Smtp-Source: APXvYqypBJ+RY3iZXTAN7jD6cDv1ks62aJk3l8+yGMMR5/FdUnFK+mmnVy1HnYwJVFkIV/LR1grkLg==
X-Received: by 2002:a50:a48a:: with SMTP id w10mr37395870edb.1.1565620846694;
        Mon, 12 Aug 2019 07:40:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r19sm1618456edy.52.2019.08.12.07.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:40:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CB894100854; Mon, 12 Aug 2019 17:40:45 +0300 (+03)
Date:   Mon, 12 Aug 2019 17:40:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Message-ID: <20190812144045.tkvipsyit3nccvuk@box>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-6-songliubraving@fb.com>
 <20190808163303.GB7934@redhat.com>
 <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
 <20190809152404.GA21489@redhat.com>
 <3B09235E-5CF7-4982-B8E6-114C52196BE5@fb.com>
 <4D8B8397-5107-456B-91FC-4911F255AE11@fb.com>
 <20190812121144.f46abvpg6lvxwwzs@box>
 <20190812132257.GB31560@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812132257.GB31560@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 03:22:58PM +0200, Oleg Nesterov wrote:
> On 08/12, Kirill A. Shutemov wrote:
> >
> > On Fri, Aug 09, 2019 at 06:01:18PM +0000, Song Liu wrote:
> > > +		if (pte_none(*pte) || !pte_present(*pte))
> > > +			continue;
> >
> > You don't need to check both. Present is never none.
> 
> Agreed.
> 
> Kirill, while you are here, shouldn't retract_page_tables() check
> vma->anon_vma (and probably do mm_find_pmd) under vm_mm->mmap_sem?
> 
> Can't it race with, say, do_cow_fault?

vma->anon_vma can race, but it doesn't matter. False-negative is fine.
It's attempt to avoid taking mmap_sem where it can be not productive.

mm_find_pmd() cannot race with do_cow_fault() since the page is locked.
__do_fault() has to return locked page before we touch page tables.
It is somewhat subtle, but I wanted to avoid taking mmap_sem where it is
possible.

-- 
 Kirill A. Shutemov
