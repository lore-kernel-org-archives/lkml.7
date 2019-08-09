Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B376C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8CB21874
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNwo9M1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406053AbfHIJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:52:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44322 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHIJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:52:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so45747870pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=coff5jRP+4bBeGfReMXie4tO+oyayDQ9HMdvtmpclDQ=;
        b=SNwo9M1MUx6gatXbQ7l9iO1/w+TnVFKCahmmqUAYpyW9H+8n0Cdqfx30RczFbZbRGj
         bf4EOgN0mZk5UpfmOEHDh9Tqi+85r9Nx5aBsfBeQVn6CWgEA5sJK+u1L8ocrYKIIthNn
         2F6M14ipEGBeiPzEROFicAyK7hD9eS/vDy9NYueghQjNprsW0sNm7IxHUP7ML9lzMRIH
         D8m+LDEHZAb3IFfADaHEHE9SI18Ug5QC84E2WuAMCubC9xOKIVg/6C6m6/cA1MrJ6iDp
         0M2Cu2ZuV6JQ9NroGGxGfIvGnRa51kvggywzGBfPcsxpBtJp4gQpVeeEHXR2l75EPd2T
         bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=coff5jRP+4bBeGfReMXie4tO+oyayDQ9HMdvtmpclDQ=;
        b=rQqvBDpx9nkIGzg4c+OtSLZxwAnwNMPk/+pTg5cTFUMORN7wXbNLPMqfdbEn+KmQUr
         iqGEgs65O3S4haSSBS23Xm5wZprjNclBOn/JMgU7NkvTGnp9AzbaY5qKP0t7kCx0eo7t
         pW2MuODeCo6nogln3Q+eabgcTW/W23z8SBHm93Ntxq69iR2/hl1E6NoURhZO9CNZNgQc
         5DlOOa46zVTejBzCoBNZB+evj5Y/fdRaahtAM6Zzpzo6VzfBooBn1MYeJqoGvpIBHLZL
         O+aDkUDQ4sw/2MUeD4HWwZGuhpnNhq6cE4um89E1KY7DUczspN32sZV5dJv1WnW1jaJk
         0WnQ==
X-Gm-Message-State: APjAAAVRp/jxrOOXM2EUpa41bs7Nh0ovzZzxmH7O5IslYSduL8slanRB
        0SGwxI2jHHLKgrDOHRRrtg8=
X-Google-Smtp-Source: APXvYqwIP7s3exCajcO3pdPQNdIVdIQ8rixRSXZeeayKqB7Lsr3Vn55iMwIIXCcgoE6PDKAdW4jOHg==
X-Received: by 2002:a65:654d:: with SMTP id a13mr16525591pgw.196.1565344367473;
        Fri, 09 Aug 2019 02:52:47 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id e24sm7992122pgk.21.2019.08.09.02.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 02:52:47 -0700 (PDT)
Date:   Fri, 9 Aug 2019 15:22:36 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, sivanich@sgi.com,
        ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup
 functions
Message-ID: <20190809095236.GC22457@bharath12345-Inspiron-5559>
References: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
 <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
 <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:21:44PM -0700, John Hubbard wrote:
> On 8/8/19 11:55 AM, Bharath Vedartham wrote:
> ...
> >  static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
> >  		    int write, int atomic, unsigned long *gpa, int *pageshift)
> >  {
> >  	struct mm_struct *mm = gts->ts_mm;
> >  	struct vm_area_struct *vma;
> >  	unsigned long paddr;
> > -	int ret, ps;
> > +	int ret;
> > +	struct page *page;
> >  
> >  	vma = find_vma(mm, vaddr);
> >  	if (!vma)
> > @@ -263,21 +187,33 @@ static int gru_vtop(struct gru_thread_state *gts, unsigned long vaddr,
> >  
> >  	/*
> >  	 * Atomic lookup is faster & usually works even if called in non-atomic
> > -	 * context.
> > +	 * context. get_user_pages_fast does atomic lookup before falling back to
> > +	 * slow gup.
> >  	 */
> >  	rmb();	/* Must/check ms_range_active before loading PTEs */
> > -	ret = atomic_pte_lookup(vma, vaddr, write, &paddr, &ps);
> > -	if (ret) {
> > -		if (atomic)
> > +	if (atomic) {
> > +		ret = __get_user_pages_fast(vaddr, 1, write, &page);
> > +		if (!ret)
> >  			goto upm;
> > -		if (non_atomic_pte_lookup(vma, vaddr, write, &paddr, &ps))
> > +	} else {
> > +		ret = get_user_pages_fast(vaddr, 1, write ? FOLL_WRITE : 0, &page);
> > +		if (!ret)
> >  			goto inval;
> >  	}
> > +
> > +	paddr = page_to_phys(page);
> > +	put_user_page(page);
> > +
> > +	if (unlikely(is_vm_hugetlb_page(vma)))
> > +		*pageshift = HPAGE_SHIFT;
> > +	else
> > +		*pageshift = PAGE_SHIFT;
> > +
> >  	if (is_gru_paddr(paddr))
> >  		goto inval;
> > -	paddr = paddr & ~((1UL << ps) - 1);
> > +	paddr = paddr & ~((1UL << *pageshift) - 1);
> >  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> > -	*pageshift = ps;
> 
> Why are you no longer setting *pageshift? There are a couple of callers
> that both use this variable.
I ll send v5 once your convinced by my argument that ps is not necessary
to set *pageshift and that *pageshift is being set.

Thank you
Bharath
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
