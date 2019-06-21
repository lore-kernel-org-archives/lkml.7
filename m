Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D1DC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C89F21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="B//niuCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFUMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:44:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46699 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:44:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id d4so9858256edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqVBZEPWFSP/e9s0tB0Ipt3Dw5LvuQwd4dI9ko39cRU=;
        b=B//niuCskz8qf17kB7Iq3o6K45T58/nDnBXWjN/lMtJrjgnyfvaL2a31L14a+fI2p+
         5ChVYoeC82xkf1EHe2lYG+Bl/oyGAgO54WMGewBL1psB3FSD5b4tl9tMsxcoRW/6yIER
         kmTdftp73gm5VP9cZaPDBdc/oUezHnco0r2TCH3bNn9B4PABUavvKWsX4RiyWBruSJHq
         vNjuu5eDcmFQEIdQg3r+0jA131TpF6fLOoWd8ebt6ejVko6orgnK4PaS0pbVmtU+IYzJ
         0OTl/a1Z596ofyzBk40B7tabxY4eKlGFQ0oZKKaAGrKElE9YTyiRHv9JT9lrewUYCXlp
         CJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqVBZEPWFSP/e9s0tB0Ipt3Dw5LvuQwd4dI9ko39cRU=;
        b=mwKjrZ7TMNwsQQUNCkK0zuKgkRaeQHhtLSgOuDONsH4qeON4P/+q0UQS5mZq+u0Bhu
         P770nZnhU+hR5/zOpvBwzf/Kn9k/vv0Q8RkFfML0G++SkXCoIh3+i7uNKy+Wyb618yCz
         D4QncZUDEIdvvjgxsxkg2AxE8eDKln9TR2ySlDW8+ooQE4Cnx1LZWq7/rSxzfehnpV5E
         VTj9+Vtrt+v5FqfKXKaBdtfrYmG19hlouS6eBEYvYexTbPXEZqItitKiRNUubilDswYv
         mYQYqfD0pr+PQiJSXduE+uuTlj8tby6SIKRHcPmgjKQFSbnT6dCbGWKAybQ19qSMpFaq
         jkOw==
X-Gm-Message-State: APjAAAXS88qiszCLsxQ0RzUZDyWa46XzulmHE2XTYnI8AILrG/FfuX+b
        764ipzfgyeIs1vH1sf+LMTLhpA==
X-Google-Smtp-Source: APXvYqyuPh8UjXLvvCCKNbaorIU7bGuaPuVf4C/aLJivx/vVf6Ln9WpleDFHzTJZF8WmtQPEuHB/lw==
X-Received: by 2002:a50:ec03:: with SMTP id g3mr84559343edr.233.1561121041750;
        Fri, 21 Jun 2019 05:44:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i21sm404358ejc.79.2019.06.21.05.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:44:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CF12B10289C; Fri, 21 Jun 2019 15:44:02 +0300 (+03)
Date:   Fri, 21 Jun 2019 15:44:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        matthew.wilcox@oracle.com, kirill.shutemov@linux.intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v4 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190621124402.z4l67ck4vr5g7xe3@box>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-4-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613175747.1964753-4-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:57:45AM -0700, Song Liu wrote:
> @@ -419,6 +419,11 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  			put_page(page);
>  			if (pmd_none(*pmd))
>  				return no_page_table(vma, flags);
> +		} else {  /* flags & FOLL_SPLIT_PMD */
> +			spin_unlock(ptl);
> +			ret = 0;
> +			split_huge_pmd(vma, pmd, address);
> +			pte_alloc(mm, pmd);

pte_alloc() can fail and the failure should be propogated to the caller.

-- 
 Kirill A. Shutemov
