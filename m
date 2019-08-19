Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34200C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE462087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3pRQ1dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfHSTH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:07:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34642 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHSTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:07:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so1748405pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WHGqZLDt9a+Qw4mTuhWg8ibFrzx8EVTAEIo7NN7uUto=;
        b=H3pRQ1dCM/eJk1TgtiVsp73U6nYHv753LJCykk1urL3AFHndUAwUr5EvkEljG01GxN
         HMBSgFvyVOHnP1biKu+2paoz5lO/CyMIkU6sS8zA1YZcVsXhHbag8ZnwqH8MGdD8/4zD
         08MwjIyWz6aDP1NjGJenI7R5Cgepa01wuc+Qy/7kum0lfetrYMxySJnRdqV5U0VeiIf4
         gTJUYzVjqNoTzTKgQHNnbkpT7SHOow9P84BqkAyLyG9/1T4y4yS0ROWBLqiLu4F7SHY0
         u5ajIyRXZGPwhWiIvSkev9LgmOndRTOY09WTs3hurB1sJIPOYDr0PaJ49ObuT14Jcm9J
         VhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WHGqZLDt9a+Qw4mTuhWg8ibFrzx8EVTAEIo7NN7uUto=;
        b=YGTmiz1mBESsu0vPZaBXUG8Ha0BtiGoPzYQiL9hYxgmxYnFzrvqdyVG3M1BehzVEM1
         EgULnezuNif8GabaRql235rCbreX53qk/qnEO9SfYmj4sF1ywDogms+nmdCB19WCHd92
         6fpDa1E6iFAQJJZUSPXxUx/I0vykTB25WwmRou4GbDPHf3HHIVGwCLL3RapW21C5Yod3
         Ntk1DFMpvCh0rBZdPdSlU+GwmEn4fBlIv1rHzYL+cU4K807zvJ1sQH6M/+iPicayOkeQ
         /+v5fX1d5SO8VTlULFxl696I6rzWgDwvqE05/zueezVzqykimSRMFjkrVd4ub3g7h5Q4
         zHYA==
X-Gm-Message-State: APjAAAVsqHfdpcN95lpka5M7oUkQd2i3R6Krmm5hBenRG+GIX30rbYAL
        CeMOKP9jVKL2IrWS/2QsEoQ=
X-Google-Smtp-Source: APXvYqyXUC4nhUMvLsEyoD3Ye6bi/qwluhAFtXBp9B7pM6+hMAj67CWmgFPDCKhaBvy8Rnjjm61TRQ==
X-Received: by 2002:aa7:938d:: with SMTP id t13mr24796850pfe.180.1566241646311;
        Mon, 19 Aug 2019 12:07:26 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id v8sm19123293pjb.6.2019.08.19.12.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:07:25 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:37:15 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
Cc:     jhubbard@nvidia.com, jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH 2/2] sgi-gru: Remove uneccessary
 ifdef for CONFIG_HUGETLB_PAGE
Message-ID: <20190819190714.GB6261@bharath12345-Inspiron-5559>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-3-git-send-email-linux.bhar@gmail.com>
 <20190819130057.GC5808@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190819130057.GC5808@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:00:57AM -0500, Dimitri Sivanich wrote:
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Thanks! 
> On Mon, Aug 19, 2019 at 01:08:55AM +0530, Bharath Vedartham wrote:
> > is_vm_hugetlb_page will always return false if CONFIG_HUGETLB_PAGE is
> > not set.
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dimitri Sivanich <sivanich@sgi.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: William Kucharski <william.kucharski@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel-mentees@lists.linuxfoundation.org
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/misc/sgi-gru/grufault.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 61b3447..bce47af 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -180,11 +180,11 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> >  {
> >  	struct page *page;
> >  
> > -#ifdef CONFIG_HUGETLB_PAGE
> > -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > +	if (unlikely(is_vm_hugetlb_page(vma)))
> > +		*pageshift = HPAGE_SHIFT;
> > +	else
> > +		*pageshift = PAGE_SHIFT;
> > +
> >  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> >  		return -EFAULT;
> >  	*paddr = page_to_phys(page);
> > @@ -238,11 +238,12 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
> >  		return 1;
> >  
> >  	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> > -#ifdef CONFIG_HUGETLB_PAGE
> > -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > -#else
> > -	*pageshift = PAGE_SHIFT;
> > -#endif
> > +
> > +	if (unlikely(is_vm_hugetlb_page(vma)))
> > +		*pageshift = HPAGE_SHIFT;
> > +	else
> > +		*pageshift = PAGE_SHIFT;
> > +
> >  	return 0;
> >  
> >  err:
> > -- 
> > 2.7.4
> > 
