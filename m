Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE26C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C8C2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzsJvhau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfG1R41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:56:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36473 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1R40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:56:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so26605157plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9NgY+9REzKo/zxFxg1LeJgCnxBhmvyoEoZBcU1LXk0=;
        b=GzsJvhauRWL7PSWXgxuUnBswR65wSjC/py5XB3CPMQMeojWt77IBYkNRVM1FAbXk27
         506oHvYhfbKfQHASajWdGfzcxWXuaM+EE90pZMCVzg1/jcmA01ANWDM9qx4yyf3nK6OG
         ErWIGw8w0Bxt+ERqVQheE3V2hjxHXiMp/k6tLOJESHKOXt0teCUfCB/6JBjiq+7jslyF
         fUgULUk17ruS7rZ9ci/4hG/BS1W255rKAZxc5aV1yCTdtRvdi4NBbZPd7L0sIfyMemu8
         YoHsPEFahFzKV19L36h5STSddrh+ZeEII+JrTGdQZ2kW7GxFt4M8+Oltw/oSv6cKYft6
         RFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9NgY+9REzKo/zxFxg1LeJgCnxBhmvyoEoZBcU1LXk0=;
        b=T6GcWnirHEvkSXIHLhdrina1vkb4eG+r+BFbNmNZXd89Hxk8OvkKndFOp0s94cD9C/
         i71ZBYlI/GGEDLluXfMUHIrm3geC5dg+gcZhOm3kBeWyczGsFkzmFBrls9psZPZnhb6K
         23riiRKRXb2FS41lgu34Bqqfwy8NRCa+klmJBdvvqyVDUlYaNKZb/cS8XZXOeWWEQTgD
         LkIxLswQxkc+XuuFXt+cjxfuLbzHY+qSbpnV/IIoV7C400LXJM65iDq+NJRYAunWVJtL
         vhETWVpIBf/99QwjwJowGwKcypgZI3LdI8grYWPMtV1V/QxjVov5vNXMNU0tf25C7jML
         QU2g==
X-Gm-Message-State: APjAAAXPU6m/F6gmvgzG5NWz0D7EJg3dG+6Xdu2AoAknAGk2npGVtB5f
        sMzshyOdcqXvhP499E6QHuw=
X-Google-Smtp-Source: APXvYqxdDpWI8zTtqYX0tdce8r2lBw5SdnOIWMVyhFqx7s8oneYHV9QX5UBnVitKKGx272Jx+KohgA==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr103163221plt.247.1564336585990;
        Sun, 28 Jul 2019 10:56:25 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id h12sm67756728pje.12.2019.07.28.10.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 10:56:25 -0700 (PDT)
Date:   Sun, 28 Jul 2019 23:26:17 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     sivanich@sgi.com, arnd@arndb.de, ira.weiny@intel.com,
        jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] sgi-gru: Remove *pte_lookup functions
Message-ID: <20190728175617.GA5391@bharath12345-Inspiron-5559>
References: <1564170120-11882-1-git-send-email-linux.bhar@gmail.com>
 <1564170120-11882-2-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564170120-11882-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 05:22:28PM +0800, Hillf Danton wrote:
> 
> On Fri, 26 Jul 2019 12:42:26 -0700 (PDT) Bharath Vedartham wrote:
> > 
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
> > +		ret = get_user_pages_fast(vaddr, 1, write, &page);
> > +		if (!ret)
> >  			goto inval;
> >  	}
> > +
> > +	paddr = page_to_phys(page);
> 
> You may drop find_vma() above if PageHuge(page) makes sense here.
I don't think it does. Hugepage support is still incomplete for this
driver.

Thank you
Bharath
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
> > -	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> > -	*pageshift = ps;
> > +	paddr = paddr & ~((1UL << *pageshift) - 1);
> > +	*gpa = uv_soc_phys_ram_to_gpa(paddr);
> > +
> >  	return VTOP_SUCCESS;
> >  
> >  inval:
> > -- 
> > 2.7.4
> 
