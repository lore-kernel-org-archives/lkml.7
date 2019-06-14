Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA79C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E3621537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WzNVrOBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFNO73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:59:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41493 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNO73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:59:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id 33so2779905qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5z2Pz9BEyGq7RJT7oSwXGEkkJAkO10nXW654v8UxM6g=;
        b=WzNVrOBd17Pk5xfQND6MhYXpenRxgHkYF6+NIHY7bXPGySvJWnA4Yc5m/7jqocYAVx
         nTrcDq6ANA2a920ACj3SsqsjF/thm1dKOTQodWJSnroRL7n10qZOOIuDGVx0ljoBaROR
         hLa/IhZRI7QfKibOJvG/7RzUho1Pu8cy9+Uhnt8lmT6kZeU09kSH02M/IqiDeVEl+E+2
         5s/xKQU+RT5r5a4slL5v/ITGAbcYb+PGmPoI6NegmH/rqdPpxS8Q4dIGUiEvEqy6jrYV
         s6VH8U4Ql0ajpdx5rS6/X/rje8aqnk8n12k9vFWka8I7ICAl41Z1O9v3sUhO3JIEIgBZ
         VSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5z2Pz9BEyGq7RJT7oSwXGEkkJAkO10nXW654v8UxM6g=;
        b=USafhbz3FBMm8+vWn6LmN6GmlrWiM3JQVHYJepjCJ8zAO02KctFSnutbwAmbLimiiN
         ryx6Jl4p39l2SjgHreN0IACV3xmeMZU5YW1/5/d3aX5MsSNrutvstds34xJiHRx/cFk+
         XZZPti6RdLWgpxlGCzjP9Ww8Oa029OUqgNnIsZ3QBgg2QghwslzF0ZJOGqvv4yvTHSfq
         8zAwjZp3pO+Jc6SC0g+sslob7miYOwT5ppz5qLGSY6zRmOZ1WQCMZHlPNC2jhlTlQ8wT
         3cqtSqKnj2nFkhNs89Db2vkjroLW8gXuUZh+2yMccHzTBBzG74WS2orG9ZsbUA01aOUC
         n2fw==
X-Gm-Message-State: APjAAAVfyCnZcF0lHxD06+yObH9E4puO6ppd+5IndWyYr79MWBXJlCwZ
        1NdKMVxLhLbGjmDpOuIL3i+oOQ==
X-Google-Smtp-Source: APXvYqx3Gg4yTUqFYBGtbb6cacElACxIxE3Pvk81wkhcKZ5g0ia7pAZnlMD1JRW94Q3de08FfWw//Q==
X-Received: by 2002:ac8:2ae8:: with SMTP id c37mr27433373qta.267.1560524367784;
        Fri, 14 Jun 2019 07:59:27 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g10sm1458390qki.37.2019.06.14.07.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:59:27 -0700 (PDT)
Message-ID: <1560524365.5154.21.camel@lca.pw>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from
 pfn_to_online_page()
From:   Qian Cai <cai@lca.pw>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jun 2019 10:59:25 -0400
In-Reply-To: <87lfy4ilvj.fsf@linux.ibm.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
         <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
         <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
         <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 14:28 +0530, Aneesh Kumar K.V wrote:
> Qian Cai <cai@lca.pw> writes:
> 
> 
> > 1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the
> > same
> > pfn_section_valid() check.
> > 
> > 2) powerpc booting is generating endless warnings [2]. In
> > vmemmap_populated() at
> > arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> > PAGES_PER_SUBSECTION, but it alone seems not enough.
> > 
> 
> Can you check with this change on ppc64.  I haven't reviewed this series yet.
> I did limited testing with change . Before merging this I need to go
> through the full series again. The vmemmap poplulate on ppc64 needs to
> handle two translation mode (hash and radix). With respect to vmemap
> hash doesn't setup a translation in the linux page table. Hence we need
> to make sure we don't try to setup a mapping for a range which is
> arleady convered by an existing mapping.

It works fine.

> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index a4e17a979e45..15c342f0a543 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -88,16 +88,23 @@ static unsigned long __meminit
> vmemmap_section_start(unsigned long page)
>   * which overlaps this vmemmap page is initialised then this page is
>   * initialised already.
>   */
> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
>  {
>  	unsigned long end = start + page_size;
>  	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>  
> -	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct
> page)))
> -		if (pfn_valid(page_to_pfn((struct page *)start)))
> -			return 1;
> +	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct
> page))) {
>  
> -	return 0;
> +		struct mem_section *ms;
> +		unsigned long pfn = page_to_pfn((struct page *)start);
> +
> +		if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> +			return 0;
> +		ms = __nr_to_section(pfn_to_section_nr(pfn));
> +		if (valid_section(ms))
> +			return true;
> +	}
> +	return false;
>  }
>  
>  /*
> 
