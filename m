Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EAC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332D5217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9am0Efc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfK1VWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:22:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36273 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1VW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:22:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so32645370wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zacUhBiF0D2r1M/XEfL2iZtJ1q7R7ytzGKqkS9NCn0w=;
        b=N9am0EfcOq6pRgS/6stJ1kOB9hXFjaOE1psdZlacG0Q2+zMuIfHGvuGUDf9g02SPdw
         8+HwHtp7YT1jKWgqM3g+DLTVRgSfNjLlsHsUdpoVYAbSHQGa4puCc9aNmE1a9GLVqNAi
         iCtrX6lkyMohQWMFo6hJBneJu3yJz9GqeTbEVHFpKxV2pf0vjemgJN1BMFKA7sMdh7+P
         JpEw94EjxA5uEv1p7POXpxtLeCOB0xI0yZ7RBnAU+FyoPNzluCSJBWVMJCO8GNy4S9Pd
         JDoXHleDmU+d/x8TErQRg+gyELXyHkv3+pQfeZgyqNp1hW4mlPk/1iV6nRT4F7FsguRm
         iwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zacUhBiF0D2r1M/XEfL2iZtJ1q7R7ytzGKqkS9NCn0w=;
        b=VyQYSIqngSmaP5SXgsyJvRd7FR1TV4r9ts2yUIiA7ijKOX21Zwt13usddlmBNBQHwM
         EZMEyLnFB2dZFPK+YkbuH+jmppYXvC2lzz45Os1gEb9nrk/IlBLQUG8TB+y1pYErs+4R
         09Fjq/eip8LT2bahNhg+xE6d7Ob/0OjACTFaErQk08FSfj9xXugLDXNMxBnEJrMgqTb3
         dLvCHytJXzLDgHQhGjio34VPJ0e4HQAyyQ+YvqN9d4E+NuFUzS7z4q7rNJxjVUFLbXiA
         gGVlTXIpX+PduG1pv2kKo/dmfWfpFMc6OzXfDiU6kDS1Dyo0aGluGt+BACL8MWV8TyZz
         /agg==
X-Gm-Message-State: APjAAAVLx9iUDjX5UBJptN7PnTRMVK9fvzz9UIziL7jp70rPZgEDaojd
        dFOL24ur7ewgHHs+yjPU7ehKaKeH
X-Google-Smtp-Source: APXvYqwmJCy9eDZLSUP4scaSc397AWw0L/AvZ5C/g8V+D/wrF4T+azaDEHfgexYGVoBn4iM/qOoNoQ==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr51701274wrs.170.1574976147572;
        Thu, 28 Nov 2019 13:22:27 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b8sm24301877wrt.39.2019.11.28.13.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Nov 2019 13:22:26 -0800 (PST)
Date:   Thu, 28 Nov 2019 21:22:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191128212226.sfrhfs5m3q7m6tly@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
>On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
>> At this point, we are sure page is PageTransHuge, which means
>> hpage_nr_pages is HPAGE_PMD_NR.
>> 
>> This is safe to use PMD_SIZE instead of calculating it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/page_vma_mapped.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index eff4b4520c8d..76e03650a3ab 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  			if (pvmw->address >= pvmw->vma->vm_end ||
>>  			    pvmw->address >=
>>  					__vma_address(pvmw->page, pvmw->vma) +
>> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
>> +					PMD_SIZE)
>>  				return not_found(pvmw);
>>  			/* Did we cross page table boundary? */
>>  			if (pvmw->address % PMD_SIZE == 0) {
>
>It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
>break if we ever get PUD THP pages.
>

Thanks for your comment.

I took a look into the code again and found I may miss something.

I found we support PUD THP pages, whilc hpage_nr_pages() just return
HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?

Search in the kernel tree, one implementation of PUD_SIZE fault is
dev_dax_huge_fault. If page fault happens here, would this if break the loop
too early?

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
