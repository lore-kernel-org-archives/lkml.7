Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87873C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653F5218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5IXMDx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfGVRxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:53:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43008 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:53:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so17734330pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H7q9PajozpPfkURyyrCsIMllw+YfN7PAIvmTYKCRDl4=;
        b=O5IXMDx+fn5jEyxDTI2ZTQIepWM+5O99gQOJBV67iOa2Z6dMIo0zZ5+UuKXsmhlRa+
         ULSFQxQ5bIai8gmpxq0U+srcKiwWISbz1BGbisQqP703jECx36HB8Eju2SO8EAJIr3Qc
         JgZPfdvGZLrupJZ9uhyc615Hv0tA8tPlpu4tuk6Ls9zrFrniJ7ctktuI5y3qfNisEoFK
         qcWln97M/Ch+fjtfkNH8yCIBRqHF0hqY9geXTvNdjsr/dhfhBDfeJSWF97mF+M2eI051
         F6laRFUzgnsMU/WUtHJqgDlkDjOxVq5Yg3SFPULHYiMa56P99awl35VVu4t9xarXe/2N
         S98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H7q9PajozpPfkURyyrCsIMllw+YfN7PAIvmTYKCRDl4=;
        b=ZMAL90idWRgzuJuy2XG9GXlTvxKcUIrw2cLPDmdWEwgqr478KDEE18xIfmXrBle5ts
         vRpgtfHoF27q1RvmC125Nk4Z1WXRDmwPAf5cN/B5fSEO8q69x1HKIgyWYntTM05oC1QP
         0nXyeS62Zcw8Xvbb4e2bhwjKJE0pM2vYVrWE7FC67PVb+1RwDmI2YTblDPlO3JLni8pD
         iDemc19/Im4WwzhD5DtG82wo4+V4A/z3oITJrLyWqYu7zq81s7R2N8m1MTmj4sXLniyc
         vlyS2Usl8GL3v4f/LQ2tZdxl2z5trbANtlyrfLyBZhia/qOZnyYC/QQP8UEYwWQVPMZW
         x6tw==
X-Gm-Message-State: APjAAAVhRgTNC5+fi/gojP2hzWqA+kHQGpmXxNr+AeI/LqG+EWTKHDDG
        hhFR5NxZiHTb972/lbM2ZpU=
X-Google-Smtp-Source: APXvYqy1h6sKN8GMy2YI7tvRjVqEjhAErZfvMhFOYWhVeaRXEXS1uTWl63XmXqpem4Y0jL2fnQ7mZg==
X-Received: by 2002:a65:6546:: with SMTP id a6mr18008344pgw.220.1563817997653;
        Mon, 22 Jul 2019 10:53:17 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id z4sm60980856pfg.166.2019.07.22.10.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:53:17 -0700 (PDT)
Date:   Mon, 22 Jul 2019 23:23:11 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        ira.weiny@intel.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] sgi-gru: Use __get_user_pages_fast in
 atomic_pte_lookup
Message-ID: <20190722175310.GC12278@bharath12345-Inspiron-5559>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-4-git-send-email-linux.bhar@gmail.com>
 <c508330d-a5d0-fba3-9dd0-eb820a96ee09@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c508330d-a5d0-fba3-9dd0-eb820a96ee09@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 07:32:36PM -0700, John Hubbard wrote:
> On 7/21/19 8:58 AM, Bharath Vedartham wrote:
> > *pte_lookup functions get the physical address for a given virtual
> > address by getting a physical page using gup and use page_to_phys to get
> > the physical address.
> > 
> > Currently, atomic_pte_lookup manually walks the page tables. If this
> > function fails to get a physical page, it will fall back too
> > non_atomic_pte_lookup to get a physical page which uses the slow gup
> > path to get the physical page.
> > 
> > Instead of manually walking the page tables use __get_user_pages_fast
> > which does the same thing and it does not fall back to the slow gup
> > path.
> > 
> > This is largely inspired from kvm code. kvm uses __get_user_pages_fast
> > in hva_to_pfn_fast function which can run in an atomic context.
> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Dimitri Sivanich <sivanich@sgi.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> >  drivers/misc/sgi-gru/grufault.c | 39 +++++----------------------------------
> >  1 file changed, 5 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 75108d2..121c9a4 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -202,46 +202,17 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> >  static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
> >  	int write, unsigned long *paddr, int *pageshift)
> >  {
> > -	pgd_t *pgdp;
> > -	p4d_t *p4dp;
> > -	pud_t *pudp;
> > -	pmd_t *pmdp;
> > -	pte_t pte;
> > -
> > -	pgdp = pgd_offset(vma->vm_mm, vaddr);
> > -	if (unlikely(pgd_none(*pgdp)))
> > -		goto err;
> > -
> > -	p4dp = p4d_offset(pgdp, vaddr);
> > -	if (unlikely(p4d_none(*p4dp)))
> > -		goto err;
> > -
> > -	pudp = pud_offset(p4dp, vaddr);
> > -	if (unlikely(pud_none(*pudp)))
> > -		goto err;
> > +	struct page *page;
> >  
> > -	pmdp = pmd_offset(pudp, vaddr);
> > -	if (unlikely(pmd_none(*pmdp)))
> > -		goto err;
> > -#ifdef CONFIG_X86_64
> > -	if (unlikely(pmd_large(*pmdp)))
> > -		pte = *(pte_t *) pmdp;
> > -	else
> > -#endif
> > -		pte = *pte_offset_kernel(pmdp, vaddr);
> > +	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> >  
> > -	if (unlikely(!pte_present(pte) ||
> > -		     (write && (!pte_write(pte) || !pte_dirty(pte)))))
> > +	if (!__get_user_pages_fast(vaddr, 1, write, &page))
> >  		return 1;
> 
> Let's please use numeric, not boolean comparison, for the return value of 
> gup.
Alright then! I ll resubmit it!
> Also, optional: as long as you're there, atomic_pte_lookup() ought to
> either return a bool (true == success) or an errno, rather than a
> numeric zero or one.
That makes sense. But the code which uses atomic_pte_lookup uses the
return value of 1 for success and failure value of 0 in gru_vtop. That's
why I did not mess with the return values in this code. It would require
some change in the driver functionality which I am not ready to do :(
> Other than that, this looks like a good cleanup, I wonder how many
> open-coded gup implementations are floating around like this. 
I ll be on the lookout!
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
> >  
> > -	*paddr = pte_pfn(pte) << PAGE_SHIFT;
> > -
> > -	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
> > +	*paddr = page_to_phys(page);
> > +	put_user_page(page);
> >  
> >  	return 0;
> > -
> > -err:
> > -	return 1;
> >  }
> >  
> >  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
> > 
