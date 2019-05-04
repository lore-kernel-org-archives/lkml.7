Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D338C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F4206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pueCylAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEDMSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:18:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38114 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEDMSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:18:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so4024234pla.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PfxztiH8X3MJjkrxFVtIDIas6bc40wWgdNkV+JlNTik=;
        b=pueCylAYmHzqPrCU1yZ9nMbM8tef0CuKfHcDYd5jwhC7vqEXugT6oi3hOZew2wkW5O
         0pwIirm6+OtxQjiOe+GCeEAoE8njybGmtTin+x/9DUJ2PKZMDpyNJfEp7qj4Q441lvbl
         m+Smt0p5XOecECZhRyW/ScF4sDQyLmZIDB+rFn/yBZIg40weRGUl07yWaHSdwoRtpdMC
         74/XVOmiXTe5ANYPBpHsk5uDCShXPacvr/BH9nl+PQfOgypY7AxnY0UDz7GN9asGkITW
         Cry+R3NCuGyVuiiWn/wGIjnOtSXbFthdA5mgQwfUdn18Iws8LjXD8swNOV1QSnefta46
         x5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfxztiH8X3MJjkrxFVtIDIas6bc40wWgdNkV+JlNTik=;
        b=FNjoaSk7zRD86T20nLRsL0WA+3Z+ZG/RDtxBBVVgPIk9QDM4xxpsj71SLwX7EbpPgQ
         1SRUKYU0YI+2OwBDDFSTMSQozW4gBYNBxY5gYH4pvjB9qACjK/+UWuF5iG7mFyD0q3pR
         PdQwzrWbIVYWW3yuzi4zvcVtGgIUHdrhDe8x/mNo0DOoiI5ISsKUl7yFoT5VNn+S7aIz
         n6FaXRIvsGV36pGuUyB+ZBcvKEqg5lPpM4sArAQSqqHU/h6rPWdh2j/npmEaqMnfqLBQ
         FD4CWkKNNn/Op6/M7MlUvwj6+JjDwS3lr3FudqJ1hfkk30IQmJuD9Or+9s8zugt7aeMa
         6PDA==
X-Gm-Message-State: APjAAAU3TqyVoKFg/hwNwMibloTM1s+K4sLQhTJT6SMYKG49CFuX9ncc
        dV49qbZWC00hdtqEBddW8jI=
X-Google-Smtp-Source: APXvYqwCXrIJJ5KHmqQq80nmIL3zB4ej5GGGXc/1zS2jCx8mjdunT0aHtAs2qYVgGws8simtIwxxlA==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr18180779pld.320.1556972329028;
        Sat, 04 May 2019 05:18:49 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id h189sm9330513pfc.125.2019.05.04.05.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 05:18:48 -0700 (PDT)
Date:   Sat, 4 May 2019 17:48:41 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory.c: Make __thp_get_unmapped_area static
Message-ID: <20190504121841.GA8142@bharath12345-Inspiron-5559>
References: <20190504102353.GA22525@bharath12345-Inspiron-5559>
 <20190504115446.GP29835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504115446.GP29835@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2019 at 07:54:46AM -0400, Michal Hocko wrote:
Hi Michal,

Thanks for having a look at the patch. 
> On Sat 04-05-19 15:53:54, Bharath Vedartham wrote:
> > __thp_get_unmapped_area is only used in mm/huge_memory.c. Make it
> > static.
> 
> Makes sense. Looks like an omission.
> 
> > Tested by building and booting the kernel.
> 
> Testing by git grep __thp_get_unmapped_area would give you a better
> picture. Build test migh not hit paths that are config specific and
> static aspect of a functions should not have any functionality related
> side effects AFAICS.
>  
I have made sure CONFIG_TRANSPARENT_HUGEPAGE was enabled before building
and booting the kernel. I have also grepped the entire kernel source for
__thp_get_unmapped_area to be very sure.
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> > ---
> >  mm/huge_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 165ea46..75fe2b7 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -509,7 +509,7 @@ void prep_transhuge_page(struct page *page)
> >  	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
> >  }
> >  
> > -unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
> > +static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
> >  		loff_t off, unsigned long flags, unsigned long size)
> >  {
> >  	unsigned long addr;
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

Thanks
Bharath
