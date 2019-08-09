Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92103C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6902D217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3D0+T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406010AbfHIJoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:44:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfHIJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:44:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so45736143pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0MjjxEATeDSohSUdPgCn+0npRclOTNWQmeqagttLXsE=;
        b=Uj3D0+T2IeTt2j8R9IQoWagucl2E8dAmOFplTadmEtycTdbXiM6UlavYMVIWRj02Cw
         4nSjNZnzwBdIAEkY38minKr8sYfOUzw8/WLlP8ed8SLzlIhwkZoWRaa1hLLX0HTNpU3l
         +C0O3IoWFhNMlGSkYFNWh5qqg1YWt7jHjjNwXnsLsenEtvNuAmN6uAW6tETi5HZkGIZL
         DrOB+8THq13ltaU/8cqB9++tw1zvfEiBQBoX3Cw1iovi0VSPgY9Yvc4UinD0eWP8t6hd
         ZwvocRvxWFkXtMq3PNSgz9fy8Uktwgue1HOdo+jRr7RaMf3sRku+Hwvkpoi4PR5Myd9g
         ufQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MjjxEATeDSohSUdPgCn+0npRclOTNWQmeqagttLXsE=;
        b=Oywvv5bUA4yIhQx6A+JfKRJszZgT7wTH/SpBmto/a+xzmE2DCIWpvnftFe41GD+zaw
         KrddnUXu6mfNgb2MeVPB3NrrixCr6N+PAhp2R2PQ2xFllNU+/wqVbSskxZHQG1T8d8KP
         2mmGcewbzZoKVl/OsDPiKylKptOB5cU1PHqZ/Puif11m3h/BTdgJ1FtibTDey+kXyU+1
         C+5qSvgWou40PAT0N06hdYCHaKxXFWssf/Xe17ZcUK6Zjg+3ZQYBQ5xvjwUPYGTFXBp5
         dCpP+dGs+dstI9/6QKmvUTyZVP/SUHBysp8JwP2O4W2EBVsriv3tXO0CwXul2o3ceWAX
         C4qw==
X-Gm-Message-State: APjAAAUs+5uQfdU/WC10gdoCzdIabUFM0Jc19tl0gFDWnJxA7zY9WClq
        mI8qtxwZV12n6DFhX7v5M9s=
X-Google-Smtp-Source: APXvYqwKbvHj8qkjrkEYqfdwuA24Q1Iov787Zkesjq5b/OE+ycYpMk/fRKyoJ/9LftbwlyAmci+LfQ==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr21121887pfp.212.1565343856824;
        Fri, 09 Aug 2019 02:44:16 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id e9sm2925944pfh.155.2019.08.09.02.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 02:44:16 -0700 (PDT)
Date:   Fri, 9 Aug 2019 15:14:06 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, sivanich@sgi.com,
        ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup
 functions
Message-ID: <20190809094406.GA22457@bharath12345-Inspiron-5559>
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
Hi John,

I did set *pageshift. The if statement above sets *pageshift. ps was
used to retrive the pageshift value when the pte_lookup functions were
present. ps was passed by reference to those functions and set by them.
But here since we are trying to remove those functions, we don't need ps
and we directly set *pageshift to HPAGE_SHIFT or PAGE_SHIFT based on the
type of vma. 

Hope this clears things up?

Thank you
Bharath
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
