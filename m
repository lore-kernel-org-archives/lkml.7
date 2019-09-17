Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D25D21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="XWv86CDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfIQLh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:37:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34871 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfIQLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:37:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id v8so3024193eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U1A0a3EcW6JDElv8WwGfEykKyOhc9EqlTK9V4ESPbBg=;
        b=XWv86CDHMt5iXBLXM/QKNfJIZRGCpFVPdS3DpVF5KaSetpqFB5BaVh6fl2nna9jyrA
         K0F2DHsyOARlKS4Acu+W4WFdJcsjCSj2dN7cgBJmE2V8IFPNZoLJemdH2owu7TX/FsWs
         iqppPlYWGaQSLyGzyGbSu7ZT7yhJ+PcHLvprahFA7qye0IeJziOm1thq8xMtuYtIAU9G
         z1LURwGamEvtsG2ax573fNanzEYDsZJp3JGVxU6tPjEaNNdro2YuuIMHQEeHnANMIOeA
         Z1fdOBI0U08ASyilbwTuF0EjYptbfGc6Jr400FKLxyqzlYj2TLkslrSAIkepMK6zWwdU
         7PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U1A0a3EcW6JDElv8WwGfEykKyOhc9EqlTK9V4ESPbBg=;
        b=hqte2vxvAHBDtMxqmw4TbVod95CKwcOj/WePKdso9xKd86Hk1zVKu/Qx3p/cxtnpEv
         KqPkNaf0EhOsIe7dFWqduX8Vwk9kYp6BHbsz1Li9AYGUDd0x7dakAJCjAiRyCBBmCthi
         mhkDqnkqzjNapx8Esa+dPXgR3nWnwJsF0Uyi1JfbbKyo/GZFhT7zzTFFeXaf3hqjTrz6
         a55zXKAgx76O0thSXCKL3uVy8Mfe1B5c/VpBrctehrISV9yaMv6k0XbRukre9vW4GCQC
         82mlu6wiyDzpjOGf4TCmuGUoiSNiBtzmaxJb28rwi1eJe/v+ZUi0X0cUDx+9WxuDTUk4
         wqRg==
X-Gm-Message-State: APjAAAX7d3o4DzQDKjyFP4+rBYN3oQmJdN8PN/5lKJk5Ps97DnHcd2LX
        KhIjDVrOS5mBaOZY70Mk/2WEMA==
X-Google-Smtp-Source: APXvYqzdODeQqVLPPkso+9i3OZhYRgK4DZMBSRS1n0wGRLqb9BdWPSkpSmiE3sQFKqQTEfUMk7CbaA==
X-Received: by 2002:a50:aa96:: with SMTP id q22mr4067132edc.179.1568720276610;
        Tue, 17 Sep 2019 04:37:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c1sm384678edd.21.2019.09.17.04.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 04:37:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7A08D101C0B; Tue, 17 Sep 2019 14:37:58 +0300 (+03)
Date:   Tue, 17 Sep 2019 14:37:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Lucian Adrian Grijincu <lucian@fb.com>
Cc:     linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@fb.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3] mm: memory: fix /proc/meminfo reporting for
 MLOCK_ONFAULT
Message-ID: <20190917113758.kfcbagaz7nlbqnco@box>
References: <20190913211119.416168-1-lucian@fb.com>
 <20190916152619.vbi3chozlrzdiuqy@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916152619.vbi3chozlrzdiuqy@box>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:26:19PM +0300, Kirill A. Shutemov wrote:
> > ---
> >  mm/memory.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index e0c232fe81d9..55da24f33bc4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3311,6 +3311,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
> >  	} else {
> >  		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
> >  		page_add_file_rmap(page, false);
> > +		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(page))
> > +			mlock_vma_page(page);
> 
> Why do you only do this for file pages?

Because file pages are locked already, right?

-- 
 Kirill A. Shutemov
