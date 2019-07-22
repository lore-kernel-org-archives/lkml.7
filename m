Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3580C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F8421903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5w+mGxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfGVRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:47:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33584 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGVRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:47:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so17732551pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ssliLyV8U+mhRbl4ipf9bRa3EL22Ezd5Zc9rGXszSvs=;
        b=C5w+mGxcCfYenODdQNw1QcoLPL+bTkqpAf1/84e6VjiF/EoUBRTpVAR+fNjCytOAWp
         odi5USyMM1CmgRscWbz7evmXa7roPGotsByCf0dCTZYoBvFSPOM8gPIGhpelZJSVH4kB
         hmL7ht19DHj9QHK7nirEINAtPWdthi1fyy909XKPUyZ0sF2ocOcpxFB7WTDRSZe0K810
         cFeY4feogogD3qQW80cDHyCXQa084E3fdKJZBNveSLtwkmItkyXKczLr82vjNBMn8GOC
         D8FspNPt0fikrMjAzRzXpw3qh+0sRFbGrB73QY18Lv1wx61yQFRX5ooBCKklMPAlbkQs
         BRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ssliLyV8U+mhRbl4ipf9bRa3EL22Ezd5Zc9rGXszSvs=;
        b=ilTg3cbrJPthqrjeBvBsaiwWw7NUmB1P75TNeQRGwSMNnmqdA75y7RQUqInpVj/oYy
         oibgf23Sm9sZ5+s47MH4epvej4EL3sgs0veCZjod4vkFuErjeXpZ203qEG2RmbmEl/cx
         u8L98xSl1rQoGyeBpgqSGhMLWjHH5JfsOwVTfiK9aNOfefAQZC6LRl8+9Vh5eSgDLwpB
         rW9/NCdJBFj857akzBaS4JrKRRNvV/hXaOJkKXkZDKdmpzFkvBC9IHTJuIH6SYRhi2+O
         h12Hses+jnwO+jMvTjLKEt2+i2Y8oVUg/6IjFq9oAs3x1i+EwXqoPFCmPndbttWbr6p3
         CGuw==
X-Gm-Message-State: APjAAAVoa1scazLPnzGVSNBKUnuPzoxm7PpACQXmK4bwtXwbQFdsTf+y
        NiFsN3qIlgzmLvgWhI77qMk=
X-Google-Smtp-Source: APXvYqytaXVkl+pZJk2sr2G9EcYG8eurkZ6Bh7OAgDsV2SsE5u3Auq7jbF2z3AZSzMtO7hgrslDQ9w==
X-Received: by 2002:a62:fc0a:: with SMTP id e10mr1400314pfh.114.1563817652196;
        Mon, 22 Jul 2019 10:47:32 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id w3sm35130886pgl.31.2019.07.22.10.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 10:47:31 -0700 (PDT)
Date:   Mon, 22 Jul 2019 23:17:25 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org,
        ira.weiny@intel.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] sgi-gru: Convert put_page() to get_user_page*()
Message-ID: <20190722174725.GA12278@bharath12345-Inspiron-5559>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
 <1563724685-6540-2-git-send-email-linux.bhar@gmail.com>
 <dae42533-7e71-0e41-54a2-58c459761b3e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dae42533-7e71-0e41-54a2-58c459761b3e@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 07:25:31PM -0700, John Hubbard wrote:
> On 7/21/19 8:58 AM, Bharath Vedartham wrote:
> > For pages that were retained via get_user_pages*(), release those pages
> > via the new put_user_page*() routines, instead of via put_page().
> > 
> > This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> > ("mm: introduce put_user_page*(), placeholder versions").
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
> >  drivers/misc/sgi-gru/grufault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Thanks! 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
> > diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> > index 4b713a8..61b3447 100644
> > --- a/drivers/misc/sgi-gru/grufault.c
> > +++ b/drivers/misc/sgi-gru/grufault.c
> > @@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
> >  	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
> >  		return -EFAULT;
> >  	*paddr = page_to_phys(page);
> > -	put_page(page);
> > +	put_user_page(page);
> >  	return 0;
> >  }
> >  
> > 
